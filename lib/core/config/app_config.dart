enum AppEnvironment {
  development,
  staging,
  production;

  static AppEnvironment fromName(String value) {
    return switch (value.trim().toLowerCase()) {
      'prod' || 'production' => AppEnvironment.production,
      'staging' => AppEnvironment.staging,
      _ => AppEnvironment.development,
    };
  }
}

class AppConfig {
  final AppEnvironment environment;
  final String supabaseUrl;
  final String supabaseAnonKey;

  const AppConfig({
    required this.environment,
    required this.supabaseUrl,
    required this.supabaseAnonKey,
  });

  factory AppConfig.fromEnvironment() {
    return AppConfig(
      environment: AppEnvironment.fromName(
        const String.fromEnvironment('APP_ENV', defaultValue: 'development'),
      ),
      supabaseUrl: const String.fromEnvironment('SUPABASE_URL'),
      supabaseAnonKey: const String.fromEnvironment('SUPABASE_ANON_KEY'),
    );
  }

  void validate() {
    final missingKeys = <String>[
      if (supabaseUrl.trim().isEmpty) 'SUPABASE_URL',
      if (supabaseAnonKey.trim().isEmpty) 'SUPABASE_ANON_KEY',
    ];

    if (missingKeys.isNotEmpty) {
      throw StateError(
        'Missing required app configuration: ${missingKeys.join(', ')}',
      );
    }
  }
}
