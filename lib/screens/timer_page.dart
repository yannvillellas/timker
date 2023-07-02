import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class TimerPage extends StatefulWidget {
  const TimerPage({Key? key, required this.timerName}) : super(key: key);
  final String timerName;

  @override
  _TimerPageState createState() => _TimerPageState();
}

class _TimerPageState extends State<TimerPage> {
  late Stopwatch _stopwatch;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _stopwatch = Stopwatch();
    _timer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  Duration getElapsedTime() {
    return _stopwatch.elapsed;
  }

  String getElapsedTimeAsString() {
    return '${_stopwatch.elapsed.inHours.toString().padLeft(2, '0')}:${(_stopwatch.elapsed.inMinutes % 60).toString().padLeft(2, '0')}:${(_stopwatch.elapsed.inSeconds % 60).toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.yellow),
          onPressed: () {
            Navigator.of(context).pop({
              'elapsedTime': _stopwatch.elapsed,
              'timerName': widget.timerName
            });
          },
        ),
        title: Text(widget.timerName.toUpperCase(),
            style: const TextStyle(color: Colors.yellow, letterSpacing: 3)),
        elevation: 0,
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CupertinoButton(
                onPressed:
                    _stopwatch.isRunning ? _stopwatch.stop : _stopwatch.start,
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
                  child: Text(
                    getElapsedTimeAsString(),
                    style: const TextStyle(
                        color: Colors.yellow,
                        fontSize: 40,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(height: 50),
              IconButton(
                onPressed: () {
                  if (_stopwatch.isRunning) {
                    _stopwatch.stop();
                  } else {
                    _stopwatch.start();
                  }
                  setState(() {});
                },
                icon:
                    Icon(_stopwatch.isRunning ? Icons.pause : Icons.play_arrow),
                iconSize: 50,
                color: Colors.yellow,
              ),
              if (!_stopwatch.isRunning && _stopwatch.elapsedMilliseconds > 0)
                IconButton(
                  onPressed: () {
                    _stopwatch.reset();
                    setState(() {});
                  },
                  icon: const Icon(Icons.replay),
                  iconSize: 50,
                  color: Colors.yellow,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
