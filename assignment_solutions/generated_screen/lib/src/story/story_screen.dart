import 'package:flutter/material.dart';
import 'package:generated_screen/src/story/event_panel.dart';

class StoryScreen extends StatelessWidget {
  const StoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: InformationPanel(),
          ),
          Expanded(
            flex: 3,
            child: EventPanel(),
          ),
        ],
      ),
    );
  }
}

class InformationPanel extends StatelessWidget {
  const InformationPanel({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Expanded(
          child: Column(
            children: [
              Expanded(
                child: StoryMap(),
              ),
              SizedBox(
                height: 150,
                child: Controls(),
              ),
            ],
          ),
        ),
        SizedBox(
          width: 250,
          child: PlayerList(),
        ),
      ],
    );
  }
}

class PlayerList extends StatelessWidget {
  const PlayerList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.green,
      alignment: Alignment.center,
      child: const Text('Playerlist'),
    );
  }
}

class Controls extends StatelessWidget {
  const Controls({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue,
      alignment: Alignment.center,
      child: const Text('Controls'),
    );
  }
}

class StoryMap extends StatelessWidget {
  const StoryMap({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
        return Container(
      margin: const EdgeInsets.all(8.0),
      color: Colors.red.shade900,
      alignment: Alignment.center,
      child: const Text('Map'),
    );
  }
}
