part of 'home_bloc.dart';

sealed class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class TodayTaskLoaded extends HomeState {
  final List<TaskModel> tasks;
    final int complete;
  final int pending;
  final int cancelled;
  final int onGoing;
  const TodayTaskLoaded({required this.tasks,required this.complete,required this.pending,required this.cancelled,required this.onGoing});

  @override
  List<Object> get props => [tasks,complete,pending,cancelled,onGoing];
}



