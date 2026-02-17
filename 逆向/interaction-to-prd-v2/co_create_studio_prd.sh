#!/bin/bash
# co_create_studio_prd.sh
# Human-AI Co-Creation Workflow for PRD Generation

OUTPUT_FILE="simulation_studio_prd_v4.md"

echo "🤝 Human-AI Co-Creation Mode"
echo "------------------------------------------------"
echo "I (The AI) will handle the 80% (Specs, Logic, Flows)."
echo "You (The PMS) need to define the 20% (Who & Why)."
echo "------------------------------------------------"

# 1. 采集人类意图 (The 20%)
echo ""
echo "Q1: Who is the primary Target Audience? (e.g., 'Novice Creator')"
read -p "> " TARGET_AUDIENCE

echo ""
echo "Q2: What is the core Feature Intent? (e.g., 'Lower entry barrier')"
read -p "> " FEATURE_INTENT

echo ""
echo "🤖 AI Analysis: Tracing code logic based on your intent..."
echo "Running: interaction-to-prd-cn skill..."
sleep 1

# 2. 生成 PRD 内容 (AI Auto-Generation based on Code + Human Input)
# 注意：此处为模拟 AI 根据输入变量生成的过程

cat << EOF > "$OUTPUT_FILE"
# PRD: Video Creation Agent (v4.0 - Co-Created)

## 一、文档概述 (Document Overview)
> **Target Audience**: $TARGET_AUDIENCE
> **Feature Intent**: $FEATURE_INTENT

---

## 三、用户旅程 (User Journey Map)

### 3.1 核心画像: $TARGET_AUDIENCE
> **Design Goal**: $FEATURE_INTENT

| 阶段 | 核心动作 | 触点组件 | 代码映射逻辑 |
| :--- | :--- | :--- | :--- |
| **触达** | 访问创作工作室 | \`ContentStudioNew\` | 路由 \`/simulation/studio\` 加载 |
| **交互** | 创建脚本 | \`CreateScriptModal\` | 必须填写 Title 和 SlotType |
| **交付** | 生成视频 | \`VideoStudioEditor\` | 调用 \`generateCinematicPrompt\` |

## 四、功能详细说明 (Functional Specifications)

### 4.1 智能脚本创建
> **Value Proposition**: 为了实现 "$FEATURE_INTENT"，系统提供了模板化的创建流程。

**规格详情 (Reverse Engineered)**:
*   **输入项**: Title, SlotType, AspectRatio, ShootingStyle
*   **约束**: Title 必填且非空
*   **默认值**: SlotType='Core Content', AspectRatio='9:16'

## 五、核心算法逻辑 (Core Algorithm Logic)
*   **Source**: \`src/app/lib/iom-engine.ts\`
*   **Logic**: 当 \`iomEnabled=true\` 时，根据 VisualIntent 自动注入镜头语言。

EOF

# 3. 人工验证环 (HITL)
echo ""
echo "✅ Draft generated: $OUTPUT_FILE"
echo "------------------------------------------------"
echo "👤 Please review the generated PRD."
echo "   Does the User Journey match your '$TARGET_AUDIENCE' persona?"
echo "------------------------------------------------"
read -p "Press [Enter] to open file for review..."

if command -v code &> /dev/null; then
    code "$OUTPUT_FILE"
elif command -v open &> /dev/null; then
    open "$OUTPUT_FILE"
else
    echo "Please open '$OUTPUT_FILE' manually."
fi

echo ""
read -p "Approved? (y/n) " -n 1 -r
echo ""

if [[ $REPLY =~ ^[Yy]$ ]]; then
    echo "🎉 PRD Finalized!"
else
    echo "❌ Draft kept for iteration."
fi
