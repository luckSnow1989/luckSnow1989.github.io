# 任务模板:03-tasks.md

> **何时使用**:阶段 2,完成设计后
> **谁负责**:开发工程师 + CC 拆分
> **耗时**:15-30 分钟

---

```markdown
# [REQ-2026-001] 任务分解

| 项目 | 内容 |
|---|---|
| 关联设计 | [02-design.md](./02-design.md) |
| 关联需求 | [01-requirement.md](./01-requirement.md) |
| 预估总工时 | 12h(2 个工作日) |
| 实际工时 | _待填_ |
| 负责人 | @张三 |
| 评审人 | @赵六 |

## 任务概览

| Phase | 主题 | 任务数 | 预估 |
|---|---|---|---|
| Phase 1 | 数据层(规则 + 记录) | 3 | 2h |
| Phase 2 | 规则引擎(策略模式) | 5 | 3h |
| Phase 3 | 订单集成(Feign 调用) | 4 | 4h |
| Phase 4 | 接口与文档(knife4j) | 3 | 2h |
| Phase 5 | 上线准备(灰度 + 监控) | 3 | 1h |

**总任务数:18** · **总预估:12h**

---

## Phase 1:数据层(预估 2h)

### T1.1 创建 promo_rule 表
- **路径**:`promotion-service/src/main/resources/db/migration/V1__create_promo_rule.sql`
- **动作**:写 Flyway migration,创建 promo_rule 表 + 索引
- **验收**:本地 MySQL 跑通,字段齐全
- **commit**:`feat(promo): T1.1 create promo_rule table`

### T1.2 创建 promo_usage 表
- **路径**:`promotion-service/src/main/resources/db/migration/V2__create_promo_usage.sql`
- **动作**:写 Flyway migration,创建 promo_usage 表 + 唯一索引
- **验收**:本地 MySQL 跑通,唯一索引生效
- **commit**:`feat(promo): T1.2 create promo_usage table`

### T1.3 写 PromoRuleServiceTest
- **路径**:`promotion-service/src/test/java/.../PromoRuleServiceTest.java`
- **动作**:JUnit 5 + Mockito,覆盖 CRUD + 边界
- **验收**:覆盖率 100%,所有 case 通过
- **commit**:`test(promo): T1.3 PromoRuleServiceTest`

---

## Phase 2:规则引擎(预估 3h)

### T2.1 设计 PromotionStrategy 接口
- **路径**:`promotion-service/src/main/java/.../strategy/PromotionStrategy.java`
- **动作**:定义接口 `apply(order, rule) -> DiscountResult`
- **验收**:接口清晰,JavaDoc 完整
- **commit**:`feat(promo): T2.1 PromotionStrategy interface`

### T2.2 实现 FullReductionStrategy
- **路径**:`promotion-service/src/main/java/.../strategy/impl/FullReductionStrategy.java`
- **动作**:实现满减逻辑(注意 BigDecimal 比较)
- **验收**:通过单元测试
- **commit**:`feat(promo): T2.2 FullReductionStrategy`

### T2.3 实现 PromotionStrategyFactory
- **路径**:`promotion-service/src/main/java/.../strategy/PromotionStrategyFactory.java`
- **动作**:Map<type, strategy>,工厂方法
- **验收**:通过单元测试
- **commit**:`feat(promo): T2.3 PromotionStrategyFactory`

### T2.4 写策略测试
- **路径**:`promotion-service/src/test/java/.../strategy/`
- **动作**:覆盖边界:刚好 100 / 99.99 / 1000 / 0 / 负数
- **验收**:8+ 个 case 全通过
- **commit**:`test(promo): T2.4 strategy tests`

### T2.5 策略性能压测
- **路径**:`promotion-service/src/test/java/.../StrategyBenchmarkTest.java`
- **动作**:JMH 或简单循环,1000 次 < 10ms
- **验收**:报告附在 commit message
- **commit**:`test(promo): T2.5 strategy benchmark`

---

## Phase 3:订单集成(预估 4h)

### T3.1 注入 PromotionClient
- **路径**:`order-service/src/main/java/.../client/PromotionClient.java`
- **动作**:@FeignClient,fallback,超时设置
- **验收**:编译通过,本地启动能注入
- **commit**:`feat(order): T3.1 PromotionClient`

### T3.2 订单创建时调用
- **路径**:`order-service/src/main/java/.../service/OrderServiceImpl.java`
- **动作**:在 createOrder 方法中调用 client.applyPromotion
- **验收**:走通端到端流程
- **commit**:`feat(order): T3.2 integrate promotion`

### T3.3 OrderServiceTest
- **路径**:`order-service/src/test/java/.../OrderServiceTest.java`
- **动作**:Mock PromotionClient,覆盖调用 + fallback
- **验收**:覆盖率 ≥ 80%
- **commit**:`test(order): T3.3 OrderServiceTest`

### T3.4 集成测试
- **路径**:`order-service/src/test/java/.../PromotionIntegrationTest.java`
- **动作**:Testcontainers,真实 MySQL + Redis
- **验收**:端到端走通
- **commit**:`test(order): T3.4 PromotionIntegrationTest`

---

## Phase 4:接口与文档(预估 2h)

### T4.1 暴露 POST /api/orders
- **路径**:`order-service/src/main/java/.../controller/OrderController.java`
- **动作**:加 `promoCode` 字段
- **验收**:Swagger 显示
- **commit**:`feat(order): T4.1 promoCode in order API`

### T4.2 订单详情页展示
- **路径**:`order-service/src/main/java/.../dto/OrderDetailVO.java`
- **动作**:加 `discountAmount` 字段
- **验收**:响应 JSON 包含字段
- **commit**:`feat(order): T4.2 discountAmount in detail`

### T4.3 knife4j 文档更新
- **路径**:`order-service/src/main/java/.../controller/`
- **动作**:@Operation 注解 + @Parameter
- **验收**:knife4j 显示完整
- **commit**:`docs(order): T4.3 knife4j update`

---

## Phase 5:上线准备(预估 1h)

### T5.1 灰度方案
- **路径**:`docs/gray-release/REQ-2026-001.md`
- **动作**:白名单 10 用户 + 灰度配置
- **验收**:文档 + Nacos 配置
- **commit**:`docs(promo): T5.1 gray release plan`

### T5.2 监控告警
- **路径**:`monitoring/prometheus/promo-alerts.yml`
- **动作**:Prometheus 告警规则
- **验收**:告警规则上线
- **commit**:`chore(monitor): T5.2 promo alerts`

### T5.3 回滚方案
- **路径**:`docs/rollback/REQ-2026-001.md`
- **动作**:详细步骤 + 命令 + 责任人
- **验收**:文档 + 演练
- **commit**:`docs(promo): T5.3 rollback plan`

---

## 任务状态

- [x] T1.1 ✅ 2026-06-15 10:30
- [x] T1.2 ✅ 2026-06-15 11:00
- [x] T1.3 ✅ 2026-06-15 14:00
- [x] T2.1 ✅ 2026-06-15 15:30
- [ ] T2.2 ... 进行中

## 阻塞 / 风险

- 暂无

## 进度日志

- 2026-06-15 10:30 — T1.1 完成
- 2026-06-15 14:00 — T1.3 写测试卡了半小时(Mock 没 import 对),已解决
```

---

## 💡 填写要点

- **每个任务独立 commit**——粒度细,便于回滚
- **任务粒度 2-5 分钟**——不是夸张,大任务拆不开
- **每任务有明确验收**——不是"做完"
- **进度日志**——遇到问题就记,后人翻到这知道踩过什么坑

## 🎯 反模式

- ❌ 任务写"开发订单模块"——粒度太大,无法验收
- ❌ 没有 commit 约定——后面无法 review
- ❌ 没有阻塞/风险——出问题了不知道
