import 'package:flutter/material.dart';
import 'package:widgets_demo/src/examples/screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: WidgetExampleScreen(),
    );
  }
}
