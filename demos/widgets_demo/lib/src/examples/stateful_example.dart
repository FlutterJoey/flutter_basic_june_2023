import 'package:flutter/material.dart';

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
      onPressed: () {
        pressButton();
      },
      child: Text('$count'),
    );
  }
}
