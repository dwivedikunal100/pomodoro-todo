import 'package:flutter/material.dart';
import 'package:pomodoro_todo/home/src/tasks.dart';
import 'package:pomodoro_todo/storage/storage.dart';
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
  int dropdownValue;
  String task;
  bool timerActive = false;
  final fieldText = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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

  void updateTimerActive() {
    setState(() {
      timerActive = true;
    });
  }

  clearDetails() {
    fieldText.clear();
    setState(() {
      task = null;
      dropdownValue = null;
    });
  }

  Widget _buildCountownTimerContainer() {
    return Container(
        padding: EdgeInsets.all(10),
        height: MediaQuery.of(context).size.height,
        width: 300,
        decoration: BoxDecoration(color: Constants.primaryColor),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          circularCountDownTimer,
          Padding(padding: EdgeInsets.all(20)),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            timerActive
                ? MaterialButton(
                    onPressed: () {
                      setState(() {
                        timerActive = false;
                      });
                      circularCountDownTimer.pauseTimer();
                    },
                    child: Text("Pause"),
                    color: Colors.orangeAccent,
                  )
                : MaterialButton(
                    onPressed: () {
                      setState(() {
                        timerActive = true;
                      });
                      circularCountDownTimer.startTimer();
                    },
                    child: Text("Resume"),
                    color: Colors.greenAccent,
                  ),
            Padding(padding: EdgeInsets.all(10)),
            MaterialButton(
              onPressed: () {
                setState(() {
                  timerActive = false;
                });
                circularCountDownTimer.resetTimer();
              },
              color: Colors.redAccent,
              child: Text("Reset"),
            )
          ])
        ]));
  }

  Widget _buildTasksContainer() {
    return Container(
        padding: EdgeInsets.only(left: 10, right: 10),
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(color: Constants.secondaryColor),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
              padding: EdgeInsets.only(top: 10, left: 5),
              child: Text(
                "Add a Task",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
              )),
          _buildAddTask(),
          Tasks(
            circularCountDownTimer: circularCountDownTimer,
            isActive: this.updateTimerActive,
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
              Flexible(
                  child: TextFormField(
                controller: fieldText,
                decoration: InputDecoration(hintText: 'Add task name'),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    task = null;
                  }
                  task = value;
                  return null;
                },
              )),
              _buildTimeSelector(),
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
                      onPressed: () {
                        CoreStorage.createTask(
                          task == null ? "Demo Task" : task,
                          dropdownValue == null ? 5 : dropdownValue,
                        );
                        clearDetails();
                      }))
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTimeSelector() {
    return Container(
        height: 30,
        margin: EdgeInsets.only(left: 10, right: 10, top: 10),
        child: DropdownButton<int>(
          value: dropdownValue,
          isDense: true,
          elevation: 0,
          hint: Text(
            'Minutes',
          ),
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
        ));
  }
}
