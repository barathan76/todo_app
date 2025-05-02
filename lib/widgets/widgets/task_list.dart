import 'package:flutter/material.dart';
import 'package:todo_app/db/db_api.dart';
import 'package:todo_app/model/task.dart';
import 'package:todo_app/widgets/task_tile.dart';

class TaskList extends StatefulWidget {
  const TaskList({
    super.key,
    required this.task,
    required this.onTap,
    required this.completed,
    required this.undoCompleted,
  });
  final List<Task> task;
  final bool onTap;
  final void Function(Task task) completed;
  final void Function(Task task) undoCompleted;
  @override
  State<TaskList> createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.task.length,
      itemBuilder: (BuildContext context, int index) {
        return TaskTile(
          task: widget.task[index],
          dismissed: (task) {
            widget.task.remove(task);
            TodoApi().deleteTask(task);
          },
          completed: (task) {
            widget.completed(task);
          },
          undo: (task) {
            setState(() {
              widget.task.add(task);
              TodoApi().addTask(task);
            });
            if (widget.onTap) {
              widget.undoCompleted(task);
            }
          },
          onSave: (task) {},
          onTap: widget.onTap,
        );
      },
    );
  }
}
