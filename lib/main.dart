import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'screens/home_page.dart';

void main() async {
  //init the hive database
  await Hive.initFlutter();
  //open a box
  var box = await Hive.openBox('myBox');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Timker',
      home: const HomePage(),
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color.fromARGB(255, 0, 0, 0),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Colors.yellow),
          bodyMedium: TextStyle(color: Colors.yellow),
          bodySmall: TextStyle(color: Colors.yellow),
        ),
        appBarTheme: const AppBarTheme(
          color: Color.fromARGB(255, 0, 0, 0),
          elevation: 0,
          centerTitle: true,
        ),
      ),
    );
  }
}
