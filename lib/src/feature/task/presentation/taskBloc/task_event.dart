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

class TaskCreateRequest extends TaskEvent {
  final TaskModel taskModel;
  const TaskCreateRequest({required this.taskModel});

  @override
  List<Object> get props => [taskModel];
}
