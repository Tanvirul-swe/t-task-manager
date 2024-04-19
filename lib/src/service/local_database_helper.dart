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

  // Bike Table
  static const String bikeTable = 'bike_info';
  static const String columnId = '_id';
  static const String columnBrand = 'brand';
  static const String columnModelName = 'model_name';
  static const String columnFrontShockPsi = 'front_shock_psi';
  static const String columnFrontShockSag = 'front_shock_sag';
  static const String columnFrontShockHsc = 'front_shock_hsc';
  static const String columnFrontShockLsc = 'front_shock_lsc';
  static const String columnFrontShockHsr = 'front_shock_hsr';
  static const String columnFrontShockLsr = 'front_shock_lsr';
  static const String columnRearShockPsi = 'rear_shock_psi';
  static const String columnRearShockSag = 'rear_shock_sag';
  static const String columnRearShockHsc = 'rear_shock_hsc';
  static const String columnRearShockLsc = 'rear_shock_lsc';
  static const String columnRearShockHsr = 'rear_shock_hsr';
  static const String columnRearShockLsr = 'rear_shock_lsr';
  static const String columnFrontTirePsi = 'front_tire_psi';
  static const String columnRearTirePsi = 'rear_tire_psi';
  static const String columnImage = 'image';

  //  Rides info Table
  static const String rideInfoTable = 'ride_info';
  static const String columnData = 'data';

  // Task Table
  static const String taskTable = 'task_info';
  static const String columnTitle = 'title';
  static const String columnDate = 'date';
  static const String columnStartTime = 'start_time';
  static const String columnEndTime = 'end_time';
  static const String columnDescription = 'description';
  static const String columnTaskType = 'task_type';

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
            $columnCreatedAt INT,
            $columnUpdatedAt INT,
            $columnIsDeleted INT 
            $columnIsSynced INT,
            UNIQUE ($columnId) ON CONFLICT REPLACE
          )
      ''');
      await db.execute('''
          CREATE TABLE $taskTagTable (
            $columnId INTEGER,
            $columnTagName TEXT,
            $columnTaskId INTEGER,
            $columnCreatedAt INT,
            $columnUpdatedAt INT,
            $columnIsDeleted INT
            $columnIsSynced INT,
            UNIQUE ($columnId) ON CONFLICT REPLACE
          )
      ''');
    } catch (e) {
      debugPrint("Database Create Exception : $e");
    }
  }
}
