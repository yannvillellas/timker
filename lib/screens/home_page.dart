import 'package:flutter/material.dart';
import 'package:timker/widgets/timer_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void _addTimer() {} //TODO: dialog box or open the new timer_page

  void _removeTimer(int index) {} //TODO: as the video

  List timerList = [
    ["Timer 1", 10],
    ["Timer 2", 20],
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            const Text('T I M K E R', style: TextStyle(color: Colors.yellow)),
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.yellow,
        onPressed: _addTimer,
        child: const Icon(
          Icons.add,
        ),
      ),
      body: ListView.builder(
        itemCount: timerList.length,
        itemBuilder: (context, index) {
          return TimerCard(
            timerName: timerList[index][0],
            timerDuration: timerList[index][1],
          );
        },
      ),
    );
  }
}
