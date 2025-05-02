part of 'create_task_bloc.dart';

@immutable
sealed class CreateTaskEvent {}

class SaveTitleEvent extends CreateTaskEvent {
  final String title;
  SaveTitleEvent({required this.title});
}

class SaveDateEvent extends CreateTaskEvent {
  final DateTime date;
  SaveDateEvent({required this.date});
}

class SaveDescEvent extends CreateTaskEvent {
  final String desc;
  SaveDescEvent({required this.desc});
}

class SaveImpEvent extends CreateTaskEvent {
  final bool imp;
  SaveImpEvent({required this.imp});
}

class SaveTaskEvent extends CreateTaskEvent {}
