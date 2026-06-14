# 开源 AI 工作流全景决策树

> 这是一张**完整地图**——覆盖「AI 工作流」这个大概念下的所有主流开源项目。
> 
> 把之前的 5 框架 + cc-workflows + cc-workflows-extras(A 类) + general-ai-workflows(B 类) **全部串起来**。

---

## 总图

```
              ┌──────────────────────────────────────────────┐
              │     你想用 AI 做什么?                          │
              └──────────┬───────────────────────────────────┘
                         │
        ┌────────────────┼────────────────┐
        ▼                ▼                ▼
   「写代码」      「搭应用 / 自动化」   「搭知识库 / Bot」
   (开发者视角)     (工程团队视角)        (业务方视角)
        │                │                │
        ▼                ▼                ▼
   [A 路线]         [B 路线]          [B 路线]
   Claude Code      通用工作流        通用工作流
   生态(下方)       平台(右方)        平台(右方)
```

---

## A 路线:Claude Code 生态(开发者视角)

### A1. Skill 合集(给 AI 立规矩)

```
「我的 AI 总跳过关键步骤 / 不知道怎么做对」
│
├─ 我用 Claude Code
│  │
│  ├─ 我想要工程纪律(测试/TDD/Code Review) ──▶ Superpowers
│  │
│  ├─ 我想要产品视角(需求/CEO 评审/设计) ────▶ gstack
│  │
│  ├─ 我想要完整体系(28 子代理 + 116 技能) ──▶ Everything Claude Code
│  │
│  ├─ 我想要通用规划(任务清单/检查清单) ─────▶ planning-with-files
│  │
│  └─ 我想要 Spec 驱动(SPEC.md → 执行) ─────▶ GSD
│
├─ 我用 Codex / Cursor / Copilot ──▶ Waza(8 个克制 Skill,跨平台)
│
└─ 我觉得上面都太重 ──▶ Waza(8 个 Skill,只做该有的)
```

### A2. 第二梯队(单一焦点项目)

```
「我有一个具体痛点」
│
├─ "AI 不知道下一步做啥" ──▶ Claude Taskmaster(20.9k★,PRD → 任务)
│
├─ "AI 一个人干不动大型项目" ──▶ Ruflo(48k★,多智能体编排)
│
├─ "想每次开发都积累质量" ──▶ Compounding Engineering(Plan-Work-Review)
│
├─ "想并行提速" ──▶ claude-squad(Git worktree + 多 Claude)
│
└─ "想搭 Claude Code 插件 / Marketplace" ──▶ 看 cc-workflows/
```

### A3. CC 全景能力

```
「我不懂 Claude Code,先科普下」
│
└─▶ cc-workflows/ 教程
   覆盖:Skills / Plugins / Marketplaces / Sub-Agents 
         / Hooks / MCP / LSP / Commands / Settings
```

---

## B 路线:通用 AI 工作流平台(业务 / 团队视角)

```
「我想搭一个 AI 应用 / Bot / 知识库」
│
├─ 我不会写代码
│  └─▶ Coze Studio(5 分钟出 Bot,多平台发布)
│
├─ 我是后端工程师 / 产品经理
│  │
│  ├─ 我想自动化现有流程(Slack+DB+邮件)
│  │  └─▶ n8n(500+ 集成,通用自动化王者)
│  │
│  ├─ 我想搭企业级 AI 应用 + RAG
│  │  └─▶ Dify(AI 应用 WordPress,MCP 280+ 工具)
│  │
│  ├─ 我有大量复杂 PDF / 扫描件
│  │  └─▶ RAGFlow(DeepDoc 深度文档理解)
│  │
│  └─ 我想做多 Agent 复杂任务
│     └─▶ LangGraph(代码优先,状态图)
│
├─ 我是 Python 工程师
│  └─▶ LangGraph / LangFlow / Flowise
│
└─ 我想快速原型 / 教学
   └─▶ Flowise / LangFlow(LangChain 拖拽)
```

---

## 灵魂问题 1:你要做的是"工具"还是"产品"?

```
我想做的是?
│
├─ 工具(给开发者用)
│  │
│  ├─ 帮开发者写代码 ──────▶ A 路线(Claude Code 生态)
│  │
│  └─ 帮开发者搭 AI 流水线 ─▶ A 路线(Claude Code 生态)
│
└─ 产品(给最终用户用)
   │
   ├─ AI 客服 / 智能助手 ──▶ B 路线(Dify / Coze / RAGFlow)
   │
   ├─ 知识库问答系统 ─────▶ B 路线(RAGFlow / Dify)
   │
   ├─ 跨系统流程自动化 ───▶ B 路线(n8n)
   │
   └─ 内部效率工具 ──────▶ B 路线(Flowise / Coze)
```

---

## 灵魂问题 2:你的项目阶段

