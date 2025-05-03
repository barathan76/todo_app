import 'package:todo_repo/todo_repo.dart';
import 'package:todo_db/todo_db.dart';

class TodoRepository extends TodoRepo {
  TodoRepository._() : database = TodoDatabase();
  static final TodoRepository _instance = TodoRepository._();
  factory TodoRepository() => _instance;
  final TodoDb database;

  @override
  void addTask(Task task) async {
    await database.insertTask(task.toMap());
  }

  @override
  void deleteTask(Task task) async {
    await database.deleteTask(task.toMap());
  }

  @override
  void updateTask(Task task) async {
    await database.updateTask(task.toMap());
  }

  @override
  Future<List<Task>> get completedTask async {
    return await database.loadCompletedTask().then(
      (list) => list.map((task) => Task.fromMap(task)).toList(),
    );
  }

  @override
  Future<List<Task>> get pendingTask async {
    return await database.loadPendingTask().then(
      (list) => list.map((task) => Task.fromMap(task)).toList(),
    );
  }
}
