# Architecture Overview

OpenAtomGit is a HarmonyOS ArkTS client project for AtomGit.

## Layers

- UI: pages, common, widget
- Navigation: navigation and AppShell
- State: store and page state
- Data: service and dao
- System: HarmonyOS capabilities

## Rules

- Keep Index small.
- Keep API calls out of pages.
- Keep DTO mapping outside UI.
- Update CHANGELOG-AI after assisted changes.
