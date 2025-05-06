part of 'pending_task_bloc.dart';

sealed class PendingTaskEvent {}

class LoadPendingTask extends PendingTaskEvent {}

class AddPendingTask extends PendingTaskEvent {
  final Task task;
  AddPendingTask({required this.task});
}

class RemovePendingTask extends PendingTaskEvent {
  final Task task;
  RemovePendingTask({required this.task});
}

class InsertPendingTask extends PendingTaskEvent {
  final Task task;
  final int index;
  InsertPendingTask({required this.task, required this.index});
}

class UpdatePendingTask extends PendingTaskEvent {
  final Task task;
  final int index;
  UpdatePendingTask({required this.task, required this.index});
}
