import 'package:flutter/material.dart';
import 'package:todo_app/model/task.dart';
import 'package:todo_app/widgets/buttons/navigation_button.dart';
import 'package:todo_app/widgets/buttons/star_button.dart';

class TaskEditor extends StatefulWidget {
  const TaskEditor({super.key, required this.onSave, this.task});
  final Task? task;
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
    if (widget.task != null) {
      titleController.text = widget.task!.title!;
      dueDate = widget.task!.dueDate;
      isImp = widget.task!.isImportant;
      descConroller.text = widget.task!.description!;
    }
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
                  check: isImp,
                  onPressed: () {
                    setState(() {
                      isImp = !isImp;
                    });
                  },
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
                    widget.onSave(
                      Task(
                        description: descConroller.text,
                        dueDate: dueDate,
                        title: titleController.text,
                        isImportant: isImp,
                      ),
                    );
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
      //         Row(
      //           mainAxisSize: MainAxisSize.max,
      //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //           children: [
      //             NavigationButton(
      //               text: 'Close',
      //               color: Colors.red,
      //               onPressed: () {
      //                 Navigator.of(context).pop();
      //               },
      //             ),
      //             NavigationButton(
      //               text: 'Save Task',
      //               color: Colors.green,
      //               onPressed: () {
      //                 Navigator.of(context).pop();
      //               },
      //             ),
      //           ],
      //         ),
      //       ],
      // });
      
//       Scaffold(
//         appBar: AppBar(),
//         body: Padding(
//           padding: EdgeInsets.all(8),
//           child: Column(
//             children: [
//               BlocBuilder(
//                 builder: (context, state) {
//                   final taskState = context.watch<CreateTaskBloc>().state;
//                   final taskbloc = context.read<CreateTaskBloc>();
//                   return Column(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       Expanded(
//                         child: Row(
//                           mainAxisSize: MainAxisSize.max,
//                           children: [
//                             Expanded(
//                               child: TextFormField(
//                                 initialValue: taskState.title ?? "Enter title",
//                                 onChanged:
//                                     (value) => taskbloc.add(
//                                       SaveTitleEvent(title: value),
//                                     ),
//                                 decoration: InputDecoration(
//                                   label: Text("Title"),
//                                   border: OutlineInputBorder(
//                                     borderRadius: BorderRadius.circular(10),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                             StarButton(),
//                           ],
//                         ),
//                       ),
//                       Row(
//                         children: [
//                           Text(
//                             taskState.dueDate != null
//                                 ? "Due on ${taskState.dueDate!.day}/${taskState.dueDate!.month}/${taskState.dueDate!.year}"
//                                 : 'Select due date',
//                           ),
//                           SizedBox(width: 2),

//                           IconButton(
//                             icon: Icon(Icons.calendar_month),
//                             onPressed: () async {
//                               await showDatePicker(
//                                 context: context,
//                                 firstDate: DateTime(DateTime.now().month - 5),
//                                 lastDate: DateTime(DateTime.now().year + 5),
//                               ).then((value) {
//                                 if (value != null) {
//                                   taskbloc.add(SaveDateEvent(date: value));
//                                 }
//                               });
//                             },
//                           ),
//                         ],
//                       ),
//                       Text("Description "),
//                       Expanded(
//                         child: TextField(
//                           decoration: InputDecoration(
//                             border: OutlineInputBorder(),
//                           ),
//                           keyboardType: TextInputType.multiline,
//                           maxLines: 100,
//                           onChanged:
//                               (value) =>
//                                   taskbloc.add(SaveDescEvent(desc: value)),
//                         ),
//                       ),
//                       SizedBox(height: 5),
//                     ],
//                   );
//                 },
//               ),
//               Row(
//                 mainAxisSize: MainAxisSize.max,
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   NavigationButton(
//                     text: 'Close',
//                     color: Colors.red,
//                     onPressed: () {
//                       Navigator.of(context).pop();
//                     },
//                   ),
//                   NavigationButton(
//                     text: 'Save Task',
//                     color: Colors.green,
//                     onPressed: () {
//                       Navigator.of(context).pop();
//                     },
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class TaskEditorDialog extends StatefulWidget {
//   const TaskEditorDialog({super.key, this.task, this.isEdit = false});
//   final Task? task;
//   final bool isEdit;

//   @override
//   State<TaskEditorDialog> createState() => _TaskEditorDialogState();
// }

// class _TaskEditorDialogState extends State<TaskEditorDialog> {
//   TextEditingController titleController = TextEditingController();
//   DateTime? dueDateController;
//   TextEditingController descConroller = TextEditingController();

//   void loadTask(Task task) {
//     titleController.text = task.title!;
//     dueDateController = task.dueDate!;
//     descConroller.text = task.description!;
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (widget.task != null) {
//       loadTask(widget.task!);
//     }
//     final formKey = GlobalKey();
//     return /*Dialog.fullscreen(
//       child: SafeArea(*/ Scaffold(
//       appBar: AppBar(),
//       body: Padding(
//         padding: EdgeInsets.all(8),
//         child: Form(
//           key: formKey,
//           child: Column(
//             children: [
//               Row(
//                 children: [
//                   Expanded(
//                     child: TextFormField(
//                       controller: titleController,
//                       decoration: InputDecoration(
//                         label: Text("Title"),
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                       ),
//                     ),
//                   ),
//                   StarButton(),
//                 ],
//               ),
//               Row(
//                 children: [
//                   Text(
//                     dueDateController != null
//                         ? "Due on ${dueDateController!.day}/${dueDateController!.month}/${dueDateController!.year}"
//                         : 'Select due date',
//                   ),
//                   SizedBox(width: 2),

//                   IconButton(
//                     icon: Icon(Icons.calendar_month),
//                     onPressed: () async {
//                       await showDatePicker(
//                         context: context,
//                         firstDate: DateTime(DateTime.now().month - 5),
//                         lastDate: DateTime(DateTime.now().year + 5),
//                       ).then((value) {
//                         if (value != null) {
//                           setState(() {
//                             dueDateController = value;
//                           });
//                         }
//                       });
//                     },

//                     // () => showDialog(
//                     //   context: context,
//                     //   builder: (context) {
//                     //     final data = DatePickerDialog(
//                     //       firstDate: DateTime.now(),
//                     //       lastDate: DateTime(DateTime.now().year + 5),
//                     //     );

//                     //     return data;
//                     //   },
//                     // ),
//                   ),
//                 ],
//               ),
//               Text("Description "),

//               Expanded(
//                 child: TextField(
//                   decoration: InputDecoration(border: OutlineInputBorder()),
//                   keyboardType: TextInputType.multiline,
//                   maxLines: 100,
//                   controller: descConroller,
//                 ),
//               ),
//               SizedBox(height: 5),
//               Row(
//                 mainAxisSize: MainAxisSize.max,
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   NavigationButton(
//                     text: 'Close',
//                     color: Colors.red,
//                     onPressed: () {
//                       Navigator.of(context).pop();
//                     },
//                   ),
//                   NavigationButton(
//                     text: 'Save Task',
//                     color: Colors.green,
//                     onPressed: () {
//                       setState(() {
//                         sampleData.add(
//                           Task(
//                             title: titleController.text,
//                             description: descConroller.text,
//                             dueDate: dueDateController,
//                             isImportant: false,
//                           ),
//                         );
//                       });
//                       Navigator.of(context).pop();
//                     },
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
