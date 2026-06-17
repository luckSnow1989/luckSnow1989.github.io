#!/usr/bin/env python3
"""
Hook 3: 覆盖率检查器 (PostToolUse - Bash)
作用: 检测到 mvn test jacoco:report 跑完后,自动检查覆盖率
      不达标时阻止进入下一阶段
"""
import json
import sys
import os
import re
import glob

# 覆盖率硬指标(可配置)
COVERAGE_TARGETS = {
    "service": {"line": 80, "branch": 70},
    "controller": {"line": 60, "branch": 0},
    "util": {"line": 100, "branch": 100},
    "default": {"line": 80, "branch": 70}
}


def parse_jacoco_report(report_path):
    """解析 JaCoCo CSV 报告,按 PACKAGE 聚合 line/branch 覆盖率

    JaCoCo CSV 列定义(13 列):
      0:GROUP  1:PACKAGE  2:CLASS
      3:INSTRUCTION_MISSED  4:INSTRUCTION_COVERED
      5:BRANCH_MISSED        6:BRANCH_COVERED
      7:LINE_MISSED          8:LINE_COVERED
      9:COMPLEXITY_MISSED   10:COMPLEXITY_COVERED
     11:METHOD_MISSED        12:METHOD_COVERED

    CSV 只输出 CLASS 维度的行,需要按 PACKAGE 字段手动聚合。
    """
    if not os.path.exists(report_path):
        return None

    with open(report_path, 'r') as f:
        lines = f.readlines()

    if len(lines) < 2:
        return None

    # 按 PACKAGE 聚合统计
    pkg_stats = {}  # package -> {line_missed, line_covered, branch_missed, branch_covered}

    for line in lines[1:]:  # 跳标题
        parts = line.strip().split(',')
        if len(parts) < 13:
            continue

        group = parts[0].strip()
        package = parts[1].strip()
        class_name = parts[2].strip()

        # 跳过空 CLASS 行(汇总行)
        if not class_name:
            continue
        # 跳过 GROUP == PACKAGE 的非 class 行
        if group == package:
            continue
        # 跳过根包(Spring Boot 启动类,不属于业务模块)
        if package == "com.example.my_demo":
            continue
        # 跳过 Lombok 自动生成的 DTO/VO/Entity(只有 getter/setter/equals/hashCode,覆盖率意义不大)
        last_pkg = package.rsplit('.', 1)[-1] if '.' in package else package
        if last_pkg in ('dto', 'vo', 'entity'):
            continue
        # 跳过匿名内部类(如 FileProductRepository.new TypeReference() {...})
        if '.new ' in class_name or '{' in class_name:
            continue

        try:
            line_missed = int(parts[7])       # 真正的 LINE_MISSED
            line_covered = int(parts[8])      # 真正的 LINE_COVERED
            branch_missed = int(parts[5])     # 真正的 BRANCH_MISSED
            branch_covered = int(parts[6])    # 真正的 BRANCH_COVERED
        except (ValueError, IndexError):
            continue

        if package not in pkg_stats:
            pkg_stats[package] = {
                "line_missed": 0, "line_covered": 0,
                "branch_missed": 0, "branch_covered": 0
            }
        pkg_stats[package]["line_missed"] += line_missed
        pkg_stats[package]["line_covered"] += line_covered
        pkg_stats[package]["branch_missed"] += branch_missed
        pkg_stats[package]["branch_covered"] += branch_covered

    # 计算每个 package 的覆盖率
    results = []
    for package, stats in pkg_stats.items():
        line_total = stats["line_missed"] + stats["line_covered"]
        line_pct = (stats["line_covered"] / line_total * 100) if line_total > 0 else 100

        branch_total = stats["branch_missed"] + stats["branch_covered"]
        branch_pct = (stats["branch_covered"] / branch_total * 100) if branch_total > 0 else 100

        results.append({
            "package": package,
            "line_pct": round(line_pct, 1),
            "branch_pct": round(branch_pct, 1),
            "line_covered": stats["line_covered"],
            "line_total": line_total
        })

    return results


