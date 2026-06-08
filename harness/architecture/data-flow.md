# Data Flow

## Login

LoginPage collects token. Auth service validates it. Token manager saves it. AppShell opens the main area.

## Repository

Repository page receives a stable model. Raw API data should be converted before UI rendering.

## Search

Search page owns keyword and tab state. Search service loads data. Mapper converts API data to UI data.

## Cache

MVP can start without database. Later token uses preferences and list data uses local database.
