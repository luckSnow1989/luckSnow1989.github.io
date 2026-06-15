# AI 编程框架 + 通用工作流平台 工具箱

> 5 大 AI 编程框架(Claude Code 生态)+ 10 个开源工作流项目(2 条河)+ **Spring Cloud 微服务工作流手册(8 阶段)** 完整教程 + 速查卡 + 选型工具

---

## 🆕 v3.1 重大更新:1 句话启动 + 3 hooks 全自动(不用再说 8 次"下一步")

上次发布 v3.0 后,用户反馈:8 阶段流程每步都需手动触发,很麻烦。这次加了**自动化层**——一个 slash command + 3 个 hooks,中间只在 4 个关键节点让你拍板:

- 🪝 **`/req-full` 一句话启动** 8 阶段流程
- 🪝 **Hook 1(stage-tracker)** — 检测关键词自动推进状态机
- 🪝 **Hook 2(doc-validator)** — 写 0X-*.md 后自动验证必填字段
- 🪝 **Hook 3(coverage-check)** — `mvn test` 跑完自动检查 JaCoCo 覆盖率
- ⏸️ **4 个检查点**:0 需求 / 3 Worktree / 6 Review / 7 收尾
- ⏱️ **省时**:30-60 分钟/需求

## v3.0 重大更新:加了 Spring Cloud 微服务实战工作流手册

之前只有"**用什么框架**"的视角。这次加了"**怎么用**"的视角——**Spring Cloud 微服务 + Claude Code 的 8 阶段开发流程**:

- ✅ 每个新需求按 8 阶段走(需求 → 设计 → 任务 → Worktree → 编码 → 单测 → Review → 归档)
- ✅ 强制 TDD + JUnit 5 + Mockito + Testcontainers + JaCoCo(覆盖 ≥ 80%)
- ✅ 每阶段 1 份留痕文档(8 份 = 一次完整交付)
- ✅ 需求/重构/Bug 三类场景都有完整实例
- ✅ A3 横向流程图,贴墙用

---

## v2.0 重大更新:加了"开源工作流"完整地图

之前只覆盖 **5 个 AI 编程框架**(都偏 Claude Code)。这次扩展到 **15+ 个开源工作流项目**,分**两条河**:

- **🅰 A 河(开发者视角)**:Claude Code 生态,5 框架 + 5 个第二梯队(Waza/Taskmaster/Ruflo/CE/squad)
- **🅱 B 河(业务方视角)**:7 个通用 AI 工作流平台(n8n/Dify/Coze/LangGraph/RAGFlow/Flowise/LangFlow)

> **跨河的人,跑得最快。**

---

## 🚀 不知道该用哪个?

**先看这两份**:
- 🎯 **[开源 AI 工作流全景图](open-source-workflows-overview/overview-full-1.png)** —— 15+ 项目一张图,A 河 + B 河
- 🌳 **[全景决策树](open-source-workflows-overview/decision-tree.md)** —— 5 分钟从"不知道"到"装它"

**10 秒速记**:
- 不会代码 + 快速出 Bot → `Coze Studio`(🅱 B 河)
- 跨系统自动化(Slack+DB+邮件) → `n8n`(🅱 B 河)
- 企业 AI 应用 + RAG → `Dify`(🅱 B 河)
- 复杂多 Agent 协同 → `LangGraph`(🅱 B 河) / `Ruflo`(🅰 A 河)
- 专业文档问答(法律/金融/医疗) → `RAGFlow`(🅱 B 河)
- Claude Code 写代码 + 强工程纪律 → `Superpowers`(🅰 A 河)
- Claude Code 写代码 + 产品视角 → `gstack`(🅰 A 河)
- Claude Code 写代码 + 完整体系 → `Everything Claude Code`(🅰 A 河)
- 想要克制的 Skill 包(8 个) → `Waza`(🅰 A 河)
- 想要并行提速 → `claude-squad`(🅰 A 河)

