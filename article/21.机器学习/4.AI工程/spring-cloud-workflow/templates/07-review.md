# 代码审查模板:07-review.md

> **何时使用**:阶段 6,测试通过后
> **谁负责**:CC 自动 review + 工程师交叉 review
> **生成方式**:Superpowers requesting-code-review

---

```markdown
# [REQ-2026-001] Code Review 报告

| 项目 | 内容 |
|---|---|
| 关联测试 | [06-test-report.md](./06-test-report.md) |
| 关联变更 | [05-changes.md](./05-changes.md) |
| Review 日期 | 2026-06-16 10:00 |
| Reviewer | Claude Code(主)+ @王五(交叉 review) |
| PR | #1234 |
| 变更规模 | +1850 / -45,18 commits,27 files |

## 1. Review 总览

| 维度 | 评级 | 备注 |
|---|---|---|
| **功能正确性** | ✅ 通过 | 满足所有验收标准 |
| **代码质量** | ⚠️ 1 个 P1 | 有可优化项 |
| **安全性** | ✅ 通过 | 无明显漏洞 |
| **性能** | ✅ 通过 | 满足设计指标 |
| **可测试性** | ✅ 通过 | 测试覆盖充分 |
| **可维护性** | ⚠️ 1 个 P1 | 注释需补充 |
| **Spring Cloud 规范** | ✅ 通过 | 符合团队约定 |

**总体结论**:✅ **通过**(1 个 P1 必修,2 个 P2 建议)

---

## 2. P0 严重问题(必修)

> P0 = 必须改,否则不允许合并

✅ **无 P0 问题**

---

## 3. P1 一般问题(必改)

> P1 = 必修,改完可以合并

### 3.1 [P1] 分布式锁未配置看门狗

**位置**:`PromotionServiceImpl.java:45-48`

**问题**:
```java
// ❌ 当前实现
Boolean acquired = redis.opsForValue()
    .setIfAbsent(lockKey, "1", Duration.ofSeconds(5));
```

如果业务执行超过 5 秒,锁会自动释放,可能导致并发问题。

**建议**:
```java
// ✅ 建议实现:用 Redisson 的看门狗机制
RLock lock = redisson.getLock(lockKey);
boolean acquired = lock.tryLock(0, 30, TimeUnit.SECONDS);
// 看门狗自动续期,直到业务执行完
```

**严重度**:P1(中风险,常态不会触发,但高并发下可能出现)

**修正 commit**:`fix(promo): use Redisson watchdog for distributed lock`

---

### 3.2 [P1] JavaDoc 不完整

**位置**:`PromotionStrategyFactory.java`(整个类)

**问题**:
```java
// ❌ 缺少 JavaDoc
public class PromotionStrategyFactory {
    public PromotionStrategy get(String type) { ... }
}
```

**建议**:
```java
/**
 * 促销策略工厂.
 * <p>根据规则类型返回对应策略实现.
 *
 * @author zhangsan
 * @since 1.0.0
 */
