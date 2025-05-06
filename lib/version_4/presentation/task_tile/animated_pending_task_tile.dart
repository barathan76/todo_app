import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/version_4/bloc/completed_task_bloc/completed_task_bloc.dart';
import 'package:todo_app/version_4/bloc/pending_task_bloc/pending_task_bloc.dart';
import 'package:todo_app/version_4/presentation/task_view/edit_task.dart';
import 'package:todo_app/version_4/presentation/widgets/dismissableContainer.dart';
import 'package:todo_app/version_4/presentation/widgets/snackbar_indicator.dart';
import 'package:todo_app/version_4/presentation/widgets/tasktile.dart';
import 'package:todo_repo/todo_repo.dart';

class AnimatedPendingTaskTile extends StatelessWidget {
  const AnimatedPendingTaskTile({
    super.key,
    required this.pendingTasks,
    required this.index,
    required this.insertTask,
  });
  final List<Task> pendingTasks;
  final int index;
  final void Function(int index) insertTask;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(pendingTasks[index].id),
      background: dismissableContainer(color: Colors.green),
      secondaryBackground: dismissableContainer(color: Colors.red),
      onDismissed: (direction) {
        final pendingTaskBloc = context.read<PendingTaskBloc>();
        final completedTaskBloc = context.read<CompletedTaskBloc>();
        final messenger = ScaffoldMessenger.of(context);
        Task task = pendingTasks[index];
        if (direction == DismissDirection.startToEnd) {
          pendingTaskBloc.add(RemovePendingTask(task: task));
          completedTaskBloc.add(AddTask(task: task));
          messenger.clearSnackBars();
          messenger.showSnackBar(
            snackBarIndicator("Completed", () {
              completedTaskBloc.add(RemoveTask(task: task));
              pendingTaskBloc.add(InsertPendingTask(task: task, index: index));
            }, context),
          );
        } else {
          pendingTaskBloc.add(RemovePendingTask(task: task));
          messenger.clearSnackBars();
          messenger.showSnackBar(
            snackBarIndicator("Deleted", () {
              pendingTaskBloc.add(InsertPendingTask(task: task, index: index));
            }, context),
          );
        }
      },
      child: GestureDetector(
        onTap: () {
          showDialog(
            context: context,
            builder:
                (context) => EditTask(task: pendingTasks[index], index: index),
          );
        },
        child: TaskTile(task: pendingTasks[index]),
      ),
    );
  }
}
