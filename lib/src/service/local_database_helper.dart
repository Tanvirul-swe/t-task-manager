// ignore_for_file: depend_on_referenced_packages

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  DatabaseHelper();
  final _databaseName = "compa.db";
  final _databaseVersion = 1;

  // Common Column
  static const String columnCreatedAt = 'created_at';
  static const String columnUpdatedAt = 'updated_at';
  static const String columnIsSynced = 'is_synced';
  static const String columnIsDeleted = 'is_deleted';
  static const String columnId = '_id';

  // Task Table
  static const String taskTable = 'task_info';
  static const String columnTitle = 'title';
  static const String columnDate = 'date';
  static const String columnStartTime = 'start_time';
  static const String columnEndTime = 'end_time';
  static const String columnDescription = 'description';
  static const String columnTaskType = 'task_type';
  static const String columnStatus = 'status';

  // Task Tag Table
  static const String taskTagTable = 'task_tag';
  static const String columnTagName = 'tag_name';
  static const String columnTaskId = 'task_id';

  // make this a singleton class
  DatabaseHelper._privateConstructor();

  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  // only have a single app-wide reference to the database

  Future<Database?> database() async {
    Database? database;

    database = await _initDatabase();

    return database;
  }

// SQL code to initialize database
  _initDatabase() async {
    // if Device is ios then get application library directory path

    // var databasesPath = await getDatabasesPath();
    Directory documentsDirectory = await getApplicationDocumentsDirectory();

    // var databasesPath = await getDatabasesPath();
    String path = join(documentsDirectory.path, _databaseName);

    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    try {
      await db.execute('''
          CREATE TABLE $taskTable (
            $columnId INTEGER,
            $columnTitle TEXT,
            $columnDate INT,
            $columnStartTime INT,
            $columnEndTime INT,
            $columnDescription TEXT,
            $columnTaskType TEXT,
            $columnStatus INT,
            $columnCreatedAt INT,
            $columnUpdatedAt INT,
            $columnIsDeleted INT,
            $columnIsSynced INT,
            UNIQUE ($columnId) ON CONFLICT REPLACE
          )
      ''');
      await db.execute('''
          CREATE TABLE $taskTagTable (
            $columnId INTEGER,
            $columnTagName TEXT,
            $columnTaskId INTEGER,
            UNIQUE ($columnId) ON CONFLICT REPLACE
          )
      ''');
    } catch (e) {
      debugPrint("Database Create Exception : $e");
    }
  }
}
