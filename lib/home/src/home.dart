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
            Expanded(child: _buildTasksContainer()),
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
    return Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(color: Constants.secondaryColor),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(padding: EdgeInsets.all(5), child: Text("Add a Task")),
          _buildAddTask(),
          Tasks(
            circularCountDownTimer: circularCountDownTimer,
          )
        ]));
  }

  Widget _buildAddTask() {
    return Container(
      height: 70,
      margin: EdgeInsets.only(bottom: 30),
      child: Card(
        child: Container(
          padding: EdgeInsets.all(10),
          child: Row(
            children: [
              Flexible(child: TextFormField()),
              Container(
                  decoration: const ShapeDecoration(
                    color: Colors.lightBlue,
                    shape: CircleBorder(),
                  ),
                  child: IconButton(
                      icon: Icon(
                        Icons.add,
                        color: Colors.white,
                      ),
                      onPressed: () {}))
            ],
          ),
        ),
      ),
    );
  }
}
