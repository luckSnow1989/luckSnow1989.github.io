# gstack 极简卡(半张 A4)

```
┌─────────────────────────────────────────────────┐
│  gstack 极简卡                            v1.0  │
├─────────────────────────────────────────────────┤
│                                                 │
│  🚨 出事: Ctrl+C → /careful → /freeze <dir>    │
│                                                 │
│  🔥 标准流程:                                   │
│  /plan-eng-review → [写] → /review → /qa → /ship│
│                                                 │
│  🧭 不知道下一步?  →  /gstack                  │
│                                                 │
│  🛡️  安全:                                       │
│   生产环境?    →  /careful                      │
│   重构单模块?  →  /freeze <dir>                 │
│   干完了?      →  /unfreeze                     │
│                                                 │
│  🖥️  浏览器 ($B):                                │
│   $B snapshot | click @e3 | type @e5 "x"       │
│   $B screenshot | navigate <url> | logs console│
│                                                 │
│  📦 文件在哪:                                    │
│   skills:    ~/.claude/skills/                 │
│   产物:      ~/.gstack/projects/<id>/          │
│   浏览器:    .gstack/browse.json               │
│                                                 │
│  💡 心法: AI 干活,你决策。夸你 ≠ 你牛。         │
│                                                 │
│  🔧 挂了? cd browse && bun run server.ts &     │
│                                                 │
└─────────────────────────────────────────────────┘
```

**命令字典(完整版看另一张卡)**

规划  /office-hours · /plan-ceo-review · /plan-eng-review ⭐ · /plan-design-review · /design-consultation
质量  /review ⭐ · /investigate · /qa ⭐ · /qa-only · /design-review · /codex
发布  /ship · /document-release · /retro
基建  /gstack · /browse · /setup-browser-cookies · /careful · /freeze · /unfreeze · /guard · /gstack-upgrade