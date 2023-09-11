import 'dart:async';

import 'package:flutter/material.dart';
import 'package:horror_story_generator/src/login_screen.dart';
import 'package:rive/rive.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    unawaited(_waitScreen());
  }

  Future<void> _waitScreen() async {
    await Future.delayed(const Duration(seconds: 3));

    if (mounted) {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) {
          return const LoginScreen();
        },
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: RiveAnimation.asset('assets/flutter_buddy.riv'),
      ),
    );
  }
}
