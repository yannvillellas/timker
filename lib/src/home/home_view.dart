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
        elevation: 1,
        shape: Border(
          bottom: BorderSide(
            color: Theme.of(context).dividerColor,
            width: 2.0,
          ),
        ),
      ),
      body: timers.isEmpty
          ? Center(child: Text(AppLocalizations.of(context)!.noTimers))
          : ReorderableListView(
              children: timers.map((timer) {
                return Card(
                  elevation: 0.3,
                  key: timer.key,
                  child: timer,
                );
              }).toList(),
              onReorder: (oldIndex, newIndex) async {
                if (newIndex > oldIndex) {
                  newIndex -= 1;
                }

                TimerTile timer = timers.removeAt(oldIndex);
                timers.insert(newIndex, timer);

                setState(() {});

                SharedPreferences prefs = await SharedPreferences.getInstance();
                List<String>? storedTimers = prefs.getStringList('timers');
                String timerData = storedTimers!.removeAt(oldIndex);
                storedTimers.insert(newIndex, timerData);
                await prefs.setStringList('timers', storedTimers);
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _addTimer(
            'New Timer #${timers.length + 1}',
            const Duration(),
          );
        },
        child: const Icon(
          Icons.add,
        ),
      ),
    );
  }
}
