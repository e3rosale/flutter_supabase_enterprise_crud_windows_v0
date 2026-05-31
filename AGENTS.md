# AGENTS.md

Guidance for AI coding agents working in this repository.

## Project Overview

This is a Flutter CRUD application backed by Supabase. The codebase uses a
feature-first structure with Clean Architecture-inspired boundaries:

- `lib/app`: application bootstrap, app shell, and dependency construction.
- `lib/core`: cross-cutting concerns such as config, errors, logging,
  validation, and utilities.
- `lib/features/*/domain`: entities, repository contracts, and use cases.
- `lib/features/*/data`: datasources, models, and repository implementations.
- `lib/features/*/presentation`: pages, widgets, state, and view models.

Preserve these boundaries when adding or changing code.

## Architecture Rules

- Do not construct Supabase clients, datasources, repositories, or use cases in
  widgets/pages.
- Wire dependencies through `lib/app/dependency_container.dart` or an equivalent
  app-level composition point.
- Domain code must not import Flutter UI packages or Supabase implementation
  types.
- Presentation code should depend on view models/use cases, not concrete data
  implementations.
- Keep feature-specific code inside its feature folder unless it is genuinely
  shared across features.
- Put shared validation, error, logging, and config code under `lib/core`.

## Configuration And Secrets

- Do not commit secrets.
- Do not bundle `.env` files as Flutter assets.
- Runtime config is supplied with Dart defines:

```powershell
flutter run `
  --dart-define=APP_ENV=development `
  --dart-define=SUPABASE_URL=https://your-project.supabase.co `
  --dart-define=SUPABASE_ANON_KEY=your-anon-key
```

- Keep `.env.example` limited to required key names and placeholder values.
- If adding new required config, update `AppConfig`, `.env.example`, `README.md`,
  and `docs/architecture.md`.

## Supabase And Database

- Database schema changes belong in `supabase/migrations`.
- Update `docs/database.md` when schema, RLS, or seed expectations change.
- Keep user-facing errors separate from raw Supabase exception details.
- Treat permissive RLS policies as development-only unless explicitly requested.

## Testing Expectations

For behavior changes, add or update focused tests:

- Models: parsing and mapping.
- Use cases: validation and repository interaction.
- Repositories: datasource success/failure mapping.
- View models: loading, success, mutation, and error states.
- Widgets: important rendered states and user flows.

Prefer fakes for simple domain/presentation tests. Add mocking dependencies only
when fakes become awkward or obscure the test intent.

## Quality Gates

Run these before committing when the Flutter toolchain is available:

```powershell
dart format .
flutter analyze
flutter test
```

If `flutter` is unavailable in the current shell, run at least:

```powershell
dart format lib test
dart analyze
```

Document any validation that could not be run in the final response.

## Editing Guidelines

- Keep changes scoped to the requested task.
- Do not refactor unrelated platform runner files.
- Do not modify generated Flutter platform files unless the task requires it.
- Prefer small, explicit classes over broad abstractions.
- Keep public app text and docs clear, concise, and accurate.
- Use ASCII unless editing an existing file that already uses non-ASCII.

## Git And PR Hygiene

- Work on the current feature branch unless the user explicitly asks otherwise.
- Do not commit unrelated local changes.
- Before committing, check:

```powershell
git status --short
git diff --check
```

- Use concise commit messages that describe the user-visible or architectural
  outcome.
- If GitHub CLI is unavailable, push the branch and provide the GitHub compare
  or pull request creation URL.
