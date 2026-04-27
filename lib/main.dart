import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

// import 'app.dart';
// import 'core/constants/app_constants.dart';

import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: ".env");
  
  await Supabase.initialize(
    url: "somehting",
    anonKey: "else",
  );

  runApp(const MyApp());
}