# 从 0 构建 AtomGit 鸿蒙客户端：项目定位、技术选型与整体架构

## 1. 为什么要做 OpenAtomGit

OpenAtomGit 是一个从 0 构建的 HarmonyOS AtomGit 客户端实践项目。

它不是一个简单的 API Demo，也不是对现有 GitHub 客户端的二次开发，而是希望通过一个真实 App，把 HarmonyOS ArkTS 客户端开发、AtomGit OpenAPI 调用、登录鉴权、分页列表、仓库详情、代码浏览、Issue 展示、本地缓存等能力串起来。

## 2. 为什么不是二开 GitHub 客户端

成熟 GitHub 客户端可以提供产品形态和工程结构参考，但 AtomGit 的 API、登录方式、平台定位和后续 AI Hub 能力都有自己的特点。

因此，本项目采用全新工程，从 0 设计适合 AtomGit 的客户端架构。

## 3. 项目目标

第一层：做出一个真实可运行的 AtomGit HarmonyOS 客户端。

第二层：沉淀一套 HarmonyOS ArkTS 客户端工程结构。

第三层：通过文章系列，把网络层、登录、搜索、仓库详情、代码浏览、Issue、本地缓存等能力拆解出来，形成可学习、可复用的实践案例。

## 4. MVP 功能规划

- Token 登录
- 当前用户信息获取
- 搜索仓库
- 搜索用户
- 搜索 Issue
- 仓库详情
- 代码浏览
- Issue 列表与详情
- 本地浏览历史

## 5. 技术选型

- HarmonyOS
- ArkTS
- ArkUI
- AtomGit OpenAPI
- Preferences
- RelationalStore
- WebView

## 6. 工程分层预览

```text
pages 页面层
  -> usecase 业务用例层
  -> repository 领域仓储层
  -> platform/atomgit API 适配层
  -> core/network 与 core/storage 基础能力层
```

## 7. 后续文章规划

后续文章将围绕项目从 0 到 1 的建设过程展开，覆盖工程初始化、网络请求封装、Token 登录、DTO 模型设计、搜索、仓库详情、代码浏览、Issue、本地缓存和 OAuth 登录。
