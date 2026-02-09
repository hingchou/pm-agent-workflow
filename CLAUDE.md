# 项目宪法 (Project Constitution)

## Tech Stack
- 语言: Python 3.11+
- 框架: FastAPI
- 数据库: PostgreSQL (数据存储) / Redis (频率限制)
- 外部服务: SendGrid API (邮件服务)

## NEVER Rules（红线规则）
1. 🚫 严禁在日志中打印 PII（个人身份信息，如邮箱、密码、Token）
2. 🚫 严禁使用无类型提示（Python）
3. 🚫 严禁引入 <2 星的 GitHub 库
4. 🚫 严禁未经审计直接调用外部 API（SendGrid 调用必须包含超时和重试机制）
5. 🚫 严禁在响应中暴露用户是否存在的信息（防止枚举攻击）

## Git 提交规范
- feat: 新功能
- fix: Bug 修复
- audit: 审计报告更新
- spec: 规格文档修改

## 依赖审批流程
新增依赖必须经过 @nova-judge 审计，评分 >85 才可合并。
