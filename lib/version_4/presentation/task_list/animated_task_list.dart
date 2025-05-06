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

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PendingTaskBloc, PendingTaskState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is PendingTaskInitial) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            context.read<PendingTaskBloc>().add(LoadPendingTask());
          });
          return Center(child: CircularProgressIndicator());
        }

        if (state is PendingTaskLoaded || state is PendingTaskUpdated) {
          List<Task> pendingTasks = state.pendingTask;
          return AnimatedList(
            key: _listKey,
            initialItemCount: pendingTasks.length,
            itemBuilder: (context, index, animation) {
              return _buildTaskTile(context, pendingTasks, index, animation);
            },
          );
        }
        return Center(child: Text("Error in loading data"));
      },
    );
  }

  Widget _buildTaskTile(
    BuildContext context,
    List<Task> pendingTasks,
    int index,
    Animation<double> animation,
  ) {
    return SizeTransition(
      sizeFactor: animation,
      child: AnimatedPendingTaskTile(
        pendingTasks: pendingTasks,
        index: index,
        insertTask: _insertTask,
      ),
    );
  }

  void _insertTask(int index) {
    _listKey.currentState?.insertItem(index);
  }
}
