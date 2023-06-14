import 'package:flutter/material.dart';
import 'package:story_gen/story_gen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light().copyWith(
        colorScheme: const ColorScheme.light().copyWith(
          primary: Colors.blue,
        ),
      ),
      home: const GeneratorPage(),
    );
  }
}

class GeneratorPage extends StatefulWidget {
  const GeneratorPage({super.key});

  @override
  State<GeneratorPage> createState() => _GeneratorPageState();
}

class _GeneratorPageState extends State<GeneratorPage> {
  HorrorStoryGenerator? generator;

  List<StoryBeatEvent> events = [];
  MapUpdateEvent? latestMapEvent;

  void start() {
    generator?.generate(
      speed: const Duration(
        seconds: 1,
      ),
    );
  }

  void setup(List<Character> characters) {
    generator = HorrorStoryGenerator();
    generator!.setScene(
      Scene(
        width: 12,
        length: 12,
        visibility: 3,
        characters: characters,
      ),
    );
    generator!.addMapEventListener(onMapEvent);
    generator!.addStoryEventListener(onStoryEvent);
  }

  void stop() {
    generator?.stop();
    generator?.removeMapEventListener(onMapEvent);
    generator?.removeStoryEventListener(onStoryEvent);
    setState(() {
      events.clear();
      latestMapEvent = null;
      generator = null;
    });
  }

  void onStoryEvent(StoryBeatEvent event) {
    setState(() {
      events.add(event);
    });
  }

  void onMapEvent(MapUpdateEvent event) {
    setState(() {
      latestMapEvent = event;
    });
  }

  @override
  void dispose() {
    stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 200,
            child: Row(
              children: [
                Expanded(
                  child: FilledButton(
                    onPressed: () {
                      setup([
                        Character(name: 'Jacques', archetype: Archetype.funny),
                        Character(name: 'Jacques', archetype: Archetype.funny),
                        Character(name: 'Jacques', archetype: Archetype.funny),
                      ]);
                      start();
                    },
                    child: const Text('start'),
                  ),
                ),
                Expanded(
                  child: Text(
                    latestMapEvent?.characters
                            .where((character) => !character.isDead)
                            .length
                            .toString() ??
                        '',
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                for (var event in events) ...[
                  ListTile(
                    title: Text(event.mainActor.name),
                    subtitle: Text(event.message),
                    leading: Text(event.type.name),
                  )
                ],
              ],
            ),
          )
        ],
      ),
    );
  }
}
