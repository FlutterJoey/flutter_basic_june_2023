import 'package:flutter/material.dart';
import 'package:generated_screen/src/story/story_screen.dart';

class HorrorApp extends StatelessWidget {
  const HorrorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(
        useMaterial3: true,
      ),
      home: const StoryScreen(),
    );
  }
}