```
我现在在哪?
│
├─ 探索期(0 → 1)
│  └─ 选轻量:Coze / Flowise / Waza
│
├─ 验证期(1 → 10)
│  └─ 选主流:Dify / n8n / Superpowers / GSD
│
├─ 增长期(10 → 100)
│  └─ 选企业级:Ruflo / Compounding / RAGFlow + Dify
│
└─ 成熟期(100+)
   └─ 选自定义:LangGraph / n8n + 自研
```

---

## 灵魂问题 3:你的数据主权要求

```
数据必须自己掌控?
│
├─ 是(金融 / 政务 / 医疗 / 军工)
│  └─▶ 自托管平台:n8n / Dify / RAGFlow
│      避开:Coze(平台托管)
│
└─ 否(普通业务)
   └─▶ 看体验选,都行
```

---

## 灵魂问题 4:你要做什么生意?

```
商业模式?
│
├─ 自用 / 内部工具 ──▶ 任何平台都 OK
│
├─ 做 SaaS 卖给客户 ──▶ 避开 n8n / Dify 多租户限制
│  └─▶ 推荐:LangGraph / RAGFlow / Flowise(MIT / Apache)
│
└─ 嵌入到产品里 ──▶ MIT / Apache 优先
   └─▶ 推荐:LangGraph / Flowise / LangFlow
```

---

## 项目速查总表(15+ 个项目)

### A. Claude Code 生态(开发者视角)

| 项目 | 类别 | Star | 协议 | 一句话 |
|---|---|---|---|---|
| **gstack** | Skill 合集 | 60k+ | - | 虚拟 YC 团队,产品视角 |
| **Superpowers** | Skill 合集 | 145k+ | - | 严格工程纪律,Tech Lead 视角 |
| **Everything Claude Code** | Skill 合集 | 150k+ | - | 28 子代理 + 116 技能 |
| **planning-with-files** | Skill 合集 | 7.5k+ | - | 持久化规划工作流 |
| **GSD** | Skill 合集 | 49k+ | - | Spec 驱动开发 |
| **Waza** | 单一焦点 | 3k+ | - | 8 个克制 Skill |
| **Claude Taskmaster** | 任务分解 | 20.9k | MIT+Commons | PRD → 任务清单 |
| **Ruflo** | 多智能体 | 48k+ | MIT | Swarm 编排 + RAG 记忆 |
| **Compounding Engineering** | 流程 | - | - | Plan-Work-Review 三步法 |
| **claude-squad** | 并行 | - | - | Git worktree + 多 Claude |

### B. 通用 AI 工作流平台(业务视角)

| 平台 | 类别 | Star | 协议 | 一句话 |
|---|---|---|---|---|
| **n8n** | 通用自动化 | 188k+ | Sus. Use | 可编程的 Zapier |
| **Dify** | AI 应用 | 142k+ | 改 Apache | AI 应用 WordPress |
| **Coze Studio** | 零代码 Bot | 新兴 | Apache | 字节的 AI 助手工厂 |
| **LangGraph** | Agent 框架 | 31k+ | MIT | LangChain 嫡系 |
| **RAGFlow** | RAG 引擎 | 80.7k | Apache | 深度文档理解 |
| **Flowise** | LLM 编排 | 45.6k | MIT | LangChain 拖拽 |
| **LangFlow** | LLM 编排 | 40k+ | MIT | LangChain 官方可视化 |

---

## 5 个黄金组合

### 组合 1:Claude Code 开发(单兵)

```
Waza(克制) + Taskmaster(任务) + claude-squad(并行)
```

### 组合 2:Claude Code 开发(团队)

```
Superpowers(纪律) + GSD(Spec) + Ruflo(编排) + Compounding(质量)
```

### 组合 3:企业 AI 应用

```
Dify(应用层) + RAGFlow(文档解析) + n8n(系统集成)
```

### 组合 4:快速 Bot 上线

```
Coze Studio(零代码) + n8n(后期接系统)
```

### 组合 5:复杂多 Agent 系统

```
LangGraph(代码) + LangServe(部署) + LangSmith(观测)
```

---

## 资源链接

- **A 类教程**:`/workspace/{gstack,superpowers,ecc,pwf,gsd}-tutorial/`
- **A 类扩展**:`/workspace/cc-workflows-extras/`
- **CC 全景**:`/workspace/cc-workflows/`
- **B 类教程**:`/workspace/general-ai-workflows/`
- **本总图**:`/workspace/open-source-workflows-overview/`

---

## 一句话总结

> **AI 工作流的世界,分两条河:**
> 
> - **左河(开发者)**:Claude Code 生态——给"用 AI 写代码"的人
> - **右河(业务方)**:通用 AI 平台——给"用 AI 搭应用"的人
> 
> **你是谁,决定你走哪条河。**
> 
> **但跨河的人,跑得最快。**
