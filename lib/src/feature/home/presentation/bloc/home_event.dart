part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class TodayTaskRequested extends HomeEvent {
  const TodayTaskRequested();
}

class HomeTaskCountEvent extends HomeEvent {
  const HomeTaskCountEvent();
}
