# Modules

## App source root

```text
app/entry/src/main/ets/
```

## pages

Screen level pages.

Current pages:

- pages/Index.ets
- pages/welcome/WelcomePage.ets
- pages/login/LoginPage.ets
- pages/main/MainPage.ets
- pages/search/SearchPage.ets
- pages/account/AccountPage.ets
- pages/repository/RepositoryDetailPage.ets

Future naming cleanup:

- MainPage may become HomePage.
- AccountPage may become MinePage or ProfilePage.

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

## infra

Shared engineering files.

Planned files:

- style constants
- logger
- error mapper
- debug helpers
