import 'package:flutter/material.dart';
import 'package:horror_story_generator/src/detail_screen.dart';
import 'package:horror_story_generator/src/setup_screen.dart';
import 'package:story_gen/story_gen.dart';

class StoryScreen extends StatefulWidget {
  const StoryScreen({
    required this.characters,
    super.key,
  });

  final List<Character> characters;

  @override
  State<StoryScreen> createState() => _StoryScreenState();
}

class _StoryScreenState extends State<StoryScreen> {
  final generator = HorrorStoryGenerator();
  bool started = false;
  final events = <StoryBeatEvent>[];
  List<Character> gameCharacters = [];
  List<MonsterCharacter> monsters = [];

  @override
  void initState() {
    generator.setScene(
      Scene(
        width: 12,
        length: 12,
        visibility: 4,
        characters: widget.characters,
      ),
    );
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    if (started) {
      generator.stop();
      generator.removeStoryEventListener(_onEvent);
      generator.removeMapEventListener(_onMapEvent);
    }
  }

  void _onEvent(StoryBeatEvent event) {
    setState(() {
      events.add(event);
    });
  }

  void _onMapEvent(MapUpdateEvent event) {
    setState(() {
      gameCharacters = event.characters;
      monsters = event.monsters;
    });
  }

  void _start() {
    if (started) {
      return;
    }

    generator.addStoryEventListener(_onEvent);
    generator.addMapEventListener(_onMapEvent);

    generator.generate(
      speed: const Duration(seconds: 1),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Story Generator'),
      ),
      floatingActionButton: started
          ? null
          : FloatingActionButton.extended(
              onPressed: _start,
              label: const Text('Start!'),
            ),
      body: ListView(
        children: [
          CharacterChips(characters: widget.characters),
          OrientationBuilder(builder: (context, orientation) {
            var orientation = MediaQuery.of(context).orientation;
            if (orientation == Orientation.landscape) {
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 2,
                    child: StoryEvents(
                      events: events,
                    ),
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        constraints: const BoxConstraints(
                          maxHeight: 240,
                          maxWidth: 240,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          image: const DecorationImage(
                            image: NetworkImage(
                              'https://images.unsplash.com/'
                              'photo-1478760329108-5c3ed9d495a0?'
                              'ixlib=rb-4.0.3&'
                              'ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8'
                              '&auto=format&fit=crop&w=2148&q=80',
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: Stack(
                          children: [
                            for (var character in gameCharacters) ...[
                              AnimatedPositioned(
                                duration: const Duration(milliseconds: 500),
                                curve: Curves.easeInOut,
                                left: character.position.x * 20,
                                top: character.position.y * 20,
                                child: Icon(
                                  character.statusIcon,
                                  size: 20,
                                  color: Colors.green,
                                ),
                              ),
                            ],
                            for (var monster in monsters) ...[
                              AnimatedPositioned(
                                duration: const Duration(milliseconds: 500),
                                curve: Curves.easeInOut,
                                left: monster.position.x * 20,
                                top: monster.position.y * 20,
                                child: const Icon(
                                  Icons.android_rounded,
                                  size: 20,
                                  color: Colors.red,
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }
            return StoryEvents(events: events);
          }),
        ],
      ),
    );
  }
}

extension StatusIcon on Character {
  IconData get statusIcon {
    if (isFainted) {
      return Icons.local_hospital_rounded;
    }
    if (isDead) {
      return Icons.church_rounded;
    }
    return Icons.person;
  }
}

class StoryEvents extends StatelessWidget {
  const StoryEvents({
    super.key,
    required this.events,
  });

  final List<StoryBeatEvent> events;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (var event in events.reversed) ...[
          EventCard(
            event: event,
            key: ValueKey(event),
          ),
        ],
      ],
    );
  }
}

class CharacterChips extends StatelessWidget {
  const CharacterChips({
    super.key,
    required this.characters,
  });

  final List<Character> characters;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Wrap(
        children: [
          for (var character in characters) ...[
            Padding(
              padding: const EdgeInsets.all(2.0),
              child: Chip(
                label: Text(
                  character.name,
                  style: const TextStyle(
                    color: Colors.black,
                  ),
                ),
                backgroundColor: character.color.shade100,
              ),
            ),
          ]
        ],
      ),
    );
  }
}

class EventCard extends StatefulWidget {
  const EventCard({
    required this.event,
    super.key,
  });

  final StoryBeatEvent event;

  @override
  State<EventCard> createState() => _EventCardState();
}

class _EventCardState extends State<EventCard> {
  double scale = 0.5;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        setState(() {
          scale = 1;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 350),
      curve: Curves.easeInCirc,
      opacity: scale,
      child: Card(
        child: ListTile(
          leading: ArchetypeIcon(archetype: widget.event.mainActor.archetype),
          title: Text(widget.event.mainActor.name),
          subtitle: Text(widget.event.message),
          trailing: FilledButton.tonalIcon(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => EventDetailScreen(event: widget.event),
                ),
              );
            },
            icon: const Icon(Icons.visibility),
            label: const Text('Show more!'),
          ),
        ),
      ),
    );
  }
}
