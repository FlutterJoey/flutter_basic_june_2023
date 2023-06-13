import 'package:flutter/material.dart';

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

  static MyInheritedStatefulWidgetState of(BuildContext context) {
    return context.getInheritedWidgetOfExactType<MyInheritedWidget>()!.state;
  }
}

class MyInheritedStatefulWidgetState extends State<MyInheritedStatefulWidget> {
  String name = '';

  void updateName(String name) {
    setState(() {
      this.name = name;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MyInheritedWidget(state: this, child: widget.child);
  }
}

class RetrievalWidget extends StatelessWidget {
  const RetrievalWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var name = MyInheritedStatefulWidget.of(context).name;

    return Text(name);
  }
}
