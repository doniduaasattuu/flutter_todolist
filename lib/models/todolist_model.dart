import 'package:todolist/utility/utility.dart';

class TodolistModel {
  TodolistModel({
    required this.todo,
    required this.done,
    required this.createdAt,
    required this.updatedAt,
  }) : id = uuid.v4();

  final String id;
  final String todo;
  bool done;
  final DateTime createdAt;
  final DateTime updatedAt;

  get created {
    return formatter.format(createdAt);
  }

  void setDone(bool value) {
    done = value;
  }
}
