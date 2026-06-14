---
description: 一句话启动 8 阶段 Spring Cloud 需求开发流程
---

# /req-full - 8 阶段工作流一锅端

> 用途:在 Spring Cloud 微服务项目中,启动完整的 8 阶段开发流程(需求→设计→任务→Worktree→编码→单测→Review→归档)
> 自动化程度:80%(4 个关键节点需人工确认,中间全自动)
> 配合 hooks:无需手动切换阶段

## 参数解析

```
/req-full [需求编号] [需求标题]
/req-full REQ-2026-001 满100减20
```

或者用一句话描述:

```
/req-full 我要加一个满100减20的促销功能
```

---

## 行为流程(8 阶段串接)

### 阶段 0:需求接入 ⏸️ **检查点 1**

- 在 `PROJECT_PLAN.md` 创建 `[REQ-YYYY-NNN] 标题`
- 创建目录 `.history/REQ-YYYY-NNN/`
- **运行**:Superpowers `brainstorming`(问 8-12 个澄清问题)
- 生成 `01-requirement.md`
- ⏸️ **停下来等用户确认需求**

### 阶段 1:架构设计(自动)

- 基于 `01-requirement.md`
- **运行**:Superpowers `writing-plans` + 用户在 `CLAUDE.md` 里的技术栈约束
- 输出:接口设计、库表 DDL、缓存设计、风险评估
- 生成 `02-design.md`
- **不自动停下**(可通过 hook 配置)

### 阶段 2:任务分解(自动)

- 基于 `02-design.md`
- **运行**:Taskmaster parse + 依赖排序
- 生成 `03-tasks.md`(每个任务 2-5 分钟)

### 阶段 3:Git Worktree ⏸️ **检查点 2**

- 创建 `../<service>-<short-desc>` worktree
- 分支:`feature/REQ-2026-NNN-短描述`
- 写 `04-worktree-info.md`
- ⏸️ **停下来等用户确认分支名**

### 阶段 4:编码实现(自动)

- 按 `03-tasks.md` 逐项实现
- **运行**:Superpowers `test-driven-development`(强制先写测试)
- **运行**:Superpowers `subagent-driven-development`(子代理并行)
- 每个任务单独 commit
- 自动生成 `05-changes.md`(git log + diff 统计)
- **不自动停下**(全自动跑)

### 阶段 5:单元测试(自动)

- 跑 `mvn test jacoco:report`
- 检查覆盖率:Service ≥ 80% / 工具类 100%
- 不达标 → 触发 `systematic-debugging` 补测试
- 达标 → 生成 `06-test-report.md`
- ⏸️ **如果覆盖率不达标,停下来提示用户**

### 阶段 6:Code Review ⏸️ **检查点 3**

- **运行**:Superpowers `requesting-code-review`(4 维度:功能/质量/安全/性能)
- 生成 `07-review.md`(P0/P1/P2 分级)
- ⏸️ **停下来给用户看 review 结果**

### 阶段 7:收尾归档 ⏸️ **检查点 4**

- 自动合并到主分支(需用户确认)
- 部署命令(可选)
- 生成 `08-summary.md`
- 更新 `PROJECT_PLAN.md`(移到"已完成")
- 清理 worktree
- ⏸️ **最后停下来报告完成**

---

## 与 hooks 的配合

本命令依赖 3 个 hooks(见 `.claude/settings.json`):

1. **UserPromptSubmit hook** — 检测用户输入是否含"开始 /req-full" 标记
2. **PreToolUse hook** — 检测到 `Write` 工具创建 `0X-*.md` 时,自动验证模板完整性
3. **PostToolUse hook** — 检测到 `Bash` 跑 `mvn test` 时,自动追加覆盖率检查

详见 `docs/02-hooks-配置详解.md`

---

## 关键原则

- **不替代人决策** — 4 个检查点必须人拍板
- **不跳过阶段** — 任何一个失败都停下来
- **不破坏单测** — TDD 强制,覆盖率硬指标
- **不丢失留痕** — 每个阶段都写文档,git 自动记录

---

## 失败处理

| 失败 | 行为 |
|---|---|
| 阶段 0 提问超过 15 轮 | 停下,提示用户简化需求 |
| 阶段 4 单测跑不过 | 自动调用 systematic-debugging,3 次失败后停下 |
| 阶段 5 覆盖率不达标 | 停下,提示用户:是补测试还是降低标准 |
| 阶段 6 P0 问题 | 停下,必须先修才能进阶段 7 |
| Git 冲突 | 停下,提示用户手动合并 |

---

## 使用示例

```bash
# 标准用法
> /req-full REQ-2026-001 满100减20

# 简略用法(自动生成需求编号)
> /req-full 满100减20的促销功能

# 加描述
> /req-full 我要加一个满100减20的促销功能,用户一天只能用1次
```

## 完整使用流程

```
> /req-full REQ-2026-001 满100减20

CC: 🚀 启动 8 阶段流程,需求 REQ-2026-001
    [阶段 0/8] 需求接入
    Q1: 减 20 是"满 100 才减"还是累计?
    Q2: 同一用户一天能用几次?
    ...

你: (回答问题)

CC: [阶段 0/8] ✅ 01-requirement.md 已生成
    请确认需求...

你: ✅ 确认

CC: [阶段 1/8] 架构设计中...
    [阶段 2/8] 任务分解中...
    [阶段 3/8] ⏸️ Worktree 准备就绪
         分支: feature/REQ-2026-001-promo
         路径: ../order-service-promo
         确认创建吗?

你: ✅ 创建

CC: [阶段 4/8] 编码中... (18 个任务,预计 8h)
    ... 进度同步 ...
    [阶段 5/8] 单元测试...
    ✅ 60 cases passed, 覆盖 87%

CC: [阶段 6/8] ⏸️ Review 报告
    P0: 0
    P1: 1 (Redisson 看门狗)
    P2: 2
    请看 07-review.md 详情

你: ✅ 同意合并

CC: [阶段 7/8] 合并 + 归档
    ✅ REQ-2026-001 完成!
    详见 .history/REQ-2026-001/08-summary.md
```

总交互: **4 次确认**(需求 / Worktree / Review / 收尾),其余全自动。
