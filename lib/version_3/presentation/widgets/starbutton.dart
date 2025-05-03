import 'package:flutter/material.dart';

class StarButton extends StatefulWidget {
  const StarButton({super.key, required this.onPressed, required this.initial});
  final void Function(bool mark) onPressed;
  final bool initial;
  @override
  State<StarButton> createState() => _StarButtonState();
}

class _StarButtonState extends State<StarButton> {
  bool mark = false;
  @override
  void initState() {
    mark = widget.initial;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        setState(() {
          mark = !mark;
        });
        widget.onPressed(mark);
      },
      icon: Icon(
        mark ? Icons.star_border_outlined : Icons.star,
        color: Colors.yellow,
      ),
    );
  }
}
