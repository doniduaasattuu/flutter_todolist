import 'package:flutter/material.dart';
import 'package:todolist/models/todolist_model.dart';
import 'package:todolist/ui/todo_form.dart';
import 'package:todolist/widget/header_todo.dart';

class TodoItem extends StatefulWidget {
  const TodoItem(
      {super.key,
      required this.index,
      required this.todo,
      required this.onUpdateTodo});

  final int index;
  final TodolistModel todo;
  final Function(int, TodolistModel)? onUpdateTodo;

  @override
  State<TodoItem> createState() => _TodoItemState();
}

class _TodoItemState extends State<TodoItem> {
  void _openUpdateTodoOverlay() {
    showModalBottomSheet(
      useSafeArea: true,
      isScrollControlled: true,
      context: context,
      builder: (ctx) {
        return TodoForm(
          todo: widget.todo,
          index: widget.index,
          onUpdateTodo: widget.onUpdateTodo,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    TodolistModel todo = widget.todo;
    bool isChecked = todo.done;

    return InkWell(
      borderRadius: const BorderRadius.all(Radius.circular(16)),
      onTap: () {
        _openUpdateTodoOverlay();
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
