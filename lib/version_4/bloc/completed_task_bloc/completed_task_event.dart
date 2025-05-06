part of 'completed_task_bloc.dart';

sealed class CompletedTaskEvent {}

class LoadTask extends CompletedTaskEvent {}

class AddTask extends CompletedTaskEvent {
  final Task task;
  AddTask({required this.task});
}

class InsertTask extends CompletedTaskEvent {
  final Task task;
  final int index;
  InsertTask({required this.task, required this.index});
}

class RemoveTask extends CompletedTaskEvent {
  final Task task;

  RemoveTask({required this.task});
}

class DeleteTask extends CompletedTaskEvent {
  final Task task;
  DeleteTask({required this.task});
}