---

## 🗺️ 完整地图(2 大河 + 3 大区域)

```
AI 工作流全景
│
├── 🅰 A 河:Claude Code 生态(给"用 AI 写代码"的人)
│   │
│   ├── A1. Skill 合集(给 AI 立规矩)— 5 框架
│   │   • gstack / Superpowers / ECC / PWF / GSD
│   │
│   ├── A2. 第二梯队(单一焦点项目)— 5 项目
│   │   • Waza / Claude Taskmaster / Ruflo /
│   │     Compounding Engineering / claude-squad
│   │
│   └── A3. CC 全景能力 — 1 教程
│       • cc-workflows/(Skills/Plugins/MCP/Hooks...)
│
└── 🅱 B 河:通用 AI 工作流平台(给"用 AI 搭应用"的人)
    │
    ├── 7 大平台
    │   • n8n / Dify / Coze Studio / LangGraph /
    │     RAGFlow / Flowise / LangFlow
    │
    └── 教程 + 速查卡(general-ai-workflows/)
```

---

## 📚 完整教程(8 套,每个一份)

### 🅰 A 河:Claude Code 生态

| 区域 | 教程 | 颜色 | 主题 | 适合 |
|---|---|---|---|---|
| **A1 框架** | [📖 gstack](gstack-tutorial/gstack-tutorial.md) | 🟦 蓝 | 角色视角 | 独立开发 / Web 创业 |
| | [📖 Superpowers](superpowers-tutorial/superpowers-tutorial.md) | 🟪 紫 | 流程纪律 | 后端 / 重构 / 跨平台 |
| | [📖 Everything Claude Code](ecc-tutorial/ecc-tutorial.md) | 🟧 橙 | 工具全家桶 | 重度用户 / 企业 |
| | [📖 Planning with Files](pwf-tutorial/pwf-tutorial.md) | 🟩 青 | 持久化记忆 | 长任务 / 多项目 |
| | [📖 GSD](gsd-tutorial/gsd-tutorial.md) | 🟥 玫红 | 上下文隔离 | 中大型 / 原型 |
| **A2 扩展** | [📖 CC 生态第二梯队](cc-workflows-extras/cc-workflows-extras.md) | 🟢 墨绿 | 单一焦点项目 | 痛点明确 |
| **A3 全景** | [📖 CC 工作流全景](cc-workflows/cc-workflows.md) | 🟦 深蓝灰 | 8 大扩展点 | 想搞懂 CC 生态 |
| **🅱 B 河** | [📖 通用 AI 工作流平台](general-ai-workflows/general-ai-workflows.md) | 🟧 琥珀金 | 7 大平台 | 业务方 / 团队 |
| **总图** | [📖 全景决策树](open-source-workflows-overview/decision-tree.md) | 🟣 靛蓝 | 2 河合并 | 谁都看 |
| **🆕 Spring Cloud 工作流** | [📖 8 阶段开发手册](spring-cloud-workflow/spring-cloud-workflow.md) | 🟦 深青 | CC 实战 + 单测 + 留痕 | Java 后端 |
| **🆕 自动化层** | [📖 自动化配置 + 教程](spring-cloud-workflow/automation/docs/01-快速安装.md) | 🟦 深青 | /req-full + 3 hooks | 所有人 |

每套教程结构:
- 第 0 章:是什么 + 跟其他框架怎么区分
- 环境准备(10 分钟跑通)
- 核心机制详解
- 实战演练
- 对比与组合
- 常见陷阱
- 灵魂问题
- 精通路径 + 资源

---

## 🖼️ 16 张速查卡(图片,贴墙用)

### 🅰 A 河速查卡

