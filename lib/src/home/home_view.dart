import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'util/timer_tile.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final List<TimerTile> timers = [
    TimerTile(
        key: UniqueKey(),
        name: "Timer 1",
        duration: const Duration(minutes: 25)),
    TimerTile(
        key: UniqueKey(),
        name: "Timer 2",
        duration: const Duration(minutes: 30)),
    TimerTile(
        key: UniqueKey(),
        name: "Timer 3",
        duration: const Duration(minutes: 35)),
    TimerTile(
        key: UniqueKey(),
        name: "Timer 4",
        duration: const Duration(minutes: 40, seconds: 30)),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.appTitle,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 32,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => context.push('/settings'),
          ),
        ],
      ),
      body: ReorderableListView(
        padding: const EdgeInsets.all(16),
        children: timers,
        onReorder: (oldIndex, newIndex) {
          setState(() {
            if (newIndex > oldIndex) {
              newIndex -= 1;
            }
            final TimerTile timer = timers.removeAt(oldIndex);
            timers.insert(newIndex, timer);
          });
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(
          Icons.add,
        ),
      ),
    );
  }
}
