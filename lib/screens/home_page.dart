import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:timker/data/database.dart';
import 'package:timker/util/dialog_box.dart';
import 'package:timker/util/timer_card.dart';
import 'package:timker/screens/timer_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _myBox = Hive.box('myBox');
  final _controller = TextEditingController();
  TimerDatabase db = TimerDatabase();

  @override
  void initState() {
    //check if this is the first time ever the app is opened
    if (_myBox.get('TIMERLIST') == null) {
      db.createInitialData();
    } else {
      db.loadData();
    }
    super.initState();
  }

  //save a new timer
  void saveNewTimer() {
    setState(() {
      db.timerList.add([_controller.text, 0]);
      _controller.clear();
    });
    Navigator.of(context).pop();
    db.updateDatabase();
  }

  // show the dialgo box to add a new timer
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

  // remove a timer
  void _removeTimer(int index) {
    setState(() {
      db.timerList.removeAt(index);
    });
    db.updateDatabase();
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
        itemCount: db.timerList.length,
        itemBuilder: (context, index) {
          return TimerCard(
            timerName: db.timerList[index][0],
            timerDurationInMs: db.timerList[index][1],
            removeTimer: (context) => _removeTimer(index),
          );
        },
      ),
    );
  }
}
