import 'package:hive_flutter/hive_flutter.dart';

class TimerDatabase {
  List timerList = [];

  //reference our box
  final _myBox = Hive.box('myBox');

  //run this method if this is the first time ever the app is opened
  void createInitialData() {
    timerList = [
      ['Work', 0],
      ['Study', 10],
    ];
  }

  //load the data from database
  void loadData() {
    timerList = _myBox.get('TIMERLIST');
  }

  //update the database
  void updateDatabase() {
    _myBox.put('TIMERLIST', timerList);
  }
}