def classify_package(package):
    """根据包名分类,决定用哪个目标"""
    pkg_lower = package.lower()
    last_pkg = package.rsplit('.', 1)[-1] if '.' in package else package

    # service 包(含 .impl)统一归为 service
    if "service" in pkg_lower:
        return "service"
    if "controller" in pkg_lower:
        return "controller"
    if "util" in pkg_lower or "utils" in pkg_lower:
        return "util"
    return "default"


def check_coverage(command, cwd):
    """检查最近一次 mvn test 跑完后的覆盖率"""
    # 找最新的 JaCoCo 报告
    candidates = [
        os.path.join(cwd, "target", "site", "jacoco", "jacoco.csv"),
        os.path.join(cwd, "target", "jacoco-report", "jacoco.csv"),
    ]

    # 子模块
    for sub in glob.glob(os.path.join(cwd, "**", "target", "site", "jacoco", "jacoco.csv"), recursive=True):
        candidates.append(sub)

    # 找最新修改的
    candidates = [c for c in candidates if os.path.exists(c)]
    if not candidates:
        return None

    latest = max(candidates, key=os.path.getmtime)
    return parse_jacoco_report(latest)


def evaluate(results):
    """根据结果判定通过/失败"""
    if not results:
        return {"status": "UNKNOWN", "message": "未找到覆盖率报告"}

    failed = []
    for r in results:
        category = classify_package(r["package"])
        target = COVERAGE_TARGETS[category]
        if r["line_pct"] < target["line"]:
            failed.append({
                "package": r["package"],
                "category": category,
                "actual": r["line_pct"],
                "target": target["line"],
                "type": "line"
            })
        if target["branch"] > 0 and r["branch_pct"] < target["branch"]:
            failed.append({
                "package": r["package"],
                "category": category,
                "actual": r["branch_pct"],
                "target": target["branch"],
                "type": "branch"
            })

    return {
        "status": "PASS" if not failed else "FAIL",
        "results": results,
        "failed": failed,
        "summary": f"总包数: {len(results)}, 失败: {len(failed)}"
    }


def main():
    try:
        input_data = json.load(sys.stdin)
    except json.JSONDecodeError:
        sys.exit(0)

    tool_name = input_data.get("tool_name", "")
    tool_input = input_data.get("tool_input", {})
    tool_output = input_data.get("tool_output", "")

    if tool_name != "Bash":
        sys.exit(0)

    command = tool_input.get("command", "")
    cwd = input_data.get("cwd", ".")

    # 只检查 mvn test 相关命令
    if "mvn" not in command or "test" not in command:
        sys.exit(0)

    # 跑完才检查
    if "BUILD SUCCESS" not in tool_output and "BUILD FAILURE" not in tool_output:
        sys.exit(0)

    if "BUILD FAILURE" in tool_output:
        print("❌ 构建失败,跳过覆盖率检查", file=sys.stderr)
        output = {
            "decision": "block",
            "reason": "构建失败,需先修复编译/测试错误再继续"
        }
        print(json.dumps(output))
        sys.exit(0)

    # 检查覆盖率
    results = check_coverage(command, cwd)
    if not results:
        print("⚠️ 未找到 JaCoCo 报告,跳过检查", file=sys.stderr)
        output = {"continue": True}
        print(json.dumps(output))
        sys.exit(0)

    evaluation = evaluate(results)

    print(f"\n📊 覆盖率检查结果: {evaluation['status']}", file=sys.stderr)
    print(f"   {evaluation['summary']}", file=sys.stderr)

    if evaluation["status"] == "PASS":
        print("✅ 覆盖率达标,可以进入下一阶段", file=sys.stderr)
        output = {
            "continue": True,
            "hookSpecificOutput": {
                "additionalContext": json.dumps(evaluation, ensure_ascii=False)
            }
        }
    else:
        print("❌ 覆盖率不达标:", file=sys.stderr)
        for f in evaluation["failed"]:
            print(f"   - {f['package']} ({f['type']}): {f['actual']}% < {f['target']}%", file=sys.stderr)

        # 不阻断(因为还要补测试),但强提示
        output = {
            "continue": True,
            "hookSpecificOutput": {
                "additionalContext": f"⚠️ 覆盖率不达标,需补测试后才能进 review 阶段。详情: {json.dumps(evaluation, ensure_ascii=False)}"
            }
        }

    print(json.dumps(output))


if __name__ == "__main__":
    main()
