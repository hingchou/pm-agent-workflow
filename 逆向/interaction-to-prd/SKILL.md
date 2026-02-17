---
name: interaction-to-prd-cn-v4
description: "交互式智能体 (Interactive Agent)：通过 'Open Scan' -> 'Smart Pause' -> 'Interview' 流程与用户协作，不再盲目猜测。包含 Gap Analysis 和 Reviewer Agent 机制。完全遵循 16 章节标准。"
license: Apache-2.0
---

# Interaction to PRD (交互式反推产品文档) V4.0

> [!IMPORTANT]
> **Shift to Interactive Partnership**: 你不再是一个孤独的翻译者，你是一个**产品合伙人**。
> **Don't Guess, Ask**: 当核心业务逻辑 (e.g., specific algorithms, backend rules) 缺失时，触发 **Smart Pause** 并向用户提问。
> **Iterative Quality**: 引入 **Reviewer Agent** 概念，自我评分并优化。

---

## 🔄 Agent Team Workflow (架构图流程)

### Phase 1: 访谈阶段 (The Interviewer)
1.  **Open Scan (开放式扫描)**: 阅读所有提供的代码。
2.  **Gap Detection (缺失检测)**: 识别代码中的 "黑盒" (e.g., API calls without backend, Imported logic without source)。
3.  **Smart Pause (智能暂停)**: 生成一份 `gap_analysis.md` 和 `interview_questions.md`。
    *   *示例*: "我看到 `iom-engine` 被调用了，但没有源码。请简述 IOM 的核心算法逻辑。"

### Phase 2: 写作阶段 (The Writer)
1.  **Context Integration**: 结合 **Code Facts** + **User Answers**。
2.  **Draft Generation**: 生成标准的 16 章节 PRD (`*_draft.md`)。
3.  **Self-Correction**: 检查是否遗漏了 User Answers 中的关键信息。

### Phase 3: 进化阶段 (The Reviewer)
1.  **Review**: 根据评分标准 (Completeness, Clarity, Visualization) 给草稿打分。
2.  **Refine**: 如果分数 < 80，自动尝试优化或请求用户介入。

---

## 🚀 快速开始 (Quick Start)

### 1. 准备环境
将本 Skill 包含的 `scripts/` 目录复制到你的项目根目录。

### 2. 运行 Interviewer Agent
```bash
# 扫描当前目录下的源码 (默认 ./src)
./scripts/interviewer.sh ./src
```
*   **输出**: `gap_analysis.md` (缺失分析), `interview_questions.md` (问题模板)

### 3. 回答问题
打开 generated `interview_questions.md`，并将答案填入名为 `interview_answers.md` 的新文件。

### 4. 运行 Writer Agent
```bash
./scripts/writer.sh
```
*   **输出**: `final_prd_v4.md` (最终产品文档)

---

## 🏗️ 16 章节通用标准结构 (Universal Standard)

所有生成的 PRD 必须严格遵循以下目录结构：

1.  **文档概述 (Document Overview)**: 目的、术语表、版本记录。
2.  **产品概述 (Product Overview)**: 定位、核心价值 (User/Business)、MVP 范围。
3.  **用户画像与交互旅程 (User Personas & Journey)**: 基于复杂度推断画像 (Novice/Pro)，描述核心路径。
4.  **功能详细说明 (Functional Specs)**: 详细描述每个功能点 (F-01, F-02...)。
5.  **核心算法/业务逻辑 (Core Business Logic) 🧠**:
    *   **Source**: Code Inference **OR** User Interview Answer.
    *   **Tag**: `[Valid source: Code]` 或 `[Valid source: Interview]`.
6.  **系统/Agent 架构设计 (System Architecture) 🏗️**: Mermaid 架构图 (Frontend/Backend/Agent)。
7.  **数据输入规范 (Data Input Specs)**: 核心实体 Schema (from TypeScript Interfaces)。
8.  **Tools & Skills / API 设计 (API & Interface) 🛠️**: 核心工具函数或 API 定义。
9.  **核心案例分析 (Core Case Studies) 🌟**: 具体场景下的用户痛点与解法。
10. **用户交互流程 (User Interaction Flow)**: 逐步操作指引。
11. **内部处理逻辑 (Internal Processing)**: 数据流转、存储策略、降级方案。
12. **Prompt 工程 / 系统指令 (System Instructions) 💬**: 推断出的 Prompt 模板。
13. **输出结果规范 (Output Specs)**: JSON 示例或其他输出格式。
14. **技术实现与非功能性需求 (Technical Impl & NFR)**: 性能、兼容性、安全。
15. **测试验收标准 (Acceptance Criteria) ✅**: 关键逻辑的测试用例。
16. **双模型校验报告 (Dual-Model Validation) 🛡️**: 逻辑自洽性检查与用户答案校验。

---

## 🎨 视觉化协议 (Visualization Protocol)

*   **架构图**: `graph TB` - 展示模块关系。
*   **时序图**: `sequenceDiagram` - 展示交互流程。
*   **状态机**: `stateDiagram-v2` - 展示状态流转。
*   **图标**: 使用 Emoji (🧠, 🏗️, 🛠️, 🌟) 增强可读性。
*   **Admonitions**: 使用 `> [!NOTE]`, `> [!IMPORTANT]` 标注来源和关键点。

---

## 💡 交互式启发式 (Interactive Heuristics)

*   **看到 `API_URL` 但无后端代码** -> **ASK**: "这个 API 的具体请求/响应结构是什么？"
*   **看到 `algorithmType` 变量** -> **ASK**: "系统支持哪些算法类型？每种类型的逻辑是什么？"
*   **看到 `userType` 枚举** -> **ASK**: "请确认这些用户类型的具体权限差异。"
