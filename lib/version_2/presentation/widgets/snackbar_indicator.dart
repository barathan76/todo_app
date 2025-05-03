import 'package:flutter/material.dart';

SnackBar snackBarIndicator(String text, void Function() undo) {
  return SnackBar(
    content: Text("Task is ${text}ed"),
    action: SnackBarAction(
      label: 'Undo',
      onPressed: () {
        undo();
      },
    ),
    duration: Duration(seconds: 3),
  );
}
