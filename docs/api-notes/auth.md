# Auth API Notes

## 第一阶段认证策略

OpenAtomGit MVP 阶段优先实现 Token 登录。

客户端统一使用：

```text
Authorization: Bearer {token}
```

## 登录验证接口

```text
GET /api/v5/user
```

验证成功后：

- 保存 token
- 保存当前用户基础信息
- 进入首页

验证失败后：

- 401：Token 无效或已过期
- 403：当前 Token 无权限访问
- 429：请求过于频繁

## OAuth 后续规划

OAuth 登录放在工程增强阶段实现，主要流程包括：

1. WebView 打开授权页
2. 用户授权后回调 redirect_uri
3. Deep Link 接收 code
4. code 换取 access_token
5. 保存 access_token 与 refresh_token
