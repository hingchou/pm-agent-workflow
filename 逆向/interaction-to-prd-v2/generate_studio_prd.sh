#!/bin/bash
# generate_studio_prd.sh
# 自动生成 Content Studio PRD (Human-in-the-Loop Verified)

# 定义文件路径
DRAFT_FILE="draft_simulation_studio_prd.md"
FINAL_FILE="simulation_studio_prd_v3.1.md"

echo "🤖 AI Agent: Generating Draft PRD..."

# 1. 生成草稿内容
cat << 'EOF' > "$DRAFT_FILE"
# PRD: Video Creation Agent (Draft for Review)

> [!WARNING] 需人工核对
> 本文档由 AI 自动生成，请重点检查 **第五章算法逻辑** 和 **第七章数据模型**。

## 一、文档概述 (Document Overview)
> **Context**: 本文档描述了一个用于视频创作的智能体 (Agent)，它通过 "Content Studio" 界面与用户交互。

---

## 三、用户旅程 (User Journey Map)

### 3.1 典型画像: 进阶创作者 (Advanced Creator)
> [!NOTE] 来源: 结合 Context 与 Interaction Flow 推导

| 阶段 | 核心动作 | 触点组件 | 系统反馈 |
| :--- | :--- | :--- | :--- |
| **1. 触达** | 点击 "Create New Script" | `CreateScriptModal` | 弹出表单 |
| **2. 交互** | 上传首帧图片 | `VisualAnchorUpload` | 预览图片加载 |
| **3. 细化** | 开启 IOM 润色 | `SceneDetailSheet` | 生成 Cinematic Prompt |
| **4. 交付** | 点击 "Generate Video" | `VideoStudioEditor` | 进度条显示 "Rendering" |

## 四、数据输入规范 (Data Input Specifications)

### 1. 脚本创建表单 (CreateScriptModal)
| 字段名称 | 类型 | 必填 | 约束条件 |
| :--- | :--- | :--- | :--- |
| **title** | string | 是 | `trim().length > 0` |
| **slotType** | Enum | 是 | `Core Content`, `Monetized`, `Experiment` |

## 五、核心算法逻辑 (Core Algorithm Logic)

> [!WARNING] 需人工核对: Visual Intent 映射表
> 请确认以下映射是否与 `iom-engine.ts` 最新版本一致。

**Visual Intent Mapping**:
*   `Detail` -> `close-up, macro lens`
*   `Impact` -> `wide shot, dramatic lighting`
*   `Emotion` -> `soft focus, warm tones`

EOF

echo "✅ Draft generated: $DRAFT_FILE"
echo ""
echo "👤 Human-in-the-Loop Checkpoint:"
echo "------------------------------------------------"
echo "Please review the draft PRD. The file will be opened for you."
echo "Press [Enter] to open the file..."
read -p ""

# 尝试打开文件 (兼容 Mac/Linux)
if command -v code &> /dev/null; then
    code "$DRAFT_FILE"
elif command -v open &> /dev/null; then
    open "$DRAFT_FILE"
else
    echo "Could not open editor automatically. Please open '$DRAFT_FILE' manually."
fi

echo ""
echo "------------------------------------------------"
read -p "Have you finished reviewing and saving changes? (y/n) " -n 1 -r
echo ""

if [[ $REPLY =~ ^[Yy]$ ]]; then
    mv "$DRAFT_FILE" "$FINAL_FILE"
    echo "🎉 Success! Verified PRD saved to: $FINAL_FILE"
else
    echo "❌ Operation cancelled. Draft kept at: $DRAFT_FILE"
fi
