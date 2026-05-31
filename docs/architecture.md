# Architecture

This project uses a feature-first structure with Clean Architecture-inspired
boundaries.

## Layers

- `app`: application bootstrap, dependency construction, and top-level widget.
- `core`: cross-cutting concerns such as configuration, errors, logging, and
  validation.
- `features/*/domain`: entities, repository contracts, and use cases.
- `features/*/data`: Supabase datasources and repository implementations.
- `features/*/presentation`: pages, widgets, state, and view models.

Presentation code should depend on domain use cases or injected view models.
It should not construct Supabase clients, datasources, repositories, or use
cases directly.

## Configuration

Runtime configuration is supplied with Dart defines:

```powershell
flutter run `
  --dart-define=APP_ENV=development `
  --dart-define=SUPABASE_URL=https://your-project.supabase.co `
  --dart-define=SUPABASE_ANON_KEY=your-anon-key
```

Do not bundle `.env` files as Flutter assets. `.env.example` exists only as a
local reference for required keys.
