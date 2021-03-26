import 'package:flutter/material.dart';
import 'package:pomodoro_todo/utils/utils.dart';

class Tasks extends StatefulWidget {
  final circularCountDownTimer;

  Tasks({this.circularCountDownTimer});

  @override
  State<StatefulWidget> createState() => _Tasks();
}

class _Tasks extends State<Tasks> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Container(
      height: 70,
      child: Card(
        child: Container(
            padding: EdgeInsets.all(10),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                      child: TextFormField(
                    style: TextStyle(fontSize: 20),
                  )),
                  _buildTimeSelector(),
                  Row(children: [
                    IconButton(
                      onPressed: () {
                        widget.circularCountDownTimer
                            .setDuration(dropdownValue);
                        widget.circularCountDownTimer.startTimer();
                      },
                      icon: Icon(
                        Icons.play_arrow,
                        color: Colors.green,
                      ),
                    ),
                    IconButton(
                      onPressed: () =>
                          widget.circularCountDownTimer.pauseTimer(),
                      icon: Icon(Icons.pause, color: Colors.orange),
                    ),
                    IconButton(
                      onPressed: () =>
                          widget.circularCountDownTimer.resetTimer(),
                      icon: Icon(
                        Icons.stop,
                        color: Colors.red,
                      ),
                    ),
                  ])
                ])),
      ),
    ));
  }

  int dropdownValue = 5;
  Widget _buildTimeSelector() {
    return DropdownButton<int>(
      value: dropdownValue,
      icon: Icon(Icons.access_time),
      elevation: 0,
      onChanged: (int newValue) {
        setState(() {
          dropdownValue = newValue;
        });
      },
      items: <int>[5, 10, 15, 20, 25, 30, 35, 40, 45, 50, 55]
          .map<DropdownMenuItem<int>>((int value) {
        return DropdownMenuItem<int>(
          value: value,
          child: Text(value.toString()),
        );
      }).toList(),
    );
  }
}
