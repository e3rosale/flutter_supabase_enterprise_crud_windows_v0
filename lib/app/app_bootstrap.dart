import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../core/config/app_config.dart';
import 'app.dart';
import 'dependency_container.dart';

Future<void> bootstrapApp(AppConfig config) async {
  WidgetsFlutterBinding.ensureInitialized();

  config.validate();

  await Supabase.initialize(
    url: config.supabaseUrl,
    anonKey: config.supabaseAnonKey,
  );

  final dependencies = AppDependencies(
    supabaseClient: Supabase.instance.client,
  );

  runApp(MyApp(dependencies: dependencies));
}
