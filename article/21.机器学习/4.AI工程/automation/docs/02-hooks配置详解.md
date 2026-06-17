# Hooks 配置详解

> 3 个 hook 的原理、协议、定制方法

---

## Claude Code Hook 协议

Claude Code 通过 4 个时机触发 hook(每个可挂多个脚本):

| 时机 | 触发点 | 典型用途 |
|---|---|---|
| **UserPromptSubmit** | 用户发消息后,CC 处理前 | 改写输入、追加上下文、检测意图 |
| **PreToolUse** | CC 准备调用工具前 | 阻断危险操作、改写工具参数 |
| **PostToolUse** | 工具调用完成后 | 验证结果、自动补救、追加操作 |
| **Notification** | CC 给用户发通知时 | 改写通知内容、加日志 |

**协议**:hook 脚本从 stdin 读 JSON,stdout 输出 JSON(可选),`exit 0` 表示继续,`exit 2` 表示阻断。

---

## Hook 1: 阶段跟踪器 (stage-tracker.py)

### 触发时机

**UserPromptSubmit** —— 用户每发一条消息都跑

### 作用

检测用户输入里的关键词,自动推进状态机。8 个阶段对应 8 组关键词:

| 阶段 | 触发关键词 |
|---|---|
| 0 需求 | 需求, requirement, 脑暴, brainstorm |
| 1 设计 | 设计, design, 架构 |
| 2 任务 | 任务, task, 分解, 拆解 |
| 3 Worktree | worktree, 分支, branch |
| 4 编码 | 代码, 实现, 写代码, coding, implement |
| 5 测试 | 测试, test, 覆盖, coverage |
| 6 Review | review, 审查, 评审 |
| 7 收尾 | 收尾, 归档, merge, summary, 完成 |

### 输入

```json
{
  "user_prompt": "我要做设计",
  "session_id": "abc123"
}
```

### 输出(写到 stderr,主流程不阻断)

```
🔄 状态推进: 阶段 0 → 阶段 1
📋 当前需求: REQ-2026-001
```

### 状态文件

`/tmp/req-state.json`:

```json
{
  "current_stage": "1",
  "req_id": "REQ-2026-001",
  "history": [
    {"from": "?", "to": "0", "timestamp": "...", "prompt": "..."},
    {"from": "0", "to": "1", "timestamp": "...", "prompt": "..."}
  ]
}
```

### 定制方法

修改 `STAGE_TRIGGERS` 字典加你自己的关键词:

```python
STAGE_TRIGGERS = {
    "0": ["需求", "requirement", "脑暴", "brainstorm", "新功能"],  # 加 "新功能"
    ...
}
```

---

## Hook 2: 文档验证器 (doc-validator.py)

### 触发时机

**PostToolUse (Write)** —— CC 每次写文件后跑

### 作用

检测到 CC 写 `0X-*.md` 模板时,自动检查必填字段。**不阻断**,只提示。

### 验证规则

8 个模板,每个有必填字段:

```python
TEMPLATE_REQUIRED = {
    "01-requirement": [
        r"需求编号", r"创建日期", r"## 1. 背景",
        r"## 2. 需求描述", r"## 3. 验收标准",
        r"## 4. 不做什么", r"## 5. 风险与依赖"
    ],
    "02-design": [
        r"## 1. 涉及的微服务", r"## 2. 接口设计",
        r"## 3. 数据库设计", r"## 6. 异常处理"
    ],
    ...
}
```

### 输出

```
✅ [01-requirement] 模板完整
# 或
⚠️ [01-requirement] 模板不完整,缺失字段:
   - ## 1. 背景
   - ## 3. 验收标准
```

### 定制方法

加你团队自己的必填字段:

```python
TEMPLATE_REQUIRED = {
    "01-requirement": [
        ...原有,
        r"## 安全合规",  # 你团队的额外要求
        r"## 性能预估"
    ],
}
```

或者新增模板(比如 `09-监控配置.md`):

```python
TEMPLATE_REQUIRED["09-monitoring"] = [
    r"## 监控指标", r"## 告警规则", r"## 值班表"
]
```

---

## Hook 3: 覆盖率检查器 (coverage-check.py)

### 触发时机

**PostToolUse (Bash)** —— CC 跑 `mvn test` 完成后

### 作用

读 JaCoCo CSV 报告,自动检查覆盖率。**不达标时强提示**,但不阻断(允许 CC 补测试)。

### 目标配置

```python
COVERAGE_TARGETS = {
    "service": {"line": 80, "branch": 70},     # Service 层硬指标
    "controller": {"line": 60, "branch": 0},   # Controller 可协商
    "util": {"line": 100, "branch": 100},      # 工具类 100%
    "default": {"line": 80, "branch": 70}
}
```

