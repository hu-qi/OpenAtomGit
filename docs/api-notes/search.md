# Search API Notes

## MVP 关注点

搜索模块第一阶段支持：

- 仓库搜索
- 用户搜索
- Issue 搜索

## 页面结构

SearchPage 下按类型展示不同结果列表。

## 状态字段

每个搜索类型维护 keyword、page、loading、hasMore 和 list。

## 交互策略

- 输入关键词后搜索
- 切换类型时保留关键词
- 下拉刷新第一页
- 上拉加载下一页
- 无数据展示空态
- 请求失败展示重试入口