| 框架 / 项目 | 完整版(A4) | 极简版(A5) |
|---|---|---|
| **5 框架** | | |
| gstack | [🟦 cheatsheet-full-1.png](gstack-tutorial/gstack-full-1.png) | [🟦 cheatsheet-tiny-1.png](gstack-tutorial/gstack-tiny-1.png) |
| Superpowers | [🟪 cheatsheet-full-1.png](superpowers-tutorial/cheatsheet-full-1.png) | [🟪 cheatsheet-tiny-1.png](superpowers-tutorial/cheatsheet-tiny-1.png) |
| ECC | [🟧 cheatsheet-full-1.png](ecc-tutorial/ecc-full-1.png) | [🟧 cheatsheet-tiny-1.png](ecc-tutorial/ecc-tiny-1.png) |
| pwf | [🟩 cheatsheet-full-1.png](pwf-tutorial/pwf-full-1.png) | [🟩 cheatsheet-tiny-1.png](pwf-tutorial/pwf-tiny-1.png) |
| GSD | [🟥 cheatsheet-full-1.png](gsd-tutorial/gsd-full-1.png) | [🟥 cheatsheet-tiny-1.png](gsd-tutorial/gsd-tiny-1.png) |
| **A2 第二梯队** | | |
| CC 工作流第二梯队 | [🟢 cheatsheet-full-1.png](cc-workflows-extras/cheatsheet-full-1.png) | [🟢 cheatsheet-tiny-1.png](cc-workflows-extras/cheatsheet-tiny-1.png) |
| **A3 全景** | | |
| CC 工作流全景 | [🟦 cheatsheet-full-1.png](cc-workflows/cheatsheet-full-1.png) | [🟦 cheatsheet-tiny-1.png](cc-workflows/cheatsheet-tiny-1.png) |

### 🅱 B 河速查卡

| 平台 / 总图 | 完整版(A4) | 极简版(A5) |
|---|---|---|
| **7 大平台** | [🟧 cheatsheet-full-1.png](general-ai-workflows/cheatsheet-full-1.png) | [🟧 cheatsheet-tiny-1.png](general-ai-workflows/cheatsheet-tiny-1.png) |
| **2 河总图** | [🟣 overview-full-1.png](open-source-workflows-overview/overview-full-1.png) | [🟣 overview-tiny-1.png](open-source-workflows-overview/overview-tiny-1.png) |
| **5 框架总图** | [🟦 five-frameworks-1.png](five-frameworks/five-frameworks-1.png) | — |

### 🆕 Spring Cloud 工作流(Java 实战)

| 主题 | 完整版(A4) | 极简版(A5) | 流程图(A3 横向) |
|---|---|---|---|
| **8 阶段工作流** | [🟦 cheatsheet-full-1.png](spring-cloud-workflow/cheatsheet-full-1.png) | [🟦 cheatsheet-tiny-1.png](spring-cloud-workflow/cheatsheet-tiny-1.png) | [🟦 flow-diagram-1.png](spring-cloud-workflow/flow-diagram-1.png) |
| **🆕 自动化(/req-full + hooks)** | [🟦 cheatsheet-automation-1.png](spring-cloud-workflow/automation/cheatsheet-automation-1.png) | — | — |

**打印建议**:
- 完整版 A4 彩色 → 显示器旁
- 极简版 A5 黑白即可 → 桌角/工具墙
- 塑封防咖啡 ☕

---

## 🎯 推荐使用路径

### 🅰 给开发者(写代码)

```
第 1 步:看 [5 框架总览图] / [全景图] 选型
   ↓
第 2 步:看 [决策树] 确认
   ↓
第 3 步:读对应框架的 [教程] 跑通
   ↓
第 4 步:打印 [速查卡] 贴墙
   ↓
第 5 步:熟练后回来加第二梯队(Waza/Taskmaster/Ruflo...)
   ↓
第 6 步:看 [cc-workflows/] 了解 CC 生态全景
   ↓
第 7 步(可选):用 [claude-squad] 提速
```

### 🅱 给业务方 / 团队(搭应用)

