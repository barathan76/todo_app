export 'src/todo_repository.dart';
export 'src/model/task.dart';
import 'package:todo_repo/src/model/task.dart';

abstract class TodoRepo {
  Future<List<Task>> get pendingTask;
  Future<List<Task>> get completedTask;
  void addTask(Task task);
  void updateTask(Task task);
  void deleteTask(Task task);
}
