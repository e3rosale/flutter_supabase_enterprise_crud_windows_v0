# Flutter Supabase Enterprise CRUD

Enterprise-style Flutter CRUD app backed by Supabase.

## Architecture

The app uses a feature-first structure with Clean Architecture-inspired
boundaries:

- `lib/app`: bootstrap, dependency construction, and app shell.
- `lib/core`: configuration, errors, logging, validation, and utilities.
- `lib/features/users/domain`: entities, use cases, and repository contracts.
- `lib/features/users/data`: Supabase datasource and repository implementation.
- `lib/features/users/presentation`: pages, widgets, state, and view models.

See `docs/architecture.md` for the project conventions.

## Prerequisites

- Flutter SDK
- A Supabase project
- A `users` table matching `docs/database.md`

## Configuration

Pass runtime configuration with Dart defines:

```powershell
flutter run `
  --dart-define=APP_ENV=development `
  --dart-define=SUPABASE_URL=https://your-project.supabase.co `
  --dart-define=SUPABASE_ANON_KEY=your-anon-key
```

Required keys are also listed in `.env.example`, but `.env` is not bundled into
the app.

## Development

```powershell
flutter pub get
dart format .
flutter analyze
flutter test
```

## Database

Apply the baseline migration in `supabase/migrations` or create the table
manually using `docs/database.md`.
