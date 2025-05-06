import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_repo/todo_repo.dart';
import 'package:todo_app/version_4/bloc/completed_task_bloc/completed_task_bloc.dart';
import 'package:todo_app/version_4/presentation/widgets/snackbar_indicator.dart';
import 'package:todo_app/version_4/presentation/widgets/tasktile.dart';
import 'package:todo_app/version_4/presentation/widgets/dismissableContainer.dart';

class CompletedTaskList extends StatelessWidget {
  const CompletedTaskList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CompletedTaskBloc, CompletedTaskState>(
      builder: (context, state) {
        if (state is CompletedTaskInitial) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            context.read<CompletedTaskBloc>().add(LoadTask());
          });
          return Center(child: CircularProgressIndicator());
        }
        if (state is CompletedTaskLoaded || state is CompletedTaskUpdated) {
          List<Task> completedTask = state.completedTask;
          return ListView.builder(
            itemCount: completedTask.length,
            itemBuilder: (BuildContext context, int index) {
              return Dismissible(
                key: GlobalKey(),
                background: dismissableContainer(color: Colors.red),
                onDismissed: (direction) {
                  final bloc = context.read<CompletedTaskBloc>();
                  Task task = completedTask[index];
                  bloc.add(DeleteTask(task: task));
                  final scaffoldMessenger = ScaffoldMessenger.of(context);
                  scaffoldMessenger.clearSnackBars();
                  scaffoldMessenger.showSnackBar(
                    snackBarIndicator("Delet", () {
                      bloc.add(InsertTask(task: task, index: index));
                    }, context),
                  );
                },
                child: TaskTile(task: completedTask[index]),
              );
            },
          );
        }
        return Center(child: Text("error in loading"));
      },
    );
  }
}
