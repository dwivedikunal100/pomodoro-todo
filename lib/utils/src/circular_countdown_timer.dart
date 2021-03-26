import 'dart:async';

import 'package:flutter/material.dart';

class CircularCountDownTimer extends StatefulWidget {
  final double side;
  final _CircularCountDownTimer _child = _CircularCountDownTimer();

  CircularCountDownTimer({this.side});
  void startTimer() {
    _child.startTimer();
  }

  void resetTimer() {
    _child.resetTimer();
  }

  void pauseTimer() {
    _child.pauseTimer();
  }

  void setColor(Color color) {
    _child.setColor(color);
  }

  void setDuration(int minutes) {
    _child.setDuration(minutes);
  }

  @override
  _CircularCountDownTimer createState() => _child;
}

class _CircularCountDownTimer extends State<CircularCountDownTimer> {
  Timer _timer;
  int _maxTime = 0;
  int _currentTime = 0;
  Color _progressColor = Colors.redAccent;

  void setDuration(int minutes) {
    setState(() {
      _maxTime = minutes * 60;
      _currentTime = _maxTime;
    });
  }

  void pauseTimer() {
    if (_timer != null) {
      _timer.cancel();
    }
  }

  void resetTimer() {
    if (_timer != null) {
      _timer.cancel();
    }
    setState(() {
      _currentTime = _maxTime;
    });
  }

  void setColor(Color color) {
    setState(() {
      _progressColor = color;
    });
  }

  void startTimer() {
    if (_timer != null && _timer.isActive) return;
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) => setState(
        () {
          if (_currentTime < 1) {
            timer.cancel();
          } else {
            _currentTime = _currentTime - 1;
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    resetTimer();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Column(
            children: <Widget>[
              SizedBox(
                height: widget.side,
                width: widget.side,
                child: Stack(
                  children: [
                    Center(
                      child: Container(
                        width: widget.side,
                        height: widget.side,
                        child: new CircularProgressIndicator(
                          value: remainingTime(),
                          backgroundColor: Colors.grey,
                          valueColor:
                              new AlwaysStoppedAnimation<Color>(_progressColor),
                          strokeWidth: 10,
                        ),
                      ),
                    ),
                    Center(
                        child: Text(
                      Duration(seconds: _currentTime)
                          .toString()
                          .substring(2, 7),
                      style: TextStyle(
                          fontSize: (widget.side * 0.2), color: Colors.white),
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
    if (_maxTime == 0) return 0;
    double maxTime = _maxTime.toDouble();
    double currentTime = _currentTime.toDouble();
    return currentTime / maxTime;
  }
}
