import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'util/timer_tile.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<TimerTile> timers = [];

  @override
  void initState() {
    super.initState();
    _loadTimers();
  }

  _loadTimers() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? storedTimers = prefs.getStringList('timers');
    setState(() {
      timers = (storedTimers ?? []).map((timer) {
        Map<String, dynamic> timerData = jsonDecode(timer);
        return TimerTile(
          key: UniqueKey(),
          timer: Timer(
            name: timerData['name'],
            duration: Duration(milliseconds: timerData['duration']),
          ),
        );
      }).toList();
    });
  }

  _addTimer(String name, Duration duration) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? storedTimers = prefs.getStringList('timers') ?? [];
    Map<String, dynamic> timerData = {
      'name': name,
      'duration': duration.inMilliseconds,
    };
    storedTimers.add(jsonEncode(timerData));
    await prefs.setStringList('timers', storedTimers);

    setState(() {
      timers.add(TimerTile(
        key: UniqueKey(),
        timer: Timer(name: name, duration: duration),
      ));
    });
  }

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
      body: timers.isEmpty
          ? Center(child: Text(AppLocalizations.of(context)!.noTimers))
          : ReorderableListView(
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
        onPressed: () {
          _addTimer(
            'New Timer',
            const Duration(seconds: 30),
          );
        },
        child: const Icon(
          Icons.add,
        ),
      ),
    );
  }
}
