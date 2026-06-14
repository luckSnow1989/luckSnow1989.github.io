# 测试报告模板:06-test-report.md

> **何时使用**:阶段 5,代码完成后
> **谁负责**:CC 跑测试 + 工程师分析
> **生成方式**:结合 `mvn test` + JaCoCo 报告

---

```markdown
# [REQ-2026-001] 单元测试报告

| 项目 | 内容 |
|---|---|
| 关联变更 | [05-changes.md](./05-changes.md) |
| 测试日期 | 2026-06-15 17:00 |
| 测试人 | @张三 + Claude Code |
| 测试框架 | JUnit 5 + Mockito + AssertJ + Testcontainers |
| 覆盖率工具 | JaCoCo 0.8.11 |

## 1. 测试执行总览

```
$ mvn -pl promotion-service,order-service test jacoco:report

[INFO] -------------------------------------------------------
[INFO]  T E S T S
[INFO] -------------------------------------------------------
[INFO] Running com.company.promotion.service.PromotionServiceTest
[INFO] Tests run: 12, Failures: 0, Errors: 0, Skipped: 0
[INFO]
[INFO] Running com.company.promotion.strategy.FullReductionStrategyTest
[INFO] Tests run: 8, Failures: 0, Errors: 0, Skipped: 0
[INFO]
[INFO] Running com.company.promotion.service.impl.PromotionServiceImplTest
[INFO] Tests run: 15, Failures: 0, Errors: 0, Skipped: 0
[INFO]
[INFO] Running com.company.promotion.PromotionIntegrationTest
[INFO] Tests run: 5, Failures: 0, Errors: 0, Skipped: 0
[INFO]
[INFO] Running com.company.order.service.OrderServiceTest
[INFO] Tests run: 20, Failures: 0, Errors: 0, Skipped: 0
[INFO]
[INFO] -------------------------------------------------------
[INFO] BUILD SUCCESS
[INFO] -------------------------------------------------------
[INFO] Total tests: 60
[INFO] Passed: 60
[INFO] Failed: 0
[INFO] Skipped: 0
[INFO] Time: 12.3s
[INFO] -------------------------------------------------------
```

✅ **60/60 通过**,耗时 12.3 秒(集成测试 8 秒,单元测试 4 秒)

## 2. 覆盖率报告(JaCoCo)

### 2.1 promotion-service

| 包 | 行覆盖 | 分支覆盖 | 方法覆盖 |
|---|---|---|---|
| service | **92%** | **85%** | 100% |
| strategy | **100%** | **100%** | 100% |
| controller | **75%** | 60% | 90% |
| mapper | 0% | 0% | 0% (框架自动) |
| **总计** | **87%** | **78%** | **93%** |

**达标情况**:
- ✅ Service 行覆盖 92% > 80% (硬指标)
- ✅ Service 分支 85% > 70% (硬指标)
- ✅ Strategy 100%
- ⚠️ Controller 75% < 80% (可接受,主要是异常分支)

### 2.2 order-service(增量部分)

| 类 | 行覆盖 | 分支覆盖 |
|---|---|---|
| OrderServiceImpl(新增) | 88% | 82% |
| OrderController(新增) | 70% | 60% |
| PromotionClient(新增) | 0% | 0% (接口,无逻辑) |

## 3. 测试用例清单

### 3.1 单元测试:PromotionServiceImpl(15 cases)

| # | 测试场景 | 输入 | 预期输出 | 状态 |
|---|---|---|---|---|
| 1 | 正常满减 | 金额 100,规则 FULL_100_20 | 80 | ✅ |
| 2 | 刚好等于门槛 | 金额 100.00 | 80 | ✅ |
| 3 | 低于门槛 | 金额 99.99 | 99.99(不减免) | ✅ |
| 4 | 大额订单 | 金额 1000 | 980(只减 1 次) | ✅ |
| 5 | 0 元订单 | 金额 0 | 抛 BusinessException | ✅ |
| 6 | 负数订单 | 金额 -100 | 抛 BusinessException | ✅ |
| 7 | 规则不存在 | code: NOT_EXIST | 返回原金额 | ✅ |
| 8 | 规则过期 | 规则 endTime 已过 | 抛 BusinessException | ✅ |
| 9 | 已用 1 次 | usage 记录存在 | 抛 PROMO_LIMIT_EXCEEDED | ✅ |
| 10 | 分布式锁失败 | Redis 返回 false | 抛 PROMO_LOCK_FAILED | ✅ |
| 11 | 并发 100 个 | 100 线程同时调用 | 仅 1 个成功,其他降级 | ✅ |
| 12 | Feign 超时 | 客户端超时 | 抛 PROMO_TIMEOUT | ✅ |
| 13 | 数据库异常 | mock 抛 SQLException | 事务回滚 + 锁释放 | ✅ |
| 14 | 缓存为空 | 第一次访问 | 走 DB,加载到缓存 | ✅ |
| 15 | 缓存命中 | 缓存已有 | 走缓存 | ✅ |

### 3.2 单元测试:FullReductionStrategy(8 cases)

| # | 场景 | 金额 | 规则 | 预期 |
|---|---|---|---|---|
| 1 | 边界 - 等于 | 100.00 | threshold 100, discount 20 | 80.00 |
| 2 | 边界 - 差一点 | 99.99 | 同上 | 99.99 |
| 3 | 大额 | 1000.00 | 同上 | 980.00 |
| 4 | 零 | 0.00 | 同上 | 0.00 |
| 5 | 小数 | 99.999 | 同上 | 99.99(向下取整) |
| 6 | 阈值 0 | 100.00 | threshold 0, discount 20 | 80.00(无门槛) |
| 7 | 折扣 0 | 100.00 | threshold 100, discount 0 | 100.00(无折扣) |
| 8 | 金额超 BigDecimal.MAX | MAX_VALUE | 同上 | 不会溢出(BigDecimal) |

### 3.3 集成测试:Testcontainers(5 cases)

| # | 场景 | 验证点 |
|---|---|---|
| 1 | 端到端下单 | 创建订单 → 应用促销 → 验证金额 |
| 2 | 退单退还次数 | 退单 → 调 promotion-service → 验证可再次使用 |
| 3 | 并发 100 线程 | 验证 promo_usage 唯一索引生效 |
| 4 | Redis 故障 | 模拟 Redis 挂掉,降级到原价 |
| 5 | MySQL 故障 | 模拟 DB 挂,事务回滚 + 锁释放 |

## 4. 没覆盖到的代码 + 原因

| 文件/方法 | 行数 | 原因 |
|---|---|---|
| `PromotionController.manualRetry` | 15 | 手动重试入口,极少用,文档说明足够 |
| `PromotionServiceImpl.logAudit` | 8 | 审计日志,只有 log.info,无需测试 |
| `GlobalExceptionHandler.handleValidation` | 12 | Bean Validation 自动触发,框架已测 |

**说明**:这些都是"非业务关键"代码,已和架构师 @王五 确认不需要测试。

## 5. 测试运行时间分析

| 类型 | 用例数 | 时间 |
|---|---|---|
| 单元测试 | 55 | 4.2s |
| 集成测试(Testcontainers) | 5 | 8.1s |
| **总计** | **60** | **12.3s** |

✅ 单测 ≤ 5s 满足快速反馈要求

## 6. 覆盖率截图

> 见 `screenshots/coverage-promotion-service.png`
> 见 `screenshots/coverage-order-service.png`

## 7. 性能基准

```
# 1000 次 PromotionServiceImpl.applyPromotion
平均: 3.2ms
P50: 2.8ms
P95: 8.5ms
P99: 15.2ms

# 满足 02-design.md 中的 < 10ms 要求 ✅
```

## 8. 总结

- ✅ 所有验收标准都有对应测试
- ✅ 覆盖率超指标
- ✅ 集成测试覆盖关键场景
- ✅ 性能达标
- ✅ 60 个测试全部通过

**结论:可以进入阶段 6 Code Review**
```

---

## 💡 填写要点

- **覆盖率不达标,流程不前进**——硬指标不能妥协
- **每个验收标准都有测试**——验收 = 测试通过
- **没覆盖的代码说明理由**——透明,不藏拙
- **性能基准单独测**——不要混在功能测试里

## 🎯 反模式

- ❌ 写测试只为"通过覆盖率",不验证业务正确性
- ❌ Mock 一切(包括 Date.now()),导致测试失真
- ❌ 集成测试跑真实 MySQL 不用 Testcontainers(慢 + 不稳定)
- ❌ 测试代码不 commit(不跟生产代码一起 review)
