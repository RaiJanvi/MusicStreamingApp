import 'dart:io';
import 'dart:async';

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

/* Class for Database Management
   and all its operations-CRUD
   Create-Read-Update-Delete */

class DatabaseHelper {
  static final _dbName = "musicStreaming.db";
  static final _dnVersion = 1;
  static final _tableName = "userDetails";

  //columns of table
  static final columnId = "_id";
  static final columnUName = "userName";
  static final columnEmail = "email";
  static final columnPassword = "password";
  static final columnDOB = "dob";
  static final columnGender = "gender";

  //Singleton class for creating instance of DatabaseHelper class
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;

  Future<Database> get database async {
    _database ??= await initialDatabase();
    return _database!;
  }

  //To initialize the database
  Future<Database> initialDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, _dbName);

    return await openDatabase(path, version: _dnVersion, onCreate: _onCreate);
  }

  //To create table in database
  Future _onCreate(Database db, int version) async {
    return db.execute(
        '''
        CREATE TABLE $_tableName(
          $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
          $columnUName TEXT NOT NULL,
          $columnEmail TEXT NOT NULL,
          $columnPassword TEXT NOT NULL,
          $columnDOB TEXT NOT NULL,
          $columnGender TEXT NOT NULL )
      '''
    );
  }

  //To insert data in table
  Future<int> insert(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return db.insert(_tableName, row);
  }

  //To validate user exists or not
  Future<List<Map<String,dynamic>>> validateUser(String email, String password) async{
    Database db = await instance.database;
    return await db.query(_tableName,columns: [columnId], where: '$columnEmail=? AND $columnPassword=?', whereArgs: [email,password]);
  }

  //To display all data of current user
  Future<List<Map<String, dynamic>>> queryAll(int id) async{
    Database db = await instance.database;
    return await db.query(_tableName, where: '$columnId=?', whereArgs: [id]);
  }

  //To display userName of current user
  Future<List<Map<String, dynamic>>> userName(int id) async{
    Database db = await instance.database;
    return await db.query(_tableName,columns: [columnUName] ,where: '$columnId=?', whereArgs: [id]);
  }

  //To update table data
  Future<int> update(Map<String,dynamic> row, int id) async{
    Database db = await instance.database;
    return await db.update(_tableName, row, where: '$columnId = ?',whereArgs: [id] ); // '?' is used to prevent SQL injection
  }

  //To delete user account
  Future<int> delete(int id) async{
    Database db = await instance.database;
    return await db.delete(_tableName,where: '$columnId = ?', whereArgs: [id]);
  }

}

