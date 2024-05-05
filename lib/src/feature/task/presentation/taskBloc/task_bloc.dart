import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_task_manager/src/common/function/common_method.dart';
import 'package:t_task_manager/src/feature/history/presentation/page/task_history_page.dart';
import 'package:t_task_manager/src/feature/task/data/model/task_model.dart';
import 'package:t_task_manager/src/feature/task/repositories/task_local_repo.dart';
import 'package:t_task_manager/src/feature/task/repositories/task_server_repo.dart';

part 'task_event.dart';
part 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final TaskLocalRepo taskLocalRepo;
  final TaskServerRepo taskServerRepo;
  TaskBloc(this.taskLocalRepo, this.taskServerRepo) : super(TaskInitial()) {
    on<TaskEvent>((event, emit) async {
      try {
        emit(TaskLoading());

        // await Future.delayed(const Duration(seconds: 2));

        if (event is TaskListRequested) {
          final tasks = await taskLocalRepo.getAllTask(event.taskType);

          if (tasks.isEmpty) {
            emit(TaskEmpty());
          } else {
            emit(TaskLoaded(tasks: tasks));
          }
        } else if (event is TaskCreateRequest) {
          final result = await taskLocalRepo.addTask(event.taskModel);
          debugPrint("Task Create Result: $result");
          if (result) {
            emit(const TaskCreateSuccess());
          }
        } else if (event is TaskDeleteRequested) {
          final result = await taskLocalRepo.deleteTask(event.taskId);
          debugPrint("Task Delete Result: $result");
          if (result) {
            emit(const TaskDeleteSuccess());
          }
        } else if (event is TaskStatusUpdateRequested) {
          final result = await taskLocalRepo.updateTaskStatus(
              event.taskId, event.taskStatus);
          debugPrint("Task Status Update Result: $result");
          if (result) {
            emit(const TaskStatusUpdateSuccess());
          }
        }
      } catch (e) {
        emit(TaskError(message: e.toString()));
      }
    });
  }

  // Make Task Group by date
  List<Map<String, List<TaskModel>>> taskGroupByDate(List<TaskModel> tasks) {
    List<Map<String, List<TaskModel>>> taskMap = [];
    // Group By Date Make same date task in one list
    for (var element in tasks) {
      //Key value formate is  14 May 2021
      final key = CommonMethod.millisToRealDate(element.date);
      debugPrint("Task Date: ${key}");

      if (taskMap.isEmpty) {
        taskMap.add({
          key: [element]
        });
      } else {
        final index = taskMap.indexWhere((element) => element.containsKey(key));
        if (index == -1) {
          taskMap.add({
            key: [element]
          });
        } else {
          taskMap[index][key]!.add(element);
        }
      }
    }
    return taskMap;
  }
}
