# PM-Agent Workflow Skills

> **将 PM 的动作固化为 AI Skills，实现资产化交付**  
> 适用于任何使用 Claude Code / Cursor / Windsurf 的产品团队

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Claude Skills](https://img.shields.io/badge/Claude-Skills-blue.svg)](https://docs.anthropic.com/claude/docs/skills)

---

## 🎯 这是什么？

这是一套**代码化的产品管理流程**，通过 2 个 AI Skills 强制执行：

1. **@spec-architect** - 将模糊需求转化为工程规格（CLAUDE.md + Pydantic + Gherkin）
2. **@nova-judge** - 审计代码质量并生成风险报告（评分 <80 拒绝合并）

### 核心价值
- ❌ 告别"拍脑袋开发"和"Vibe Coding"
- ✅ 强制 Spec-Driven Development（测试驱动意图开发）
- ✅ AI 自动审计，人类只需决策（合并/驳回）
- ✅ Bug 转化为 Skill 更新，组织能力持续增长

---

## ⚡ 5 分钟快速开始

### Step 1: Fork 本仓库

```bash
git clone https://github.com/hingchou/pm-agent-workflow.git
cd pm-agent-workflow
```

### Step 2: 验证 Skills 已加载

**如果你使用 Claude Code：**
```bash
# Claude Code 会自动识别 .claude/skills/ 目录
claude skills list

# 应显示：
# - spec-architect
# - nova-judge
```

**如果你使用 Cursor / Windsurf：**
```bash
# 将 Skills 内容添加到 .cursorrules 或 .windsurfrules
cat .claude/skills/spec-architect/SKILL.md >> .cursorrules
echo "\n---\n" >> .cursorrules
cat .claude/skills/nova-judge/SKILL.md >> .cursorrules
```

### Step 3: 运行演示案例

```bash
# 查看演示案例（密码重置功能）
cd examples/password_reset

# 你会看到完整的交付物：
# - requirements.md（EARS 语法需求）
# - logic_flow.mermaid（状态机图）
# - CLAUDE.md（项目宪法）
# - schemas/password_reset_contract.py（数据契约）
# - tests/password_reset.feature（Gherkin 测试）
```

### Step 4: 调用 Skills

在 Claude / Cursor 中执行：

```
@spec-architect 根据 examples/password_reset/requirements.md 生成规格文档
```

或（如果你的工具不支持 @ 语法）：

```
我需要为"密码重置"功能生成规格文档。

需求文件：examples/password_reset/requirements.md

请生成：
1. CLAUDE.md（项目宪法）
2. schemas/password_reset_contract.py（数据契约）
3. tests/password_reset.feature（测试用例）
```

---

## 🏗️ 工作流程

```mermaid
graph LR
    A[PM 定义需求] --> B[@spec-architect 生成规格]
    B --> C[PM 审核]
    C --> D[工程师实现]
    D --> E[@nova-judge 审计]
    E --> F{评分 ≥ 80?}
    F -->|是| G[合并代码]
    F -->|否| H[驳回修复]
    H --> D
```

### 阶段说明

| 阶段 | 负责人 | 产出物 | 耗时 |
|------|--------|--------|------|
| 1. 意图锚定 | PM | requirements.md + Mermaid 图 | 1-2h |
| 2. 规格生成 | @spec-architect | 3 份文档（宪法/契约/测试） | 5min |
| 3. PM 审核 | PM | 签字确认 | 10min |
| 4. 代码实现 | 工程师 | 可运行的代码 | 1-3d |
| 5. 自动审计 | @nova-judge | 审计报告 + 评分 | 3min |
| 6. 决策 | PM | 合并/驳回 | 5min |

---

## 📚 详细文档

### 核心概念
- **TDVD 协议**（Test-Driven Vision Development）：先定义 Spec，再写代码
- **EARS 语法**：`When [事件], the system shall [动作]`
- **FMEA 风险分析**：`RPN = 严重度 × 频度`

### 必读文档
1. [完整 SOP 文档](docs/SOP_PM_TO_AGENT.md) - PM-Agent 协同工作流
2. [Spec Architect 使用指南](.claude/skills/spec-architect/SKILL.md) - 规格生成 Skill
3. [Nova Judge 使用指南](.claude/skills/nova-judge/SKILL.md) - 代码审计 Skill

---

## 🎯 真实案例

### 案例：密码重置功能

**需求输入：**
```markdown
When 用户输入错误密码 3 次, the system shall 锁定账户 30 分钟
When 外部邮件服务超时（>5 秒）, the system shall 重试 3 次并记录日志
```

**@spec-architect 生成：**
- ✅ `CLAUDE.md` - 定义 Tech Stack 和 NEVER Rules
- ✅ `password_reset_contract.py` - Pydantic 模型（强类型校验）
- ✅ `password_reset.feature` - Gherkin 测试用例（覆盖边界条件）

**@nova-judge 审计发现：**
- 🚨 日志泄露用户邮箱（违反 GDPR）
- 🚨 API Key 硬编码（安全风险）
- 🚨 HTTP 请求无超时（资源耗尽）
- **评分：45/100 → 拒绝合并**

**修复后重审：**
- ✅ 所有 PII 已脱敏
- ✅ 密钥改用环境变量
- ✅ 强制 timeout=5 秒
- **评分：92/100 → 允许合并**

查看完整案例：[examples/password_reset/](examples/password_reset/)

---

## 🛠️ 安装与配置

### 前置要求
- Python 3.11+ 或 Node.js 18+
- Claude Code / Cursor / Windsurf（任选其一）
- Git 基础知识

### 自动化配置（推荐）

```bash
# 1. 克隆仓库
git clone https://github.com/hingchou/pm-agent-workflow.git
cd pm-agent-workflow

# 2. 运行安装脚本
chmod +x setup.sh
./setup.sh

# 脚本会自动：
# - 检查 Python/Node 版本
# - 安装依赖（pre-commit, pytest, mypy）
# - 配置 Git hooks
# - 验证 Skills 加载
```

### 手动配置

**Python 项目：**
```bash
pip install -r requirements.txt
pre-commit install
```

**Node.js 项目：**
```bash
npm install
npx husky install
```

---

## 🎓 团队落地指南

### Week 1: 试点阶段（1-2 人）
- [ ] Fork 本仓库到团队 GitHub
- [ ] PM + 1 名工程师完成演示案例
- [ ] 验证 Skills 在你的技术栈下能正常工作

### Week 2: 小范围推广（3-5 人）
- [ ] 选择 1 个真实需求试运行
- [ ] 收集反馈并调整 NEVER Rules
- [ ] 更新 `CLAUDE.md.template`

### Week 3: 全员培训
- [ ] 宣讲 SOP 文档（1 小时）
- [ ] 全员完成演练任务
- [ ] 建立 Code Review 流程

### Month 1: 持续优化
- [ ] 每周回顾：返工率、Bug 逃逸率
- [ ] 更新 Skills（根据新 Bug 补充规则）
- [ ] 庆祝第一个"审计评分 90+"的 PR 🎉

详细落地计划：[docs/SOP_PM_TO_AGENT.md](docs/SOP_PM_TO_AGENT.md)

---

## 🔧 自定义配置

### 修改 NEVER Rules

编辑 `templates/CLAUDE.md.template`：

```markdown
## NEVER Rules（红线规则）
1. 🚫 严禁在日志中打印 PII
2. 🚫 严禁使用 `any` 类型
3. 🚫 严禁引入 <2 星的 GitHub 库
4. 🚫 严禁未经审计直接调用外部 API
5. 🚫 [添加你的自定义规则]
```

### 调整审计标准

编辑 `.claude/skills/nova-judge/SKILL.md`：

```markdown
## 评分逻辑
base_score = 100
base_score -= (critical_issues * 30)  # 你可以修改权重
base_score -= (high_issues * 15)
base_score -= (medium_issues * 5)
```

### 适配其他编程语言

本 Skills 已支持：
- ✅ Python（FastAPI / Django / Flask）
- ✅ TypeScript（Next.js / Express / NestJS）
- ✅ Go（Gin / Echo）
- ✅ Java（Spring Boot）

只需修改 `CLAUDE.md.template` 中的 Tech Stack 即可。

---

## 📊 效果预期

### 推行前 vs 推行后

| 指标 | 推行前 | 推行后（预期） | 提升 |
|------|--------|----------------|------|
| Spec 返工率 | 40% | 5% | **-87%** |
| Bug 逃逸率 | 15% | 3% | **-80%** |
| Code Review 时间 | 2 天 | 0.5 天 | **-75%** |
| 新人上手时间 | 2 周 | 5 天 | **-64%** |

### ROI 计算
- **投入：** 5 天团队培训 + 2 周磨合
- **产出：** 每月节省 40 小时返工时间
- **回本周期：** 1 个月
- **年化收益：** 480 小时/团队（约 $24,000）

---

## 🤝 贡献指南

### 如何贡献

1. **报告 Bug**
   - 提交 Issue：描述场景 + 复现步骤
   - 标签：`bug` / `enhancement` / `question`

2. **提交 PR**
   - Fork 本仓库
   - 创建分支：`feature/your-feature-name`
   - 提交 PR 时附带审计报告（`@nova-judge` 评分 ≥ 85）

3. **分享案例**
   - 在 Discussions 中分享你的实践经验
   - 我们会精选优秀案例加入 `examples/`

### 贡献者公约
- 所有 PR 必须通过 `@nova-judge` 审计
- 新增 NEVER Rules 必须有真实 Bug 案例支持
- 文档更新必须同步更新中英文版本

---

## 📜 许可证

MIT License

```
Copyright (c) 2026 逸云

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction...
```

---

## 🌟 致谢

### 灵感来源
- **TDVD 协议**：受 TDD（测试驱动开发）启发
- **EARS 语法**：NASA 需求工程标准
- **FMEA 分析**：丰田生产方式（TPS）

### 引用文献
- *The Phoenix Project* by Gene Kim
- *Accelerate* by Nicole Forsgren
- 芒格：《穷查理宝典》
- 段永平：本分思想

---

## 📞 联系方式

- **GitHub Issues:** [提交问题](https://github.com/hingchou/pm-agent-workflow/issues)
- **Discussions:** [加入讨论](https://github.com/hingchou/pm-agent-workflow/discussions)
- **Email:** nightowlhc@gmail.com
- **Twitter/X:** [nightowlhc](https://x.com/nightowlhc)

---

## 🚀 Star History

如果这个项目对你有帮助，请给个 ⭐️ Star！

[![Star History Chart](https://api.star-history.com/svg?repos=hingchou/pm-agent-workflow&type=Date)](https://star-history.com/#hingchou/pm-agent-workflow&Date)

---

**Made with ❤️ by PM who believe in deterministic engineering**
