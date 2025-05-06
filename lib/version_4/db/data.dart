import 'package:todo_app/misc/sample_data.dart';
import 'package:todo_repo/todo_repo.dart';

class Data {
  Data._();
  static final Data _instance = Data._();
  factory Data() => _instance;
  final List<Task> _pendingTasks = [];
  final List<Task> _completedTasks = [];

  void loadPendingTasks() {
    for (var task in sampleData) {
      _pendingTasks.add(
        Task(
          title: task.title,
          description: task.description,
          dueDate: task.dueDate,
          isCompleted: false,
          isImportant: task.isImportant,
        ),
      );
    }
  }

  void loadCompletedTasks() {
    for (var task in sampleData) {
      _completedTasks.add(
        Task(
          title: task.title,
          description: task.description,
          dueDate: task.dueDate,
          isCompleted: true,
          isImportant: task.isImportant,
        ),
      );
    }
  }

  void loadTasks() {
    loadCompletedTasks();
    loadPendingTasks();
  }

  void updatePendingTask(Task task, int index) {
    _pendingTasks.removeAt(index);
    _pendingTasks.insert(index, task);
  }

  void addPendingTask(Task task) {
    _pendingTasks.add(task);
  }

  List<Task> get pendingTasks => _pendingTasks;
  List<Task> get completedTasks => _completedTasks;
}
