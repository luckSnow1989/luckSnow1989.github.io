# 变更记录模板:05-changes.md(自动生成)

> **何时使用**:阶段 4,编码过程中
> **谁负责**:CC 自动生成 + 工程师补充决策记录
> **生成方式**:基于 git log + git diff 自动统计

---

```markdown
# [REQ-2026-001] 代码变更总结

| 项目 | 内容 |
|---|---|
| 关联任务 | [03-tasks.md](./03-tasks.md) |
| Worktree | [04-worktree-info.md](./04-worktree-info.md) |
| 开始时间 | 2026-06-15 09:00 |
| 结束时间 | 2026-06-15 18:00 |
| 提交数 | 18 个 commit |

## 1. 修改文件清单

### promotion-service(新增)
```
promotion-service/
├── pom.xml                                          [新增]
└── src/main/java/com/company/promotion/
    ├── PromotionApplication.java                    [新增]
    ├── controller/PromotionController.java          [新增]
    ├── service/PromotionService.java                [新增]
    ├── service/impl/PromotionServiceImpl.java       [新增]
    ├── strategy/PromotionStrategy.java              [新增]
    ├── strategy/impl/FullReductionStrategy.java     [新增]
    ├── strategy/PromotionStrategyFactory.java       [新增]
    ├── entity/PromoRule.java                        [新增]
    ├── entity/PromoUsage.java                       [新增]
    ├── mapper/PromoRuleMapper.java                  [新增]
    ├── mapper/PromoUsageMapper.java                 [新增]
    ├── dto/PromotionRequest.java                    [新增]
    ├── dto/PromotionResult.java                     [新增]
    ├── exception/BusinessException.java             [新增]
    └── exception/GlobalExceptionHandler.java        [新增]

promotion-service/src/main/resources/
├── application.yml                                  [新增]
├── db/migration/V1__create_promo_rule.sql           [新增]
└── db/migration/V2__create_promo_usage.sql          [新增]

promotion-service/src/test/java/com/company/promotion/
├── service/PromotionServiceTest.java                [新增]  (12 cases)
├── strategy/FullReductionStrategyTest.java          [新增]  (8 cases)
├── service/impl/PromotionServiceImplTest.java       [新增]  (15 cases)
└── PromotionIntegrationTest.java                    [新增]  (5 cases)
```

### order-service(修改)
```
order-service/src/main/java/com/company/order/
├── client/PromotionClient.java                      [新增]
├── service/impl/OrderServiceImpl.java               [修改:  +30 行,调用 PromotionClient]
├── controller/OrderController.java                  [修改:  +5 行,加 promoCode]
├── dto/OrderRequest.java                            [修改:  +1 字段]
└── dto/OrderDetailVO.java                           [修改:  +1 字段]

order-service/src/test/java/com/company/order/
└── service/OrderServiceTest.java                    [修改:  +8 cases]
```

## 2. 提交历史(从 git log 提取)

```bash
$ git log --oneline feature/REQ-2026-001-promo

a1b2c3d feat(promo): T5.3 rollback plan
b2c3d4e chore(monitor): T5.2 promo alerts
c3d4e5f docs(promo): T5.1 gray release plan
d4e5f6g docs(order): T4.3 knife4j update
e5f6g7h feat(order): T4.2 discountAmount in detail
f6g7h8i feat(order): T4.1 promoCode in order API
g7h8i9j test(order): T3.4 PromotionIntegrationTest
h8i9j0k test(order): T3.3 OrderServiceTest
i9j0k1l feat(order): T3.2 integrate promotion
j0k1l2m feat(order): T3.1 PromotionClient
k1l2m3n test(promo): T2.5 strategy benchmark
l2m3n4o test(promo): T2.4 strategy tests
m3n4o5p feat(promo): T2.3 PromotionStrategyFactory
n4o5p6q feat(promo): T2.2 FullReductionStrategy
o5p6q7r feat(promo): T2.1 PromotionStrategy interface
p6q7r8s test(promo): T1.3 PromoRuleServiceTest
q7r8s9t feat(promo): T1.2 create promo_usage table
r8s9t0u feat(promo): T1.1 create promo_rule table
```

**总统计**:
- 18 commits
- 27 文件变更
- +1850 / -45 行
- 平均每个 commit 100 行

## 3. 关键变更说明

### 3.1 核心新增:PromotionService

```java
@Service
public class PromotionServiceImpl implements PromotionService {

