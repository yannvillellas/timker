import 'package:flutter/material.dart';

class TimerCard extends StatelessWidget {
  final String timerName;
  final int timerDuration;

  const TimerCard({
    super.key,
    required this.timerName,
    required this.timerDuration,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(
          top: 25,
          left: 25,
          right: 25,
        ),
        child: Container(
          padding: const EdgeInsets.all(25.0),
          decoration: BoxDecoration(
            color: Colors.yellow,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            timerName,
            style: const TextStyle(color: Colors.black),
          ),
        ));
  }
}
//TODO: Add time in hours minutes and seconds to the timer card (probably change int to time variable like the clock widget video)