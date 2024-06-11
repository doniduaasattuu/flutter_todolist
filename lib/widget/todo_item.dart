import 'package:flutter/material.dart';
import 'package:todolist/models/todolist_model.dart';
import 'package:todolist/widget/header_todo.dart';

class TodoItem extends StatefulWidget {
  const TodoItem({super.key, required this.todo});

  final TodolistModel todo;

  @override
  State<TodoItem> createState() => _TodoItemState();
}

class _TodoItemState extends State<TodoItem> {
  @override
  Widget build(BuildContext context) {
    TodolistModel todo = widget.todo;
    bool isChecked = todo.done;

    return GestureDetector(
      onDoubleTap: () {
        debugPrint('Double tap action');
      },
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  HeaderTodo(
                    text: todo.todo,
                    size: 16,
                    done: todo.done,
                  ),
                  Text(todo.created),
                ],
              ),
              const Spacer(),
              Column(
                children: [
                  Checkbox(
                    value: isChecked,
                    onChanged: (value) {
                      setState(
                        () {
                          todo.setDone(value!);
                        },
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
