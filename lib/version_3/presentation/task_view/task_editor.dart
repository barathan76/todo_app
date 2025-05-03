import 'package:flutter/material.dart';
import 'package:todo_repo/todo_repo.dart';
import 'package:todo_app/version_3/presentation/widgets/starbutton.dart';
import 'package:todo_app/version_3/presentation/widgets/navigation_button.dart';

class TaskEditor extends StatefulWidget {
  const TaskEditor({
    super.key,
    this.id,
    required this.title,
    required this.desc,
    required this.isImp,
    required this.date,
    required this.onSave,
  });
  final String? id;
  final String title;
  final String desc;
  final bool isImp;
  final DateTime date;
  final void Function(Task task) onSave;

  @override
  State<TaskEditor> createState() => _TaskEditorState();
}

class _TaskEditorState extends State<TaskEditor> {
  TextEditingController titleController = TextEditingController();
  DateTime? dueDate;
  TextEditingController descConroller = TextEditingController();
  bool isImp = false;

  @override
  void initState() {
    titleController.text = widget.title;
    dueDate = widget.date;
    isImp = widget.isImp;
    descConroller.text = widget.desc;
    super.initState();
  }

  @override
  void dispose() {
    titleController.dispose();
    descConroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: titleController,
                    onChanged: (value) => titleController.text,
                    decoration: InputDecoration(
                      label: Text("Title"),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
                StarButton(
                  onPressed: (mark) {
                    setState(() {
                      isImp = mark;
                    });
                  },
                  initial: isImp,
                ),
              ],
            ),

            Row(
              children: [
                Text(
                  dueDate != null
                      ? "Due on ${dueDate!.day}/${dueDate!.month}/${dueDate!.year}"
                      : 'Select due date',
                ),
                SizedBox(width: 2),

                IconButton(
                  icon: Icon(Icons.calendar_month),
                  onPressed: () async {
                    await showDatePicker(
                      context: context,
                      firstDate: DateTime(DateTime.now().month - 5),
                      lastDate: DateTime(DateTime.now().year + 5),
                    ).then((value) {
                      if (value != null) {
                        setState(() {
                          dueDate = value;
                        });
                      }
                    });
                  },
                ),
              ],
            ),
            Text("Description "),
            Expanded(
              child: TextField(
                onChanged: (value) => descConroller.text,
                decoration: InputDecoration(border: OutlineInputBorder()),
                keyboardType: TextInputType.multiline,
                maxLines: 100,
                controller: descConroller,
              ),
            ),
            SizedBox(height: 5),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                NavigationButton(
                  text: 'Close',
                  color: Colors.red,
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                NavigationButton(
                  text: 'Save Task',
                  color: Colors.green,
                  onPressed: () {
                    Task task = Task(
                      description: descConroller.text,
                      dueDate: dueDate,
                      title: titleController.text,
                      isImportant: isImp,
                    );
                    if (widget.id != null) task.id = widget.id!;
                    widget.onSave(task);
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
