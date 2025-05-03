import 'package:flutter/material.dart';
import 'package:todo_app/version_1/db/data.dart';
import 'package:todo_app/version_1/homescreen.dart';

void main() async {
  Data().loadTasks();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: HomeScreen());
  }
}
