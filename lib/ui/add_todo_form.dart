import 'package:flutter/material.dart';
import 'package:todolist/models/todolist_model.dart';
import 'package:todolist/utility/utility.dart';
import 'package:todolist/widget/custom_text.dart';

class AddTodoForm extends StatefulWidget {
  const AddTodoForm({super.key, required this.onAddTodo});

  final Function(TodolistModel) onAddTodo;

  @override
  State<AddTodoForm> createState() => _AddTodoFormState();
}

class _AddTodoFormState extends State<AddTodoForm> {
  final TextEditingController _todoController = TextEditingController();
  bool _done = false;
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
                  const CustomText(
                    text: 'Add Todo',
                    weight: FontWeight.w600,
                    size: 16,
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
                      value: _done,
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
                        Text(formatter.format(_createdAt)),
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
              ElevatedButton(
                onPressed: () {
                  final String todo = _todoController.text;

                  if (todo.isNotEmpty) {
                    widget.onAddTodo(
                      TodolistModel(
                        todo: todo,
                        done: _done,
                        createdAt: _createdAt,
                        updatedAt: _updatedAt,
                      ),
                    );

                    Navigator.pop(context);
                  } else {
                    showDialog(
                      context: context,
                      builder: (ctx) => AlertDialog(
                        title: const Text('Input is invalid'),
                        content: const Text(
                            'Please make sure the todo you\'ve entered is valid.'),
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
                child: const CustomText(
                  text: 'Save',
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
