import 'package:flutter/material.dart';
import 'package:todo_app/db/db_api.dart';
import 'package:todo_app/model/task.dart';
import 'package:todo_app/widgets/screens/task_edit.dart';
import 'package:todo_app/widgets/widgets/task_list.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Task> pendingTasks = [];
  List<Task> completedTasks = [];
  TodoApi todoApi = TodoApi();

  void loadData() async {
    pendingTasks = await todoApi.loadPendingTask();
    completedTasks = await todoApi.loadCompletedTask();
  }

  @override
  void initState() {
    loadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      initialIndex: 0,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Todo App"),
          bottom: const TabBar(
            tabs: <Widget>[
              Tab(child: Text("Pending")),
              Tab(child: Text("Completed")),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            TaskList(
              task: pendingTasks,
              onTap: true,
              completed: (task) {
                setState(() {
                  completedTasks.add(task);
                  task.isCompleted = true;
                });
                todoApi.updateTask(task);
              },
              undoCompleted: (task) {
                setState(() {
                  completedTasks.remove(task);
                  task.isCompleted = false;
                });
                todoApi.updateTask(task);
              },
            ),
            TaskList(
              task: completedTasks,
              onTap: false,
              completed: (task) {},
              undoCompleted: (task) {},
            ),
          ],
          // children: <Widget>[
          //   FutureBuilder(
          //     future: todoApi.loadPendingTask(),
          //     builder: (context, snapshot) {
          //       if (snapshot.connectionState == ConnectionState.done) {
          //         if (snapshot.hasData) {
          //           pendingTasks = [...snapshot.data!];
          //           return TaskList(
          //             task: pendingTasks,
          //             onTap: true,
          //             completed: (task) {
          //               setState(() {
          //                 completedTasks.add(task);
          //                 task.isCompleted = true;
          //               });
          //               todoApi.updateTask(task);
          //             },
          //             undoCompleted: (task) {
          //               setState(() {
          //                 completedTasks.remove(task);
          //                 task.isCompleted = false;
          //               });
          //               todoApi.updateTask(task);
          //             },
          //           );
          //         }
          //       }
          //       return CircularProgressIndicator();
          //     },
          //   ),
          //   FutureBuilder(
          //     future: todoApi.loadCompletedTask(),
          //     builder: (context, snapshot) {
          //       if (snapshot.connectionState == ConnectionState.done) {
          //         if (snapshot.hasData) {
          //           completedTasks = snapshot.data!;
          //           return TaskList(
          //             task: completedTasks,
          //             onTap: false,
          //             completed: (task) {},
          //             undoCompleted: (task) {},
          //           );
          //         }
          //       }
          //       return CircularProgressIndicator();
          //     },
          //   ),
          // ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showDialog(
              context: context,
              builder:
                  (context) => TaskEditor(
                    onSave: (task) {
                      setState(() {
                        pendingTasks = List.of(pendingTasks)..add(task);
                        todoApi.addTask(task);
                      });
                    },
                  ),
            );
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
