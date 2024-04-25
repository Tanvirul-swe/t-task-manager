import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_task_manager/src/feature/home/repositories/home_repository.dart';
import 'package:t_task_manager/src/feature/task/data/model/task_model.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final HomeRepository repo;
  HomeBloc(this.repo) : super(HomeInitial()) {
    on<HomeEvent>((event, emit) async {
      emit(HomeLoading());
      if (event is TodayTaskRequested) {
        final todayTask = await repo.getTodayTask();
        final taskCountMap = await repo.countAllTask();
        emit(TodayTaskLoaded(
            tasks: todayTask,
            cancelled: taskCountMap['cancelled'] ?? 0,
            complete: taskCountMap['completed'] ?? 0,
            onGoing: taskCountMap['onGoing'] ?? 0,
            pending: taskCountMap['pending'] ?? 0));
      } else if (event is HomeTaskCountEvent) {}
    });
  }
}
