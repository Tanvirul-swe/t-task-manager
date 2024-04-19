import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart';
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
  Future<List<TaskModel>> getAllTask() async {
    Database? db = await DatabaseHelper.instance.database();
    try {
      List<Map<String, dynamic>> tasks =
          await db!.query(DatabaseHelper.taskTable);
      List<TaskModel> taskList = [];
      await Future.forEach(tasks, (element) async {
        List<Map<String, dynamic>> tags = await db.query(
            DatabaseHelper.taskTagTable,
            where: "${DatabaseHelper.columnTaskId} = ?",
            whereArgs: [element[DatabaseHelper.columnId]]);
        debugPrint("Tags: $tags");
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
