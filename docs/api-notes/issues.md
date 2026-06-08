# Issues API Notes

## MVP 关注点

Issue 模块第一阶段只做只读能力：

- Issue 列表
- Issue 详情
- Issue 评论展示
- 标签、状态、时间展示

## 页面映射

```text
RepoDetailPage -> IssueListPage -> IssueDetailPage
```

## 领域模型

建议统一使用：

```text
IssueModel
IssueCommentModel
IssueLabelModel
```

## 后续扩展

- 创建 Issue
- 关闭 Issue
- 重新打开 Issue
- 创建评论
- 编辑评论
