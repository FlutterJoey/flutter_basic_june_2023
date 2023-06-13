import 'package:flutter/material.dart';

class EventPanel extends StatelessWidget {
  const EventPanel({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    List<String> events = List.generate(
      100,
      (index) => 'Someone died, or did they? Maybe they survived',
    );
    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          const TabBar(
            tabs: [
              Tab(
                text: 'List',
              ),
              Tab(
                text: 'Grid',
              ),
            ],
          ),
          Expanded(
            child: TabBarView(
              children: [
                EventList(
                  events: events,
                ),
                EventGrid(
                  events: events,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class EventGrid extends StatelessWidget {
  const EventGrid({
    required this.events,
    super.key,
  });

  final List<String> events;

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 4,
      childAspectRatio: 1,
      mainAxisSpacing: 8,
      crossAxisSpacing: 8,
      padding: const EdgeInsets.all(16.0),
      children: [
        for (var event in events)
          Card(
            child: Center(
              child: Text(event),
            ),
          ),
      ],
    );
  }
}

class EventList extends StatelessWidget {
  const EventList({
    required this.events,
    super.key,
  });

  final List<String> events;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        for (var event in events)
          ListTile(
            title: Text(event),
          ),
      ],
    );
  }
}
