import 'package:flutter/material.dart';
import 'package:todo_app/model/task.dart';
import 'package:todo_app/version_1/db/data.dart';
import 'package:todo_app/version_1/presentation/widgets/snackbar_indicator.dart';
import 'package:todo_app/version_1/presentation/widgets/tasktile.dart';
import 'package:todo_app/version_1/presentation/widgets/dismissableContainer.dart';

class CompletedTaskList extends StatefulWidget {
  const CompletedTaskList({super.key});

  @override
  State<CompletedTaskList> createState() => _CompletedTaskListState();
}

class _CompletedTaskListState extends State<CompletedTaskList> {
  Data data = Data();

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: data.completedTasks.length,
      itemBuilder: (BuildContext context, int index) {
        return Dismissible(
          key: GlobalKey(),
          background: dismissableContainer(color: Colors.red),
          onDismissed: (direction) {
            Task task = data.completedTasks[index];
            setState(() {
              data.completedTasks.removeAt(index);
              ScaffoldMessenger.of(context).clearSnackBars();
              ScaffoldMessenger.of(context).showSnackBar(
                snackBarIndicator("Delet", () {
                  data.completedTasks.insert(index, task);
                }),
              );
            });
          },
          child: TaskTile(task: data.completedTasks[index]),
        );
      },
    );
  }
}
