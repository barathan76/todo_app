import 'package:todo_app/model/task.dart';

import 'database.dart';

class TodoApi {
  TodoApi._() : todoDb = TodoDb();
  final TodoDb todoDb;
  static final TodoApi _instance = TodoApi._();
  factory TodoApi() => _instance;
  Future<List<Task>> loadCompletedTask() async {
    List<Task> tasks = await todoDb.tasks;
    List<Task> completed = [];
    for (final Task task in tasks) {
      if (task.isCompleted) {
        completed.add(task);
      }
    }
    return completed;
  }

  Future<List<Task>> loadPendingTask() async {
    List<Task> tasks = await todoDb.tasks;
    List<Task> pending = [];
    for (final Task task in tasks) {
      if (!task.isCompleted) {
        pending.add(task);
      }
    }
    return pending;
  }

  Future<void> updateTask(Task task) async {
    await todoDb.updateTask(task);
  }

  Future<void> deleteTask(Task task) async {
    await todoDb.deleteTask(task);
  }

  Future<void> addTask(Task task) async {
    await todoDb.insertTask(task);
  }
}
