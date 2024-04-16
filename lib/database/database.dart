import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_moura/database/database_scripts.dart';

class DatabaseHelper {
  static DatabaseHelper? _databaseHelper;
  static Database? _database;

  DatabaseHelper._createInstance();

//Singleton para validar se tem a instacia ativa, se tive retornar ela, senão cria
  factory DatabaseHelper() {
    if (_databaseHelper == null) {
      _databaseHelper = DatabaseHelper._createInstance();
    }
    return _databaseHelper!;
  }

//Faz o get do banco de dados
  Future<Database> get datebase async {
    if (_database == null) {
      _database = await initializeDatabase();
    }
    return _database!;
  }

  Future<Database> initializeDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + "/monitorapa.db";


    Database database = await openDatabase(
      path,
      version: DatabaseScripts.update.entries.last.key,
      onCreate: _createdb,
      onConfigure: _onConfigure,
      onUpgrade: (
        Database db,
        int oldVersion,
        int newVersion,
      ) async {

        ///Executa os scripts de update independete de versão que estava, então ele insere
        for (int version = oldVersion + 1; version <= newVersion; version++) {
          if (DatabaseScripts.update[version] != null) {
            for (int i = 0; i < DatabaseScripts.update[version]!.length; i++) {
              await db.execute(DatabaseScripts.update[version]![i]);
            }
          }
        }
      },
    );

    return database;
  }

  static Future _onConfigure(Database db) async {
    await db.execute('PRAGMA foreign_keys = ON');
  }

  void _createdb(Database db, int newVersion) async {
    //Executa os scripts de criação do banco
    for (int i = 0; i < DatabaseScripts.create.length; i++) {
      await db.execute(DatabaseScripts.create[i]);
    }

    // Executa os scripts de update do banco.
    // EX: Cliente baixa a versão em produção com banco versão 7,
    // Então gera o banco com a versão 1, e executa os scripts de alteração.
    for (int version = 1; version <= newVersion; version++) {
      if (DatabaseScripts.update[version] != null) {
        for (int i = 0; i < DatabaseScripts.update[version]!.length; i++) {
          await db.execute(DatabaseScripts.update[version]![i]);
        }
      }
    }
  }

 
}
