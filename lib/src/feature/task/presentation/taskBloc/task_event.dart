part of 'task_bloc.dart';

abstract class TaskEvent extends Equatable {
  const TaskEvent();

  @override
  List<Object> get props => [];
}

class TaskListRequested extends TaskEvent {
  final TaskType taskType;
  final int startDate;
  final int endDate;
  const TaskListRequested(
      {required this.taskType, this.endDate = 0, this.startDate = 0});

  @override
  List<Object> get props => [taskType, startDate, endDate];
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

class TaskRequestEventByDate extends TaskEvent{
  final int date;
  const TaskRequestEventByDate({required this.date});

  @override
  List<Object> get props => [date];
}
