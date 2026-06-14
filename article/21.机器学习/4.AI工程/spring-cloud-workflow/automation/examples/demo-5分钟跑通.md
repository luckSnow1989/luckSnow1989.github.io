# 5 分钟跑通 demo

> 目标:用 `/req-full` 跑一个真实的小需求,验证 hooks 都正常工作
> 预计耗时:5 分钟(交互) + 自动化跑 ~20 分钟

---

## 准备工作(2 分钟)

```bash
# 1. 找一个 Spring Cloud 项目(用订单服务做例子)
cd ~/projects/order-service

# 2. 确保 CC 装好
claude --version

# 3. 复制 automation 配置(假设你已经从工具箱 cp 过了)
ls .claude/
# 应该看到: commands/ hooks/ settings.json

# 4. 初始化 PROJECT_PLAN.md
cat > PROJECT_PLAN.md <<'EOF'
# 项目计划

## 进行中
(空)

## 待启动
(空)

## 已完成
(空)
EOF

# 5. 启动 CC
claude
```

---

## 启动 8 阶段流程(3 分钟交互)

### 第 1 步:启动(15 秒)

```
> /req-full REQ-2026-001 满100减20
```

**期望看到**:
```
🚀 启动 8 阶段流程,需求 REQ-2026-001
[阶段 0/8] 需求接入

📋 让我先确认几个关键问题:
Q1: 减 20 是"满 100 才减"还是累计?
Q2: 同一用户一天能用几次?
...
```

### 第 2 步:回答需求问题(1-2 分钟)

**你**:`Q1 单次,Q2 每天 1 次,Q3 退单返还,其他你看着合理填`

**CC 边问边记**,**Hook 1** 静默跟踪阶段。

### 第 3 步:确认需求 ⏸️(10 秒)

CC 写完 `01-requirement.md` 后:

```
[Hook 2] ✅ [01-requirement] 模板完整

[阶段 0/8] ✅ 01-requirement.md 已生成
   路径: .history/REQ-2026-001/01-requirement.md
   请确认需求 → 后续会继续自动推进
```

**你**:`确认`

CC 自动进阶段 1,2,然后停在阶段 3 让你确认 Worktree。

### 第 4 步:确认 Worktree ⏸️(10 秒)

```
[阶段 3/8] ⏸️ Worktree 准备就绪
   分支: feature/REQ-2026-001-promo
   路径: ../order-service-promo
   确认创建吗?
```

**你**:`创建`

CC 自动跑阶段 4(编码)、5(测试)。

### 第 5 步:测试阶段(自动,1-3 分钟)

CC 自己跑子代理,逐任务实现 + 写测试 + commit。

中途你会看到:
```
[阶段 4/8] 编码中... (T1.1 18:30, T1.2 19:00, ...)
[阶段 5/8] 跑测试...
[Hook 3] 📊 覆盖率检查结果: PASS
   总包数: 12, 失败: 0
   ✅ 覆盖率达标,可以进入下一阶段
```

**如果 Hook 3 报 FAIL**(常见情况):
```
[Hook 3] ❌ 覆盖率不达标:
   - com.company.promo.service (line): 75% < 80%
   CC: 我去补 5 个测试用例...
[再跑 mvn test]
[Hook 3] ✅ 通过
```

### 第 6 步:Review ⏸️(10 秒看报告)

```
[阶段 6/8] ⏸️ Review 报告
   P0: 0
   P1: 1 (Redisson 看门狗)
   P2: 2
   详情: .history/REQ-2026-001/07-review.md
```

**你**:打开 07-review.md 看一眼,如果 P1 同意修,就 `同意合并`。
CC 自动修 P1,再 review 一遍。

### 第 7 步:收尾 ⏸️(10 秒)

```
[阶段 7/8] 合并 + 归档
   ✅ REQ-2026-001 完成!
   📂 .history/REQ-2026-001/
      ├── 01-requirement.md ✅
      ├── 02-design.md ✅
      ├── 03-tasks.md ✅
      ├── 04-worktree-info.md ✅
      ├── 05-changes.md ✅
      ├── 06-test-report.md ✅
      ├── 07-review.md ✅
      └── 08-summary.md ✅
   🚀 下一步:部署到测试环境
```

---

## 验证 hooks 都生效(2 分钟)

### 检查 Hook 1(阶段跟踪)

```bash
cat /tmp/req-state.json
```

应该看到类似:
```json
{
  "current_stage": "7",
  "req_id": "REQ-2026-001",
  "history": [
    {"from": "?", "to": "0", ...},
    {"from": "0", "to": "1", ...},
    ...
  ]
}
```

### 检查 Hook 2(文档验证)

```bash
# 故意写个不完整的 02-design
mkdir -p /tmp/test-history
cat > /tmp/test-history/02-design.md <<'EOF'
# 标题
## 1. 涉及的微服务
(没写其他)
EOF

echo '{"tool_name":"Write","tool_input":{"file_path":"/tmp/test-history/02-design.md","content":"# 标题\n## 1. 涉及的微服务\n"}}' | \
  python3 .claude/hooks/doc-validator.py

# 应该看到 ⚠️ 模板不完整
```

### 检查 Hook 3(覆盖率)

```bash
# 如果你刚跑过 mvn test,应该已经有 JaCoCo 报告
ls target/site/jacoco/jacoco.csv

# 模拟跑 hook
echo '{"tool_name":"Bash","tool_input":{"command":"mvn test"},"tool_output":"BUILD SUCCESS","cwd":"'$PWD'"}' | \
  python3 .claude/hooks/coverage-check.py

# 应该看到 📊 覆盖率检查结果
```

---

## 🎉 跑完后的感受

| 维度 | 之前 | 现在 |
|---|---|---|
| 启动流程 | 8 次手动 | 1 次 `/req-full` |
| 阶段切换 | 每次都说"下一步" | Hook 1 自动 |
| 文档完整性 | 容易漏字段 | Hook 2 自动验证 |
| 覆盖率 | 跑完才知道 | Hook 3 跑 mvn test 后立刻 |
| 人工介入 | 8+ 次 | **4 次**(需求/Worktree/Review/收尾) |

**节省的时间**:每次新需求省 30-60 分钟(主要省在"切换阶段时的摩擦")。

---

## 下一步可以试

- 跑 2-3 个真实需求,收集痛点
- 加更多 hook(自动跑 lint / 自动 commit message 检查 / 自动 changelog 生成)
- 接入 CI:Hook 3 的结果可以推到 GitLab CI / GitHub Actions
- 团队推广:把这个配置加到团队的 git template
