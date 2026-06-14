# 通用 AI 工作流平台指南

> 配色:琥珀金 `#b45309`(主)+ `#78350f`(深)+ `#fde68a`(浅)
> 主题:7 大主流**通用 AI 工作流平台** 实战选型手册
> 范围:n8n / Dify / Coze Studio / LangGraph / RAGFlow / Flowise / LangFlow

---

## 0. 为什么需要这一份?

之前 5 框架(以及 cc-workflows-extras)都是 **"给开发者用 Claude Code"** 的视角。但 AI 自动化的更大图景,是 **"给业务方构建 AI 应用"**:

- 公司要做智能客服 → 用啥?
- 团队要搭知识库 → 用啥?
- 运营要接流程自动化 → 用啥?
- 老板要个"AI 助手" → 用啥?

这些场景,大多**不需要写代码**。本教程聚焦 7 大**开源**平台,帮你选对工具、不踩坑。

---

## 1. 一句话定位对比

| 平台 | 一句话 | 适合 |
|---|---|---|
| **n8n** | "可编程的 Zapier"——通用自动化王者,AI 是后加能力 | 跨系统集成、流程自动化 |
| **Dify** | "AI 应用的 WordPress"——LLMOps 一站式,可视化 + 后端 | 企业级 AI 应用 + RAG |
| **Coze Studio** | "字节出品的 AI 助手工厂"——零代码 Bot 平台 | C 端用户、对话机器人 |
| **LangGraph** | "LangChain 嫡系"——代码优先 Agent 状态图 | 复杂多 Agent 系统、Python 工程师 |
| **RAGFlow** | "深度文档理解"——专攻复杂 PDF/表格的 RAG 引擎 | 法律/金融/医疗专业文档 |
| **Flowise** | "LangChain 拖拽版"——LLM 节点式编排 | 快速原型、AI 工程师 |
| **LangFlow** | "LangChain 官方可视化"——Python 自定义组件 | LangChain 深度用户 |

---

## 2. 详细对比矩阵(8 个维度)

| 维度 | n8n | Dify | Coze Studio | LangGraph | RAGFlow | Flowise | LangFlow |
|---|---|---|---|---|---|---|---|
| **定位** | 通用自动化 | AI 应用平台 | 零代码 Bot | Agent 框架 | RAG 引擎 | LLM 编排 | LLM 编排 |
| **开源** | ✅ fair-code | ✅ 改 Apache | ✅ Apache | ✅ MIT | ✅ Apache | ✅ MIT | ✅ MIT |
| **可视化** | ✅ 拖拽 | ✅ 拖拽 | ✅ 拖拽 | ❌ 代码 | ✅ 拖拽 | ✅ 拖拽 | ✅ 拖拽 |
| **AI Agent** | ⚠️ 新增 | ✅ 强 | ✅ 强 | ✅ 原生 | ⚠️ MCP | ✅ | ✅ |
| **集成数** | 500+ | 280+(MCP) | 60+ | LangChain 生态 | 中等 | 100+ | 100+ |
| **学习曲线** | 中 | 中 | 低 | **高** | 中 | 中 | 中 |
| **商用风险** | ⚠️ 需授权 | ⚠️ 有限制 | ✅ Apache | ✅ 无 | ✅ 无 | ✅ 无 | ✅ 无 |
| **GitHub ★** | 188k | 142k | 新兴 | 31k+ | 80.7k | 45.6k | 40k+ |
| **部署** | Docker | Docker | Docker | Python 库 | Docker | Docker | Docker |

---

## 3. 7 大平台深度拆解

### 3.1 n8n — 通用自动化王者

