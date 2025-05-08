import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/version_4/presentation/task_tile/completed_task_tile.dart';
import 'package:todo_repo/todo_repo.dart';
import 'package:todo_app/version_4/bloc/completed_task_bloc/completed_task_bloc.dart';

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
          List<Task> completedTasks = state.completedTask;
          if (completedTasks.isEmpty) {
            return Center(child: Text("No Completed Tasks"));
          }
          return ListView.builder(
            itemCount: completedTasks.length,
            itemBuilder: (BuildContext context, int index) {
              return CompletedTaskTile(
                completedTasks: completedTasks,
                index: index,
              );
            },
          );
        }
        return Center(child: Text("error in loading"));
      },
    );
  }
}
