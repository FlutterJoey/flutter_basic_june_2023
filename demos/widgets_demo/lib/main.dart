import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Row(
          children: [
            Expanded(
              child: Container(
                color: Colors.green,
              ),
            ),
            const SizedBox(
              height: 100,
              width: 100,
              child: CircularContainer(
                color: Colors.blueGrey,
              ),
            ),
            Expanded(
              child: Container(
                color: Colors.red,
                alignment: Alignment.center,
                child: const MyStatefulWidget(
                  initalCount: 5,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CircularContainer extends StatelessWidget {
  const CircularContainer({
    required this.color,
    super.key,
  });

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(1000000000),
      ),
    );
  }
}

/// stls will create this template
class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({
    required this.initalCount,
    super.key,
  });

  final int initalCount;

  @override
  MyStatefulState createState() => MyStatefulState();
}

class MyStatefulState extends State<MyStatefulWidget> {
  late int count;

  void pressButton() {
    setState(() {
      count = count + 1;
    });
  }

  @override
  void initState() {
    count = widget.initalCount;
    super.initState();
  }

  @override
  void didUpdateWidget(covariant MyStatefulWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: pressButton,
      child: Text('$count'),
    );
  }
}
