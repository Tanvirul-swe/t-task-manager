import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:t_task_manager/src/feature/task/data/model/task_model.dart';
import 'package:t_task_manager/src/service/local_database_helper.dart';

class HomeRepository {
  //Get today task from local storage
  Future<List<TaskModel>> getTodayTask() async {
    Database? db = await DatabaseHelper.instance.database();
    try {
      // Get the milliseconds for today's date at midnight (00:00:00)
      DateTime today = DateTime.now();
      DateTime startOfDay = DateTime(today.year, today.month, today.day);

      String query =
          "SELECT * FROM ${DatabaseHelper.taskTable} WHERE ${DatabaseHelper.columnDate} >= ? AND ${DatabaseHelper.columnDate} < ?";

      // Bind the start and end of the day milliseconds as parameters
      List<Map<String, dynamic>> result = await db!.rawQuery(
        query,
        [
          startOfDay.millisecondsSinceEpoch,
          startOfDay.add(const Duration(days: 1)).millisecondsSinceEpoch
        ], // Adding 1 day to get the start of the next day
      );

      await db.close();

      // Mapping the result to TaskModel objects
      return result
          .map((e) => TaskModel.fromLocalDB(
                e,
              ))
          .toList();
    } catch (e) {
      rethrow;
    }
  }

  // Count all type of task from local storage
  Future<Map<String, int>> countAllTask() async {
    Database? db = await DatabaseHelper.instance.database();
    try {
      // Here count completed task and pending task , cancelled task and on going task

      String completedQuery =
          "SELECT COUNT(*) FROM ${DatabaseHelper.taskTable} WHERE ${DatabaseHelper.columnStatus} = 1";
      String pendingQuery =
          "SELECT COUNT(*) FROM ${DatabaseHelper.taskTable} WHERE ${DatabaseHelper.columnDate} >= ? OR ${DatabaseHelper.columnDate} < ${DatabaseHelper.columnStartTime} ORDER BY ${DatabaseHelper.columnId}";
      String cancelledQuery =
          "SELECT COUNT(*) FROM ${DatabaseHelper.taskTable} WHERE ${DatabaseHelper.columnStatus} = 3";
      String onGoingQuery =
          "SELECT COUNT(*) FROM ${DatabaseHelper.taskTable}  WHERE  ${DatabaseHelper.columnStartTime}<= ? AND ${DatabaseHelper.columnEndTime} >= ? AND ${DatabaseHelper.columnDate} <=?";

      final completedTaskCount = Sqflite.firstIntValue(
          await db!.rawQuery(completedQuery)); // Completed Task Count

      final pendingTaskCount = Sqflite.firstIntValue(await db.rawQuery(
          pendingQuery,
          [DateTime.now().millisecondsSinceEpoch])); // Pending Task Count
      final cancelledTaskCount = Sqflite.firstIntValue(
          await db.rawQuery(cancelledQuery)); // Cancelled Task Count

      final onGoingTaskCount =
          Sqflite.firstIntValue(await db.rawQuery(onGoingQuery, [
        DateTime.now().millisecondsSinceEpoch,
        DateTime.now().millisecondsSinceEpoch,
        DateTime.now().millisecondsSinceEpoch
      ])); // On Going Task Count

      await db.close();
      return {
        "completed": completedTaskCount ?? 0,
        "pending": pendingTaskCount ?? 0,
        "cancelled": cancelledTaskCount ?? 0,
        "onGoing": onGoingTaskCount ?? 0
      };
    } catch (e) {
      rethrow;
    }
  }
}
