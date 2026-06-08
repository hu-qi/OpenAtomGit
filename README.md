# OpenAtomGit

OpenAtomGit 是一个从 0 构建的 HarmonyOS AtomGit 客户端实践项目。

本项目不是对现有 GitHub 客户端的二次开发，而是参考成熟代码托管客户端的产品形态，结合 AtomGit OpenAPI 重新设计的一套 HarmonyOS ArkTS 客户端工程实践。

## 项目目标

- 构建一个可运行的 AtomGit HarmonyOS 客户端
- 实践 ArkTS 网络层封装、登录鉴权、分页列表、仓库详情、代码浏览、Issue 展示、本地缓存等能力
- 输出一套从 0 到 1 的技术文章
- 为 HarmonyOS 开发者提供一个真实、完整、可学习的开源项目

## 技术栈

- HarmonyOS
- ArkTS
- ArkUI
- AtomGit OpenAPI
- Preferences
- RelationalStore
- WebView

## MVP 功能

- Token 登录
- 获取当前用户信息
- 搜索仓库
- 搜索用户
- 搜索 Issue
- 仓库详情
- 代码浏览
- Issue 列表与详情
- 本地浏览历史

## 文章系列

1. 从 0 构建 AtomGit 鸿蒙客户端：项目定位、技术选型与整体架构
2. 搭建一个可长期维护的 HarmonyOS 工程结构
3. 用 ArkTS 封装一个可复用的 HttpClient
4. 实现 Token 登录、登录态保存与自动恢复
5. 设计 DTO 与领域模型，隔离 API 字段变化
6. 实现仓库搜索、分页加载与列表状态管理
7. 实现用户搜索、用户主页与个人资料展示
8. 实现仓库详情页
9. 实现仓库文件树、代码浏览与 Markdown 预览
10. 实现 Issue 列表、详情与评论展示
11. 用本地缓存优化仓库详情、Issue 与浏览历史体验
12. 实现 OAuth 登录、WebView 授权与 Deep Link 回调

## Roadmap

详见 [roadmap.md](./roadmap.md)。
