import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_repo/todo_repo.dart';
import 'package:todo_app/version_4/bloc/pending_task_bloc/pending_task_bloc.dart';
import 'package:todo_app/version_4/presentation/task_view/task_editor.dart';

class CreateTask extends StatelessWidget {
  const CreateTask({super.key, required this.onSave});
  final void Function() onSave;
  @override
  Widget build(BuildContext context) {
    return TaskEditor(
      title: "",
      desc: "",
      date: DateTime.now(),
      isImp: false,
      onSave: (Task task) {
        onSave();
        BlocProvider.of<PendingTaskBloc>(
          context,
        ).add(AddPendingTask(task: task));
      },
    );
  }
}
