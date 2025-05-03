import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_repo/todo_repo.dart';
import 'package:todo_app/version_3/bloc/pending_task_bloc/pending_task_bloc.dart';
import 'package:todo_app/version_3/presentation/task_view/task_editor.dart';

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
      id: task.id,
      onSave: (Task task) {
        BlocProvider.of<PendingTaskBloc>(
          context,
        ).add(UpdatePendingTask(task: task, index: index));
      },
    );
  }
}
