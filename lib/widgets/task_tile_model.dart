import 'package:flutter/material.dart';
import 'package:todo_app/model/task.dart';

class TaskTileModel {
  void onDismissed(
    DismissDirection direction,
    context,
    Function(Task task) dismissed,
    Function(Task task) undo,
    Function(Task task) completed,
    bool onTap,
    Task task,
  ) {
    String text = "delet";
    if (direction == DismissDirection.startToEnd) {
      if (onTap) {
        text = "complet";
        completed(task);
      } else {
        text = "delet";
      }
    }

    dismissed(task);

    final snackBar = SnackBar(
      content: Text("Task is ${text}ed"),
      action: SnackBarAction(
        label: 'Undo',
        onPressed: () {
          undo(task);
        },
      ),
      duration: Duration(seconds: 3),
    );
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
