import 'dart:async';

import 'package:flutter/material.dart';

class CircularCountDownTimer extends StatefulWidget {
  final seconds;

  CircularCountDownTimer({this.seconds});

  @override
  _CircularCountDownTimer createState() => _CircularCountDownTimer();
}

class _CircularCountDownTimer extends State<CircularCountDownTimer> {
  Timer _timer;
  int _start;

  @override
  void initState() {
    _start = widget.seconds;
    super.initState();
    startTimer();
  }

  @override
  void didUpdateWidget(covariant CircularCountDownTimer oldWidget) {
    super.didUpdateWidget(oldWidget);
    _timer.cancel();
    _start = widget.seconds;
    startTimer();
  }

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) => setState(
        () {
          if (_start < 1) {
            timer.cancel();
          } else {
            _start = _start - 1;
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Column(
            children: <Widget>[
              SizedBox(
                height: 200.0,
                child: Stack(
                  children: [
                    Center(
                      child: Container(
                        width: 200,
                        height: 200,
                        child: new CircularProgressIndicator(
                          value: remainingTime(),
                          backgroundColor: Colors.grey,
                          strokeWidth: 10,
                        ),
                      ),
                    ),
                    Center(
                        child: Text(
                      Duration(seconds: _start).toString().substring(2, 7),
                      style: TextStyle(fontSize: 30),
                    )),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  double remainingTime() {
    double maxTime = widget.seconds.toDouble();
    double currentTime = _start.toDouble();
    return currentTime / maxTime;
  }
}
