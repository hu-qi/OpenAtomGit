# ADR 0002: GSY Style Architecture

## Status

Accepted

## Context

GSYGithubAppOH provides a useful HarmonyOS client structure for pages, components, store, dao, service, navigation and testing documents.

## Decision

OpenAtomGit will learn from that structure but will not copy GitHub-specific business logic.

## Consequences

- We keep a clear project structure.
- AtomGit API adapter remains independent.
- GitHub-only features are not added unless AtomGit has matching value.
