Feature: 密码重置功能

  Scenario: 正常流程 - 用户申请重置密码
    Given 系统已启动且邮件服务正常
    And 用户 "user@example.com" 存在于系统中
    And 该用户在过去 1 小时内未发起过重置请求
    When 用户提交邮箱 "user@example.com" 的重置请求
    Then 系统应返回状态 "success"
    And 提示信息应为 "如果邮箱存在，您将收到重置邮件"
    And 外部邮件服务应收到发送请求
    And 数据库应生成一个新的有效 Token，有效期 30 分钟

  Scenario: 安全流程 - 邮箱不存在（防枚举）
    Given 系统已启动
    And 用户 "ghost@example.com" 不存在于系统中
    When 用户提交邮箱 "ghost@example.com" 的重置请求
    Then 系统应返回状态 "success"
    And 提示信息应为 "如果邮箱存在，您将收到重置邮件"
    And 系统不应发送任何邮件

  Scenario: 异常流程 - 频率限制触发
    Given 用户 "spammer@example.com" 在过去 1 小时内已发起 3 次请求
    When 用户提交邮箱 "spammer@example.com" 的重置请求
    Then 系统应返回状态 "rate_limit"
    And 提示信息应为 "请求过于频繁，请稍后再试"
    And 系统不应生成新 Token

  Scenario: 边界条件 - 邮件服务超时
    Given 外部邮件服务响应时间 > 5 秒
    When 用户提交有效邮箱 "slow@example.com" 的重置请求
    Then 系统应触发重试机制
    And 重试次数应最多为 3 次
    And 如果重试均失败，系统应记录错误日志

  Scenario: 业务流程 - 使用 Token 重置密码
    Given 用户拥有有效的重置 Token "pwd_reset_validuuid"
    When 用户提交新密码 "NewPassword123" 和该 Token
    Then 系统应更新用户密码
    And 该 Token 应立即失效
