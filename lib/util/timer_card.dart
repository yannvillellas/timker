import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:timker/screens/timer_page.dart';

class TimerCard extends StatelessWidget {
  final String timerName;
  final int timeElapsed;
  final Function(BuildContext)? removeTimer;

  const TimerCard({
    super.key,
    required this.timerName,
    required this.timeElapsed,
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
          child: GestureDetector(
            onTap: () async {
              final result = await Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => TimerPage(timerName: timerName)));
              if (result != null) {
                final elapsedTime = result['elapsedTime'] as Duration;
                final timerName = result['timerName'] as String;
                // save the elapsed time to local storage or do something else with it
              }
            },
            child: Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.all(25.0),
              decoration: BoxDecoration(
                color: Colors.yellow,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Text(
                      timerName,
                      textAlign: TextAlign.left,
                      style: const TextStyle(color: Colors.black),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    '${(timeElapsed ~/ 60).toString().padLeft(2, '0')}:${(timeElapsed % 60).toString().padLeft(2, '0')}',
                    style: const TextStyle(color: Colors.black),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
