import 'package:flutter/material.dart';
import 'package:todo_app/model/task.dart';
import 'package:todo_app/widgets/buttons/star_button.dart';
import 'package:todo_app/widgets/screens/task_edit.dart';
import 'package:todo_app/widgets/task_tile_model.dart';

class TaskTile extends StatelessWidget {
  const TaskTile({
    super.key,
    required this.dismissed,
    required this.task,
    required this.undo,
    required this.onSave,
    required this.onTap,
    required this.completed,
  });
  final Task task;
  final void Function(Task task) dismissed;
  final Function(Task task) undo;
  final void Function(Task task) onSave;
  final void Function(Task task) completed;
  final bool onTap;

  @override
  Widget build(BuildContext context) {
    TaskTileModel model = TaskTileModel();
    return Padding(
      padding: EdgeInsets.all(8),
      child: Dismissible(
        key: GlobalKey(),
        onDismissed: (direction) {
          model.onDismissed(
            direction,
            context,
            dismissed,
            undo,
            completed,
            onTap,
            task,
          );
        },
        background: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: onTap ? Colors.green : Colors.red,
          ),
        ),
        secondaryBackground: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.red,
          ),
        ),
        child: GestureDetector(
          onTap: () {
            if (onTap) {
              showDialog(
                context: context,
                builder:
                    (context) => TaskEditor(
                      task: task,
                      onSave: (task) {
                        onSave(task);
                      },
                    ),
              );
            }
          },

          child: Container(
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.onPrimary,
              boxShadow: [BoxShadow(offset: Offset.zero, blurRadius: 2)],

              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(
                  task.title!,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w300,
                    color: Colors.deepPurple,
                  ),
                ),

                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'due on',
                      style: TextStyle(fontSize: 10, color: Colors.red),
                    ),
                    Text(
                      task.dueDate == null
                          ? ''
                          : '${task.dueDate!.day}/${task.dueDate!.month}/${task.dueDate!.year}',
                      style: TextStyle(color: Colors.green),
                    ),
                  ],
                ),
                StarButton(task: task),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