```
第 1 步:看 [7 平台总图] 选型
   ↓
第 2 步:看 [决策树] 确认
   ↓
第 3 步:读 [general-ai-workflows/ 教程] 跑通
   ↓
第 4 步:打印 [B 河速查卡] 贴墙
   ↓
第 5 步:选 1-2 个 [黄金组合] 落地
   ↓
第 6 步(可选):用 A 河(Claude Code 生态)写 MCP/API 增强 B 河
```

---

## 📊 A 河 5 框架一眼对比(开发者视角)

| 维度 | gstack | Superpowers | ECC | pwf | GSD |
|---|---|---|---|---|---|
| **颜色** | 🟦 | 🟪 | 🟧 | 🟩 | 🟥 |
| **规模** | 23 角色 | 14 skill | 181+47+34+8 | 3 文件+5 hook | 33 agent+41 文档 |
| **触发** | 手动 | 自动 | 混合 | 混合 | 流程驱动 |
| **平台** | 1 | 6 | 6 | 14+ | 4+ |
| **核心武器** | 真实浏览器 | TDD 铁律 | 三钩记忆+安全 | PreToolUse 防漂 | 上下文隔离 |
| **心法** | 你决策 | 系统优于临时 | 沉淀自己 | 写硬盘 | 别硬撑 |
| **新手推荐** | ★★★★ | ★★★★★ | ★★ | ★★★ | ★★★★ |
| **大项目推荐** | ★★★ | ★★★★ | ★★★★★ | ★★★★ | ★★★★★ |

---

## 📊 B 河 7 平台一眼对比(业务视角)

| 维度 | n8n | Dify | Coze | LangGraph | RAGFlow | Flowise | LangFlow |
|---|---|---|---|---|---|---|---|
| **颜色** | 🟧 | 🟧 | 🟧 | 🟧 | 🟧 | 🟧 | 🟧 |
| **定位** | 通用自动化 | AI 应用 | 零代码 Bot | Agent 框架 | RAG 引擎 | LLM 编排 | LLM 编排 |
| **★** | 188k | 142k | 新兴 | 31k | 80.7k | 45.6k | 40k |
| **可视化** | ✅ | ✅ | ✅ | ❌ | ✅ | ✅ | ✅ |
| **集成数** | 500+ | 280+ | 60+ | LC 生态 | 中 | 100+ | 100+ |
| **学习曲线** | 中 | 中 | 低 | **高** | 中 | 中 | 中 |
| **商用风险** | ⚠️ | ⚠️ | ✅ | ✅ | ✅ | ✅ | ✅ |
| **适合** | 跨系统 | 企业 AI+RAG | C 端 Bot | 复杂多 Agent | 专业文档 | 快速原型 | LC 用户 |

---

## 🏆 5 个黄金组合(实战验证)

### 🅰 A 河组合

1. **单兵 Claude Code**:Waza(克制)+ Taskmaster(任务)+ claude-squad(并行)
2. **团队 Claude Code**:Superpowers(纪律)+ GSD(Spec)+ Ruflo(编排)+ Compounding(质量)

### 🅱 B 河组合

3. **企业 AI 应用**:Dify(应用层)+ RAGFlow(文档解析)+ n8n(系统集成)
4. **快速 Bot 上线**:Coze Studio(零代码)+ n8n(后期接系统)
5. **复杂多 Agent**:LangGraph(代码)+ LangServe(部署)+ LangSmith(观测)

### 🅰↔🅱 跨河组合(神级)

> **A 河(Claude Code 生态)写代码,产出 MCP / API;B 河(通用平台)集成到业务流程。**
>
> 例子:Claude Code + Superpowers 写好「文档解析 MCP Server」 → Dify 工作流调用它 → n8n 触发「收到新文档就解析入库」 → RAGFlow 提供检索

---

## 💼 15+ 项目 GitHub 速查

### 🅰 A 河(开发者)

