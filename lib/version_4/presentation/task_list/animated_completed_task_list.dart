import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/version_4/bloc/completed_task_bloc/completed_task_bloc.dart';
import 'package:todo_app/version_4/presentation/task_tile/animated_completed_task_tile.dart';
import 'package:todo_repo/todo_repo.dart';

class AnimatedCompletedTaskList extends StatefulWidget {
  const AnimatedCompletedTaskList({super.key});

  @override
  State<AnimatedCompletedTaskList> createState() =>
      _AnimatedCompletedTaskListState();
}

class _AnimatedCompletedTaskListState extends State<AnimatedCompletedTaskList> {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  List<Task> completedTasks = [];
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
          completedTasks = state.completedTask;
          if (completedTasks.isEmpty) {
            return Center(child: Text("No Completed Tasks"));
          }
          return AnimatedList(
            key: _listKey,
            initialItemCount: completedTasks.length,
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
                  child: AnimatedCompletedTaskTile(
                    completedTasks: completedTasks,
                    index: index,
                    listKey: _listKey,
                  ),
                ),
              );
            },
          );
        }
        return Center(child: Text("error in loading"));
      },
    );
  }
}
