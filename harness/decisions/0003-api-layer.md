# ADR 0003: API Layer

## Status

Accepted

## Decision

Keep remote data away from UI components.

Recommended flow:

- service loads remote data
- mapper converts data
- model is used by pages

## Result

Pages should render model data only.
