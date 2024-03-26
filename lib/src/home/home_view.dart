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
  List<TimerTile> _timers = [];
  final List<TimerTile> _selectedTimers = [];

  @override
  void initState() {
    super.initState();
    _loadTimers();
  }

  _loadTimers() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? storedTimers = prefs.getStringList('timers');
    setState(() {
      _timers = (storedTimers ?? []).map((timer) {
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
      _timers.add(TimerTile(
        key: UniqueKey(),
        timer: Timer(name: name, duration: duration),
      ));
    });
  }

  _removeTimer(TimerTile timer) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? storedTimers = prefs.getStringList('timers');
    storedTimers!.removeWhere((storedTimer) {
      Map<String, dynamic> timerData = jsonDecode(storedTimer);
      return timerData['name'] == timer.timer.name &&
          timerData['duration'] == timer.timer.duration.inMilliseconds;
    });
    await prefs.setStringList('timers', storedTimers);

    setState(() {
      _timers.remove(timer);
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
        actions: _selectedTimers.isEmpty
            ? [
                IconButton(
                  icon: const Icon(Icons.settings),
                  onPressed: () => context.push('/settings'),
                ),
              ]
            : [
                if (_selectedTimers.length == 1)
                  IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () {
                      // TODO: Implement edit functionality
                    },
                  ),
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    for (var timer in _selectedTimers) {
                      _removeTimer(timer);
                    }
                    setState(() {
                      _selectedTimers.clear();
                    });
                  },
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
      body: _timers.isEmpty
          ? Center(child: Text(AppLocalizations.of(context)!.noTimers))
          : ReorderableListView(
              children: _timers.map((timer) {
                return Card(
                  elevation: 0.3,
                  key: timer.key,
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        if (_selectedTimers.contains(timer)) {
                          _selectedTimers.remove(timer);
                        } else {
                          _selectedTimers.add(timer);
                        }
                      });
                    },
                    onLongPress: () {
                      setState(() {
                        if (_selectedTimers.contains(timer)) {
                          _selectedTimers.remove(timer);
                        } else {
                          _selectedTimers.add(timer);
                        }
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: _selectedTimers.contains(timer)
                              ? Theme.of(context).colorScheme.secondary
                              : Colors.transparent,
                          width: 2.0,
                        ),
                      ),
                      child: timer,
                    ),
                  ),
                );
              }).toList(),
              onReorder: (oldIndex, newIndex) async {
                if (newIndex > oldIndex) {
                  newIndex -= 1;
                }

                TimerTile timer = _timers.removeAt(oldIndex);
                _timers.insert(newIndex, timer);

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
            'New Timer #${_timers.length + 1}',
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
