part of 'create_task_bloc.dart';

final class CreateTaskState {
  String? title;
  String? description;
  DateTime? dueDate;
  bool isImportant;
  CreateTaskState({
    this.title,
    this.description,
    this.dueDate,
    this.isImportant = false,
  });
  CreateTaskState copyWith({
    String Function()? title,
    DateTime Function()? dueDate,
    String Function()? description,
    bool Function()? isImportant,
  }) {
    return CreateTaskState(
      title: title != null ? title() : this.title,
      description: description != null ? description() : this.description,
      dueDate: dueDate != null ? dueDate() : this.dueDate,
      isImportant: isImportant != null ? isImportant() : this.isImportant,
    );
  }

  // @override
  // List<Object?> get props => [title, description, dueDate, isImportant];
}
