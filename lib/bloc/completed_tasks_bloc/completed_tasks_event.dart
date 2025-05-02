part of 'completed_tasks_bloc.dart';

@immutable
sealed class CompletedTasksEvent {}

class AddTask extends CompletedTasksEvent {
  AddTask({required this.task});
  final Task task;
}

class LoadTask extends CompletedTasksEvent {}