**5 框架**:
- [garrytan/gstack](https://github.com/garrytan/gstack) — 60k+
- [obra/superpowers](https://github.com/obra/superpowers) — 145k+
- [affaan-m/everything-claude-code](https://github.com/affaan-m/everything-claude-code) — 150k+
- [OthmanAdi/planning-with-files](https://github.com/OthmanAdi/planning-with-files) — 7.5k+
- [gsd-build/get-shit-done](https://github.com/gsd-build/get-shit-done) — 49k+

**5 个第二梯队**:
- [tw93/waza](https://github.com/tw93/waza) — 3k+ · 8 个克制 Skill
- [eyaltoledano/claude-task-master](https://github.com/eyaltoledano/claude-task-master) — 20.9k · PRD→任务
- [ruvnet/ruflo](https://github.com/ruvnet/ruflo) — 48k+ · 多智能体编排
- [EveryInc/compounding-engineering-plugin](https://github.com/EveryInc/compounding-engineering-plugin) — Plan-Work-Review
- [smtg-ai/claude-squad](https://github.com/smtg-ai/claude-squad) — Git worktree 并行

### 🅱 B 河(业务)

- [n8n-io/n8n](https://github.com/n8n-io/n8n) — 188k+ · 通用自动化
- [langgenius/dify](https://github.com/langgenius/dify) — 142k+ · AI 应用
- [coze-dev/coze-studio](https://github.com/coze-dev/coze-studio) — 字节 AI 助手工厂
- [langchain-ai/langgraph](https://github.com/langchain-ai/langgraph) — 31k+ · Agent 框架
- [infiniflow/ragflow](https://github.com/infiniflow/ragflow) — 80.7k+ · 深度文档 RAG
- [FlowiseAI/Flowise](https://github.com/FlowiseAI/Flowise) — 45.6k+ · LLM 拖拽
- [langflow-ai/langflow](https://github.com/langflow-ai/langflow) — 40k+ · LC 官方可视化

---

## 🛠️ 附带 Skills(可复用工作流)

- **[html2png](.skills/html2png/)** — HTML → PDF → PNG 一键渲染(本工具箱所有速查卡用的就是这个)
- **[skill-creator](.skills/skill-creator/)** — 把重复工作流变成可复用 skill 的元工具

---

## 📝 工具箱内容统计(v3.1)

- 📘 **10 套完整教程**(v2 的 9 套 + Spring Cloud 8 阶段工作流)
- 🖼️ **22 张图片**(v3.0 的 21 张 + 1 张自动化速查卡)
- 🪝 **3 个自动化 Hooks**(stage-tracker / doc-validator / coverage-check)
- 📜 **1 个 slash command**(`/req-full` 一锅端)
- ⚙️ **1 份完整 settings.json** 模板
- 🌳 **2 份选型决策树**(5 框架版 + 全景版)
- 📊 **2 份横向对比表**(5 框架 + 7 平台)
- 📋 **8 份留痕文档模板**(Spring Cloud 工作流)
- 💡 **3 个完整实例 + 1 个 demo**(新增需求 / 复杂重构 / 线上 Bug / 5 分钟跑通)
- 🛠️ **2 个附带的可复用 skills**
- 📦 总计 **~5.7MB** 压缩包

**最后更新**:2026 年 6 月
**适用版本**:基于各项目 2026 年 Q1-Q2 公开数据 + Claude Code 2.1+ 生态 + Spring Boot 3.2.x / Spring Cloud 2023.x

---

## 一句话总结

> **AI 工作流的世界,分两条河。**
>
> - **左河(开发者)**:Claude Code 生态——给"用 AI 写代码"的人
> - **右河(业务方)**:通用 AI 平台——给"用 AI 搭应用"的人
>
> **你是谁,决定你走哪条河。**
>
> **但跨河的人,跑得最快。**
>
> **而当你用 CC 写 Spring Cloud 微服务时,8 阶段流程 + 8 份留痕文档,让你不只写代码,还在积累团队的数字资产。**
