# Modules

## App source root

```text
app/entry/src/main/ets/
```

## pages

Screen level pages.

Planned pages:

- pages/Index.ets
- pages/welcome/WelcomePage.ets
- pages/login/LoginPage.ets
- pages/main/MainPage.ets
- pages/search/SearchPage.ets
- pages/account/AccountPage.ets
- pages/repository/RepositoryDetailPage.ets

## common

Reusable pure UI components.

Current components:

- common/AppShell.ets
- common/PageHeader.ets
- common/FeatureText.ets

Planned components:

- EmptyState
- LoadingState
- ErrorState

## widget

Business widgets.

Planned widgets:

- RepositoryItem
- IssueItem
- UserItem
- SearchTypeChip

## navigation

Route constants and navigation helpers.

Current file:

- navigation/AppRoute.ets

## service

AtomGit API services.

Planned files:

- AtomGitConfig
- AtomGitHttpClient
- AtomGitAuthService
- AtomGitUserService
- AtomGitRepositoryService
- AtomGitSearchService
- AtomGitIssueService

## store

Page and domain state.

Planned stores:

- NavigationStore
- LoginStore
- SearchStore
- RepositoryStore

## dao

Local cache and data aggregation.

Planned dao:

- UserDao
- RepositoryDao
- IssueDao
- HistoryDao
