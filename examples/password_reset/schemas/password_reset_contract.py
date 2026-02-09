from pydantic import BaseModel, Field, field_validator, EmailStr
from typing import Literal
from datetime import datetime

class PasswordResetRequest(BaseModel):
    """密码重置请求的数据契约"""
    
    email: EmailStr = Field(
        description="用户的注册邮箱地址"
    )

class PasswordResetResponse(BaseModel):
    """密码重置响应的数据契约"""
    
    status: Literal["success", "error", "rate_limit"] = Field(
        description="请求处理状态"
    )
    message: str = Field(
        description="返回给用户的提示信息。注意：无论邮箱是否存在，都必须返回相同的模糊提示。"
    )

class ResetTokenValidationRequest(BaseModel):
    """重置 Token 验证及新密码提交的数据契约"""
    
    token: str = Field(
        pattern=r"^pwd_reset_[a-f0-9-]{36}$",
        description="重置 Token，格式：pwd_reset_{uuid}"
    )
    new_password: str = Field(
        min_length=12,
        max_length=128,
        description="新密码，长度 12-128 位"
    )

    @field_validator("new_password")
    def validate_password_complexity(cls, v):
        # 简单示例，实际应包含更复杂的规则（大小写、数字、符号）
        import re
        if not re.search(r"[A-Z]", v):
            raise ValueError("密码必须包含至少一个大写字母")
        if not re.search(r"[a-z]", v):
            raise ValueError("密码必须包含至少一个小写字母")
        if not re.search(r"\d", v):
            raise ValueError("密码必须包含至少一个数字")
        return v
