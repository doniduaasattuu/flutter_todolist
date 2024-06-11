import 'package:todolist/data/todolist_data.dart';
import 'package:todolist/models/todolist_model.dart';

class TodolistService {
  List<TodolistModel> index() {
    return todolistData;
  }

  void remove(int index) {
    todolistData.removeAt(index);
  }

  void add(TodolistModel todolistModel) {
    todolistData.add(todolistModel);
  }
}
