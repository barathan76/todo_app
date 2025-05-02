import 'package:todo_app/model/task.dart';

final date = DateTime.now();
final sampleData = [
  Task(
    title: "Sample1",
    description: "Sample task to be completed",
    dueDate: date,
  ),
  Task(
    title: "Sample2",
    description: "Sample task to be completed by the end",
    dueDate: date,
    isImportant: true,
  ),
  Task(
    title: "Sample3",
    description: "Sample task to be completed by the end",
    dueDate: date,
  ),
];
