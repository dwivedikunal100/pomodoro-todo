import 'package:flutter/material.dart';
import 'package:pomodoro_todo/utils/utils.dart';

class Home extends StatefulWidget {
  Home({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _Home createState() => _Home();
}

class _Home extends State<Home> {
  final circularCountDownTimer = CircularCountDownTimer(
    seconds: 30,
    side: 200,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
                decoration: BoxDecoration(color: Constants.primaryColor),
                child: circularCountDownTimer),
            MaterialButton(
              onPressed: () => circularCountDownTimer.pauseTimer(),
              child: Icon(Icons.pause),
            ),
            MaterialButton(
              onPressed: () => circularCountDownTimer.startTimer(),
              child: Icon(Icons.play_arrow),
            ),
            MaterialButton(
              onPressed: () => circularCountDownTimer.resetTimer(),
              child: Icon(Icons.reset_tv),
            ),
          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