### 包名 → 分类规则

```python
def classify_package(package):
    if "service" in package.lower() and "impl" not in package.lower():
        return "service"
    if "controller" in package.lower():
        return "controller"
    if "util" in package.lower():
        return "util"
    return "default"
```

### 输出

```
📊 覆盖率检查结果: PASS
   总包数: 12, 失败: 0
✅ 覆盖率达标,可以进入下一阶段
```
或
```
📊 覆盖率检查结果: FAIL
   总包数: 12, 失败: 2
❌ 覆盖率不达标:
   - com.company.order.service (line): 75.0% < 80%
   - com.company.promo.strategy (branch): 65.0% < 70%
```

### 定制方法

**改目标**:
```python
COVERAGE_TARGETS["service"]["line"] = 85  # 提高到 85%
```

**改包名识别**(比如你用 `domain` 而不是 `service`):
```python
def classify_package(package):
    if "service" in package.lower() or "domain" in package.lower():
        return "service"
    ...
```

**强制阻断**(不达标不让进下一阶段):
```python
if evaluation["status"] == "FAIL":
    output = {
        "decision": "block",  # 改成 block 而不是 continue
        "reason": f"覆盖率不达标: {len(evaluation['failed'])} 个包"
    }
```

---

## Hook 故障排查

### 1. Hook 不触发

**症状**:跑 CC,输入"/req-full",但没有任何 hook 输出。

**排查**:
```bash
# a. 检查 settings.json 路径对不对
cat .claude/settings.json | grep command

# b. 检查 Python 解释器
which python3

# c. 用 stdin 测试
echo '{"user_prompt":"test","session_id":"x"}' | python3 .claude/hooks/stage-tracker.py
```

### 2. Hook 报错

**症状**:CC 启动时报 hook 错误,流程中断。

**排查**:
```bash
# 手动跑 hook,看错误
python3 .claude/hooks/stage-tracker.py
# 看 traceback
```

### 3. Hook 阻断流程

**症状**:CC 走到一半突然停了,说"hook 阻断"。

**排查**:
```bash
# 找到报 hook 阻断的脚本
# 在 settings.json 里找 exit 2 / decision: block 的地方
# 临时改 exit 0 / continue: true
```

### 4. 性能问题

**症状**:CC 跑得很慢,每个动作都卡几秒。

**排查**:
```bash
# Hook 不应该超过 500ms
# 慢的原因可能是:
# - Python 启动慢(可用 uv / pyinstaller 打包)
# - I/O 多(可加缓存)
# - 同步等待(可改异步)
```

---

## 高级:加你自己的 hook

### 例子:自动跑 lint

```python
# .claude/hooks/lint-runner.py
import json
import sys
import subprocess

def main():
    data = json.load(sys.stdin)
    if data.get("tool_name") != "Write":
        sys.exit(0)

    file_path = data.get("tool_input", {}).get("file_path", "")
    if not file_path.endswith(".java"):
        sys.exit(0)

    # 跑 checkstyle
    result = subprocess.run(
        ["mvn", "checkstyle:check", "-q"],
        capture_output=True, text=True
    )
    if result.returncode != 0:
        print(f"❌ Checkstyle 失败:\n{result.stdout}", file=sys.stderr)
        # 不阻断,只提示
        print(json.dumps({
            "continue": True,
            "hookSpecificOutput": {"additionalContext": "Checkstyle 有 warning"}
        }))
    else:
        sys.exit(0)

if __name__ == "__main__":
    main()
```

加到 `settings.json`:
```json
"PostToolUse": [
  {
    "matcher": "Write",
    "hooks": [{
      "type": "command",
      "command": "python3 $CLAUDE_PROJECT_DIR/.claude/hooks/lint-runner.py"
    }]
  }
]
```

### 例子:自动 commit message 检查

```python
# .claude/hooks/commit-msg-check.py
# PostToolUse(Bash) 检测 git commit
# 验证 message 格式: feat(promo): T1.1 create table
# 不规范就提示
```

---

## 最佳实践

1. **Hook 要快** — 每个 hook < 500ms,否则 CC 体验卡
2. **Hook 不要阻断主流程** — 默认 `continue: True`,除非有 P0 风险
3. **Hook 输出用 stderr** — 主 stdout 给 hook 协议 JSON
4. **Hook 出错不静默** — 至少在 stderr 打错误,便于排查
5. **Hook 状态用文件** — 不要在 hook 间用环境变量(CC 重启会丢)
6. **Hook 幂等** — 同一个输入跑两次结果要一样

---

## 资源

- [Claude Code Hooks 官方文档](https://docs.claude.com/claude-code/hooks)
- [本仓库 hook 源码](../../.claude/hooks/)
- [配置示例](../.claude/settings.json)
