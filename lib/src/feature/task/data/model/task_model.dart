import 'package:t_task_manager/src/feature/task/data/model/task_tag_model.dart';
import 'package:t_task_manager/src/service/local_database_helper.dart';

class TaskModel {
  final int id;
  final String title;
  final int date;
  final int startTime;
  final int endTime;
  final String description;
  final String taskType;
  final int createdAt;
  final int updatedAt;
  final int isDeleted;
  final int isSynced;
  final int status;
  // 1 = Completed, 2  = In Progress, 3 = Cancelled 4 = On going

  final List<TaskTagModel> tags;

  TaskModel({
    required this.id,
    required this.title,
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.description,
    required this.taskType,
    required this.createdAt,
    required this.updatedAt,
    required this.isDeleted,
    required this.isSynced,
    this.tags = const [],
    required this.status,
  });

  factory TaskModel.fromMap(Map<String, dynamic> map) {
    return TaskModel(
      id: map['id'],
      title: map['title'],
      date: map['date'],
      startTime: map['startTime'],
      endTime: map['endTime'],
      description: map['description'],
      taskType: map['taskType'],
      createdAt: map['createdAt'],
      updatedAt: map['updatedAt'],
      isDeleted: map['isDeleted'],
      isSynced: map['isSynced'],
      status: map['status'],
      tags: List<TaskTagModel>.from(
        map['tags']?.map((x) => TaskTagModel.fromJson(x)),
      ),
    );
  }
  factory TaskModel.fromLocalDB(
    Map<String, dynamic> json, {
    List<TaskTagModel> tags = const [],
  }) {
    return TaskModel(
      id: json[DatabaseHelper.columnId],
      title: json[DatabaseHelper.columnTitle],
      date: json[DatabaseHelper.columnDate],
      startTime: json[DatabaseHelper.columnStartTime],
      endTime: json[DatabaseHelper.columnEndTime],
      description: json[DatabaseHelper.columnDescription],
      taskType: json[DatabaseHelper.columnTaskType],
      createdAt: json[DatabaseHelper.columnCreatedAt],
      updatedAt: json[DatabaseHelper.columnUpdatedAt],
      isDeleted: json[DatabaseHelper.columnIsDeleted],
      isSynced: json[DatabaseHelper.columnIsSynced] ?? 0,
      tags: tags,
      status: json[DatabaseHelper.columnStatus] ?? 0,
    );
  }
  Map<String, dynamic> toMap() {
    return {
      DatabaseHelper.columnId: id,
      DatabaseHelper.columnTitle: title,
      DatabaseHelper.columnDate: date,
      DatabaseHelper.columnStartTime: startTime,
      DatabaseHelper.columnEndTime: endTime,
      DatabaseHelper.columnDescription: description,
      DatabaseHelper.columnTaskType: taskType,
      DatabaseHelper.columnCreatedAt: createdAt,
      DatabaseHelper.columnUpdatedAt: updatedAt,
      DatabaseHelper.columnIsDeleted: isDeleted,
      DatabaseHelper.columnIsSynced: isSynced,
      DatabaseHelper.columnStatus: status,
    };
  }
}
