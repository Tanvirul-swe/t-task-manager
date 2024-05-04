import 'package:t_task_manager/src/service/local_database_helper.dart';

class TaskTagModel {
  final int id;
  final int takId;
  final String name;

  TaskTagModel({required this.id, required this.name, required this.takId});

  factory TaskTagModel.fromJson(Map<String, dynamic> json) {
    return TaskTagModel(
        id: json['id'], name: json['tag_name'], takId: json['task_id']);
  }

  factory TaskTagModel.fromLocalDB(Map<String, dynamic> json) {
    return TaskTagModel(
        id: json[DatabaseHelper.columnId],
        name: json[DatabaseHelper.columnTagName],
        takId: json[DatabaseHelper.columnTaskId]);
  }

  Map<String, dynamic> toMap() {
    return {
      DatabaseHelper.columnId: id,
      DatabaseHelper.columnTagName: name,
      DatabaseHelper.columnTaskId: takId
    };
  }

  TaskTagModel copyWith({required int id, required int takId}) {
    return TaskTagModel(id: id, name: name, takId: takId);
  }
}
