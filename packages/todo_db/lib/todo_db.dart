export 'src/todo_database.dart';

abstract class TodoDb {
  Future<void> initialize();
  Future<List<Map<String, dynamic>>> loadPendingTask();
  Future<void> insertTask(Map<String, dynamic> task);
  Future<List<Map<String, dynamic>>> loadCompletedTask();
  Future<void> deleteTask(Map<String, dynamic> task);
  Future<void> updateTask(Map<String, dynamic> task);
}
