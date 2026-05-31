import 'package:flutter/material.dart';

import '../features/users/presentation/pages/users_page.dart';
import 'dependency_container.dart';

class MyApp extends StatelessWidget {
  final AppDependencies dependencies;

  const MyApp({super.key, required this.dependencies});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Enterprise CRUD App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
      ),
      home: UsersPage(createViewModel: dependencies.createUsersViewModel),
    );
  }
}