    @Autowired private PromotionStrategyFactory strategyFactory;
    @Autowired private PromoRuleMapper ruleMapper;
    @Autowired private PromoUsageMapper usageMapper;
    @Autowired private StringRedisTemplate redis;

    @Override
    @Transactional(rollbackFor = Exception.class)
    public PromotionResult applyPromotion(PromotionRequest request) {
        // 1. 查规则(走缓存)
        PromoRule rule = getActiveRule(request.getPromoCode());

        // 2. 分布式锁(防并发)
        String lockKey = String.format("promo:lock:%d:%s:%s",
            request.getUserId(), request.getPromoCode(), LocalDate.now());
        Boolean acquired = redis.opsForValue()
            .setIfAbsent(lockKey, "1", Duration.ofSeconds(5));
        if (!Boolean.TRUE.equals(acquired)) {
            throw new BusinessException("PROMO_LOCK_FAILED", "系统繁忙");
        }

        try {
            // 3. 检查使用次数
            int usedCount = usageMapper.countByUserAndDate(
                request.getUserId(), request.getPromoCode(), LocalDate.now());
            if (usedCount >= 1) {
                throw new BusinessException("PROMO_LIMIT_EXCEEDED", "今日已使用");
            }

            // 4. 策略计算
            PromotionStrategy strategy = strategyFactory.get(rule.getType());
            BigDecimal finalAmount = strategy.apply(request.getOriginalAmount(), rule);

            // 5. 写使用记录
            PromoUsage usage = new PromoUsage();
            usage.setUserId(request.getUserId());
            usage.setPromoCode(request.getPromoCode());
            usage.setOrderId(request.getOrderId());
            usage.setUsedDate(LocalDate.now());
            usage.setStatus(1);
            usageMapper.insert(usage);

            return new PromotionResult(true, finalAmount,
                request.getOriginalAmount().subtract(finalAmount), rule.getCode(), rule.getName());

        } finally {
            redis.delete(lockKey);
        }
    }
}
```

### 3.2 关键变更:OrderService 调用

```java
// OrderServiceImpl.createOrder()
public Order createOrder(OrderRequest request) {
    Order order = new Order();
    // ... 原有逻辑 ...

    // 🆕 应用促销
    if (request.getPromoCode() != null) {
        try {
            PromotionResult promo = promotionClient.applyPromotion(
                new PromotionRequest(
                    request.getUserId(),
                    order.getOrderId(),
                    order.getAmount(),
                    request.getPromoCode()
                )
            );
            order.setDiscountAmount(promo.getDiscountAmount());
            order.setFinalAmount(promo.getFinalAmount());
        } catch (Exception e) {
            log.warn("PROMO_FAILED, fallback to original price: {}", e.getMessage());
            // 降级:用原价
        }
    }

    orderMapper.insert(order);
    return order;
}
```

## 4. 关键决策(摘录自 decisions.md)

> 详细决策见 [decisions.md](./decisions.md)

- **D1**:用 Redisson 替代手写 SETNX(由 @王五 在设计评审提出)
- **D2**:降级策略 — 促销失败时不影响订单创建(高可用 > 业务完美)
- **D3**:promo_usage 走 DB 唯一索引兜底,即使 Redis 锁失效也不会超卖

## 5. 已知问题 / TODO

- [ ] 退款时调 promotion-service 退还次数(下个需求做)
- [ ] 运营后台配置界面(下个需求做)
- [ ] 监控大盘(后续优化)
```

---

## 💡 自动生成方式

### 方法 1:用 CC 一键生成

```bash
# 在 worktree 目录
> 基于 git log 和 git diff,生成 05-changes.md,包含:
# - 文件清单
# - commit 历史
# - 关键 diff
# - 决策记录
```

### 方法 2:用脚本

```bash
#!/bin/bash
# gen-changes.sh
SINCE="2026-06-15 09:00"
UNTIL="2026-06-15 18:00"

git log --since="$SINCE" --until="$UNTIL" --pretty=format:"%h %s" > .history/REQ-2026-001/commits.txt
git diff --stat ${SINCE}..${UNTIL} > .history/REQ-2026-001/diff-stat.txt
echo "Generated"
```

## 🎯 反模式

- ❌ 手动维护文件清单(用 `git log` 自动统计)
- ❌ 不写决策记录(后人看不懂"为什么这么写")
- ❌ 把 .class 等编译产物也统计进去(用 .gitignore)
