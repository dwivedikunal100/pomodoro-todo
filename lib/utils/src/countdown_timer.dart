import 'dart:async';

import 'package:flutter/material.dart';

class CountDownTimer extends StatefulWidget {
  final retry;

  CountDownTimer({this.retry});

  @override
  _CountDownTimer createState() => _CountDownTimer();
}

class _CountDownTimer extends State<CountDownTimer> {
  Timer _timer;
  int _start = 120;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  void didUpdateWidget(covariant CountDownTimer oldWidget) {
    super.didUpdateWidget(oldWidget);
    _timer.cancel();
    _start = 120;
    int x = widget.retry;
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
    return Text(
      Duration(seconds: _start).toString().substring(2, 7),
    );
  }
}
