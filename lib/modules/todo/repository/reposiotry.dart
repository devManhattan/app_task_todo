import 'package:sqflite/sqflite.dart';
import 'package:todo_moura/database/database.dart';
import 'package:todo_moura/modules/todo/models/todo.dart';
import 'package:todo_moura/modules/todo/repository/repository_interface.dart';

class TodoRepository implements ITodoRepository {
  DatabaseHelper databaseHelper = DatabaseHelper();
  Database? db;
  @override
  Future<bool> init() async {
    try {
      db ??= await databaseHelper.datebase;
      return true;
    } catch (e, stackTrace) {
      return false;
    }
  }

  @override
  Future<bool> create(Todo todo) async {
    try {
      db!.insert("todo", todo.toMap());
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> delete(Todo todo) async {
    try {
      await db!.delete("todo", where: "id = ${todo.id}");
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<List<Todo>> getAll() async {
    try {
      List<Map<String, Object?>> todoList = await db!.query("todo");
      return todoList.map((e) => Todo.fromMap(e)).toList();
    } catch (e) {
      return [];
    }
  }

  @override
  Future<bool> update(Todo todo) async {
    try {
      db!.update("todo", todo.toMap(), where: "id = ${todo.id}");
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<List<Todo>> getByCreationDate(bool done) async {
    // TODO: implement getByData
    try {
      List<Map<String, Object?>> todoList = await db!.query("todo",
          orderBy: 'updated_date ASC',
          where:
              "deleted_date IS NULL ${done ? "AND done = 1" : "AND done = 0"}");
      return todoList.map((e) => Todo.fromMap(e)).toList();
    } catch (e) {
      return [];
    }
  }

  @override
  Future<List<Todo>> getByPrioridade(bool done) async {
    // TODO: implement getByPrioridade
    try {
      List<Map<String, Object?>> todoList = await db!.query("todo",
          orderBy: 'priority  DESC',
          where:
              "deleted_date IS NULL ${done ? "AND done = 1" : "AND done = 0"}");
      return todoList.map((e) => Todo.fromMap(e)).toList();
    } catch (e) {
      return [];
    }
  }

  @override
  Future<List<Todo>> getByTaskDate(bool done) async {
    try {
      List<Map<String, Object?>> todoList = await db!.query("todo",
          orderBy: 'task_date ASC',
          where:
              "deleted_date IS NULL ${done ? "AND done = 1" : "AND done = 0"}");
      return todoList.map((e) => Todo.fromMap(e)).toList();
    } catch (e) {
      return [];
    }
  }
}
