# 实例:场景 B - 复杂重构(无新功能)

> 场景:order-service 的 OrderServiceImpl 已有 2000+ 行,需要按业务领域拆分

## 阶段调整(对比场景 A)

| 阶段 | 调整 |
|---|---|
| **0 需求** | 简化为"重构理由 + 重构范围" |
| **1 设计** | 重头戏(架构兼容性 / 灰度 / 回滚) |
| **2 任务** | 拆更细,每步影响生产 |
| **4 编码** | 严格 TDD + 不破坏现有测试 |
| **5 测试** | **全量跑测试**(回归测试是重点) |
| **6 审查** | 重点 review 兼容性 |
| **7 收尾** | 灰度上线 + 监控 + 回滚预案 |

## 重构范围(02-design.md 重点)

```markdown
## 重构前
OrderServiceImpl (2000+ 行)
├── 订单创建
├── 订单查询
├── 订单修改
├── 订单取消
├── 退款
├── 评价
├── 物流对接
└── 促销应用

## 重构后
- OrderCreateService
- OrderQueryService
- OrderUpdateService
- OrderCancelService
- RefundService
- ReviewService
- LogisticsService
- PromotionApplicationService (本次需求)
```

## 灰度方案

- **阶段 1**:内部账号 10 个,7 天
- **阶段 2**:白名单 100 个,3 天
- **阶段 3**:5% 流量,3 天
- **阶段 4**:全量

每个阶段切换前必须有:
- 全量回归测试通过
- 监控无异常
- 业务方确认

## 回滚预案

```bash
# 1. 切回旧版本(代码灰度)
nacos config:publish --dataId=order-service --group=DEFAULT_GROUP \
  --content="version=old"

# 2. 数据回滚(如有迁移)
# 本次无数据迁移

# 3. 缓存清理
redis-cli FLUSHDB
```

## 重点 review 项

```markdown
## P0 必修
- [ ] 事务边界:@Transactional 是否还在正确位置
- [ ] 异常传播:子服务抛异常,主流程能正确处理
- [ ] 兼容性:旧代码调用方是否还能用(本次不删旧代码)

## P1 必改
- [ ] Bean 注入:循环依赖?
- [ ] 配置:Nacos 配置项有没有漏迁移
- [ ] 日志:traceId 还能串起来吗
```

## 关键经验

1. **重构 ≠ 重写**——保留外部行为,只改内部结构
2. **新旧并存**——旧代码先保留,新代码并行跑,逐步切流量
3. **回滚优先**——任何操作前先想"出问题怎么 5 分钟内回滚"
4. **监控先行**——重构前先把核心指标打好 baseline,不然出问题不知道
