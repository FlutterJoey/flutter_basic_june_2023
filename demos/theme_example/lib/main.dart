import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  var colorScheme = await ColorScheme.fromImageProvider(
    provider: const AssetImage('assets/images/flutter-mascot.png'),
  );
  runApp(
    MyApp(
      colorScheme: colorScheme,
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
    required this.colorScheme,
  });

  final ColorScheme colorScheme;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: colorScheme,
        textTheme: const TextTheme(
          bodyMedium: TextStyle(
            fontSize: 100,
          ),
        ),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      body: Column(
        children: [
          Text(
            'Test',
            style: theme.textTheme.bodyMedium,
          ),
          CircularProgressIndicator(
            color: theme.colorScheme.primary,
          ),
          const SizedBox.square(
            dimension: 100,
            child: Image(image: AssetImage('assets/images/flutter-mascot.png')),
          ),
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: Colors.pink,
              image: const DecorationImage(
                image: AssetImage('assets/images/flutter-mascot.png'),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(100),
            ),
            child: const CircularProgressIndicator(),
          ),
        ],
      ),
    );
  }
}
