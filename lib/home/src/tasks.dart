import 'package:flutter/material.dart';
import 'package:pomodoro_todo/models/models.dart';
import 'package:pomodoro_todo/storage/src/core_storage.dart';

class Tasks extends StatefulWidget {
  final circularCountDownTimer;
  final Function isActive;

  Tasks({this.circularCountDownTimer, this.isActive});

  @override
  State<StatefulWidget> createState() => _Tasks();
}

class _Tasks extends State<Tasks> {
  bool x;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: CoreStorage.getTasks(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return Expanded(
                child: SingleChildScrollView(
                    child: Column(
              children: List<Widget>.from(
                  snapshot.data.map((e) => _buildTaskCard(e)).toList()),
            )));
          } else if (snapshot.hasError) {
            return Container(
                height: MediaQuery.of(context).size.height * 0.80,
                child: Center(child: Text("Error")));
          } else {
            return CircularProgressIndicator();
          }
        });
  }

  Widget _buildTaskCard(Task task) {
    return Container(
      height: 70,
      child: Card(
        child: Container(
            padding: EdgeInsets.all(10),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                      child: Text(
                    task.title,
                    style: TextStyle(fontSize: 17),
                  )),
                  Container(
                    padding: EdgeInsets.all(3),
                    child: Text(
                      "${task.durationInMinutes.toString()} Mins",
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Row(children: [
                    MaterialButton(
                      height: 60,
                      color: Colors.green,
                      onPressed: () {
                        setState(() {
                          widget.isActive();
                        });
                        widget.circularCountDownTimer
                            .setDuration(task.durationInMinutes);
                        widget.circularCountDownTimer.startTimer();
                      },
                      child: Text(
                        "Start",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    Padding(padding: EdgeInsets.all(3)),
                    task.isCompleted == false
                        ? MaterialButton(
                            height: 60,
                            color: Colors.blueAccent,
                            onPressed: () {
                              setState(() {
                                x = false;
                              });
                              CoreStorage.completeTask(task);
                            },
                            child: Text(
                              "Complete",
                              style: TextStyle(color: Colors.white),
                            ),
                          )
                        : MaterialButton(
                            height: 60,
                            color: Colors.red,
                            onPressed: () {
                              setState(() {
                                x = false;
                              });
                              CoreStorage.deleteTask(task.id);
                            },
                            child: Text(
                              "Detele",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                  ])
                ])),
      ),
    );
  }
}
