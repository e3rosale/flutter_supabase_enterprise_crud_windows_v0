import 'app/app_bootstrap.dart';
import 'core/config/app_config.dart';

Future<void> main() async {
  await bootstrapApp(AppConfig.fromEnvironment());
}
