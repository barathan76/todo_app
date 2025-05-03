import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/model/task.dart';
import 'package:todo_app/version_2/bloc/pending_task_bloc/pending_task_bloc.dart';
import 'package:todo_app/version_2/presentation/task_view/task_editor.dart';

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
        BlocProvider.of<PendingTaskBloc>(
          context,
        ).add(UpdatePendingTask(task: task, index: index));
      },
    );
  }
}
