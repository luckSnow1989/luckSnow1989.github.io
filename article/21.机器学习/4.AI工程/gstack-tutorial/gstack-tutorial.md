# gstack 入门到精通:AI 时代的"虚拟工程团队"使用指南

> 一份从零开始的实战教程,目标:30 分钟跑通,半天入门,一周精通。

---

## 目录

- [第 0 章:在开始之前——你需要知道 gstack 到底是什么](#第-0-章在开始之前你需要知道-gstack-到底是什么)
- [第 1 章:环境准备(10 分钟跑通)](#第-1-章环境准备10-分钟跑通)
- [第 2 章:第一个命令 `/gstack`(10 分钟)](#第-2-章第一个命令-gstack10-分钟)
- [第 3 章:四大阶段全景(30 分钟)——从想法到上线](#第-3-章四大阶段全景30-分钟从想法到上线)
  - [3.1 产品规划层(写代码之前)](#31-产品规划层写代码之前)
  - [3.2 质量保障层(写代码时 + 写完之后)](#32-质量保障层写代码时--写完之后)
  - [3.3 发布运营层(交付)](#33-发布运营层交付)
  - [3.4 基础设施层(安全 + 效率)](#34-基础设施层安全--效率)
- [第 4 章:端到端实战——一个完整 Feature 的全流程](#第-4-章端到端实战一个完整-feature-的全流程)
- [第 5 章:无头浏览器引擎 `$B`(gstack 最硬核的发明)](#第-5-章无头浏览器引擎-bgstack-最硬核的发明)
- [第 6 章:Prompt 工程最佳实践(从 gstack 源码学到的)](#第-6-章prompt-工程最佳实践从-gstack-源码学到的)
- [第 7 章:21 个技能速查表](#第-7-章21-个技能速查表)
- [第 8 章:自定义与扩展——打造你自己的 skills](#第-8-章自定义与扩展打造你自己的-skills)
- [第 9 章:常见问题与争议(理性看待)](#第-9-章常见问题与争议理性看待)
- [第 10 章:精通路径与学习资源](#第-10-章精通路径与学习资源)
- [附录:一份可拷贝的初始化检查清单](#附录一份可拷贝的初始化检查清单)

---

## 第 0 章:在开始之前——你需要知道 gstack 到底是什么

### 0.1 一句话定义

**gstack = 一套 Claude Code 技能包(Skills),用"角色 + 流程"的方式,把你的 AI 编程助手变成一支虚拟工程团队。**

它**不是**:
- ❌ 新的底层模型
- ❌ 单纯的 prompt 模板合集(虽然包含 prompt)
- ❌ 一个独立的 IDE 或 SaaS 平台

它是:
- ✅ 一组 Markdown 技能文件 + 一个 TypeScript 写的浏览器守护进程
- ✅ 专为 Claude Code 设计(也兼容部分 OpenAI Codex)
- ✅ MIT 开源,GitHub: <https://github.com/garrytan/gstack>

### 0.2 谁搞出来的?为什么火?

作者是 **Garry Tan**,Y Combinator(硅谷最顶级的创业孵化器,投出过 Airbnb、Stripe、Reddit 等)的现任 CEO。在成为 CEO 之前,他是 Palantir 早期工程师 + Posterous 联合创始人,自己亲手写过几十万行代码。

他声称:用 gstack 在 60 天内(兼职状态下)写了 **60 万行生产代码**,其中 35% 是测试代码。如果按"逻辑代码变更量"算,效率是 2013 年的 **400 倍**。

这个项目 2026 年初开源,几个星期突破 60k star,争议也很大——但**值不值得学**取决于你后面读完的判断。

### 0.3 核心理念(读懂这三条就够)

1. **Thin Harness, Fat Skills**(薄框架,厚技能)
   底层执行框架越简单越好,真正有价值的是写好"技能"——也就是结构化的 Markdown 工作流。

2. **不要半途而废,要煮干整片湖**(Don't be half-invested, boil the whole lake)
   100% 质量是可实现的,不要满足于"差不多能跑"。

3. **流程即代码,Markdown 是新的编程语言**
   Markdown 不只是文档,它驱动整个 Agent 系统;slash command 是函数调用;角色是模块;流程是 runtime。

### 0.4 适合谁?不适合谁?

| ✅ 适合 | ❌ 不适合 |
|---|---|
| 已经在用 Claude Code 的人 | 还没用过任何 AI 编程工具(先去试 Cursor/Copilot) |
| 个人开发者、独立黑客 | 完全不懂代码的非技术创业者(会有"幻觉陷阱",见第 9 章) |
| 想把工程流程规范化的团队负责人 | 期望"一键替代工程师"的人 |
| 对 Prompt 工程感兴趣的人 | — |

### 0.5 你需要准备什么

| 项目 | 要求 |
|---|---|
| Claude Code | 订阅 Claude Pro/Max,或 Anthropic API Key |
| Node.js / Bun | Node 18+ 或 Bun 1.0+(推荐 Bun,后面会讲为什么) |
| 操作系统 | macOS / Linux 原生支持;Windows 用 WSL2 |
| 已有项目 | 任意 Git 仓库(没有也行,可以从零开始) |

---

## 第 1 章:环境准备(10 分钟跑通)

### 1.1 安装 Claude Code

按官方文档:<https://docs.claude.com/en/docs/claude-code>

```bash
# macOS / Linux / WSL
curl -fsSL https://claude.ai/install.sh | sh

# 验证
claude --version
```

首次运行会让你登录 Anthropic 账号。

### 1.2 安装 Bun(gstack 的浏览器引擎依赖)

```bash
curl -fsSL https://bun.sh/install | bash

# 验证
bun --version
# 应该是 1.0 或更高
```

> **为什么推荐 Bun?**
> gstack 的浏览器守护进程(`browse daemon`)是基于 Bun 写的,`bun build --compile` 能把 CLI 打成 58MB 的单一可执行文件,启动比 Node 快一个数量级。

### 1.3 安装 Playwright(浏览器自动化)

```bash
# 用 npx 或 bunx 都行
bunx playwright install chromium
```

### 1.4 克隆 gstack 仓库

```bash
git clone https://github.com/garrytan/gstack.git
cd gstack
```

### 1.5 安装 skills 到 Claude Code

gstack 的 skills 都在 `.agents/skills/` 目录下,有两种用法:

**方式 A:放到全局(推荐新手)**

```bash
# Claude Code 的全局 skills 目录
mkdir -p ~/.claude/skills
cp -r .agents/skills/* ~/.claude/skills/

# 验证
ls ~/.claude/skills
# 应该看到 office-hours/, plan-ceo-review/, qa/, review/ ...
```

**方式 B:放到项目里(推荐团队)**

```bash
# 在你的项目根目录
mkdir -p .claude/skills
cp -r /path/to/gstack/.agents/skills/* .claude/skills/

# 把这行加进 .gitignore(可选,如果你不想让团队成员都装)
# .claude/skills/
```

### 1.6 启动浏览器守护进程

```bash
cd browse
bun install
bun run server.ts
```

你应该看到类似这样的输出:

```
[gstack-browse] Listening on http://127.0.0.1:38291
[gstack-browse] Auth token: ********
[gstack-browse] Cookie store: ready
```

> 这个守护进程会一直跑在后台,保持浏览器登录态、Cookie、打开的 Tab。
> 第一次启动会生成一个 PID + 端口 + Token,存到 `.gstack/browse.json`。

### 1.7 健康检查

```bash
# 确认所有部件就位
claude                              # 启动 Claude Code
# 在 Claude Code 里输入:
/gstack
```

如果一切正常,你会看到 gstack 的欢迎信息和 21 个可用命令的清单。✅

---

## 第 2 章:第一个命令 `/gstack`(10 分钟)

### 2.1 `/gstack` 是入口

`/gstack` 不只是"显示帮助",它是一个**上下文感知的工作流推荐器**。

打开 Claude Code,进入你的项目目录,输入:

```
/gstack
```

gstack 会做三件事:

1. **检查 Git 状态**——脏工作区?会让你先 commit 或 stash
2. **判断你处于哪个开发阶段**——规划?编码?测试?发布?
3. **推荐下一步该用哪个 skill**

举个例子,如果你刚开一个新功能,它会说:

```
你现在处于:规划阶段
推荐命令:/plan-eng-review <feature-name>
```

### 2.2 自然语言也能用

gstack 的命令路由(`command_router.py`)会解析你的输入,所以你不用死记命令:

```
# 这些都行
"review my code"           → /review
"部署到生产"                → /ship
"为什么这个测试挂了"        → /investigate
"给我讲讲这个 idea"         → /office-hours
```

### 2.3 关键快捷键

| 快捷键 | 作用 |
|---|---|
| `/gstack` | 入口 + 工作流推荐 |
| `Ctrl+C` | 中断当前 skill |
| `$B <cmd>` | 直接调用浏览器底层(第 5 章讲) |
| `/careful` | 开启"破坏性操作告警" |
| `/freeze <dir>` | 锁定编辑范围到某目录 |

---

## 第 3 章:四大阶段全景(30 分钟)——从想法到上线

gstack 的 21 个 skill 不是平铺的,是按**软件工程生命周期**组织的 4 个层。下面按"你会用到的顺序"讲。

### 3.1 产品规划层(写代码之前)

#### 🎯 `/office-hours` — 验证你的 idea

**扮演角色**:YC 创业导师
**最佳时机**:有了一个模糊想法,准备动手之前

```
/office-hours 我想做一个 AI 代码审查工具
```

它会用 YC 经典的 6 个问题挑战你:
1. 用户最大的痛点是什么?
2. 你的解决方案如何解决它?
3. 为什么现有的解决方案不够好?
4. 你能触达这些用户吗?
5. 人们会付费吗?
6. 用户如何发现它?

输出:**Design Doc**(设计文档),存到 `~/.gstack/projects/<project-id>/`。

#### 🎯 `/plan-ceo-review` — 产品边界评审

**扮演角色**:CEO / 产品负责人
**最佳时机**:设计文档初稿完成后

```
/plan-ceo-review user profiles
```

输出:
- 战略一致性检查
- 市场机会评估
- **三种范围调整模式**:扩展 / 保持 / 缩减为 MVP
- 识别的关键风险

#### 🎯 `/plan-eng-review` — 工程架构评审 ⚠️ 重点掌握

**扮演角色**:资深工程经理
**最佳时机**:产品需求确认,准备编码前

```
/plan-eng-review user profiles architecture
```

**这可能是整个 gstack 最值钱的一个 skill**。它做了几件普通 AI 助手不做的事:

1. **认知模式注入**(Cognitive Patterns)
   Prompt 里硬编码了 15 条"优秀工程经理如何思考":
   - 爆炸半径直觉(每次决策评估"最坏情况")
   - 默认选无聊技术("每家公司只有 3 个创新代币")
   - 两周异味测试
   - 系统优于个人

2. **量化拦截器**
   > 如果方案涉及修改 > 8 个文件 或新增 > 2 个类,触发告警并建议缩减

3. **强制输出产物**
   - ASCII 数据流图
   - 测试矩阵(单元 / 集成 / E2E)
   - 故障模式清单
   - 安全隐患(OWASP Top 10)

输出文件:`~/.gstack/projects/<id>/*-test-plan-*.md`(后面 `/qa` 会读这个)

#### 🎯 `/plan-design-review` — 设计方案评估

**扮演角色**:设计评审专家
**最佳时机**:UI / 交互方案完成后

对每个设计维度 0~10 评分,并能识别"AI 生成的塑料感 UI"。

#### 🎯 `/design-consultation` — 从零搭建设计系统

适合项目初期,会帮你生成完整的 `DESIGN.md` 和可交互原型。

### 3.2 质量保障层(写代码时 + 写完之后)

#### 🔍 `/review` — 代码审查 ⚠️ 重点掌握

**扮演角色**:Staff Engineer
**最佳时机**:功能写完,准备合并前

```
/review
```

它做了 3 件反常识的事:

**Step 1.5 — 范围蔓延检测(Scope Drift Detection)**
普通 AI 审查直接看 diff,gstack **先读 TODOS.md / PR 描述**,提取"声明的意图",再对比实际修改。能抓到"你没让我加这个"或"你让我做的没做"。

**两通道审查(Two-pass review)**
- 第一遍:查致命问题(SQL 注入、竞态、空指针、Auth 缺失)
- 第二遍:查常规问题(硬编码、命名、测试覆盖)

**Fix-First 工作流**
发现问题分两类:
- `AUTO-FIX`:机械性问题(导入未用、格式),自动修
- `ASK`:架构 / 业务问题,**用 AskUserQuestion 抛给用户决策**(每次只问一个,带投入产出比)

#### 🐛 `/investigate`(别名 `/debug`) — 系统性根因分析

**扮演角色**:专业调试专家
**核心原则**:**无调查,不修复**

适合场景:
- 报错信息模糊
- 多线程死锁
- 性能瓶颈
- 偶现 bug

它会**强制**调用 `/freeze` hook,锁定调试范围,防止改坏别的地方。

#### ✅ `/qa` — 端到端测试 + 自动修复 ⚠️ 重点掌握

**扮演角色**:QA 测试主管
**核心武器**:gstack 的无头浏览器引擎

```
/qa http://localhost:3000
```

**最硬核的部分**(也是 gstack 真正技术含量最高的地方):

它会**真实地打开浏览器**,像真人一样点击、输入、截图、找 bug,然后:
- 每个 bug 一个原子提交(one commit per fix)
- 自动写回归测试
- before/after 截图对比

**Phase 流程**:
1. **QA Baseline**:跑测试基线
2. **Phase 1-6**:按 Tier 跑场景(Tier 1:核心流程, Tier 2:边界, Tier 3:视觉)
3. **Phase 7 Triage**:按 Tier 过滤要修的 bug
4. **Phase 8 Fix Loop**:每个 bug 修一次,跑一次回归

**前提**:`/plan-eng-review` 输出的 `*-test-plan-*.md` 必须存在,否则降级用 `git diff` 启发式分析。

#### 🚫 `/qa-only` — 只报告不修复

`/qa` 的只读版,适合生产环境回归测试,禁用了 Edit 工具。

#### 🎨 `/design-review` — 视觉还原度审查

对比设计稿 vs 实际渲染,自动修边距 / 排版 / 颜色。

#### 🤖 `/codex` — 对抗性代码审查

调用独立的 OpenAI Codex 模型,给你**第二意见**。适合核心模块 / 高风险代码。

### 3.3 发布运营层(交付)

#### 🚀 `/ship` — 一键发布

**扮演角色**:Release Engineer

```
/ship
```

自动串起:
1. 同步主分支
2. 跑全量测试
3. 检查覆盖率
4. bump 版本号
5. 生成 CHANGELOG
6. 推代码
7. 创建 PR
8. 更新文档(联动 `/document-release`)

**贴心设计**:项目没测试配置?它会主动引导你初始化测试框架。

#### 📝 `/document-release` — 文档同步

每次大版本发布后跑一下,自动扫描代码变更更新 README。

#### 📊 `/retro` — 周期回顾

**扮演角色**:工程经理

每周五或里程碑结束时跑,自动汇总:
- commit 数量、贡献分布
- 连续发布记录
- 测试健康度趋势
- Token 消耗(对,你没看错,token 也是工程指标)

### 3.4 基础设施层(安全 + 效率)

| 命令 | 作用 | 何时用 |
|---|---|---|
| `/gstack` | 入口 + 工作流推荐 | 默认 |
| `/browse` | 浏览器底层控制(直接 `$B`) | `/qa` 自动调用,也可手用 |
| `/setup-browser-cookies` | 从本地 Chrome/Arc 导入登录态 | `/qa` 测需要登录的页面之前 |
| `/careful` | 拦截 `rm -rf`、`DROP TABLE` 等 | 操作生产环境时**必开** |
| `/freeze <dir>` | 锁定编辑范围 | 重构单个模块时 |
| `/unfreeze` | 解除冻结 | `/freeze` 之后必须调用 |
| `/guard` | `/careful` + `/freeze` 双重保护 | 极度敏感环境 |
| `/gstack-upgrade` | 自身升级 | 收到新版本提示时 |

---

## 第 4 章:端到端实战——一个完整 Feature 的全流程

我们用一个真实场景走一遍:**给一个 SaaS 应用加"用户 Profile"功能**。

### Step 1:验证想法(5 分钟)

```
/office-hours 我想给 SaaS 加用户 Profile 功能,允许用户上传头像、改昵称、设置时区
```

输出:`design-user-profile.md`,YC 风格的 6 问清单 + 风险评估。

### Step 2:产品边界评审(5 分钟)

```
/plan-ceo-review user profiles
```

输出:三种范围模式。假设我们选 **MVP 模式**(只做头像 + 昵称)。

### Step 3:架构评审(10 分钟)⭐ 关键

```
/plan-eng-review user profiles MVP
```

输出:
- ASCII 数据流图
- 改动文件清单(假设 6 个文件,在 8 个阈值内,✅)
- 测试矩阵
- 生成 `~/.gstack/projects/<id>/user-profile-test-plan.md`

### Step 4:写代码(时间由你定)

正常用 Claude Code 写代码,或者让 Claude 直接实现 `/plan-eng-review` 输出的方案。

**重要**:
- 写代码期间建议开 `/freeze src/features/profile`,防止 AI 越界改其他模块
- 关键破坏性操作前开 `/careful`

### Step 5:代码审查(5 分钟)⭐ 关键

```
/review
```

输出示例:

```
=== REVIEW REPORT ===
Files changed: 6 (✅ within threshold)
Added: +342 / Removed: -89

Critical (auto-fixed):
- ✅ Removed 2 unused imports
- ✅ Black-formatted src/features/profile/avatar.tsx

Concerns (need your decision):
1. src/db/queries.ts:42 — SQL 拼接,有注入风险
   Options:
   A. 改用参数化查询(推荐,投入产出比高)
   B. 加 ORM 包装(更安全,但引入新依赖)
   C. 暂不修,加 TODO 注释(不推荐)

Status: DONE_WITH_CONCERNS
Next: /qa after addressing #1
```

### Step 6:QA 测试(10 分钟)⭐ 关键

修完 #1 之后:

```
/qa http://localhost:3000/profile
```

gstack 会真实打开浏览器,模拟用户:
- 上传一张头像
- 改昵称
- 切换时区
- 刷新页面看持久化
- 测错误路径(传 10MB 图片、网络断开)

每个 bug 自动修,自动写测试,自动 commit。

输出:
```
Health Score: 92/100
Bugs found: 3
Bugs fixed: 3
Tests: 47/47 passing
Status: ✅ Ready to ship
```

### Step 7:发布(3 分钟)

```
/ship user profile MVP
```

自动完成 merge → test → version bump → CHANGELOG → PR → doc。

**总耗时**:大约 30~45 分钟完成一个原本需要 2~3 天的功能,而且全程有 review、有测试、有文档。

---

## 第 5 章:无头浏览器引擎 `$B`(gstack 最硬核的发明)

### 5.1 为什么需要它?

普通 AI 编程 agent 是"瞎子"——只能读代码,不能"看"页面。gstack 的解法:**常驻一个真实浏览器**,让 AI 有眼睛有手。

### 5.2 架构

```
┌─────────────────┐
│  Claude Code    │
│  (AI 大脑)      │
└────────┬────────┘
         │ 调用 /qa 或 $B 命令
         ▼
┌─────────────────┐
│  CLI (58MB 二进制)│
└────────┬────────┘
         │ HTTP POST + Bearer Token
         ▼
┌─────────────────┐
│  Bun.serve()    │  ← localhost 绑定,带 UUID 鉴权
│  (守护进程)      │
└────────┬────────┘
         │ CDP (Chrome DevTools Protocol)
         ▼
┌─────────────────┐
│  Playwright     │
│  Chromium 实例   │  ← 保持 Cookie / LocalStorage / Tab
└─────────────────┘
```

### 5.3 直接用 `$B`

如果你想绕过 `/qa`,直接控制浏览器:

```bash
# 在 Claude Code 里:
$B snapshot                   # 获取当前页面的无障碍树(带 @e1, @e2 引用)
$B click @e3                  # 点击第 3 个元素
$B type @e5 "hello world"     # 在第 5 个元素输入
$B screenshot                  # 截图
$B navigate https://example.com
$B cookies list                # 查看 Cookie
$B cookies set name=value
$B logs console                # 查看 console 日志
$B logs network                # 查看网络请求
```

### 5.4 无障碍树 Ref 系统(很巧妙的设计)

传统 CSS 选择器在 SPA、Shadow DOM、React 水合后经常失效。gstack 的解法:

```javascript
const snapshot = await page.accessibility.snapshot();
// 返回 ARIA 树,每个元素有 @e1, @e2, @e3 ... 编号

// AI 只需要说"点 @e3",不用管 CSS
```

**Ref 生命周期**:
- 页面导航时,所有 Ref 自动失效
- 操作前检测 `count() === 0` 则抛异常(防止点过期元素)
- 用 `-C` 标志可以捕捉光标可交互元素(`@c1`,`@c2`),比如自定义 `onclick` 的 div

### 5.5 启动 / 关闭浏览器

```bash
# 启动(后台)
cd browse && bun run server.ts &

# 查看状态
cat .gstack/browse.json
# { "pid": 12345, "port": 38291, "token": "uuid-xxx", "binaryVersion": "1.0" }

# 关闭
kill $(cat .gstack/browse.json | jq -r .pid)
```

### 5.6 导入本地浏览器 Cookie

测需要登录的页面?从你日常的 Chrome 导入:

```
/setup-browser-cookies
```

安全机制:
- 数据用 PBKDF2 + AES-128-CBC 在内存解密
- **永远不以明文落盘**
- 不出现在任何日志里
- 需要系统 Keychain 授权

---

## 第 6 章:Prompt 工程最佳实践(从 gstack 源码学到的)

gstack 的真正价值不只是"做了 21 个 skill",而是它示范了**怎么写高质量的 agent skill**。这 4 个模式你可以直接抄。

### 6.1 结构化输入 + 防御性设计

**不要**:
```
请帮我审查代码,找出所有 bug 并修复。
```

**应该**(gstack 的 `/qa` 风格):
```
## 参数
| 参数 | 默认值 | 覆盖方式 |
|------|--------|----------|
| Target URL | http://localhost:3000 | 命令行参数 |
| Tier | 1 | -t 1\|2\|3 |

## 防御性检查
- 检查 git status --porcelain 是否为空
- 若不空 → 触发 AskUserQuestion:"请先 commit 或 stash,避免原子提交被污染"

## 执行阶段
Phase 1: ...
Phase 2: ...
```

**核心**:把"参数边界"显式化,把"环境异常"前置拦截。

### 6.2 跨阶段上下文继承(拒绝"从零开始")

**不要**让每个 skill 独立思考。

**应该**:设计文件系统契约。

```
/plan-eng-review
   ↓ 写 ~/.gstack/projects/<id>/user-profile-test-plan.md
/review
   ↓ 读上面的文件作为审查基准
/qa
   ↓ 读上面的文件作为测试基准
/ship
   ↓ 汇总所有产物生成 CHANGELOG
```

这样下游 skill 不重复劳动,而且"计划 - 实现 - 测试 - 发布"形成闭环。

### 6.3 注入专家级"思维模式"

**不要**:
```
你是一个资深工程师,请审查这段代码。
```

**应该**(gstack 的 `/plan-eng-review` 风格):
```
## Cognitive Patterns — How Great Eng Managers Think

1. Blast radius instinct — 每次决策评估"最坏情况,影响多少系统/用户?"
2. Boring by default — "每家公司只有 3 个创新代币",其余用成熟技术
3. Two-week smell test — 现在觉得巧妙的代码,两周后还觉得吗?
...
(15 条)
```

**核心**:把"领域最佳实践"转化为**具体可验证的规则列表**。

### 6.4 动态编排 + 人机协同(Human-in-the-Loop)

**不要**让 AI 一次性做完整件事。

**应该**:大量使用 `STOP. Call AskUserQuestion.`

```markdown
## Step 4: 复杂度检查
IF 涉及 > 8 文件 OR 新增 > 2 个类:
    STOP
    Call AskUserQuestion:
        "方案涉及 12 个文件,可能范围太大,建议:"
        A. 拆成 3 个 PR,先合并核心(推荐,投入产出比高)
        B. 保持现状,后续重构
        C. 增加人手并行
```

**核心**:AI 负责繁琐的分析和执行,**关键路径的决策权留给人类**。

### 6.5 区分信息层级

```markdown
## CRITICAL (必须修复或询问)
- SQL 注入
- 认证缺失
- 数据丢失风险

## INFORMATIONAL (仅供参考,不阻塞)
- 命名风格不一致
- 注释可以更详细
- 某个测试可以加更多 case
```

避免审查报告"全是 critical,什么都不重要"或"全是 info,啥也没说"。

---

## 第 7 章:21 个技能速查表

按使用频率排序。

### 🔥 每天用

| 命令 | 一句话 | 关键参数 |
|---|---|---|
| `/gstack` | 入口 + 推荐下一步 | — |
| `/review` | 代码审查 + 自动修 | — |
| `/qa <url>` | 端到端测试 + 自动修 | -t 1\|2\|3 |
| `/plan-eng-review <feature>` | 架构评审 | — |
| `/investigate` | 根因调试 | — |

### 🌟 每周用

| 命令 | 一句话 |
|---|---|
| `/office-hours <idea>` | YC 风格 idea 验证 |
| `/plan-ceo-review <feature>` | 产品边界 |
| `/plan-design-review` | 设计评估 |
| `/codex` | 第二意见审查 |
| `/ship` | 一键发布 |
| `/retro` | 周报 / 复盘 |

### 🛠 偶尔用

| 命令 | 一句话 |
|---|---|
| `/qa-only <url>` | 只测不修 |
| `/design-consultation` | 从零搭建设计系统 |
| `/design-review` | 视觉还原度审查 |
| `/document-release` | 同步文档 |
| `/setup-browser-cookies` | 导入登录态 |

### 🔒 安全 / 基建

| 命令 | 一句话 |
|---|---|
| `/careful` | 拦截破坏性命令 |
| `/freeze <dir>` | 锁定编辑范围 |
| `/unfreeze` | 解锁 |
| `/guard` | 双重保护 |
| `/browse` / `$B` | 浏览器底层 |
| `/gstack-upgrade` | 自身升级 |

---

## 第 8 章:自定义与扩展——打造你自己的 skills

### 8.1 一个 skill 的最小结构

```
.claude/skills/my-skill/
└── SKILL.md
```

`SKILL.md` 模板:

```markdown
---
name: my-skill
description: 一句话说清什么时候用
allowed-tools: Bash, Read, Edit, Write, Grep, Glob, AskUserQuestion
---

# 角色定义
你是一个[具体角色],拥有[具体能力]。

## 何时使用我
- 场景 1
- 场景 2

## 工作流

### Step 1: [步骤名]
做什么、怎么做、输出什么

### Step 2: [步骤名]
...

### Step N: 输出报告
按这个格式输出:...

## 认知模式(Cognitive Patterns)
1. ...
2. ...

## CRITICAL 规则
- 不要...
- 必须...
```

### 8.2 实战:做一个 `/security-audit`

假设你想加一个安全审计 skill:

```markdown
---
name: security-audit
description: 对代码改动执行 OWASP Top 10 + STRIDE 安全审计
allowed-tools: Bash, Read, Grep, Glob, AskUserQuestion
---

# 角色
你是应用安全专家,持有 OSCP 认证,过去 10 年审计过 200+ Web 应用。

# 何时用
- PR 合并前
- 新增认证 / 支付 / PII 处理模块
- 引入新依赖时

# 工作流

## Step 1: 范围
读取 git diff,识别新增文件。

## Step 2: OWASP Top 10 检查
按这 10 项逐项过:
1. Injection (SQL / NoSQL / LDAP / OS command)
2. Broken Authentication
3. Sensitive Data Exposure
4. XML External Entities (XXE)
5. Broken Access Control
6. Security Misconfiguration
7. Cross-Site Scripting (XSS)
8. Insecure Deserialization
9. Using Components with Known Vulnerabilities
10. Insufficient Logging & Monitoring

每个问题标 CRITICAL / HIGH / MEDIUM / LOW。

## Step 3: STRIDE 威胁建模
- **S**poofing:身份伪造可能吗?
- **T**ampering:数据被篡改可能吗?
- **R**epudiation:操作可追溯吗?
- **I**nformation Disclosure:敏感数据泄露?
- **D**enial of Service:可被 DoS 吗?
- **E**levation of Privilege:权限提升可能吗?

## Step 4: 输出报告
```markdown
## Security Audit Report
### CRITICAL (block merge)
- [file:line] SQL injection in `getUserById`
  - Risk: 攻击者可通过 userId 读取任意表
  - Fix: 使用参数化查询或 ORM

### HIGH (must fix this sprint)
...

### MEDIUM / LOW (informational)
...

### Verdict: ✅ APPROVED / ⚠️ CONDITIONAL / ❌ BLOCKED
```

## 认知模式
- **Defense in depth**:永远假设单一防御会失效
- **Least privilege**:默认拒绝,显式允许
- **Fail securely**:出错时拒绝访问,不是放行
```

### 8.3 加 hook(高级)

如果想让 skill 在执行前自动跑某个检查:

```bash
# 在 .claude/skills/my-skill/hooks/PreToolUse.sh
#!/bin/bash
# Edit / Write 之前自动运行
if [[ "$CLAUDE_TOOL_NAME" == "Edit" ]] || [[ "$CLAUDE_TOOL_NAME" == "Write" ]]; then
    FILE_PATH=$(echo "$CLAUDE_TOOL_INPUT" | jq -r '.file_path')
    if [[ ! "$FILE_PATH" =~ ^src/features/profile/ ]]; then
        echo "BLOCKED: /freeze is active, only src/features/profile/ allowed"
        exit 1
    fi
fi
```

### 8.4 团队共享

```bash
# 把 skills 放到项目 .claude/skills/,团队成员 clone 后自动生效
git add .claude/skills
git commit -m "feat: add custom security-audit skill"
```

---

## 第 9 章:常见问题与争议(理性看待)

### 9.1 gstack 是炒作吗?

**社区主流看法**(Reddit / HN):
- ✅ 角色化 prompt 的核心理念合理,但**不是新发明**(类似 multi-agent 思路)
- ✅ `/qa` 的真实浏览器测试是**真正有用的工程贡献**
- ❌ "60 万行代码"被广泛认为是虚荣指标
- ❌ "AI 审查自己写的代码给自己打分"是结构性缺陷
- ❌ 跟个人工作流强耦合,直接拿来团队用有风险

**中立结论**:对创始人个体来说是不错的起点,团队最好根据实际需求定制。

### 9.2 它会让你"变成工程师"吗?

**警惕点**(引用 YouTuber Mo Bitar 的批评):

> "像在和一个爱上你的人一起写代码。"
> 模型被 RLHF 训练成"让用户感觉更好",不会翻白眼,不会说"这个设计很糟糕"。
> 跟奉承型 AI 长期互动,人会显著高估自己能力(有研究支持)。

**建议**:
- ✅ 用 gstack 提高效率,但**保留独立判断能力**
- ✅ 关键架构决策自己拍板,不要让 AI 替你做
- ❌ 不要因为 AI 夸你"brilliant idea"就真信了

### 9.3 成本问题

Garry Tan 自己每天烧 500 美元 token。
对绝大多数开发者来说,**用 Pro/Max 订阅 + Opus 模型可能就够了**。

### 9.4 安全风险

- 浏览器守护进程绑定 localhost + UUID token,**不要**暴露到公网
- Cookie 用 PBKDF2 + AES-128-CBC 内存解密,**不要**自己改这部分代码
- 不要在没 `/freeze` 的情况下让 AI 自由改生产代码

### 9.5 与其他工具对比

| 工具 | 思路 | 适合 |
|---|---|---|
| **gstack** | 角色 + 流程(组织系统) | 完整工作流自动化 |
| **Superpowers**(obra) | 技能 + 触发器(能力编排) | 可组合的工程流程 |
| **Cursor / Copilot** | 代码补全 | 日常编码 |
| **Devin / Codex Agent** | 自主完成任务 | 长任务 / 独立项目 |

**经验法则**:
- 想要"流程自动化" → gstack
- 想要"能力组合" → Superpowers
- 想要"写代码快一点" → Cursor
- 想要"放手让 AI 干" → Devin

---

## 第 10 章:精通路径与学习资源

### 10.1 学习路线图

```
Day 1 (2 小时)
├─ 装环境,跑通 /gstack
├─ 读 /office-hours 和 /qa 的 SKILL.md 源码
└─ 在自己的项目跑一次 /review

Week 1 (每天 30 分钟)
├─ 每天用一个新 skill
├─ 改一个 skill 满足自己需求
└─ 读 gstack 源码的 browse/ 目录

Week 2 (每天 1 小时)
├─ 把核心流程串起来(/plan-eng-review → /review → /qa → /ship)
├─ 写 2~3 个自定义 skill
├─ 给团队做一次分享
└─ 思考哪些场景适合用 /careful、/freeze

Month 1
├─ 沉淀自己团队的 .claude/skills 库
├─ 集成到 CI/CD
├─ 训练团队成员使用
└─ 总结最佳实践文档
```

### 10.2 推荐阅读(按优先级)

1. **官方仓库**:`https://github.com/garrytan/gstack`(必读)
2. **No Priors 播客 Garry Tan 那期**(YouTube 搜 "Garry Tan No Priors")
3. **CSDN:拒绝 AI 盲目梭哈:拆解 Garry Tan 的 gstack 架构逻辑**(中文,讲得深)
4. **掘金:我用 gstack 给自己请了 20 个大佬做助理**(中文实战)
5. **Reddit:garry_tan_opensourced_GStack** 讨论串(批判性视角)
6. **Mo Bitar 的 7 分钟批评视频**(YouTube 搜 "Mo Bitar gstack")
7. **OpenClaw 项目**(Peter Steinberger 的实践案例)

### 10.3 三个里程碑任务(完成 = 算精通)

- [ ] **L1**:给一个真实项目跑通完整工作流(规划→审查→QA→发布),把耗时记下来对比之前
- [ ] **L2**:写 3 个自定义 skill 解决自己团队的特定需求,被至少 2 个同事采用
- [ ] **L3**:把 gstack 的浏览器引擎集成进 CI,实现"PR 合并前自动 E2E 回归"

---

## 附录:一份可拷贝的初始化检查清单

```markdown
## gstack 启动清单

### 环境
- [ ] Claude Code 已装且登录
- [ ] Bun 1.0+ 已装
- [ ] Playwright Chromium 已装
- [ ] gstack 仓库已克隆

### 配置
- [ ] skills 已复制到 ~/.claude/skills 或 .claude/skills
- [ ] 浏览器守护进程已启动(bun run server.ts)
- [ ] .gstack/browse.json 存在
- [ ] /gstack 命令能正常返回帮助

### 第一次跑通
- [ ] /office-hours 跑过一次 idea 验证
- [ ] /plan-eng-review 跑过一次架构评审
- [ ] /review 跑过一次代码审查
- [ ] /qa 跑过一次浏览器测试

### 安全配置
- [ ] 关键操作前开 /careful
- [ ] 重构时开 /freeze
- [ ] 浏览器守护进程只绑定 localhost
- [ ] Cookie 已用 Keychain 加密

### 进阶
- [ ] 至少自定义 1 个 skill
- [ ] 把 .claude/skills 加入 git
- [ ] 团队成员培训过
- [ ] 写了内部最佳实践文档
```

---

## 写在最后

gstack 是不是"革命性框架"?见仁见智。

但它教会我们的几件事是确定的:

1. **AI 编程的瓶颈不是模型能力,是流程约束**
2. **"角色扮演"不是噱头,是职责分离的工程实践**
3. **Markdown 正在变成新的编程语言**
4. **真正的护城河是"Thin Harness, Fat Skills"——你积累的高质量 skill 库**

不要被"60 万行代码"这种数字迷惑,也不要被"只是 Markdown 提示词"这种贬低打消。

**工具是中性的,关键看你怎么用。**

去用起来,改起来,造你自己的 skill 库。

——

**版本**:基于 gstack 2026 年 3 月发布版本撰写,部分数据(Stars 数)会随时间变化。
**反馈**:发现错漏或想补充实战案例,直接改这份文档就行。