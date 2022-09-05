import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:provider_demo/model/user.dart';
import 'package:sqflite/sqflite.dart';

import '../providers/user_notifier.dart';

class DatabaseHelper{
  Database? _database;

  Future openDb() async{
    _database ??= await openDatabase(
      join(await getDatabasesPath(),"userDatabasefinalok.db"),
      version: 1,
      onCreate:(Database db,int version) async{
        await db.execute('CREATE TABLE USER (id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, city TEXT)');
      }
    );
  }


  Future<int?> insertUser(User user) async{
    await openDb();
    return await _database?.insert("user",user.toMap(),conflictAlgorithm: ConflictAlgorithm.replace);
  }
  Future<List<User>> getUserList() async{
    await openDb();
    final List<Map<String,dynamic>>maps = await _database!.query('user');
    return List.generate(maps.length, (index) => User(id:maps[index]['id'],name: maps[index]['name'],city:maps[index]['city'] ));
  }
  Future<void> updateUser(User user) async {
    await openDb();
    await _database!.update("user", user.toMap(),
        where: 'id=?', whereArgs: [user.id]);
  }
  Future<void> deleteUser(int id) async {
    await openDb();
    await _database!.delete("user", where: "id = ? ", whereArgs: [id]);
  }
  Future<int?> insertUserFromUndo(User user) async{
    await openDb();
    return await _database?.insert("user",user.toMap());
  }


}