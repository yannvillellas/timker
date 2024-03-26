import 'package:flutter/material.dart';

class Timer {
  final String name;
  final Duration duration;

  Timer({
    required this.name,
    required this.duration,
  });
}

class TimerTile extends StatelessWidget {
  final Timer timer;

  const TimerTile({
    Key? key,
    required this.timer,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(timer.name),
      subtitle: Text(timer.duration.toString()),
    );
  }
}
