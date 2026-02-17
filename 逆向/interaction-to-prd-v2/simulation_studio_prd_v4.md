# PRD: Video Creation Agent (v4.0 - Co-Created)

## 一、文档概述 (Document Overview)
> **Target Audience**: E-commerce Operator
> **Feature Intent**: High Efficiency & ROI

---

## 三、用户旅程 (User Journey Map)

### 3.1 核心画像: E-commerce Operator
> **Design Goal**: High Efficiency & ROI

| 阶段 | 核心动作 | 触点组件 | 代码映射逻辑 |
| :--- | :--- | :--- | :--- |
| **触达** | 访问创作工作室 | `ContentStudioNew` | 路由 `/simulation/studio` 加载 |
| **交互** | 创建脚本 | `CreateScriptModal` | 必须填写 Title 和 SlotType |
| **交付** | 生成视频 | `VideoStudioEditor` | 调用 `generateCinematicPrompt` |

## 四、功能详细说明 (Functional Specifications)

### 4.1 智能脚本创建
> **Value Proposition**: 为了实现 "High Efficiency & ROI"，系统提供了模板化的创建流程。

**规格详情 (Reverse Engineered)**:
*   **输入项**: Title, SlotType, AspectRatio, ShootingStyle
*   **约束**: Title 必填且非空
*   **默认值**: SlotType='Core Content', AspectRatio='9:16'

## 五、核心算法逻辑 (Core Algorithm Logic)
*   **Source**: `src/app/lib/iom-engine.ts`
*   **Logic**: 当 `iomEnabled=true` 时，根据 VisualIntent 自动注入镜头语言。

