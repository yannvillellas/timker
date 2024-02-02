import 'package:flutter/material.dart';

class TimerTile extends StatefulWidget {
  final String name;
  final Duration duration;

  const TimerTile({
    Key? key,
    required this.name,
    required this.duration,
  }) : super(key: key);

  @override
  State<TimerTile> createState() => _TimerTileState();
}

class _TimerTileState extends State<TimerTile> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(widget.name),
      subtitle: Text(widget.duration.toString()),
    );
  }
}
