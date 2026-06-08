# Repositories API Notes

## MVP 关注点

仓库模块第一阶段只做只读能力：

- 仓库详情
- 仓库目录 Tree
- README 展示
- 文件内容预览

## 页面映射

```text
RepoSearchPage -> RepoDetailPage -> CodeBrowserPage -> FilePreviewPage
```

## 领域模型

建议 UI 层不要直接依赖接口返回字段，而是统一使用：

```text
RepoModel
FileNodeModel
FileContentModel
```

## 后续扩展

- Star 仓库
- Fork 仓库
- 分支切换
- Commit 列表
- Release 列表
