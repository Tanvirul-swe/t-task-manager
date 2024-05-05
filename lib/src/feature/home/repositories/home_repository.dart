import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:t_task_manager/src/constant/app_constant.dart';
import 'package:t_task_manager/src/feature/task/data/model/task_model.dart';
import 'package:t_task_manager/src/feature/task/data/model/task_tag_model.dart';
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
          "SELECT * FROM ${DatabaseHelper.taskTable} WHERE (${DatabaseHelper.columnStatus} !=${AppConstant.completed} AND ${DatabaseHelper.columnStatus} !=${AppConstant.cancelled}) AND (${DatabaseHelper.columnDate} >= ? AND ${DatabaseHelper.columnDate} < ?)";

      // Bind the start and end of the day milliseconds as parameters
      List<Map<String, dynamic>> tasks = await db!.rawQuery(
        query,
        [
          startOfDay.millisecondsSinceEpoch,
          startOfDay.add(const Duration(days: 1)).millisecondsSinceEpoch
        ], // Adding 1 day to get the start of the next day
      );

      List<TaskModel> taskList = [];
      await Future.forEach(tasks, (element) async {
        List<Map<String, dynamic>> tags = await db.query(
            DatabaseHelper.taskTagTable,
            where: "${DatabaseHelper.columnTaskId} = ?",
            whereArgs: [element[DatabaseHelper.columnId]]);
        List<TaskTagModel> tagList = [];
        for (var element in tags) {
          tagList.add(TaskTagModel.fromLocalDB(element));
        }
        taskList.add(TaskModel.fromLocalDB(element, tags: tagList));
      });

      await db.close();

      return taskList;
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

  // Delete task from local storage
  Future<bool> deleteTask(int taskId) async {
    Database? db = await DatabaseHelper.instance.database();
    try {
      await db!.delete(DatabaseHelper.taskTable,
          where: "${DatabaseHelper.columnId} = ?", whereArgs: [taskId]);
      await db.delete(DatabaseHelper.taskTagTable,
          where: "${DatabaseHelper.columnTaskId} = ?", whereArgs: [taskId]);
      db.close();
      return true;
    } catch (e) {
      debugPrint("Error: $e");
      rethrow;
    }
  }
}
