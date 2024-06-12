import 'package:flutter/material.dart';
import 'package:todolist/models/todolist_model.dart';
import 'package:todolist/services/todolist_service.dart';
import 'package:todolist/ui/todo_form.dart';
import 'package:todolist/widget/todo_list.dart';

class Todolist extends StatefulWidget {
  const Todolist({super.key});

  @override
  State<Todolist> createState() => _TodolistState();
}

class _TodolistState extends State<Todolist> {
  void _openAddTodoOverlay() {
    showModalBottomSheet(
      useSafeArea: true,
      isScrollControlled: true,
      context: context,
      builder: (ctx) {
        return TodoForm(onAddTodo: _addTodo);
      },
    );
  }

  void _addTodo(TodolistModel todolistModel) {
    setState(() {
      TodolistService().add(todolistModel);
    });
  }

  void _removeTodo(int index) {
    setState(() {
      TodolistService().remove(index);
    });
  }

  void _updateTodo(int index, TodolistModel todolistModel) {
    setState(() {
      TodolistService().update(index, todolistModel);
    });
  }

  @override
  Widget build(BuildContext context) {
    List<TodolistModel> data = TodolistService().index();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Todolist'),
        actions: [
          TextButton(
            onPressed: () {
              _openAddTodoOverlay();
            },
            child: const Icon(Icons.add),
          ),
        ],
      ),
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.zero,
          padding: const EdgeInsets.all(16),
          child: TodoList(
            todolist: data,
            onRemoveTodo: _removeTodo,
            onUpdateTodo: _updateTodo,
          ),
        ),
      ),
    );
  }
}
