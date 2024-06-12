import 'package:flutter/material.dart';
import 'package:todolist/models/todolist_model.dart';
import 'package:todolist/widget/todo_item.dart';

class TodoList extends StatefulWidget {
  const TodoList({
    super.key,
    required this.todolist,
    required this.onRemoveTodo,
    required this.onUpdateTodo,
  });

  final List<TodolistModel> todolist;
  final Function(int) onRemoveTodo;
  final Function(int, TodolistModel)? onUpdateTodo;

  @override
  State<TodoList> createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  @override
  Widget build(BuildContext context) {
    List<TodolistModel> todolist = widget.todolist;

    return ListView.builder(
      itemCount: todolist.length,
      itemBuilder: (ctx, index) => Dismissible(
        background: ClipRect(
          child: Container(
            margin: const EdgeInsets.all(6),
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              color: Colors.red,
            ),
            child: const Row(
              children: [
                Icon(Icons.delete, size: 30, color: Colors.white),
                Spacer(),
                Icon(Icons.delete, size: 30, color: Colors.white),
              ],
            ),
          ),
        ),
        key: ValueKey(todolist[index].id),
        onDismissed: (direction) {
          widget.onRemoveTodo(index);
        },
        child: TodoItem(
          todo: todolist[index],
          index: index,
          onUpdateTodo: widget.onUpdateTodo,
        ),
      ),
    );
  }
}
