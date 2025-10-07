# Architecture

DevOnboarder runs as a collection of services that share a common automation
surface: the public API, a dedicated auth service, the Discord bot that fronts
onboarding, and the web frontend used by coordinators. All of them persist state
in the shared program database and are wrapped by tooling that keeps the
infrastructure reproducible and observable.

```mermaid
flowchart LR
    subgraph Client Interfaces
        Frontend[Frontend (`frontend/`)]
        DiscordBot[Discord Bot (`bot/`)]
    end

    subgraph Core Services
        API[Onboarding API (`api/`)]
        Auth[Auth Service (`auth/`)]
    end

    subgraph Data Plane
        DB[(Shared Program Database)]
    end

    subgraph Supporting Tooling
        Compose[Docker Compose]
        Migrations[Migration Runner]
        Diagnostics[Diagnostics Suite]
    end

    Frontend -->|REST + Webhooks| API
    DiscordBot -->|Task Hooks| API
    API -->|Session Validation| Auth
    Auth --> DB
    API --> DB
    Compose --> API
    Compose --> Auth
    Compose --> DiscordBot
    Compose --> Frontend
    Compose --> DB
    Migrations --> DB
    Diagnostics --> API
    Diagnostics --> Auth
    Diagnostics --> DiscordBot
    Diagnostics --> Frontend
```

The automation surfaced by Docker Compose wires each service together with
shared environment configuration so that onboarding flows can be rehearsed and
run locally with the same integrations they rely on in production. Database
migrations keep the API, auth layer, and bots in sync with schema changes, while
health and diagnostics tooling continuously exercises service endpoints to catch
integration drift before it affects new contributors.
