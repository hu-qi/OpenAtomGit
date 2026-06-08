# CHANGELOG-AI

## 2026-06-09

- Added AI coding harness.
- Added architecture docs.
- Added requirements docs.
- Added ADR docs.
- Added testing and regression docs.
- Added service placeholders for AtomGitConfig and AtomGitHttpClient.
- Added auth, store, dao and model placeholders.
- Documented harness usage in README.
- Wired LoginPage to LoginStore for local token validation.
- Added Account logout action and routed it through AppShell.
- Updated auth manual test for login and logout flow.
- Added AtomGitAuthService and basic HttpClient GET request.
- Added Internet permission to module config.
- Changed LoginStore and LoginPage to validate token with AtomGit user API.
- Updated auth manual test for valid and invalid token checks.
- Added UserDto, UserMapper and AtomGitUserService.
- Added SessionManager for current user state.
- Stored current user after login and displayed it on Account page.
- Updated auth manual test for current user display.
- Added TokenStorage with HarmonyOS Preferences.
- Persisted token on login and cleared saved token on logout.
- Restored saved token on WelcomePage and auto-entered Main when valid.
- Updated auth manual test for token persistence.
- Added RepositoryDto and RepositoryMapper.
- Added query parameter support to AtomGitHttpClient.
- Added AtomGitSearchService for repository search.
- Wired SearchStore and SearchPage to repository search MVP.
- Updated search manual test for repository search.
- Added selected repository state in RepositoryStore.
- Added search result click navigation to repository detail.
- Updated RepositoryDetailPage to render selected repository.
- Updated search manual test for detail navigation.
- Extended repository DTO, model and mapper with detail fields.
- Added AtomGitRepositoryService for repository detail API.
- Updated RepositoryDetailPage to load repository detail and render metrics.
- Updated repo manual test for detail API.
- Added repository README service method.
- Updated RepositoryDetailPage with README preview and scroll layout.
- Updated repo manual test for README preview.
- Added RepositoryFileDto, RepositoryFileModel and RepositoryFileMapper.
- Added repository root files service method.
- Updated RepositoryDetailPage with root file list entry.
- Updated repo manual test for file tree entry.

## Rule

Record AI assisted changes here.
