import 'package:flutter/material.dart';
import 'package:todo_app/model/task.dart';
import 'package:todo_app/version_2/presentation/widgets/starbutton.dart';

class TaskTile extends StatelessWidget {
  const TaskTile({super.key, required this.task});
  final Task task;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8),
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
            if (!task.isCompleted)
              StarButton(
                onPressed: (bool mark) {
                  task.isImportant = mark;
                },
                initial: task.isImportant,
              ),
          ],
        ),
      ),
    );
  }
}
