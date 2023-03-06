import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class TimerCard extends StatelessWidget {
  final String timerName;
  final int timerDuration;
  final Function(BuildContext)? removeTimer;

  const TimerCard({
    super.key,
    required this.timerName,
    required this.timerDuration,
    required this.removeTimer,
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
          decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Slidable(
            endActionPane: ActionPane(
              motion: const StretchMotion(),
              children: [
                SlidableAction(
                  onPressed: removeTimer,
                  icon: Icons.delete,
                  backgroundColor: Colors.red,
                  borderRadius: BorderRadius.circular(12),
                ),
              ],
            ),
            child: Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.all(25.0),
              decoration: BoxDecoration(
                color: Colors.yellow,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                timerName,
                textAlign: TextAlign.left,
                style: const TextStyle(color: Colors.black),
              ),
            ),
          ),
        ));
  }
}
//TODO: Add time in hours minutes and seconds to the timer card (probably change int to time variable like the clock widget video)