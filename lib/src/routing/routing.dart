import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_task_manager/src/feature/authentication/presentation/page/sign_in_page.dart';
import 'package:t_task_manager/src/feature/authentication/presentation/page/sign_up_page.dart';
import 'package:t_task_manager/src/feature/history/presentation/page/task_history_page.dart';
import 'package:t_task_manager/src/feature/home/presentation/page/home_page.dart';
import 'package:t_task_manager/src/feature/root/presentation/page/root_screen.dart';
import 'package:t_task_manager/src/feature/setting/presentation/page/setting_page.dart';
import 'package:t_task_manager/src/feature/splash/intro_screen.dart';
import 'package:t_task_manager/src/feature/splash/splash_screen.dart';
import 'package:t_task_manager/src/feature/task/presentation/page/add_task_page.dart';
import 'package:t_task_manager/src/feature/task/presentation/page/task_list_by_category_page.dart';
import 'package:t_task_manager/src/feature/task/presentation/page/task_list_page.dart';
import 'package:t_task_manager/src/feature/task/presentation/taskBloc/task_bloc.dart';
import 'package:t_task_manager/src/feature/task/repositories/task_local_repo.dart';
import 'package:t_task_manager/src/feature/task/repositories/task_server_repo.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case '/SplashScreen':
        return MaterialPageRoute(builder: (_) => const SplashScreen());

      case '/SignInPage':
        return MaterialPageRoute(builder: (_) => const SignInPage());

      case '/SignUpPage':
        return MaterialPageRoute(builder: (_) => const SignUpPage());

      case '/IntroScreen':
        return MaterialPageRoute(builder: (_) => const IntroScreen());

      case '/HomePage':
        return MaterialPageRoute(builder: (_) => const HomePage());

      case '/RootScreen':
        return MaterialPageRoute(builder: (_) => const RootScreen());

      case '/TaskHistoryPage':
        return MaterialPageRoute(
            builder: (_) => MultiRepositoryProvider(
                  providers: [
                    RepositoryProvider(
                      create: (context) => TaskLocalRepo(),
                    ),
                    RepositoryProvider(
                      create: (context) => TaskServerRepo(),
                    ),
                  ],
                  child: BlocProvider(
                    create: (context) => TaskBloc(
                      context.read<TaskLocalRepo>(),
                      context.read<TaskServerRepo>(),
                    )..add(TaskListRequested(taskType: args)),
                    child: TaskHistoryPage(
                      taskType: args as TaskType,
                    ),
                  ),
                ));
      case '/TaskListPage':
        return MaterialPageRoute(
            builder: (_) => MultiRepositoryProvider(
                  providers: [
                    RepositoryProvider(
                      create: (context) => TaskLocalRepo(),
                    ),
                    RepositoryProvider(
                      create: (context) => TaskServerRepo(),
                    ),
                  ],
                  child: BlocProvider(
                    create: (context) => TaskBloc(context.read<TaskLocalRepo>(),
                        context.read<TaskServerRepo>()),
                    child: const TaskListPage(),
                  ),
                ));

      case '/TaskListByCategoryPage':
        return MaterialPageRoute(
            builder: (_) => TaskListByCategoryPage(
                  taskType: args as TaskCategory,
                ));

      case '/SettingPage':
        return MaterialPageRoute(builder: (_) => const SettingPage());

      case '/AddTaskPage':
        return MaterialPageRoute(
            builder: (_) => MultiRepositoryProvider(
                  providers: [
                    RepositoryProvider(
                      create: (context) => TaskLocalRepo(),
                    ),
                    RepositoryProvider(
                      create: (context) => TaskServerRepo(),
                    ),
                  ],
                  child: BlocProvider(
                    create: (context) => TaskBloc(context.read<TaskLocalRepo>(),
                        context.read<TaskServerRepo>()),
                    child: const AddTaskPage(),
                  ),
                ));

      default:
        return MaterialPageRoute(builder: (_) => Container());
    }
  }
}
