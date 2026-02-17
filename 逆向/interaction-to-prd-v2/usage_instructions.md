# 🚀 如何使用你的新技能 (Skill)

你已经成功构建了 `interaction-to-prd` 技能！以下是使用方法。

## 选项 1: 在 Claude Projects 中使用 (推荐)
1.  在 Claude.ai 中创建一个新的 **Project**。
2.  将 `interaction-to-prd/SKILL.md` 上传到 **Project Knowledge (项目知识库)**。
3.  在项目的 **Custom Instructions (自定义指令)** 中添加：
    > "当我都要求生成 PRD 章节时，始终遵循 interaction-to-prd/SKILL.md 中定义的协议。"

## 选项 2: 手动“安装”
1.  复制 `interaction-to-prd/SKILL.md` 的全部内容。
2.  将其作为**第一条消息**粘贴到对话中。
3.  Claude 现在就在该会话中“加载”了此技能。

## 选项 3: 在 CloudCode / IDE 中使用 (程序员专用)
如果你使用 CloudCode、Cursor 或 VS Code 等编辑器：
1.  将 `interaction-to-prd/SKILL.md` 文件保存到你项目根目录的 `.ref/SKILL.md` (或任何你习惯的位置)。
2.  在 IDE 的 AI 聊天窗口中，使用 `@` 引用该文件 (例如 `@SKILL.md`)。
3.  输入指令：`@SKILL.md 为当前打开的文件生成 PRD。`

## ⚡️ 快速开始指令
技能加载后，只需拖入你的 React/Vue 文件并输入：

> **"为这个组件生成 PRD。"**

## ✅ 成功标志
如果技能工作正常，Claude 会**立即**输出一个 Markdown 表格，包含：
*   **数据输入规范** (源自 props/state)
*   **Tools & Skills 设计** (源自 API 调用)
*   **用户交互流程** (源自事件处理)

...而不会问*任何*问题。
