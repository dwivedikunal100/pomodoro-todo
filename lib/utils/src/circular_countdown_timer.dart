import 'dart:async';

import 'package:flutter/material.dart';

class CircularCountDownTimer extends StatefulWidget {
  final int seconds;
  final double side;
  final _CircularCountDownTimer _child = _CircularCountDownTimer();

  CircularCountDownTimer({this.seconds, this.side});
  void startTimer() {
    _child.startTimer();
  }

  void resetTimer() {
    _child.resetTimer();
  }

  void pauseTimer() {
    _child.pauseTimer();
  }

  @override
  _CircularCountDownTimer createState() => _child;
}

class _CircularCountDownTimer extends State<CircularCountDownTimer> {
  Timer _timer;
  int _start;

  @override
  void initState() {
    _start = widget.seconds;
    super.initState();
  }

  @override
  void didUpdateWidget(covariant CircularCountDownTimer oldWidget) {
    super.didUpdateWidget(oldWidget);
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
      _start = widget.seconds;
    });
  }

  void startTimer() {
    if (_timer != null && _timer.isActive) return;
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
                          strokeWidth: 10,
                        ),
                      ),
                    ),
                    Center(
                        child: Text(
                      Duration(seconds: _start).toString().substring(2, 7),
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
    double maxTime = widget.seconds.toDouble();
    double currentTime = _start.toDouble();
    return currentTime / maxTime;
  }
}
