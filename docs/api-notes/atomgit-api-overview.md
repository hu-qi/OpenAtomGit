# AtomGit API 基础笔记

## Base URL

AtomGit API 请求需要包含 `api` 和 API 版本，当前版本为：

```text
/api/v5
```

基础示例：

```bash
curl "https://api.atomgit.com/api/v5/users/{username}"
```

## 认证方式

AtomGit API 支持三种认证方式：

### Authorization Bearer Token

```bash
curl --location 'https://api.atomgit.com/api/v5/user' \
  --header 'Authorization: Bearer {your-token}'
```

### PRIVATE-TOKEN

```bash
curl --location 'https://api.atomgit.com/api/v5/user' \
  --header 'PRIVATE-TOKEN: {your-token}'
```

### access_token query

```bash
curl "https://api.atomgit.com/api/v5/users/{username}?access_token={your-token}"
```

## 客户端采用策略

OpenAtomGit 第一版统一采用：

```text
Authorization: Bearer {token}
```

原因：

- Header 方式比 query 更适合客户端统一封装
- 与 OAuth access_token 使用习惯一致
- 后续网络拦截器可以统一处理认证信息

## MVP 优先接口

第一阶段优先验证：

```text
GET /api/v5/user
```

第二阶段再扩展：

```text
搜索仓库
搜索用户
搜索 Issue
仓库详情
仓库目录 Tree
Issue 列表
Issue 详情
```
