import 'package:flutter/material.dart';
import 'package:widgets_demo/src/examples/inherited_widget_example.dart';
import 'package:widgets_demo/src/examples/navigator_example.dart';
import 'package:widgets_demo/src/examples/stateful_example.dart';
import 'package:widgets_demo/src/examples/stateless_widget.dart';

class WidgetExampleScreen extends StatelessWidget {
  const WidgetExampleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const MyInheritedStatefulWidget(
      child: Scaffold(
        body: Column(
          children: [
            SizedBox(
              height: 100,
              width: 100,
              child: CircularContainer(
                color: Colors.blueGrey,
              ),
            ),
            Expanded(
              child: ColoredBox(
                color: Colors.red,
                child: MyStatefulWidget(initalCount: 100),
              ),
            ),
            Expanded(
              child: ColoredBox(
                color: Colors.green,
                child: NavigatorExample(),
              ),
            ),
            Expanded(
              child: ColoredBox(
                color: Colors.blue,
                child: RetrievalWidget(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
