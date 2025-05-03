import 'package:flutter/material.dart';
import 'package:todo_app/model/task.dart';
import 'package:todo_app/version_1/presentation/task_view/task_editor.dart';
import 'package:todo_app/version_1/db/data.dart';

class CreateTask extends StatelessWidget {
  const CreateTask({super.key});

  @override
  Widget build(BuildContext context) {
    return TaskEditor(
      title: "Enter title",
      desc: "Enter description",
      date: DateTime.now(),
      isImp: false,
      onSave: (Task task) {
        Data().addPendingTask(task);
      },
    );
  }
}
