import 'package:todolist/models/todolist_model.dart';
import 'package:todolist/utility/utility.dart';

List<TodolistModel> todolistData = [
  TodolistModel(
    todo: 'Belajar Flutter',
    done: false,
    createdAt: DateTime(now.year, now.month, now.day - 4),
    updatedAt: DateTime(now.year, now.month, now.day - 4),
  ),
  TodolistModel(
    todo: 'Belajar CodeIgniter 4',
    done: false,
    createdAt: DateTime(now.year, now.month, now.day - 3),
    updatedAt: DateTime(now.year, now.month, now.day - 3),
  ),
  TodolistModel(
    todo: 'Belajar Java',
    done: false,
    createdAt: DateTime(now.year, now.month, now.day - 2),
    updatedAt: DateTime(now.year, now.month, now.day - 2),
  ),
  TodolistModel(
    todo: 'Belajar JavaScript',
    done: true,
    createdAt: DateTime(now.year, now.month, now.day - 1),
    updatedAt: DateTime(now.year, now.month, now.day - 1),
  ),
  TodolistModel(
    todo: 'Belajar Restful API',
    done: false,
    createdAt: now,
    updatedAt: now,
  ),
];
