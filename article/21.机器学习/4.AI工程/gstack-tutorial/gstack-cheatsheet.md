# gstack 速查卡(贴墙版)

> 打印 A4 / A5,贴显示器边上。扫一眼就行,别想。

---

## 🚨 紧急情况(先看这里)

| 出事了 | 立即做 |
|---|---|
| AI 准备删东西 / `DROP TABLE` / `rm -rf` | `Ctrl+C` → `/careful` |
| AI 在改不该改的文件 | `/freeze <dir>` 立刻锁住 |
| AI 卡死 / 输出乱码 | `Ctrl+C` 重来,或换 `/gstack` 看推荐 |
| 浏览器守护进程挂了 | `cd browse && bun run server.ts &` |
| 找不到之前的产物 | `ls ~/.gstack/projects/` |

---

## 🧭 一个功能的标准流程

```
/office-hours <idea>              ① 验证想法(可选,但推荐)
/plan-ceo-review <feature>        ② 产品边界(可选)
   ↓
/plan-eng-review <feature>        ③ 架构评审 ⭐
   ↓
[写代码 + /freeze 锁定范围]
   ↓
/review                            ④ 代码审查 ⭐
   ↓
/qa <url>                          ⑤ 浏览器测试 ⭐
   ↓
/ship                              ⑥ 一键发布
   ↓
/retro                             ⑦ 周报/复盘
```

**快捷命令**:`/gstack` — 不记得下一步?直接跑它,它会推荐。

---

## 📋 21 个命令速查

### 产品规划(写代码前)
| 命令 | 一句话 | 啥时候用 |
|---|---|---|
| `/office-hours <idea>` | YC 风格 idea 验证 | 有模糊想法 |
| `/plan-ceo-review <feature>` | 产品边界 / MVP 决策 | 设计稿初稿后 |
| `/plan-eng-review <feature>` | 架构评审 + 数据流图 ⭐ | 准备编码前 |
| `/plan-design-review` | 设计 0-10 打分 | UI 方案后 |
| `/design-consultation` | 从零搭建设计系统 | 项目初期 |

### 质量保障(写代码时 + 后)
| 命令 | 一句话 | 啥时候用 |
|---|---|---|
| `/review` | 代码审查 + 自动修小问题 ⭐ | PR 前 |
| `/investigate`(=/debug) | 系统性找 bug 根因 | 出错时 |
| `/qa <url>` | 真实浏览器测试 + 自动修 ⭐ | 功能完成后 |
| `/qa-only <url>` | 只测不修(生产环境用) | 回归测试 |
| `/design-review` | 对比设计稿 vs 实际 | UI 完成后 |
| `/codex` | 调 OpenAI 给第二意见 | 核心模块 |

### 发布运营
| 命令 | 一句话 | 啥时候用 |
|---|---|---|
| `/ship` | 一键发布流水线 ⭐ | 一切就绪 |
| `/document-release` | 同步 README/CHANGELOG | 每次发布后 |
| `/retro` | 周报 / 复盘 / 数据统计 | 周五 |

### 基础设施 / 安全
| 命令 | 一句话 | 啥时候用 |
|---|---|---|
| `/gstack` | 入口 + 智能推荐 | 默认 / 迷茫时 |
| `/browse` / `$B` | 浏览器底层 | 调试 / 手测 |
| `/setup-browser-cookies` | 导入登录态 | 测需登录的页面 |
| `/careful` | 拦截破坏性命令 🛡️ | 操作生产环境 |
| `/freeze <dir>` | 锁定编辑范围 🛡️ | 重构单模块 |
| `/unfreeze` | 解锁 | `/freeze` 之后 |
| `/guard` | careful + freeze 双重 | 极度敏感环境 |
| `/gstack-upgrade` | 自身升级 | 收到提示时 |

---

## 🛡️ 安全开关(操作前必想)

```
生产环境?   →  /careful
重构单模块? →  /freeze src/xxx/
极度敏感?   →  /guard(双保险)
干完活?     →  /unfreeze
```

**铁律**:
- 让 AI 改生产代码前,先 `/freeze` 锁范围
- 执行 `rm`、`DROP`、`truncate`、`flush` 前,先 `/careful`
- 不要在 `/freeze` 范围外放重要文件

---

## 🖥️ 浏览器底层 `$B`(绕过 /qa 直接用)

```bash
$B snapshot              # 看页面元素(@e1, @e2 ...)
$B click @e3             # 点
$B type @e5 "hello"      # 输入
$B screenshot            # 截图
$B navigate <url>        # 跳转
$B cookies list          # 看 Cookie
$B logs console          # 看 console 日志
$B logs network          # 看网络请求
```

> Ref 编号在页面跳转后会失效,重新 `snapshot` 即可。

---

## 💡 高频组合(直接抄)

**新功能完整跑一遍**:
```
/plan-eng-review <name>  →  写代码  →  /review  →  /qa  →  /ship
```

**紧急修 bug**:
```
/careful  →  /investigate  →  /freeze src/xxx/  →  修  →  /qa-only 验证
```

**每周复盘**:
```
/retro  →  /document-release
```

**重构旧模块**:
```
/freeze <dir>  →  /plan-eng-review 重构方案  →  /review  →  /qa
```

**PR 第二意见**:
```
/review  →  /codex  →  对比两份报告
```

---

## ⌨️ 快捷键 / 入口

| 操作 | 怎么搞 |
|---|---|
| 中断当前 skill | `Ctrl+C` |
| 入口 + 推荐 | `/gstack` |
| 直接浏览器 | `$B <cmd>` |
| 自然语言路由 | "review my code" / "部署到生产" |

---

## 📁 关键路径

| 东西在哪 | 路径 |
|---|---|
| Skills 全局 | `~/.claude/skills/` |
| Skills 项目级 | `.claude/skills/` |
| 工作流产物 | `~/.gstack/projects/<id>/` |
| 浏览器状态 | `.gstack/browse.json` |
| 测试计划 | `~/.gstack/projects/<id>/*-test-plan-*.md` |

---

## 🧠 4 个核心心法

1. **薄框架,厚技能** — 别纠结配置,把精力花在写好 skill 上
2. **流程即代码** — 工作流写下来能复用,比凭感觉强 100 倍
3. **AI 干活的,你决策的** — 关键路径用 `AskUserQuestion` 抛给你
4. **保留独立判断** — AI 夸你 ≠ 你真的牛

---

## 🔧 5 分钟故障排查

| 现象 | 试试这个 |
|---|---|
| `/gstack` 没反应 | 重启 Claude Code |
| 浏览器不工作 | `cd browse && bun run server.ts &` |
| Skill 不识别 | 检查 `~/.claude/skills/` 或 `.claude/skills/` 路径 |
| `$B` 报错 | 看 `.gstack/browse.json` 端口和 PID 在不在 |
| 输出太啰嗦 | 用 `/plan-eng-review` 而不是 `/office-hours`(更聚焦) |
| AI 自己改坏了 | 立刻 `Ctrl+C` → `git checkout .` → `/careful` 重新开 |

---

**GitHub**: <https://github.com/garrytan/gstack>
**一句话**:`/gstack` 是入口,搞不定就先跑它。