# 设计模板:02-design.md

> **何时使用**:阶段 1,完成需求分析后
> **谁负责**:架构师 + CC 协助
> **耗时**:30-60 分钟

---

```markdown
# [REQ-2026-001] 技术方案

| 项目 | 内容 |
|---|---|
| 关联需求 | [01-requirement.md](./01-requirement.md) |
| 设计版本 | v1.2(2026-06-14) |
| 设计人 | @张三 + Claude Code |
| 评审人 | @王五(架构师)/ @赵六(测试) |

## 1. 涉及的微服务

| 服务 | 角色 | 改动类型 |
|---|---|---|
| order-service | 订单创建时调用促销 | 修改(新增 Feign Client) |
| promotion-service | 促销规则查询 + 应用 | **新增** |
| account-service | 无 | 无 |
| gateway-service | 无 | 无 |

## 2. 接口设计

### 2.1 promotion-service 暴露

```yaml
# Feign Client(供 order-service 调用)
@FeignClient(name = "promotion-service", path = "/api/promotion")
public interface PromotionClient {

    @PostMapping("/apply")
    PromotionResult applyPromotion(@RequestBody PromotionRequest request);
}
```

### 2.2 promotion-service 入参

```json
{
  "userId": 12345,
  "orderId": "ORD-20260614-001",
  "originalAmount": 100.00,
  "promoCode": "FULL_100_20"
}
```

### 2.3 promotion-service 返回

```json
{
  "success": true,
  "finalAmount": 80.00,
  "discountAmount": 20.00,
  "promoCode": "FULL_100_20",
  "promoName": "满100减20",
  "traceId": "abc123"
}
```

## 3. 数据库设计

### 3.1 新增 promo_rule 表(规则定义)

```sql
CREATE TABLE promo_rule (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    code VARCHAR(50) NOT NULL UNIQUE COMMENT '规则编码',
    name VARCHAR(100) NOT NULL COMMENT '规则名称',
    type VARCHAR(20) NOT NULL COMMENT '类型:FULL_REDUCTION / DISCOUNT',
    threshold DECIMAL(10,2) COMMENT '满减门槛(元)',
    discount DECIMAL(10,2) COMMENT '减免金额(元)',
    start_time DATETIME NOT NULL,
    end_time DATETIME NOT NULL,
    status TINYINT DEFAULT 1 COMMENT '0-禁用 1-启用',
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX idx_code (code),
    INDEX idx_time (start_time, end_time)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='促销规则';
```

### 3.2 新增 promo_usage 表(使用记录,防刷)

```sql
CREATE TABLE promo_usage (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    user_id BIGINT NOT NULL,
    promo_code VARCHAR(50) NOT NULL,
    order_id VARCHAR(50) NOT NULL,
    used_date DATE NOT NULL,
    status TINYINT DEFAULT 1 COMMENT '1-已使用 2-已退还',
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    UNIQUE KEY uk_user_promo_date (user_id, promo_code, used_date, status),
    INDEX idx_order (order_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='促销使用记录';
```

## 4. 关键流程

### 4.1 正常流程(顺序图)

```
用户 → 订单服务 → 促销服务 → MySQL/Redis
  │       │           │          │
  │  创建订单        │          │
  ├──────▶│           │          │
  │       │ 计算金额  │          │
  │       ├──────────▶│          │
  │       │           │ 查规则   │
  │       │           ├─────────▶│
  │       │           │←─────────┤
  │       │           │ 检查次数 │
  │       │           ├─────────▶│ Redis
  │       │           │←─────────┤
  │       │           │ 写记录   │
  │       │           ├─────────▶│ MySQL
  │       │           │←─────────┤
  │       │←──────────┤          │
  │       │ 创建订单   │          │
  │       ├─────────────────────▶│ MySQL
  │       │ 成功       │          │
  │←──────┤           │          │
```

### 4.2 退单流程

```
用户 → 订单服务 → 促销服务
  │       │           │
  │  退单  │           │
  ├──────▶│           │
  │       │ 退还次数  │
  │       ├──────────▶│
  │       │           │ 更新 promo_usage.status=2
  │       │           │
```

## 5. 缓存设计

- **promo_rule**:Redis 缓存,key=`promo:rule:{code}`,TTL=10 分钟
  - 启动时加载,变更时主动失效(Nacos + Redis Pub/Sub)
- **promo_usage**:不走缓存(强一致性)
- **分布式锁**:key=`promo:lock:{userId}:{code}:{date}`,SETNX,TTL=5s

## 6. 异常处理

| 场景 | 处理 |
|---|---|
| 规则不存在 | 返回原金额 + log warn |
| 用户超限 | 返回原金额 + 返回码 PROMO_LIMIT_EXCEEDED |
| 分布式锁失败 | 重试 3 次,失败则返回原金额(降级) |
| 网络超时 | Feign fallback,订单正常创建,促销失败 |
| 退单调用促销失败 | 重试 + 人工对账 |

## 7. 性能预估

- 预估 QPS:100(618 高峰)
- 单次计算耗时:< 10ms(无锁)/ < 50ms(有锁竞争)
- 缓存命中:> 95%
- DB QPS:< 10(主要是 promo_usage insert)

## 8. 风险与缓解

| 风险 | 影响 | 缓解 |
|---|---|---|
| 分布式锁失效 | 同一用户 1 天多次使用 | Redis SETNX + DB 唯一索引兜底 |
| 缓存不一致 | 用户用了过期的规则 | 启用前同步刷新缓存 + 校验 |
| Feign 调用失败 | 订单创建失败 | fallback + 重试 |
| 退单失败 | 次数不返还 | 重试 + 离线对账任务 |

## 9. 监控与告警

- Prometheus 指标:
  - `promo_apply_total{result=success/fail}`
  - `promo_apply_duration_seconds`
  - `promo_lock_wait_seconds`
- 告警规则:
  - 应用失败率 > 1% → 告警
  - 平均耗时 > 100ms → 告警
  - 锁等待 > 1s → 告警

## 10. 上线与回滚

- 上线顺序:
  1. 上线 promotion-service(灰度)
  2. 上线 order-service(灰度)
  3. 全量
- 回滚:
  - promotion-service:删表 + 关闭 Nacos 开关
  - order-service:关闭 Feign 调用

## 11. 评审意见

| 评审人 | 意见 | 是否采纳 |
|---|---|---|
| @王五 | 分布式锁用 Redisson 不用自己 SETNX | ✅ 采纳 |
| @王五 | 缓存预热要做 | ✅ 已加(任务 T1.5) |
| @赵六 | 集成测试要测并发 | ✅ 已加 |
```

---

## 💡 填写要点

- **接口设计用真实代码**——不画饼,CC 才能照着写
- **数据库 DDL 完整**——含索引,MySQL 5.7/8.0 语法都注意
- **异常处理 + 性能预估必须有**——上线后翻车就看这个
- **监控指标要可观测**——别写"观察",写"promo_apply_total"

## 🎯 反模式

- ❌ 接口设计"略"——后面扯皮
- ❌ 没有性能预估——出问题了不知道哪里瓶颈
- ❌ 没有回滚方案——线上事故时手忙脚乱
