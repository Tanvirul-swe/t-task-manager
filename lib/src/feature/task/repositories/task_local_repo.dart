import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:t_task_manager/src/constant/app_constant.dart';
import 'package:t_task_manager/src/feature/history/presentation/page/task_history_page.dart';
import 'package:t_task_manager/src/feature/task/data/model/task_model.dart';
import 'package:t_task_manager/src/feature/task/data/model/task_tag_model.dart';
import 'package:t_task_manager/src/service/local_database_helper.dart';

class TaskLocalRepo {
  // Add task to local storage

  Future<bool> addTask(TaskModel task) async {
    Database? db = await DatabaseHelper.instance.database();
    try {
      debugPrint("TaskModel: ${task.toMap()}");
      await db!.insert(DatabaseHelper.taskTable, task.toMap());

      await Future.forEach(task.tags, (element) async {
        debugPrint("TaskTagModel: ${element.toMap()}");
        await db.insert(DatabaseHelper.taskTagTable, element.toMap());
      });
      db.close();
      return true;
    } catch (e) {
      debugPrint("Error: $e");
      rethrow;
    }
  }

  // Get all tasks from local storage
  Future<List<TaskModel>> getAllTask(
      TaskType type, int startDate, int endDate) async {
    Database? db = await DatabaseHelper.instance.database();
    try {
      //Filter task with start date and end date
      // if startDate and endDate is 0 then not apply filter

      // Here we are fetching task based on task type
      // TaskType { completed, pending, cancelled, onGoing,all }
      // TaskType.all is for fetching all task
      // TaskType.pending is for fetching all  pending task compare current date and task_info table  start_time column (if start_time is less than current date and end_time is greater than current date)
      // TaskType.onGoing is for fetching all  onGoing task compare current date and task_info table  start_time column (if start_time is greater than current date and end_time is greater than current date)
      String query = "";
      List<dynamic> queryArgs = [];

      String filterCondition = "";
      debugPrint("StartDate: $startDate");
      debugPrint("EndDate: $endDate");
      if (startDate != 0 && endDate != 0) {
        filterCondition =
            "(${DatabaseHelper.columnDate} >= ? AND ${DatabaseHelper.columnDate} < ?) AND";
        queryArgs = [startDate, endDate];
      }

      debugPrint("TaskType: $type");
      switch (type) {
        case TaskType.all:
          query = "SELECT * FROM ${DatabaseHelper.taskTable}";
          break;
        case TaskType.pending:
          query = "SELECT * FROM ${DatabaseHelper.taskTable}"
              " WHERE $filterCondition (${DatabaseHelper.columnStatus} != ${AppConstant.cancelled} AND ${DatabaseHelper.columnStatus} != ${AppConstant.completed}) AND (${DatabaseHelper.columnDate} >= ? OR ${DatabaseHelper.columnDate} < ${DatabaseHelper.columnStartTime} ) ORDER BY ${DatabaseHelper.columnId}";
          queryArgs.add(DateTime.now().millisecondsSinceEpoch);
          break;
        case TaskType.onGoing:
          query =
              "SELECT * FROM ${DatabaseHelper.taskTable} WHERE $filterCondition (${DatabaseHelper.columnStatus} != ${AppConstant.cancelled} AND ${DatabaseHelper.columnStatus} != ${AppConstant.completed}) AND (${DatabaseHelper.columnStartTime}<= ? AND ${DatabaseHelper.columnEndTime} >= ? AND ${DatabaseHelper.columnDate} <=?)";
          queryArgs = [
            DateTime.now().millisecondsSinceEpoch,
            DateTime.now().millisecondsSinceEpoch,
            DateTime.now().millisecondsSinceEpoch
          ];
          break;
        case TaskType.completed:
          query =
              "SELECT * FROM  ${DatabaseHelper.taskTable} WHERE $filterCondition (${DatabaseHelper.columnStatus}=${AppConstant.completed})";
        case TaskType.cancelled:
          query =
              "SELECT * FROM ${DatabaseHelper.taskTable} WHERE  $filterCondition (${DatabaseHelper.columnStatus}=${AppConstant.cancelled})";
      }

      debugPrint("Query: $query");
      debugPrint("Query Args: $queryArgs");

      List<Map<String, dynamic>> tasks = await db!.rawQuery(query, queryArgs);
      debugPrint("Tasks: $tasks");
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
      db.close();
      return taskList;
    } catch (e) {
      debugPrint("Error: $e");
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

  // Update Task Status
  Future<bool> updateTaskStatus(int taskId, int taskStatus) async {
    Database? db = await DatabaseHelper.instance.database();
    try {
      await db!.update(
          DatabaseHelper.taskTable, {DatabaseHelper.columnStatus: taskStatus},
          where: "${DatabaseHelper.columnId} = ?", whereArgs: [taskId]);
      db.close();
      return true;
    } catch (e) {
      debugPrint("Error: $e");
      rethrow;
    }
  }

  // Get task by date from local storage
  Future<List<TaskModel>> getAllTaskByDate({required int date}) async {
    Database? db = await DatabaseHelper.instance.database();
    try {
      List<Map<String, dynamic>> tasks = await db!.query(
          DatabaseHelper.taskTable,
          where: "${DatabaseHelper.columnDate} = ?",
          whereArgs: [date]);
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
      db.close();
      return taskList;
    } catch (e) {
      debugPrint("Error: $e");
      rethrow;
    }
  }
}
