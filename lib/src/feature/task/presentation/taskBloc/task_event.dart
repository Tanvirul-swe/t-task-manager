part of 'task_bloc.dart';

abstract class TaskEvent extends Equatable {
  const TaskEvent();

  @override
  List<Object> get props => [];
}

class TaskListRequested extends TaskEvent {
  final TaskType taskType;
  const TaskListRequested({required this.taskType});

  @override
  List<Object> get props => [taskType];
}

class TaskDeleteRequested extends TaskEvent {
  final int taskId;
  const TaskDeleteRequested({required this.taskId});

  @override
  List<Object> get props => [taskId];
}

class TaskStatusUpdateRequested extends TaskEvent {
  final int taskId;
  final int taskStatus;
  const TaskStatusUpdateRequested(
      {required this.taskId, required this.taskStatus});

  @override
  List<Object> get props => [taskId, taskStatus];
}

class TaskCreateRequest extends TaskEvent {
  final TaskModel taskModel;
  const TaskCreateRequest({required this.taskModel});

  @override
  List<Object> get props => [taskModel];
}
