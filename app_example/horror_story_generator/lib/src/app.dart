import 'package:flutter/material.dart';
import 'package:horror_story_generator/src/splash_screen.dart';

class HorrorStoryApp extends StatelessWidget {
  const HorrorStoryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.dark,
        useMaterial3: true,
        inputDecorationTheme: const InputDecorationTheme(
          border: OutlineInputBorder(),
        ),
      ),
      home: const SplashScreen(),
    );
  }
}
