# worktree:04-worktree-info.md

> **何时使用**:阶段 3,完成需求分析后
> **谁负责**:开发人员
> **耗时**:30-60 分钟

---

```markdown
- Worktree 路径: ../order-service-promo
- 分支名:feature/REQ-2026-001-promo
- 基线 commit:main@abc123
- 创建时间:2026-08-01 10:00:00
- 关联需求编号:REQ-2026-001
```


**填写要点**:
- ✅ 主分支保持清洁,所有 feature 都在 worktree
- ✅ 每个 worktree 独立跑 mvn,互不影响
- ✅ worktree 命名规范:`../<service>-<short-desc>`