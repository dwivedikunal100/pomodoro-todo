import 'package:flutter/material.dart';
import 'package:pomodoro_todo/home/src/tasks.dart';
import 'package:pomodoro_todo/utils/utils.dart';

class Home extends StatefulWidget {
  Home({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _Home createState() => _Home();
}

class _Home extends State<Home> {
  final circularCountDownTimer = CircularCountDownTimer(
    side: 200,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _buildCountownTimerContainer(),
            _buildTasksContainer(),
          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Widget _buildCountownTimerContainer() {
    return Container(
        padding: EdgeInsets.all(10),
        height: MediaQuery.of(context).size.height,
        width: 300,
        decoration: BoxDecoration(color: Constants.primaryColor),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [circularCountDownTimer]));
  }

  Widget _buildTasksContainer() {
    return Expanded(
        child: Container(
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(color: Constants.secondaryColor),
            child: Tasks(
              circularCountDownTimer: circularCountDownTimer,
            )));
  }
}
