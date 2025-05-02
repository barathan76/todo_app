part of 'pending_tasks_bloc.dart';

enum TaskState { initial, loading, success, error }

final class PendingTasksState {
  final List<Task> pendingTasks;
  final TaskState taskState;
  PendingTasksState({
    this.pendingTasks = const [],
    this.taskState = TaskState.initial,
  });
  PendingTasksState copyWith({
    List<Task> Function()? pendingTasks,
    TaskState Function()? taskState,
  }) {
    return PendingTasksState(
      pendingTasks: pendingTasks != null ? pendingTasks() : this.pendingTasks,
      taskState: taskState != null ? taskState() : this.taskState,
    );
  }
}
