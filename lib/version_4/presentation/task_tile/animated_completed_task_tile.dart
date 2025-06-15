import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/version_4/bloc/completed_task_bloc/completed_task_bloc.dart';
import 'package:todo_app/version_4/presentation/widgets/dismissableContainer.dart';
import 'package:todo_app/version_4/presentation/widgets/snackbar_indicator.dart';
import 'package:todo_app/version_4/presentation/widgets/tasktile.dart';
import 'package:todo_repo/todo_repo.dart';

class AnimatedCompletedTaskTile extends StatelessWidget {
  const AnimatedCompletedTaskTile({
    super.key,
    required this.completedTasks,
    required this.index,
    required this.listKey,
  });

  final List<Task> completedTasks;
  final int index;
  final GlobalKey<AnimatedListState> listKey;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: GlobalKey(),
      background: dismissableContainer(color: Colors.red),
      onDismissed: (direction) {
        final bloc = context.read<CompletedTaskBloc>();
        Task task = completedTasks[index];
        deleteTask(task);
        bloc.add(DeleteTask(task: task));
        final scaffoldMessenger = ScaffoldMessenger.of(context);
        scaffoldMessenger.clearSnackBars();
        scaffoldMessenger.showSnackBar(
          snackBarIndicator("Delet", () {
            insertTask();
            bloc.add(InsertTask(task: task, index: index));
          }, context),
        );
      },
      child: TaskTile(task: completedTasks[index]),
    );
  }

  void insertTask() {
    listKey.currentState!.insertItem(
      index,
      duration: Duration(milliseconds: 500),
    );
    print("inserted");
  }

  void deleteTask(Task task) {
    listKey.currentState!.removeItem(
      index,
      (context, animation) =>
          SizeTransition(sizeFactor: animation, child: Container()),
    );
    print("deleted");
  }
}
