import 'package:flutter/material.dart';
import 'package:horror_story_generator/src/api.dart' as api;
import 'package:horror_story_generator/src/story_screen.dart';
import 'package:story_gen/story_gen.dart';

final characters = [
  Character(
    name: 'Bob',
    archetype: Archetype.funny,
  ),
  Character(
    name: 'Damien',
    archetype: Archetype.loving,
  ),
  Character(
    name: 'Bram',
    archetype: Archetype.angry,
  ),
  Character(
    name: 'Cees',
    archetype: Archetype.loving,
  ),
  Character(
    name: 'Carlo',
    archetype: Archetype.scared,
  ),
  Character(
    name: 'Arjen',
    archetype: Archetype.neutral,
  ),
  Character(
    name: 'Vick',
    archetype: Archetype.scared,
  ),
];

class SetupScreen extends StatefulWidget {
  const SetupScreen({super.key});

  @override
  State<SetupScreen> createState() => _SetupScreenState();
}

class _SetupScreenState extends State<SetupScreen> {
  final List<Character> selectedCharacters = [];
  final Future<List<Character>> characterFuture = api.getCharacters();
  @override
  Widget build(BuildContext context) {
    var navigator = Navigator.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select your players'),
      ),
      body: Stack(
        children: [
          FutureBuilder<List<Character>>(
            future: characterFuture,
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const LinearProgressIndicator();
              }
              return ListView(
                children: [
                  for (var character in snapshot.data!) ...[
                    CharacterTile(
                      character: character,
                      selected: selectedCharacters.contains(character),
                      onSelect: (selected) {
                        if (selected) {
                          setState(() {
                            selectedCharacters.add(character);
                          });
                        } else {
                          setState(() {
                            selectedCharacters.remove(character);
                          });
                        }
                      },
                    ),
                  ],
                  const SizedBox(
                    height: 100,
                  ),
                ],
              );
            },
          ),
          Positioned(
            bottom: 32,
            left: 64,
            right: 64,
            child: FilledButton(
              onPressed: () async {
                await navigator.push(
                  MaterialPageRoute(
                    builder: (context) => StoryScreen(
                      characters: List.from(selectedCharacters),
                    ),
                  ),
                );
                setState(() {
                  selectedCharacters.clear();
                });
              },
              child: const Text('Create generator!'),
            ),
          ),
        ],
      ),
    );
  }
}

class CharacterTile extends StatelessWidget {
  const CharacterTile({
    required this.character,
    required this.selected,
    required this.onSelect,
    super.key,
  });

  final Character character;
  final bool selected;
  final void Function(bool selected) onSelect;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        onSelect(!selected);
      },
      leading: ArchetypeIcon(archetype: character.archetype),
      title: Text(
        character.name,
        style: TextStyle(
          color: character.color.shade50,
        ),
      ),
      subtitle: Text(character.archetype.name),
      trailing: Checkbox(
        value: selected,
        onChanged: (_) => onSelect(!selected),
      ),
    );
  }
}

class ArchetypeIcon extends StatelessWidget {
  const ArchetypeIcon({
    super.key,
    required this.archetype,
  });

  final Archetype archetype;

  @override
  Widget build(BuildContext context) {
    var color = Colors.primaries[archetype.index].shade300;
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
      ),
      height: 40,
      width: 40,
      child: Icon(archetype.icon),
    );
  }
}

extension ArchetypeIcons on Archetype {
  IconData get icon {
    switch (this) {
      case Archetype.angry:
        return Icons.admin_panel_settings;
      case Archetype.loving:
        return Icons.favorite;
      case Archetype.funny:
        return Icons.add_reaction;
      case Archetype.scared:
        return Icons.whatshot;
      case Archetype.neutral:
        return Icons.accessibility;
    }
  }
}

extension ArchetypeColor on Archetype {
  Color get color {
    return Colors.accents[index].shade700;
  }
}

extension CharacterColor on Character {
  MaterialColor get color {
    int sum = name.codeUnits.reduce((value, element) => value + element);
    var primaryColors = Colors.primaries;
    return primaryColors[sum % primaryColors.length];
  }
}
