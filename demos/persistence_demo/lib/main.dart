import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a blue toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<String?> loadOurMessage() async {
    var preferences = await SharedPreferences.getInstance();
    return preferences.getString('our_message');
  }

  Future<void> login() async {
    var result = await post(
      Uri.parse('http://localhost:8080/login'),
      body: jsonEncode({
        'username': 'joey@iconica.nl',
        'password': 'test123',
      }),
    );

    print(result.body);
    print(result.statusCode);

    var token = jsonDecode(result.body)['token'];
    print(token);
  }

  // Future<void> saveFile() async {
  //   Directory directory = Directory('some/path/');
  //   var file = File('${directory.path}/file.txt');

  //   await file.create(recursive: true);

  //   await file.writeAsString('This is my amazing text message');

  //   var content = await file.readAsString();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          FilledButton(
            onPressed: () async {
              var preferences = await SharedPreferences.getInstance();
              await preferences.setString('our_message', 'Hello World');
              setState(() {});
              await login();
            },
            child: const Text('Update message'),
          ),
          FutureBuilder(
            future: loadOurMessage(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return Text(snapshot.data ?? 'No message');
              }
              return const CircularProgressIndicator();
            },
          ),
        ],
      ),
    );
  }
}
