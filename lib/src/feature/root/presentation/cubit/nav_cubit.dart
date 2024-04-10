import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'nav_state.dart';

enum HomeNavItem { home, tasks, activity, profile }

class NavCubit extends Cubit<NavState> {
  final int initialIndex;
  NavCubit(this.initialIndex)
      : super(NavState(
            navItem: initialIndex == 0
                ? HomeNavItem.home
                : initialIndex == 1
                    ? HomeNavItem.tasks
                    : initialIndex == 2
                        ? HomeNavItem.activity
                        : HomeNavItem.profile,
            index: initialIndex));

  void getNavItem(HomeNavItem navItem) {
    switch (navItem) {
      case HomeNavItem.home:
        emit(const NavState(navItem: HomeNavItem.home, index: 0));
        break;
      case HomeNavItem.tasks:
        emit(const NavState(navItem: HomeNavItem.tasks, index: 1));
        break;
      case HomeNavItem.activity:
        emit(const NavState(navItem: HomeNavItem.activity, index: 2));
        break;
      case HomeNavItem.profile:
        emit(const NavState(navItem: HomeNavItem.profile, index: 3));
        break;
    }
  }

  String getAppbarTitle(HomeNavItem navItem, BuildContext context) {
    switch (navItem) {
      case HomeNavItem.home:
        return "Home";
      case HomeNavItem.profile:
        return "Profile";
      case HomeNavItem.tasks:
        return "Tasks";
      case HomeNavItem.activity:
        return "Activity";
    }
  }
}
