import 'package:flutter/material.dart';
import 'package:todo_app/version_3/presentation/task_list/completed_task_list.dart';
import 'package:todo_app/version_3/presentation/task_view/create_task.dart';
import 'package:todo_app/version_3/presentation/task_list/pending_task_list.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
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
        body: TabBarView(children: [PendingTaskList(), CompletedTaskList()]),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showDialog(context: context, builder: (context) => CreateTask());
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
