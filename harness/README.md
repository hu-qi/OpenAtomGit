# harness/ — OpenAtomGit AI 工程化沉淀

本目录是 OpenAtomGit 的项目大脑，用于沉淀 HarmonyOS / ArkTS 客户端开发过程中的架构、需求、决策、测试、回归与 AI Coding 协作规范。

## 目录结构

```text
harness/
├── README.md
├── architecture/
│   ├── overview.md
│   ├── modules.md
│   ├── data-flow.md
│   └── native-bridges.md
├── requirements/
│   ├── README.md
│   ├── auth.md
│   ├── repository.md
│   ├── search.md
│   ├── issue.md
│   └── profile.md
├── decisions/
│   ├── 0001-record-architecture-decisions.md
│   ├── 0002-gsy-style-architecture.md
│   └── 0003-atomgit-api-adapter.md
├── iteration/
│   ├── CHANGELOG-AI.md
│   └── release-cadence.md
├── testing/
│   ├── strategy.md
│   └── manual/
│       ├── auth.md
│       ├── repository.md
│       ├── search.md
│       └── issue.md
├── regression/
│   ├── checklist.md
│   └── known-issues.md
└── playbooks/
    ├── add-feature.md
    ├── ai-auto-debug.md
    └── refactor-page.md
```

## 使用方式

1. 接到任务后，先阅读 `harness/architecture/` 与对应的 `harness/requirements/`。
2. 涉及架构方向、目录结构、技术路线变化时，先补充 `harness/decisions/`。
3. 改代码时，遵守 `harness/architecture/modules.md` 的目录和职责约定。
4. 完成后，在 `harness/iteration/CHANGELOG-AI.md` 追加记录。
5. 本地测试或发版前，执行 `harness/regression/checklist.md`。

## 维护原则

- 可追溯：所有 AI 辅助改动都需要记录动机和影响。
- 可回滚：尽量小步提交，避免一次性大改。
- 可重放：测试步骤要能被后来者复现。
- AI 友好：跨文件引用优先使用项目相对路径。
- 平台适配：参考 GSYGithubAppOH 的工程经验，但不复制 GitHub 业务实现。
