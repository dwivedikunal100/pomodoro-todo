import 'package:flutter/material.dart';
import 'package:pomodoro_todo/home/home.dart';

class PomodoroTodo extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Home(title: 'Pomodoro Todo'),
    );
  }
}
