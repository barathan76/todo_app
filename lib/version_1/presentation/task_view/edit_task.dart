import 'package:flutter/material.dart';
import 'package:todo_app/model/task.dart';
import 'package:todo_app/version_1/db/data.dart';
import 'package:todo_app/version_1/presentation/task_view/task_editor.dart';

class EditTask extends StatelessWidget {
  const EditTask({super.key, required this.task, required this.index});
  final Task task;
  final int index;

  @override
  Widget build(BuildContext context) {
    return TaskEditor(
      title: task.title!,
      desc: task.description!,
      date: task.dueDate!,
      isImp: task.isImportant,
      onSave: (Task task) {
        Data().updatePendingTask(task, index);
      },
    );
  }
}
