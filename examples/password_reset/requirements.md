# 密码重置功能需求

## EARS 语法描述

1. When 用户提交密码重置请求且邮箱存在, the system shall 发送重置链接到该邮箱（30 分钟有效）
2. When 用户在 30 分钟内点击链接, the system shall 允许用户输入新密码并更新数据库
3. When 链接已过期（>30 分钟）, the system shall 返回"链接已失效，请重新申请"
4. When 邮箱不存在, the system shall 返回"如果邮箱存在，您将收到邮件"（防枚举）
5. When 1 小时内请求超过 3 次, the system shall 拒绝并返回"请求过于频繁"
6. When 邮件服务超时（>5 秒）, the system shall 重试 3 次并记录日志

## 验收标准
- 用户能收到重置邮件
- Token 30 分钟后失效
- 防止邮箱枚举攻击
- 邮件服务故障有降级方案
