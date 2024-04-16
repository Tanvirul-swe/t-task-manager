// ignore_for_file: deprecated_member_use

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:t_task_manager/src/constant/app_colors.dart';
import 'package:t_task_manager/src/feature/activity/presentation/page/activity_page.dart';
import 'package:t_task_manager/src/feature/home/presentation/page/home_page.dart';
import 'package:t_task_manager/src/feature/profile/presentation/page/profile_page.dart';
import 'package:t_task_manager/src/feature/root/presentation/cubit/nav_cubit.dart';
import 'package:t_task_manager/src/feature/root/presentation/widget/crystal_navigation_bar_item.dart';
import 'package:t_task_manager/src/feature/root/presentation/widget/nav_bar.dart';
import 'package:t_task_manager/src/feature/task/presentation/page/task_list_page.dart';

class RootScreen extends StatefulWidget {
  const RootScreen({super.key});

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  int currentIndex = 0;
  final StreamController<int> _navStream = StreamController<int>.broadcast();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<NavCubit>(
          create: (context) => NavCubit(currentIndex),
        ),
      ],
      child: BlocBuilder<NavCubit, NavState>(
        builder: (context, state) {
          return Scaffold(
            extendBody: true,
            floatingActionButton: FloatingActionButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              tooltip: "Add Task",
              onPressed: () {
                Navigator.pushNamed(context, "/AddTaskPage");
              },
              backgroundColor: AppColors.primaryBlue,
              child: const Icon(
                Icons.add,
                color: AppColors.primaryWhite,
              ),
            ),
            body: Builder(builder: (context) {
              switch (state.navItem) {
                case HomeNavItem.home:
                  return const HomePage();
                case HomeNavItem.tasks:
                  return const TaskListPage();
                case HomeNavItem.activity:
                  return const ActivityPage();
                case HomeNavItem.profile:
                  return const ProfilePage();
              }
            }),
            bottomNavigationBar: Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: StreamBuilder<int>(
                  stream: _navStream.stream,
                  builder: (context, snapshot) {
                    return CrystalNavigationBar(
                      currentIndex: currentIndex,
                      height: 10,
                      borderRadius: 14,
                      marginR: const EdgeInsets.symmetric(horizontal: 30),
                      indicatorColor: Colors.blue,
                      unselectedItemColor: Colors.white70,
                      backgroundColor: AppColors.primaryWhite,
                      onTap: (i) {
                        currentIndex = i;
                        _navStream.sink.add(i);
                        context
                            .read<NavCubit>()
                            .getNavItem(HomeNavItem.values[i]);
                      },
                      enableFloatingNavBar: true,
                      items: [
                        /// Home
                        CrystalNavigationBarItem(
                          icon: SvgPicture.asset("asset/icon/Home.svg",
                              color: AppColors.primaryBlue),
                          unselectedIcon:
                              SvgPicture.asset('asset/icon/Home.svg'),
                          selectedColor: AppColors.primaryGray,
                        ),

                        /// Favourite
                        CrystalNavigationBarItem(
                          icon: SvgPicture.asset('asset/icon/Document.svg',
                              color: AppColors.primaryBlue),
                          unselectedIcon:
                              SvgPicture.asset('asset/icon/Document.svg'),
                          selectedColor: AppColors.primaryGray,
                        ),

                        CrystalNavigationBarItem(
                          icon: SvgPicture.asset('asset/icon/Activity.svg',
                              color: AppColors.primaryBlue),
                          unselectedIcon:
                              SvgPicture.asset('asset/icon/Activity.svg'),
                          selectedColor: AppColors.primaryGray,
                        ),
                        CrystalNavigationBarItem(
                          icon: SvgPicture.asset('asset/icon/Folder.svg',
                              color: AppColors.primaryBlue),
                          unselectedIcon:
                              SvgPicture.asset('asset/icon/Folder.svg'),
                          selectedColor: AppColors.primaryGray,
                        ),
                      ],
                    );
                  }),
            ),
          );
        },
      ),
    );
  }
}
