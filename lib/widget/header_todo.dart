import 'package:flutter/material.dart';

class HeaderTodo extends StatelessWidget {
  const HeaderTodo(
      {super.key,
      required this.text,
      // this.color,
      this.size = 18,
      this.weight = FontWeight.w600,
      this.done = false});

  final String text;
  // final Color? color;
  final double size;
  final FontWeight weight;
  final bool done;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: done == false ? null : Colors.red,
        fontSize: size,
        fontWeight: weight,
        decoration:
            done == false ? TextDecoration.none : TextDecoration.lineThrough,
      ),
    );
  }
}
