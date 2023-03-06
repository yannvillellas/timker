import 'package:flutter/material.dart';
import 'package:timker/util/dialog_box.dart';
import 'package:timker/util/timer_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _controller = TextEditingController();

  List timerList = [];

  void saveNewTimer() {
    setState(() {
      timerList.add([_controller.text, 10]);
      _controller.clear();
    });
    Navigator.of(context).pop();
  }

  void _addTimer() {
    showDialog(
        context: context,
        builder: (context) {
          return DialogBox(
            controller: _controller,
            onSave: saveNewTimer,
            onCancel: () => Navigator.of(context).pop(),
          );
        });
  }
  //TODO: timer button

  void _removeTimer(int index) {
    setState(() {
      timerList.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TIMKER',
            style: TextStyle(color: Colors.yellow, letterSpacing: 10)),
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
            removeTimer: (context) => _removeTimer(index),
          );
        },
      ),
    );
  }
}
