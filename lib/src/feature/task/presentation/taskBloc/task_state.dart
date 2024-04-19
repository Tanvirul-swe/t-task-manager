part of 'task_bloc.dart';

abstract class TaskState extends Equatable {
  const TaskState();

  @override
  List<Object> get props => [];
}

class TaskInitial extends TaskState {}

class TaskLoading extends TaskState {}

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

