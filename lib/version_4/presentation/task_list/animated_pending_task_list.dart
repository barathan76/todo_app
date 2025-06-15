import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/version_4/presentation/task_tile/animated_pending_task_tile.dart';
import 'package:todo_repo/todo_repo.dart';
import 'package:todo_app/version_4/bloc/pending_task_bloc/pending_task_bloc.dart';

class AnimatedPendingTaskList extends StatefulWidget {
  const AnimatedPendingTaskList({super.key});

  @override
  State<StatefulWidget> createState() => _AnimatedPendingTaskListState();
}

class _AnimatedPendingTaskListState extends State<AnimatedPendingTaskList> {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  List<Task> pendingTasks = [];
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PendingTaskBloc, PendingTaskState>(
      listener: (context, state) {
        if (state is PendingTaskLoaded || state is PendingTaskUpdated) {
          print("updated");
          List<Task> currentTasks = state.pendingTask;
          List<int> newIndexes =
              currentTasks
                  .asMap()
                  .entries
                  .where((entry) => !pendingTasks.contains(entry.value))
                  .map((entry) => entry.key)
                  .toList();

          if (_listKey.currentState != null) {
            for (int i in newIndexes) {
              _listKey.currentState!.insertItem(i);
            }
          }
          pendingTasks = currentTasks;
        }
      },
      builder: (context, state) {
        if (state is PendingTaskInitial) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            context.read<PendingTaskBloc>().add(LoadPendingTask());
          });
          return Center(child: CircularProgressIndicator());
        }

        if (state is PendingTaskLoaded || state is PendingTaskUpdated) {
          pendingTasks = state.pendingTask;
          if (pendingTasks.isEmpty) {
            return Center(child: Text("No Pending Tasks"));
          }
          return AnimatedList(
            key: _listKey,
            initialItemCount: pendingTasks.length,
            itemBuilder: (context, index, animation) {
              return SlideTransition(
                position: animation.drive(
                  Tween<Offset>(
                    begin: const Offset(1.0, 0.0), // Slide in from right
                    end: Offset.zero, // Stop at final position
                  ).chain(CurveTween(curve: Curves.easeOut)),
                ),
                child: ScaleTransition(
                  scale: animation.drive(Tween<double>(begin: 0.5, end: 1.0)),
                  child: AnimatedPendingTaskTile(
                    index: index,
                    listKey: _listKey,
                    pendingTasks: pendingTasks,
                  ),
                ),
              );
            },
          );
          // return ListView.builder(
          //   itemCount: pendingTasks.length,
          //   itemBuilder: (BuildContext context, int index) {
          //     return AnimatedPendingTaskTile(
          //       pendingTasks: pendingTasks,
          //       index: index,
          //       listKey: _listKey,
          //     );
          //   },
          // );
        }
        return Center(child: Text("Error in loading data"));
      },
    );
  }
}
