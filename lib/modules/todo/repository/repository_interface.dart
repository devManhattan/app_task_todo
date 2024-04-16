import 'dart:ffi';

import 'package:todo_moura/modules/todo/models/todo.dart';

abstract class ITodoRepository {
  Future<bool> create(Todo todo);
  Future<bool> delete(Todo todo);
  Future<bool> update(Todo todo);
  Future<List<Todo>> getAll();
  Future<List<Todo>> getByCreationDate(bool done);
  Future<List<Todo>> getByTaskDate(bool done);
  Future<List<Todo>> getByPrioridade(bool done);
   Future<bool> init();
  
}
