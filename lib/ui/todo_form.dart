import 'package:flutter/material.dart';
import 'package:todolist/models/todolist_model.dart';
import 'package:todolist/utility/utility.dart';
import 'package:todolist/widget/custom_text.dart';

class TodoForm extends StatefulWidget {
  const TodoForm({
    super.key,
    this.index,
    this.todo,
    this.onAddTodo,
    this.onUpdateTodo,
  });

  final int? index;
  final TodolistModel? todo;
  final Function(TodolistModel)? onAddTodo;
  final Function(int, TodolistModel)? onUpdateTodo;

  @override
  State<TodoForm> createState() => _TodoFormState();
}

class _TodoFormState extends State<TodoForm> {
  final TextEditingController _todoController = TextEditingController();
  bool? _done;
  DateTime _createdAt = DateTime.now();
  DateTime _updatedAt = DateTime.now();

  void _presentDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year, now.month - 1, now.day);
    final lastDate = DateTime(now.year, now.month + 1, now.day);

    final dateSelected = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: firstDate,
      lastDate: lastDate,
    );

    setState(() {
      _createdAt = dateSelected!;
      _updatedAt = _createdAt;
    });
  }

  @override
  Widget build(BuildContext context) {
    final TodolistModel? todoObject = widget.todo;
    final int? index = widget.index;

    if (todoObject != null) {
      _todoController.text = todoObject.todo;
      _done = _done ?? todoObject.done;
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.close),
                  ),
                  CustomText(
                    text: todoObject == null ? 'Add Todo' : 'Update Todo',
                    weight: FontWeight.w600,
                    size: 22,
                  ),
                ],
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  maxLength: 45,
                  controller: _todoController,
                  decoration: const InputDecoration(
                    label: Text('Todo'),
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    DropdownButton(
                      value: todoObject != null && _done == null
                          ? todoObject.done
                          : _done,
                      items: const [
                        DropdownMenuItem(
                          value: false,
                          child: Text('Unfinished'),
                        ),
                        DropdownMenuItem(
                          value: true,
                          child: Text('Finished'),
                        ),
                      ],
                      onChanged: (value) {
                        setState(() {
                          _done = value!;
                        });
                      },
                    ),
                    const Spacer(),
                    Wrap(
                      children: [
                        Text(todoObject == null
                            ? formatter.format(_createdAt)
                            : formatter.format(todoObject.createdAt)),
                        const SizedBox(width: 16),
                        GestureDetector(
                          onTap: () {
                            _presentDatePicker();
                          },
                          child: const Icon(Icons.calendar_month),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                ),
                child: const CustomText(
                  text: 'Cancel',
                  color: Colors.red,
                ),
              ),
              const SizedBox(width: 8),
              ElevatedButton(
                onPressed: () {
                  final String stringTodo = _todoController.text;

                  if (stringTodo.isNotEmpty && _done != null) {
                    if (todoObject == null) {
                      widget.onAddTodo!(
                        TodolistModel(
                          todo: stringTodo,
                          done: _done!,
                          createdAt: _createdAt,
                          updatedAt: _updatedAt,
                        ),
                      );

                      Navigator.pop(context);
                    } else {
                      // update todo
                      widget.onUpdateTodo!(
                        index!,
                        TodolistModel(
                          todo: stringTodo,
                          done: _done!,
                          createdAt: _createdAt,
                          updatedAt: _updatedAt,
                        ),
                      );

                      Navigator.pop(context);
                    }
                  } else {
                    showDialog(
                      context: context,
                      builder: (ctx) => AlertDialog(
                        title: const Text('Input is invalid'),
                        content: const Text(
                            'Please make sure the data you\'ve entered is valid.'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(ctx);
                            },
                            child: const Text('Okay'),
                          ),
                        ],
                      ),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple),
                child: CustomText(
                  text: todoObject == null ? 'Save' : 'Update',
                  color: Colors.white,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
