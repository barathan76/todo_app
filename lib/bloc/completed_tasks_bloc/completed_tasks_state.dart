part of 'completed_tasks_bloc.dart';

enum TaskState { initial, loading, success, error }

final class CompletedTasksState {
  final List<Task> pendingTasks;
  final TaskState taskState;
  CompletedTasksState({
    this.pendingTasks = const [],
    this.taskState = TaskState.initial,
  });
  CompletedTasksState copyWith({
    List<Task> Function()? pendingTasks,
    TaskState Function()? taskState,
  }) {
    return CompletedTasksState(
      pendingTasks: pendingTasks != null ? pendingTasks() : this.pendingTasks,
      taskState: taskState != null ? taskState() : this.taskState,
    );
  }
}
