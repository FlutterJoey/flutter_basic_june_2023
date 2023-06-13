import 'package:flutter/material.dart';

class NavigatorExample extends StatelessWidget {
  const NavigatorExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      child: FilledButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) {
                return Scaffold(
                  body: Center(
                    child: Column(
                      children: [
                        const Text('This is a new page'),
                        FilledButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text('close'),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        },
        child: const Text('Open new page'),
      ),
    );
  }
}
