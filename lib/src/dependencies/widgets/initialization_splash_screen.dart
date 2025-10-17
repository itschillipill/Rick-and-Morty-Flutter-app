// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:rick_and_morty/src/core/theme/app_theme.dart';

class InitializationSplashScreen extends StatelessWidget {
  const InitializationSplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}