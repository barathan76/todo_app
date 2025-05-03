import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_repo/todo_repo.dart';
import 'package:todo_app/version_3/bloc/completed_task_bloc/completed_task_bloc.dart';
import 'package:todo_app/version_3/bloc/pending_task_bloc/pending_task_bloc.dart';
import 'package:todo_app/version_3/presentation/task_view/edit_task.dart';
import 'package:todo_app/version_3/presentation/widgets/snackbar_indicator.dart';
import 'package:todo_app/version_3/presentation/widgets/tasktile.dart';
import 'package:todo_app/version_3/presentation/widgets/dismissableContainer.dart';

class PendingTaskList extends StatelessWidget {
  const PendingTaskList({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PendingTaskBloc, PendingTaskState>(
      builder: (context, state) {
        if (state is PendingTaskInitial) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            context.read<PendingTaskBloc>().add(LoadPendingTask());
          });
          return Center(child: CircularProgressIndicator());
        }

        if (state is PendingTaskLoaded || state is PendingTaskUpdated) {
          List<Task> pendingTasks = state.pendingTask;
          return ListView.builder(
            itemCount: pendingTasks.length,
            itemBuilder: (BuildContext context, int index) {
              return Dismissible(
                key: GlobalKey(),
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
                      snackBarIndicator("Complet", () {
                        completedTaskBloc.add(RemoveTask(task: task));
                        pendingTaskBloc.add(
                          InsertPendingTask(task: task, index: index),
                        );
                      }),
                    );
                  } else {
                    pendingTaskBloc.add(RemovePendingTask(task: task));
                    messenger.clearSnackBars();
                    messenger.showSnackBar(
                      snackBarIndicator("Delet", () {
                        pendingTaskBloc.add(
                          InsertPendingTask(task: task, index: index),
                        );
                      }),
                    );
                  }
                },
                child: GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder:
                          (context) =>
                              EditTask(task: pendingTasks[index], index: index),
                    );
                  },
                  child: TaskTile(task: pendingTasks[index]),
                ),
              );
            },
          );
        }
        return Center(child: Text("Error in loading data"));
      },
    );
  }
}
