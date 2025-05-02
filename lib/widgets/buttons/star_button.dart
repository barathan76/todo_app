import 'package:flutter/material.dart';
import 'package:todo_app/model/task.dart';

class StarButton extends StatefulWidget {
  StarButton({super.key, this.task, this.onPressed, this.check = false});
  final Task? task;
  final void Function()? onPressed;
  bool check;
  @override
  State<StarButton> createState() => _StarButtonState();
}

class _StarButtonState extends State<StarButton> {
  bool check = false;
  @override
  Widget build(BuildContext context) {
    check = widget.task != null ? widget.task!.isImportant : widget.check;
    return IconButton(
      onPressed: () {
        if (widget.task != null) {
          setState(() {
            widget.task!.isImportant = !widget.task!.isImportant;
          });
        } else {
          widget.onPressed!();
        }
      },
      icon: Icon(
        check ? Icons.star_border_outlined : Icons.star,
        color: Colors.yellow,
      ),
    );
  }
}
