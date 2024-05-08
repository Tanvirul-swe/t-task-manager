part of 'task_bloc.dart';

abstract class TaskState extends Equatable {
  const TaskState();

  @override
  List<Object> get props => [];
}

class TaskInitial extends TaskState {}

class TaskLoading extends TaskState {}

class TaskDeleteSuccess extends TaskState {
  const TaskDeleteSuccess();

  @override
  List<Object> get props => [];
}

class TaskStatusUpdateSuccess extends TaskState {
  const TaskStatusUpdateSuccess();

  @override
  List<Object> get props => [];
}

class TaskLoaded extends TaskState {
  final List<TaskModel> tasks;
  const TaskLoaded({
    required this.tasks,
  });

  @override
  List<Object> get props => [tasks];
}

class TaskError extends TaskState {
  final String message;
  const TaskError({required this.message});

  @override
  List<Object> get props => [message];
}

class TaskEmpty extends TaskState {}

class TaskCreateSuccess extends TaskState {
  const TaskCreateSuccess();

  @override
  List<Object> get props => [];
}

class TaskLoadedByDate extends TaskState {
  final List<Map<String, List<TaskModel>>> tasks;
  const TaskLoadedByDate({required this.tasks});

  @override
  List<Object> get props => [tasks];
}
