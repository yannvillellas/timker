import 'package:flutter/material.dart';

class TimerPage extends StatelessWidget {
  const TimerPage({Key? key, required this.timerName}) : super(key: key);
  final String timerName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.yellow),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(timerName.toUpperCase(),
            style: const TextStyle(color: Colors.yellow, letterSpacing: 3)),
        elevation: 0,
      ),
      body: Container(),
    );
  }
}
