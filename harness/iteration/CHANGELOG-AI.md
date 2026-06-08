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

## Rule

Record AI assisted changes here.