**仓库**:[n8n-io/n8n](https://github.com/n8n-io/n8n) · **Star**:188k+ · **协议**:Sustainable Use License(fair-code)· **商业**:2025 年 10 月获 1.8 亿美元 C 轮,估值 25 亿

**核心场景**:
- 跨 SaaS 集成(Slack / GitHub / Notion / Stripe)
- 定时任务 + 数据处理
- AI Agent 作为工作流的一个节点

**特色**:
- 500+ 集成节点(所有平台里最多)
- 支持 JS / Python 代码节点,无限制扩展
- 自托管 = 数据完全可控
- AI 原生支持(OpenAI / LangChain / Anthropic 节点)

**5 分钟上手**:
```bash
# Docker 启动
docker run -d --name n8n --restart unless-stopped \
  -p 5678:5678 \
  -e N8N_BASIC_AUTH_ACTIVE=true \
  -e N8N_BASIC_AUTH_USER=admin \
  -e N8N_BASIC_AUTH_PASSWORD=yourpass \
  -v ~/.n8n:/home/node/.n8n \
  n8nio/n8n

# 访问 http://localhost:5678
```

**典型工作流**:Webhook 触发 → 调用 AI → 写数据库 → Slack 通知

**⚠️ 商用注意**:
- 社区版免费自用
- **不能把 n8n 本身当 SaaS 卖给客户**(需要企业版授权)
- 内部自动化不受限制

**灵魂问题**:
> **n8n vs Zapier?** 
> n8n:开源、可控、零执行次数限制、有学习曲线
> Zapier:零门槛、SaaS、按执行次数收费
> 
> 选 n8n 如果你在乎:数据主权 / 成本可控 / 长期经营

---

### 3.2 Dify — AI 应用 WordPress

**仓库**:[langgenius/dify](https://github.com/langgenius/dify) · **Star**:142k · **协议**:改 Apache 2.0(多租户限制)· **商业**:2026 年获 3000 万美元 A 轮

**核心场景**:
- 构建 AI 聊天机器人和助手
- RAG 知识库问答
- 企业级 Agentic Workflow

**特色**:
- 可视化工作流编排(ReactFlow)
- Prompt IDE(在线调试 + 多模型对比)
- 50+ 内置工具(Google Search / Stable Diffusion)
- RAG 一体化(混合检索 + 重排)
- **2026 新增 MCP 协议**——可连接 280+ 外部工具

**典型工作流**:上传文档 → RAG 检索 → LLM 生成 → 部署为 API

**⚠️ 商用注意**:
- 多租户 SaaS 服务需要商业授权
- 不可移除/修改 Dify 控制台 Logo 和版权信息

**灵魂问题**:
> **Dify vs Coze Studio?**
> Dify:开源、可控、私有化部署、企业级
> Coze:零代码、字节系生态、不能私有化
> 
> 选 Dify 如果你在乎:开源 / 数据主权 / 长期可控

---

### 3.3 Coze Studio — 字节的 AI 助手工厂

**仓库**:[coze-dev/coze-studio](https://github.com/coze-dev/coze-studio) · **协议**:Apache 2.0 · **背景**:字节跳动

**核心场景**:
- 快速构建 AI 助手 / Bot
- 多平台发布(飞书、抖音、微信公众号、Discord)
- 零代码搭建对话应用

**特色**:
- 100+ 模板(客服 / 翻译 / 营销 Bot)
- 内置 60+ 插件(搜索、代码执行、图像生成)
- 一键发布到多平台
- 与字节系深度集成(豆包、飞书、抖音)

**5 分钟上手**:
- 国际版:[coze.com](https://www.coze.com)
- 国内版:[coze.cn](https://www.coze.cn)
- 注册即用,**无需部署**

**典型工作流**:选模板 → 配知识库 → 调提示词 → 一键发布

**⚠️ 注意**:
- 模型选择绑定平台内置(不支持自定义端点)
- 高级定制和大规模跨系统连接受限
- 私有化部署能力有限

**灵魂问题**:
> **Coze vs Dify 选哪个?**
> 选 Coze 如果你:不懂代码 / 想 5 分钟上线 / 用字节生态
> 选 Dify 如果你:需要私有化 / 想要更多模型 / 企业级

---

### 3.4 LangGraph — Agent 编排的代码方案

**仓库**:[langchain-ai/langgraph](https://github.com/langchain-ai/langgraph) · **Star**:31k+ · **协议**:MIT · **商业**:LangChain Inc

**核心场景**:
- 长时间运行的多 Agent 对话系统
- 有状态工作流(跨会话记忆)
- 研究和实验性 AI 应用

**特色**:
- **代码即配置**——你的 Python 代码就是工作流
- 有状态图(`StateGraph`)——每个节点修改 State,跨节点共享
- **人类在环中断 / 恢复**机制
- 与 LangChain 生态深度集成(100+ 工具、20+ Retriever)
- **MIT 协议,商用最宽松**(无任何限制)

**5 分钟上手**:
```python
from langgraph.graph import StateGraph
from typing import TypedDict

class State(TypedDict):
    messages: list
    next_step: str

def agent(state: State):
    # 调用 LLM 决策
    return {"next_step": "tools"}

def tools(state: State):
    # 调用工具
    return {"next_step": "agent"}

workflow = (
    StateGraph(State)
    .add_node("agent", agent)
    .add_node("tools", tools)
    .add_edge("agent", "tools")
    .add_edge("tools", "agent")
    .compile()
)
```

**灵魂问题**:
> **LangGraph vs 拖拽平台?**
> LangGraph:**代码级别精细控制**,可版本控制、测试、CI/CD
> Dify / Flowise:可视化,但 Agent 内部逻辑是黑盒
> 
> 选 LangGraph 如果你:Python 工程师 / 要复杂多 Agent / 严格可观测

---

### 3.5 RAGFlow — 深度文档理解 RAG 引擎

**仓库**:[infiniflow/ragflow](https://github.com/infiniflow/ragflow) · **Star**:80.7k · **协议**:Apache 2.0 · **公司**:InfiniFlow

**核心场景**:
- 法律 / 金融 / 医疗等**专业文档**问答
- 多来源知识库(PDF + 网页 + 数据库混合)
- 需要**引用溯源**的合规场景

**特色**:
- **DeepDoc 文档解析**——比 Dify 通用解析强 10 倍
  - OCR + 表格结构识别(TSR)+ 布局分析
  - 处理合并单元格、公式、复杂版式
- 模板化分块——可视化展示分块结果
- 引用溯源到原文片段(降低幻觉)
- 双向量引擎(Elasticsearch + Infinity)
- 内置 MCP 支持

**对比 Dify 的 RAG**:
| 维度 | RAGFlow | Dify |
|---|---|---|
| 文档解析 | 专业级,多引擎 | 通用级,主流格式 |
| 引用溯源 | 定位到原文 | 文档级 |
| 向量引擎 | ES / Infinity | 多种 |
| 部署 | 独立服务 | 内嵌 |
| 适合规模 | 大型企业 | 中小型 |

**5 分钟上手**:
```bash
docker compose -f docker/docker-compose.yml up -d
# 最低配置:8 核 32G 内存 + SSD
```

**灵魂问题**:
> **RAGFlow 能替代 Dify 吗?**
> 不能。RAGFlow 是**专用 RAG 引擎**,没有 Dify 的 Prompt IDE 和完整 Agent 框架
> 最佳实践:**RAGFlow 解析 + Dify 调用**——企业级 RAG 黄金组合

---

### 3.6 Flowise — 拖拽式 LLM 编排

**仓库**:[FlowiseAI/Flowise](https://github.com/FlowiseAI/Flowise) · **Star**:45.6k · **协议**:MIT

**核心场景**:
- AI 工程师快速原型
- 内部 AI 工具搭建
- 学习和演示

**特色**:
- **极简**——把 LangChain 抽象成画布节点
- 拖一个"Ollama LLM" + 拖一个"Chroma Vector" + 拖一个"Prompt" = 跑通 RAG
- 5 分钟搭出本地大模型 RAG
- 100+ 预制节点

**5 分钟上手**:
```bash
npm install -g flowise
npx flowise start
# 访问 http://localhost:3000
```

**典型用例**:
- 产品经理搭知识库问答机器人
- 运营配自动抓取竞品文案的 Agent
- 实习生 5 分钟跑通本地 RAG 流程

**灵魂问题**:
> **Flowise vs LangFlow?**
> Flowise:生态大,易上手,适合快速原型
> LangFlow:LangChain 官方,Python 自定义,深度用户
> 
> 新手选 Flowise;LangChain 深度用户选 LangFlow

---

### 3.7 LangFlow — LangChain 官方可视化

**仓库**:[langflow-ai/langflow](https://github.com/langflow-ai/langflow) · **Star**:40k+ · **协议**:MIT

**特色**:
- **LangChain 官方出品**——和 LangChain 无缝集成
- Python 自定义组件——可以完全掌控底层逻辑
- 多模型支持(LLM、向量库、AI 工具)
- 多智能体编排
- 快速部署:导出为 API / MCP Server / Python 应用

**5 分钟上手**:
```bash
pip install langflow
langflow run
# 访问 http://localhost:7860
```

**典型用例**:
- LangChain 用户的快速可视化
- Python 自定义组件集成
- 多智能体协同工作流

---

## 4. 选型决策树

### 决策 1:技术能力

```
你是?
├─ 不会写代码 ────────────▶ Coze Studio(零代码)
│
├─ 产品经理 / 运营 ────────▶ Dify 或 Coze(可视化)
│
├─ 后端工程师 ────────────▶ n8n(集成) 或 Dify(AI)
│
├─ Python 工程师 ──────────▶ LangGraph(精细控制)
│
└─ LangChain 深度用户 ────▶ LangFlow / Flowise
```

### 决策 2:核心诉求

```
你要做什么?
├─ 跨系统自动化(Slack + 数据库 + 邮件)
│  └─▶ n8n ★★★★★
│
├─ 企业 AI 应用(知识库 + 对话 + API)
│  └─▶ Dify ★★★★★
│
├─ C 端 Bot / 助手(发布到飞书 / 抖音)
│  └─▶ Coze Studio ★★★★★
│
├─ 复杂多 Agent 协同
│  └─▶ LangGraph ★★★★★
│
├─ 专业文档问答(法律 / 金融 / 医疗)
│  └─▶ RAGFlow ★★★★★
│
├─ 快速原型 / 内部工具
│  └─▶ Flowise ★★★
│
└─ LangChain 项目可视化
   └─▶ LangFlow ★★★
```

### 决策 3:数据主权

```
数据必须自己掌控?
├─ 是(金融 / 政务 / 医疗)
│  └─▶ 自托管平台:n8n / Dify / RAGFlow
│
└─ 否(普通业务)
   └─▶ 随便选,看体验
```

### 决策 4:商用授权

```
你的商业模式?
├─ 自用 + 内部工具 ─────▶ 任何平台都 OK
│
├─ 做 SaaS 卖给客户 ────▶ 避开 n8n / Dify 多租户限制
│  └─▶ 推荐:LangGraph / RAGFlow / Flowise / LangFlow(MIT / Apache)
│
└─ 嵌入到产品里 ────────▶ MIT / Apache 优先
   └─▶ 推荐:LangGraph / Flowise / LangFlow
```

---

## 5. 黄金组合

### 组合 1:企业级 RAG 黄金组合

```
RAGFlow(解析专业文档) ──HTTP──▶ Dify(LLM 应用层)
                          ↑
                       提供 RAG API
```

**适用**:法律 / 金融 / 医疗企业,文档复杂 + 需要应用层

### 组合 2:DevOps + AI 黄金组合

```
n8n(连接 GitHub / Slack / DB) ──HTTP──▶ Dify(AI 处理)
                                    ↑
                                 提供 AI API
```

**适用**:技术团队,既要做自动化又要做 AI

### 组合 3:快速 Bot 黄金组合

```
Coze Studio(快速搭 Bot) ──导出──▶ 多平台发布
                              ↑
                          字节系生态
```

**适用**:运营 / 内容创作者,想快速上线

### 组合 4:复杂 Agent 黄金组合

```
LangGraph(代码级多 Agent) ──LangServe──▶ 部署为 REST API
                                       ↑
                                    Python 工程师
```

**适用**:研究 / 实验 / 复杂多步任务

---

## 6. 部署方式速查

| 平台 | 推荐部署 | 最低配置 |
|---|---|---|
| n8n | Docker / npm | 2 核 4G |
| Dify | Docker Compose | 2 核 4G |
| Coze Studio | Docker(2026 改开源) | 4 核 8G |
| LangGraph | Python 库 / LangServe | 2 核 4G |
| RAGFlow | Docker | **8 核 32G + SSD** |
| Flowise | npm / Docker | 1 核 2G |
| LangFlow | pip | 1 核 2G |

---

## 7. 商业模式 / 许可证速查

| 平台 | 协议 | 商用 | 自托管 SaaS |
|---|---|---|---|
| n8n | Sustainable Use License | ✅ | ❌ 需授权 |
| Dify | 改 Apache 2.0 | ✅ | ⚠️ 需授权(多租户) |
| Coze Studio | Apache 2.0 | ✅ | ✅ |
| LangGraph | MIT | ✅ | ✅ |
| RAGFlow | Apache 2.0 | ✅ | ✅ |
| Flowise | MIT | ✅ | ✅ |
| LangFlow | MIT | ✅ | ✅ |

> ⚠️ **重要**:做 SaaS 产品前,务必检查最新许可证——版本更新可能变更条款。

---

## 8. 实战速查表

### 8.1 我想要 X,选哪个?

| 我想要 | 推荐 | 备选 |
|---|---|---|
| 智能客服(对接现有 CRM) | Dify | n8n + LLM |
| 公司内部知识库 | RAGFlow(复杂文档) / Dify(通用) | LangGraph |
| 内容创作 Bot | Coze Studio | Flowise |
| 定时跑数据 + AI 分析 | n8n | Dify |
| 复杂研究 Agent(多步推理) | LangGraph | Dify |
| 营销活动自动化 | n8n | Coze |
| 法律合同审查 | RAGFlow | Dify + RAGFlow |
| 财务数据 ETL | n8n | 自建 |
| 跨平台 Bot(微信+飞书+邮件) | Coze Studio | n8n |
| 教学 / 演示 | Flowise | LangFlow |
| 企业级 RAG | RAGFlow + Dify | 自建 LangGraph |

### 8.2 灵魂问题速答

**Q:不会代码,选啥?**
A:Coze Studio(5 分钟出 Bot)

**Q:文档特别复杂(扫描件 PDF / 表格),选啥?**
A:RAGFlow(DeepDoc 解析)

**Q:要做成 SaaS 卖给别人,选啥?**
A:LangGraph / RAGFlow / Flowise(MIT / Apache,无授权问题)

**Q:想接最多第三方服务,选啥?**
A:n8n(500+ 集成)

**Q:想代码级精细控制,选啥?**
A:LangGraph(代码即配置)

**Q:想接字节系生态(飞书/抖音),选啥?**
A:Coze Studio

**Q:数据必须本地,选啥?**
A:都支持自托管,看体验选

---

## 9. 资源链接

- [n8n 官方](https://n8n.io/)
- [Dify 官方](https://dify.ai/)
- [Coze Studio](https://www.coze.com/) · [Coze.cn](https://www.coze.cn/)
- [LangGraph 文档](https://langchain-ai.github.io/langgraph/)
- [RAGFlow 官方](https://ragflow.io/)
- [Flowise 官方](https://flowiseai.com/)
- [LangFlow 官方](https://www.langflow.org/)

---

## 10. 一句话总结

> **没有"最好"的 AI 工作流平台,只有"最合适"的。**
>
> - 不会代码 + 快速出 Bot → **Coze**
> - 跨系统集成 + 流程自动化 → **n8n**
> - 企业 AI 应用 + RAG → **Dify**
> - 复杂多 Agent + 精细控制 → **LangGraph**
> - 专业文档 + 引用溯源 → **RAGFlow**
> - 快速原型 + LangChain → **Flowise / LangFlow**
>
> **选错不可怕,组合用才出奇迹**。
