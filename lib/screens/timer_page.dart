import 'package:flutter/cupertino.dart';
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
        body: SafeArea(
          child: Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CupertinoButton(
                onPressed: () {},
                padding: const EdgeInsets.all(0),
                child: Container(
                  height: 250,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.yellow,
                      width: 4,
                    ),
                  ),
                  child: const Text(
                    '00:00:00',
                    style: TextStyle(
                        color: Colors.yellow,
                        fontSize: 40,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(height: 50),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.play_arrow),
                iconSize: 50,
                color: Colors.yellow,
              ),
            ],
          )),
        ));
  }
}
