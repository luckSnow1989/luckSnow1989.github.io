#!/usr/bin/env python3
"""
Hook 1: 阶段跟踪器 (UserPromptSubmit)
作用: 检测用户输入,自动激活对应的阶段 skill
"""
import json
import sys
import os
from datetime import datetime

STATE_FILE = "/tmp/req-state.json"

# 8 阶段对应的触发关键词
STAGE_TRIGGERS = {
    "0": ["需求", "requirement", "脑暴", "brainstorm"],
    "1": ["设计", "design", "架构"],
    "2": ["任务", "task", "分解", "拆解"],
    "3": ["worktree", "分支", "branch"],
    "4": ["代码", "实现", "写代码", "coding", "implement"],
    "5": ["测试", "test", "覆盖", "coverage"],
    "6": ["review", "审查", "评审"],
    "7": ["收尾", "归档", "merge", "summary", "完成"]
}


def load_state():
    """加载当前状态"""
    if os.path.exists(STATE_FILE):
        with open(STATE_FILE, 'r') as f:
            return json.load(f)
    return {"current_stage": None, "req_id": None, "history": []}


def save_state(state):
    """保存状态"""
    with open(STATE_FILE, 'w') as f:
        json.dump(state, f, indent=2)


def detect_stage(prompt):
    """从用户输入检测想进入的阶段"""
    prompt_lower = prompt.lower()
    for stage, keywords in STAGE_TRIGGERS.items():
        for kw in keywords:
            if kw in prompt_lower:
                return stage
    return None


def main():
    # 读取 hook 输入(Claude Code 通过 stdin 传 JSON)
    try:
        input_data = json.load(sys.stdin)
    except json.JSONDecodeError:
        # 不影响主流程
        sys.exit(0)

    user_prompt = input_data.get("user_prompt", "")
    session_id = input_data.get("session_id", "")

    state = load_state()

    # 检测是否在 8 阶段流程中
    detected = detect_stage(user_prompt)

    if detected and state.get("req_id"):
        # 推进状态机
        old_stage = state.get("current_stage", "?")
        if detected != old_stage:
            state["current_stage"] = detected
            state["history"].append({
                "from": old_stage,
                "to": detected,
                "timestamp": datetime.now().isoformat(),
                "prompt": user_prompt[:80]
            })
            save_state(state)

            # 输出 hook 提示
            print(f"🔄 状态推进: 阶段 {old_stage} → 阶段 {detected}", file=sys.stderr)
            print(f"📋 当前需求: {state['req_id']}", file=sys.stderr)

    # 输出 JSON(Claude Code hook 协议)
    output = {
        "continue": True,
        "hookSpecificOutput": {
            "additionalContext": f"当前阶段: {state.get('current_stage', '?')}/8, 需求: {state.get('req_id', '未设置')}"
        }
    }
    print(json.dumps(output))


if __name__ == "__main__":
    main()
