import 'package:flutter/material.dart';
import 'package:horror_story_generator/src/setup_screen.dart';
import 'package:story_gen/story_gen.dart';

class EventDetailScreen extends StatelessWidget {
  const EventDetailScreen({
    required this.event,
    super.key,
  });

  final StoryBeatEvent event;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: event.mainActor.archetype.color,
        title: Text(event.mainActor.name),
      ),
      body: ListView(
        children: [
          OtherCharacter(
            otherActor: event.secondaryActor,
            otherMonster: event.monster,
          ),
          EventTypeIndicator(eventType: event.type),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  event.message,
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
          ),
          if (event.visibleMonsters.isNotEmpty) ...[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      const Text(
                        'Monsters',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 18,
                        ),
                      ),
                      for (var monster in event.visibleMonsters) ...[
                        MonsterInfoCard(
                          monsterCharacter: monster,
                        ),
                        if (monster != event.visibleMonsters.last) ...[
                          const Divider(),
                        ],
                      ]
                    ],
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class OtherCharacter extends StatelessWidget {
  const OtherCharacter({
    required this.otherActor,
    required this.otherMonster,
    super.key,
  });

  final Character? otherActor;
  final MonsterCharacter? otherMonster;

  @override
  Widget build(BuildContext context) {
    var character = otherActor;
    var monster = otherMonster;
    if (monster != null) {
      return MonsterInfoCard(monsterCharacter: monster.monster);
    }
    if (character != null) {
      return ListTile(
        tileColor: character.color,
        leading: ArchetypeIcon(archetype: character.archetype),
        title: Text('with: ${character.name}'),
        subtitle: Text(character.archetype.name),
      );
    }
    return const SizedBox.shrink();
  }
}

class MonsterInfoCard extends StatelessWidget {
  const MonsterInfoCard({
    required this.monsterCharacter,
    super.key,
  });

  final Monster monsterCharacter;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.adb),
      title: Text(monsterCharacter.name),
      subtitle: Column(
        children: [
          MonsterStatEntry(
            title: 'Sound',
            value: monsterCharacter.sound,
          ),
          MonsterStatEntry(
            title: 'Attack',
            value: monsterCharacter.attackName,
          ),
          MonsterStatEntry(
            title: 'Speed',
            value: monsterCharacter.speed.toString(),
          ),
          MonsterStatEntry(
            title: 'Deadliness',
            value: monsterCharacter.deadlyNess.toString(),
          ),
          MonsterStatEntry(
            title: 'Scare Factor',
            value: monsterCharacter.scareFactor.toString(),
          ),
        ],
      ),
    );
  }
}

class MonsterStatEntry extends StatelessWidget {
  const MonsterStatEntry({
    Key? key,
    required this.title,
    required this.value,
  }) : super(key: key);

  final String title;
  final String value;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.end,
            ),
          ),
        ],
      ),
    );
  }
}

class EventTypeIndicator extends StatelessWidget {
  const EventTypeIndicator({
    required this.eventType,
    super.key,
  });

  final StoryBeatEventType eventType;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        color: eventType.color,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(
                eventType.icon,
                size: 30,
              ),
              Text(
                eventType.name,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

extension EventTypeColor on StoryBeatEventType {
  Color get color {
    return Colors.accents[index].shade400;
  }
}

extension EventTypeIcon on StoryBeatEventType {
  IconData get icon {
    switch (this) {
      case StoryBeatEventType.faint:
        return Icons.hotel;
      case StoryBeatEventType.attack:
        return Icons.sports_martial_arts;
      case StoryBeatEventType.kill:
        return Icons.warning_amber_rounded;
      case StoryBeatEventType.romance:
        return Icons.favorite_rounded;
      case StoryBeatEventType.say:
        return Icons.message_rounded;
      case StoryBeatEventType.thought:
        return Icons.feedback_rounded;
      case StoryBeatEventType.flee:
        return Icons.sports_handball;
      case StoryBeatEventType.splitUp:
        return Icons.call_split_rounded;
      case StoryBeatEventType.jumpScare:
        return Icons.notification_important;
      case StoryBeatEventType.end:
        return Icons.sports_score_rounded;
    }
  }
}
