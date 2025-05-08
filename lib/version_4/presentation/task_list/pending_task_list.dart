import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_repo/todo_repo.dart';
import 'package:todo_app/version_4/presentation/task_tile/pending_task_tile.dart';
import 'package:todo_app/version_4/bloc/pending_task_bloc/pending_task_bloc.dart';

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
          if (pendingTasks.isEmpty) {
            return Center(child: Text("No Pending Tasks"));
          }
          return ListView.builder(
            itemCount: pendingTasks.length,
            itemBuilder: (BuildContext context, int index) {
              return PendingTaskTile(pendingTasks: pendingTasks, index: index);
            },
          );
        }
        return Center(child: Text("Error in loading data"));
      },
    );
  }
}
