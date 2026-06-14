#!/usr/bin/env python3
"""
Hook 2: 文档验证器 (PostToolUse - Write)
作用: 检测到 Write 创建 0X-*.md 模板时,自动验证模板完整性
"""
import json
import sys
import os
import re

# 8 个阶段模板的必填字段
TEMPLATE_REQUIRED = {
    "01-requirement": [
        r"需求编号", r"创建日期", r"需求方", r"负责人",
        r"## 1. 背景", r"## 2. 需求描述", r"## 3. 验收标准",
        r"## 4. 不做什么", r"## 5. 风险与依赖"
    ],
    "02-design": [
        r"关联需求", r"设计版本", r"## 1. 涉及的微服务",
        r"## 2. 接口设计", r"## 3. 数据库设计",
        r"## 6. 异常处理", r"## 7. 性能预估"
    ],
    "03-tasks": [
        r"关联设计", r"预估总工时", r"负责人",
        r"## 任务概览", r"### T1\."
    ],
    "06-test-report": [
        r"测试执行总览", r"覆盖率报告", r"测试用例清单",
        r"## 1\.", r"## 2\.", r"## 3\."
    ],
    "07-review": [
        r"Review 总览", r"P0 严重问题", r"P1 一般问题", r"P2 建议问题"
    ],
    "08-summary": [
        r"完成度", r"工时回顾", r"关键决策回顾",
        r"踩过的坑", r"数据"
    ]
}


def detect_template(file_path):
    """从文件名识别是哪个阶段模板"""
    basename = os.path.basename(file_path)
    for prefix in TEMPLATE_REQUIRED:
        if basename.startswith(prefix):
            return prefix
    return None


def validate_template(file_path, content):
    """验证模板完整性"""
    template = detect_template(file_path)
    if not template:
        return None  # 不是阶段模板,跳过

    required = TEMPLATE_REQUIRED[template]
    missing = []
    for pattern in required:
        if not re.search(pattern, content):
            missing.append(pattern)

    return {
        "template": template,
        "missing": missing,
        "complete": len(missing) == 0
    }


def main():
    try:
        input_data = json.load(sys.stdin)
    except json.JSONDecodeError:
        sys.exit(0)

    tool_name = input_data.get("tool_name", "")
    tool_input = input_data.get("tool_input", {})

    # 只处理 Write 工具
    if tool_name != "Write":
        sys.exit(0)

    file_path = tool_input.get("file_path", "")
    content = tool_input.get("content", "")

    result = validate_template(file_path, content)

    if not result:
        sys.exit(0)  # 不是阶段模板,放行

    # 输出验证结果
    if result["complete"]:
        print(f"✅ [{result['template']}] 模板完整", file=sys.stderr)
    else:
        print(f"⚠️ [{result['template']}] 模板不完整,缺失字段:", file=sys.stderr)
        for m in result["missing"]:
            print(f"   - {m}", file=sys.stderr)

    # Hook 协议:不阻断,只提示
    output = {
        "continue": True,
        "hookSpecificOutput": {
            "additionalContext": json.dumps(result, ensure_ascii=False)
        }
    }
    print(json.dumps(output))


if __name__ == "__main__":
    main()
