import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final keys = [
    GlobalKey<_UnstableCounterState>(),
    GlobalKey<_UnstableCounterState>(),
  ];
  var currentKey = 0;

  @override
  Widget build(BuildContext context) {
    Theme.of(context);
    return MyInheritedStatefulWidget(
      child: MaterialApp(
        home: Scaffold(
          body: Row(
            children: [
              Expanded(
                child: Container(
                  color: Colors.green,
                  alignment: Alignment.center,
                  child: UnstableCounter(
                    key: keys[currentKey],
                    onUpdateCount: (count) {
                      print(count);
                      if (count > 5) {
                        setState(() {
                          currentKey = 1;
                        });
                      }
                      if (count > 10) {
                        setState(() {
                          currentKey = 0;
                        });
                      }
                    },
                  ),
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
      ),
    );
  }
}

class MyInheritedWidget extends InheritedWidget {
  const MyInheritedWidget({
    required this.state,
    super.key,
    required super.child,
  });

  final MyInheritedStatefulWidgetState state;

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return true;
  }
}

class MyInheritedStatefulWidget extends StatefulWidget {
  const MyInheritedStatefulWidget({
    required this.child,
    super.key,
  });

  final Widget child;

  @override
  State<MyInheritedStatefulWidget> createState() =>
      MyInheritedStatefulWidgetState();
}

class MyInheritedStatefulWidgetState extends State<MyInheritedStatefulWidget> {
  String name = '';

  void updateName(String name) {
    print('updating name $name');
    setState(() {
      this.name = name;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MyInheritedWidget(state: this, child: widget.child);
  }
}

class UnstableCounter extends StatefulWidget {
  const UnstableCounter({
    required this.onUpdateCount,
    super.key,
  });

  final void Function(int count) onUpdateCount;

  @override
  State<UnstableCounter> createState() => _UnstableCounterState();
}

class _UnstableCounterState extends State<UnstableCounter> {
  int count = 0;

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: () {
        setState(() {
          count++;
        });
        widget.onUpdateCount(count);

        var inheritedWidget =
            context.getInheritedWidgetOfExactType<MyInheritedWidget>();
        inheritedWidget?.state.updateName('James the $count');
      },
      child: Text(
        '$count',
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
    var inheritedWidget =
        context.getInheritedWidgetOfExactType<MyInheritedWidget>();
    var name = inheritedWidget?.state.name ?? 'No name';

    return FilledButton(
      onPressed: pressButton,
      child: Text('$count $name'),
    );
  }
}
