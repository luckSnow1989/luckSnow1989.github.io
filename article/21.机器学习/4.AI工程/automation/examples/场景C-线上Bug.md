# 实例:场景 C - 线上 Bug

> 场景:生产环境报"Bug #4231 - 部分用户订单金额计算错误,误差 0.01 元"

## 阶段调整(对比场景 A)

| 阶段 | 调整 |
|---|---|
| **0 需求** | 简化为"现象 + 复现 + 影响" |
| **1 设计** | 跳到根因分析(不是新功能设计) |
| **2 任务** | 简化为"修复 + 回归" |
| **3 Worktree** | `hotfix/REQ-2026-NNN-fix` |
| **4 编码** | 小范围修改 |
| **5 测试** | **复现用例转测试**(防回归) |
| **6 审查** | 重点 review 根因 + 修复 |
| **7 收尾** | **复盘文档**(写"为什么 bug 会出现") |

## 快速通道(8 阶段合并)

```
0+1 需求 + 根因(15min) → 2 任务(5min) → 3 Worktree(5min)
→ 4 修复(1h) → 5 测试(1h) → 6 复盘 review(30min) → 7 归档(15min)
```
**总耗时 3 小时**(紧急)

## 01-requirement.md(简化)

```markdown
# [REQ-2026-042] 修复订单金额 0.01 元误差

## 现象
用户反馈:订单 ¥99.99 显示实付 ¥99.98,少收 0.01 元
发生时间:2026-06-20 10:00 之后
影响范围:约 50 个订单(根据日志)

## 复现步骤
1. 订单金额 99.99
2. 应用"满 100 减 20"
3. 实付 = 79.99(预期)

## 根因
PromotionServiceImpl 中 BigDecimal 计算:
```java
BigDecimal finalAmount = orderAmount.subtract(discount);
// 99.99 - 20 = 79.98999999999999 (double 精度)
```

## 影响
- 用户少付 0.01 元
- 财务对账不平
- 严重度:中(不影响主流程,但数据错误)
```

## 复现用例转测试

```java
@Test
@DisplayName("复现 Bug #4231:99.99 减 20 后应为 79.99 而非 79.98")
void regressionBug4231() {
    BigDecimal orderAmount = new BigDecimal("99.99");
    BigDecimal discount = new BigDecimal("20.00");

    BigDecimal finalAmount = orderAmount.subtract(discount);

    // ❌ 修复前:79.98999999999999
    // ✅ 修复后:79.99
    assertThat(finalAmount).isEqualByComparingTo("79.99");
}
```

**这个测试永远不删**——是 bug 的"墓碑",防止回归。

## 修复

```java
// ❌ 错误:用了 double 精度
double finalAmount = orderAmount - discount;

// ✅ 正确:用 BigDecimal.setScale
BigDecimal finalAmount = orderAmount.subtract(discount)
    .setScale(2, RoundingMode.HALF_UP);  // 强制 2 位小数
```

## 07-review.md(重点)

```markdown
## 根因 Review
- [ ] 是不是用了 double 而非 BigDecimal? ← 本次
- [ ] 是不是浮点数计算未指定 scale?
- [ ] 是不是用了 == 比较 BigDecimal?
- [ ] 是不是没考虑四舍五入?

## 修复 Review
- [ ] 用 setScale(2, HALF_UP) 统一
- [ ] 全公司 grep 其他可能地方
- [ ] 写复现测试,防回归
```

## 08-summary.md(必填"复盘")

```markdown
## 复盘

### Bug 是什么?
订单金额 99.99 减 20 后,出现 0.01 元误差

### 为什么会出现?
1. 写代码时图省事用了 double
2. 单元测试只测了整数 100,没测小数边界
3. Code Review 没看 BigDecimal 用法

### 怎么防止再发生?
1. ✅ 写复现测试,进 CI
2. ✅ 团队规约:金额计算必须用 BigDecimal.setScale
3. ✅ Lint 规则:禁止在金额字段用 double
4. ⏳ 培训:Java 金额计算最佳实践
```

## 关键经验

1. **复现测试是 bug 修复的核心**——没复现测试的修复都是耍流氓
2. **根因分析时间 > 修复时间**——修错了等于没修
3. **复盘文档比修复代码更值钱**——后人看了不会重复踩
4. **3 小时解决 + 1 小时复盘**——不要赶进度跳过复盘
