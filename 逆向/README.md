# 赤光智算 - 逆向工程技能库 (Reverse Engineering Skills)

> 🔓 **让代码"说话"：通过 AI 从前端代码逆向还原业务逻辑**

本仓库包含了一套高级 AI Agent Skills，专用于从前端源代码（React/Vue 等）中"逆向工程"出产品需求文档 (PRD)、业务逻辑和后端架构。

旨在帮助团队快速理解遗留代码、接手新项目或将现有功能文档化。

## 📂 仓库结构

### 1. [核心技能] Interaction to PRD (交互反推 PRD v4)
*   **路径**: [`interaction-to-prd/`](./interaction-to-prd/)
*   **描述**: 旗舰级 Skill，能将前端代码转化为标准的 **16 章节产品需求文档 (PRD)**。
*   **核心特性**:
    *   **交互式访谈协议**: 自动检测缺失的逻辑（如后端接口、复杂算法），并向用户提出针对性问题，拒绝盲目猜测。
    *   **16 章节标准**: 生成符合交付标准的专业文档，包含功能点、用户画像、非功能性需求等。
    *   **可视化架构**: 从代码中推断并生成 Mermaid 架构图（时序图、状态机、类图）。

### 2. [参考资料] 文档与模板
*   **路径**: [`references/`](./references/)
*   **内容**:
    *   AI Agent PRD 交付标准模板
    *   Claude Skill 创建指南
    *   历史 PRD 案例参考

## 🚀 快速开始 (内部使用指南)

要在你的项目中使用 **Interaction-to-PRD** 技能：

1.  **准备脚本**: 将 `interaction-to-prd/scripts/` 文件夹复制到目标项目的根目录。
2.  **第一步：智能扫描 (Interviewer)**
    运行以下命令扫描源码（默认扫描 `./src`）：
    ```bash
    ./scripts/interviewer.sh ./src
    ```
    *系统会生成 `gap_analysis.md` (分析报告) 和 `interview_questions.md` (待确认问题)。*

3.  **第二步：补充上下文**
    打开 `interview_questions.md`，将你的答案填入一个新文件 `interview_answers.md`。

4.  **第三步：生成文档 (Writer)**
    运行生成命令：
    ```bash
    ./scripts/writer.sh
    ```
    *系统将结合代码事实 + 你的问答，输出最终的 `final_prd_v4.md`。*

## 📜 协议
Apache 2.0