public class PromotionStrategyFactory {
    /**
     * 根据类型获取策略.
     *
     * @param type 策略类型(FULL_REDUCTION / DISCOUNT)
     * @return 对应的策略实现
     * @throws BusinessException 如果类型不支持
     */
    public PromotionStrategy get(String type) { ... }
}
```

**严重度**:P1(影响后续维护)

---

## 4. P2 建议问题(可选)

> P2 = 建议改,可不改

### 4.1 [P2] 魔法值提取为常量

**位置**:`PromotionServiceImpl.java:38`

**问题**:
```java
// 数字 1 出现多次,语义不明
if (usedCount >= 1) {
```

**建议**:
```java
private static final int DAILY_LIMIT = 1;
if (usedCount >= DAILY_LIMIT) {
```

**严重度**:P2(可读性)

### 4.2 [P2] log 缺少上下文

**位置**:`OrderServiceImpl.java:62`

**问题**:
```java
log.warn("PROMO_FAILED, fallback to original price: {}", e.getMessage());
```

**建议**:
```java
log.warn("PROMO_FAILED, userId={}, orderId={}, promoCode={}, fallback to original price",
    request.getUserId(), order.getOrderId(), request.getPromoCode(), e);
```

**严重度**:P2(可观测性)

### 4.3 [P2] 测试用例命名建议

**位置**:`PromotionServiceTest.java:42`

**问题**:
```java
@Test
void test1() { ... }
```

**建议**:
```java
@Test
@DisplayName("正常满减:订单 100 元应减 20 元")
void shouldDeduct20WhenOrderOver100() { ... }
```

**严重度**:P2(可读性)

---

## 5. Spring Cloud 专项 Review

### 5.1 Feign Client

| 检查项 | 状态 |
|---|---|
| 有 fallback 吗? | ✅ 有,PromoFallback |
| 超时设置? | ✅ connectTimeout=2s, readTimeout=5s |
| 重试? | ⚠️ 没显式配置(默认不重试) |
| 日志? | ✅ FULL |

**建议**:加 `Retryer` 配置,避免网络抖动失败

### 5.2 Nacos 配置

| 检查项 | 状态 |
|---|---|
| 走 Nacos 而不是 hardcode? | ✅ 是 |
| 灰度配置? | ✅ 有 white_user_ids |
| 动态刷新? | ✅ @RefreshScope |
| 命名空间? | ✅ prod/promo |

### 5.3 分布式事务

| 检查项 | 状态 |
|---|---|
| 需要 Seata 吗? | ❌ 当前不需要(SAGA 即可) |
| @Transactional 范围正确? | ✅ 只在 PromotionService 标注 |
| 事务传播? | ✅ 默认 REQUIRED |

### 5.4 限流

| 检查项 | 状态 |
|---|---|
| 有 Sentinel 限流吗? | ✅ QPS 100,BlockException 降级 |
| 降级逻辑? | ✅ 抛 PROMO_LIMIT |

### 5.5 安全

| 检查项 | 状态 |
|---|---|
| SQL 注入? | ✅ MyBatis 用 #{} |
| XSS? | ✅ 前后端都过滤 |
| CSRF? | ✅ Gateway 拦截 |
| 敏感信息? | ✅ 走 Nacos + 加密 |

---

## 6. 性能分析

### 6.1 关键路径耗时

| 步骤 | 平均 | P99 |
|---|---|---|
| 查规则(缓存命中) | 0.5ms | 1ms |
| 查规则(缓存未命中) | 5ms | 15ms |
| Redis SETNX | 0.2ms | 1ms |
| DB 查 usage | 2ms | 8ms |
| 策略计算 | 0.1ms | 0.5ms |
| DB insert | 3ms | 12ms |
| **总计** | **5.8ms** | **37ms** |

✅ 满足设计要求 < 10ms

### 6.2 并发性能

JMH 压测(100 线程并发):
- 吞吐量:5200 QPS
- 平均耗时:18ms
- P99:45ms

✅ 满足设计预估 100 QPS(实际可承载 50x)

---

## 7. Reviewer 签字

| Reviewer | 结论 | 备注 |
|---|---|---|
| Claude Code(自动) | 通过(条件) | P1 需修 |
| @王五(交叉) | 通过 | 同意 P1,建议 P2 跟进 |
| @赵六(测试) | 通过 | 测试覆盖充分 |
| @李四(产品) | 通过 | 满足验收标准 |

---

## 8. 后续行动

- [x] 修复 P1-1:Redisson 看门狗
- [x] 修复 P1-2:补充 JavaDoc
- [ ] 跟进 P2(下个迭代)

**预计重新提交时间**:2026-06-16 14:00
**再次 Review**:@王五

---

## 9. Review Checklist(下次复用)

```markdown
## 功能
- [ ] 满足所有验收标准
- [ ] 边界条件已处理
- [ ] 异常路径已处理

## 质量
- [ ] 代码可读
- [ ] JavaDoc 完整
- [ ] 命名规范
- [ ] 没有重复代码

## 安全
- [ ] SQL 用 #{}
- [ ] 敏感信息加密
- [ ] 输入验证

## 性能
- [ ] 关键路径 < 设计指标
- [ ] 缓存合理
- [ ] 无明显 N+1

## 维护性
- [ ] 单元测试充分
- [ ] 集成测试覆盖关键
- [ ] 文档更新
```

---

## 💡 填写要点

- **P0/P1/P2 分级清晰**——不要"P0/P1 都有",让人抓不到重点
- **每条问题有位置 + 代码 + 建议**——避免"代码不好"这种空话
- **Reviewer 多元**——不能只让 AI 审,人必须看一遍
- **后续行动可执行**——不是"建议改进",是"下个迭代做"

## 🎯 反模式

- ❌ 一次过百条 P2(让人失去信任)
- ❌ 走过场(所有人都打勾,实际没看)
- ❌ P0 写"代码不够优雅"(这不是 P0)
