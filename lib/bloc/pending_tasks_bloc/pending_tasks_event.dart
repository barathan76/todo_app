part of 'pending_tasks_bloc.dart';

@immutable
sealed class PendingTasksEvent {}

class AddTask extends PendingTasksEvent {
  AddTask({required this.task});
  final Task task;
}

class LoadTask extends PendingTasksEvent {}

class DeleteTask extends PendingTasksEvent {
  DeleteTask({required this.task});
  final Task task;
}
