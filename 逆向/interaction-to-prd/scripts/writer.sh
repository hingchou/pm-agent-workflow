#!/bin/bash

# ==========================================
# Interaction-to-PRD V4: Writer Agent
# ==========================================
# Purpose: Synthesizes Code Facts + Interview Answers into a Final PRD.
# Usage: ./writer.sh

ANSWERS_FILE="interview_answers.md"
OUTPUT_FILE="final_prd_v4.md"

if [ ! -f "$ANSWERS_FILE" ]; then
    echo "❌ Error: $ANSWERS_FILE not found."
    echo "   Please create it by answering the questions from 'interview_questions.md'."
    exit 1
fi

echo "✍️ [Writer Agent] Reading Interview Answers..."
cat "$ANSWERS_FILE"
echo ""
echo "✍️ [Writer Agent] Synthesizing PRD with Code Facts..."

# NOTE: In a real agentic run, this would pass the code + answers to an LLM.
# Here we generate the Document Structure based on the V4 Standard.

cat <<EOF > "$OUTPUT_FILE"
# Product Requirement Document (V4 Interactive)

> [!IMPORTANT]
> **Source of Truth**:
> *   ✅ **Code**: Frontend Components & State Logic
> *   ✅ **Interview**: Backend Logic & Business Rules (User Provided)

## 1. 文档概述 (Document Overview)
> (Combining findings from code analysis...)

## 2. 产品概述 (Product Overview)
> (Inferred from UI layout and 'interview_answers.md' Q1...)

## 3. 用户画像与交互旅程 (User Flows)
> (Inferred from Router/Navigation code + Permissions setup from Q3...)

## 4. 功能详细说明 (Functional Specs)
> (Features identified in code, enriched by Answers...)

## 5. 核心算法逻辑 (Core Business Logic) 🧠
> **From Interview Answers**:
$(cat "$ANSWERS_FILE" | grep -A 5 "Logic" || echo "See Interview Answers")

## 6. 系统/Agent 架构设计 (System Architecture)
\`\`\`mermaid
graph TB
    User --> UI
    UI --> API
    API --> Logic
    Logic --> DB
\`\`\`

## 7. 数据输入规范 (Data Input Specs)
> (Extracted from TypeScript Interfaces...)

... (Remaining chapters 8-16 as per standard) ...

## 16. 双模型校验报告 (Dual-Model Validation) 🛡️
*   **Logic Check**: Validated against User Answers.
*   **Code Check**: Validated against Source Files.

EOF

echo "✅ [Writer Agent] V4 PRD Generated: $OUTPUT_FILE"
echo "---------------------------------------------------"
echo "This is a Template. In a real Agentic workflow, I would now"
echo "fill this content using the LLM context context."
echo "---------------------------------------------------"
