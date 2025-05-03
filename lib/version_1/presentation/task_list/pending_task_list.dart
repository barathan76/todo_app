import 'package:flutter/material.dart';
import 'package:todo_app/model/task.dart';
import 'package:todo_app/version_1/db/data.dart';
import 'package:todo_app/version_1/presentation/task_view/edit_task.dart';
import 'package:todo_app/version_1/presentation/widgets/snackbar_indicator.dart';
import 'package:todo_app/version_1/presentation/widgets/tasktile.dart';
import 'package:todo_app/version_1/presentation/widgets/dismissableContainer.dart';

class PendingTaskList extends StatefulWidget {
  const PendingTaskList({super.key});

  @override
  State<PendingTaskList> createState() => _PendingTaskListState();
}

class _PendingTaskListState extends State<PendingTaskList> {
  Data data = Data();
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: data.pendingTasks.length,
      itemBuilder: (BuildContext context, int index) {
        return Dismissible(
          key: GlobalKey(),
          background: dismissableContainer(color: Colors.green),
          secondaryBackground: dismissableContainer(color: Colors.red),
          onDismissed: (direction) {
            Task task = data.pendingTasks[index];
            if (direction == DismissDirection.startToEnd) {
              setState(() {
                task.isCompleted = true;
                data.pendingTasks.removeAt(index);
                data.completedTasks.add(task);
                ScaffoldMessenger.of(context).clearSnackBars();
                ScaffoldMessenger.of(context).showSnackBar(
                  snackBarIndicator("Complet", () {
                    task.isCompleted = false;
                    data.completedTasks.remove(task);
                    data.pendingTasks.insert(index, task);
                  }),
                );
              });
            } else {
              setState(() {
                data.pendingTasks.removeAt(index);
                ScaffoldMessenger.of(context).clearSnackBars();
                ScaffoldMessenger.of(context).showSnackBar(
                  snackBarIndicator("Delet", () {
                    data.pendingTasks.insert(index, task);
                  }),
                );
              });
            }
          },
          child: GestureDetector(
            onTap: () {
              showDialog(
                context: context,
                builder:
                    (context) =>
                        EditTask(task: data.pendingTasks[index], index: index),
              );
            },
            child: TaskTile(task: data.pendingTasks[index]),
          ),
        );
      },
    );
  }
}
