import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/version_4/bloc/completed_task_bloc/completed_task_bloc.dart';
import 'package:todo_app/version_4/presentation/widgets/dismissableContainer.dart';
import 'package:todo_app/version_4/presentation/widgets/snackbar_indicator.dart';
import 'package:todo_app/version_4/presentation/widgets/tasktile.dart';
import 'package:todo_repo/todo_repo.dart';

class CompletedTaskTile extends StatelessWidget {
  const CompletedTaskTile({
    super.key,
    required this.completedTasks,
    required this.index,
  });

  final List<Task> completedTasks;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: GlobalKey(),
      background: dismissableContainer(color: Colors.red),
      onDismissed: (direction) {
        final bloc = context.read<CompletedTaskBloc>();
        Task task = completedTasks[index];
        bloc.add(DeleteTask(task: task));
        final scaffoldMessenger = ScaffoldMessenger.of(context);
        scaffoldMessenger.clearSnackBars();
        scaffoldMessenger.showSnackBar(
          snackBarIndicator("Delet", () {
            bloc.add(InsertTask(task: task, index: index));
          }, context),
        );
      },
      child: TaskTile(task: completedTasks[index]),
    );
  }
}
