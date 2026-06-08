# OpenAtomGit 实战 02：搭建一个可长期维护的 HarmonyOS 工程结构

本文将完成 OpenAtomGit 的 HarmonyOS ArkTS 工程初始化。

## 本文目标

- 创建 HarmonyOS ArkTS 工程
- 将 App 工程放在仓库的 `app/` 目录下
- 建立基础目录分层
- 创建 Welcome、Login、Home、Search、Mine 页面骨架
- 为后续网络层、登录和业务模块预留结构

## 推荐工程信息

```text
Project name: OpenAtomGit
Module name: entry
Bundle name: com.huqi.openatomgit
App name: OpenAtomGit
Language: ArkTS
UI: ArkUI
```

## 推荐仓库结构

```text
OpenAtomGit/
├── app/
│   ├── AppScope/
│   ├── entry/
│   ├── build-profile.json5
│   ├── hvigorfile.ts
│   └── oh-package.json5
├── docs/
├── README.md
└── roadmap.md
```

## 推荐源码结构

```text
app/entry/src/main/ets/
├── app/
├── core/
├── platform/
│   └── atomgit/
├── domain/
├── pages/
└── components/
```

## 下一步

完成工程初始化后，下一篇文章将开始封装 AtomGit API 请求层。
