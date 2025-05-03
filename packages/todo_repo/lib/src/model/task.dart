import 'package:uuid/uuid.dart';

class Task {
  String id;
  String? title;
  String? description;
  DateTime? dueDate;
  bool isCompleted;
  bool isImportant;
  Task({
    this.title,
    this.description,
    this.dueDate,
    this.isCompleted = false,
    this.isImportant = false,
  }) : id = Uuid().v4();

  @override
  String toString() {
    return 'id $id title $title datetime $dueDate ';
  }

  Map<String, dynamic> toMap() => {
    'ID': id,
    'TITLE': title,
    'DUEDATE': dueDate.toString(),
    'DESC': description,
    'IMPORTANT': isImportant ? 1 : 0,
    'ISCOMPLETED': isCompleted ? 1 : 0,
  };
  void updateTask(
    String? title,
    DateTime? dueDate,
    String? desc,
    bool? imp,
    bool? comp,
  ) {
    this.title = title ?? this.title;
    this.dueDate = dueDate ?? this.dueDate;
    description = desc ?? description;
    isImportant = imp ?? isImportant;
    isCompleted = comp ?? isCompleted;
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    Task todo = Task(
      title: map['TITLE'],
      dueDate: DateTime.parse(map['DUEDATE']),
      description: map['DESC'],
      isImportant: map['IMPORTANT'] == 1 ? true : false,
      isCompleted: map['ISCOMPLETED'] == 1 ? true : false,
    );
    todo.id = map['ID'];
    return todo;
  }
}
