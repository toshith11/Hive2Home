import 'package:flutter/material.dart';
import 'core/theme/app_theme.dart';
import 'features/splash/splash_screen.dart';

void main() {
  runApp(const Hive2HomeApp());
}

class Hive2HomeApp extends StatelessWidget {
  const Hive2HomeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Hive2Home',
      theme: AppTheme.lightTheme,
      home: const SplashScreen(),
    );
  }
}