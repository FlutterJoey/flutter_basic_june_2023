import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:horror_story_generator/src/api.dart';
import 'package:horror_story_generator/src/story_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:story_gen/story_gen.dart';

void main() {
  group('some unit tests', () {
    test('test if we actually try to log in', () async {
      SharedPreferences.setMockInitialValues({
        'token': 'my regular token',
      });
      await saveToken('my amazing token');

      var prefs = await SharedPreferences.getInstance();

      var token = prefs.getString('token');
      expect(token, equals('my amazing toke'));
    });
  });

  testWidgets('Event card actions', (widgetTester) async {
    await widgetTester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: EventCard(
            event: StoryBeatEvent(
              scene: Scene(
                width: 10,
                length: 10,
                visibility: 3,
                characters: [
                  Character(name: 'Tester', archetype: Archetype.angry)
                ],
              ),
              timeStamp: const Duration(seconds: 5),
              mainActor: Character(name: 'Tester', archetype: Archetype.angry),
              visibleMonsters: [],
              type: StoryBeatEventType.say,
              message: 'Something',
            ),
          ),
        ),
      ),
    );

    await widgetTester.pumpAndSettle();

    expect(find.byIcon(Icons.admin_panel_settings), findsOneWidget);
    expect(find.text('Something'), findsOneWidget);
  });
}
