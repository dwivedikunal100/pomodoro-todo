import 'dart:io';

import 'package:flutter/material.dart';
import 'package:pomodoro_todo/app/app.dart';
import 'package:window_size/window_size.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    setWindowMinSize(Size(375, 500));
  }
  runApp(PomodoroTodo());
}
