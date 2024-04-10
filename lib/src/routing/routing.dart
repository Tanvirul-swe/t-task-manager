import 'package:flutter/material.dart';
import 'package:t_task_manager/src/feature/authentication/presentation/page/sign_in_page.dart';
import 'package:t_task_manager/src/feature/authentication/presentation/page/sign_up_page.dart';
import 'package:t_task_manager/src/feature/history/presentation/page/task_history_page.dart';
import 'package:t_task_manager/src/feature/home/presentation/page/home_page.dart';
import 'package:t_task_manager/src/feature/root/presentation/page/root_screen.dart';
import 'package:t_task_manager/src/feature/splash/intro_screen.dart';
import 'package:t_task_manager/src/feature/splash/splash_screen.dart';
import 'package:t_task_manager/src/feature/task/presentation/page/task_list_page.dart';

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
            builder: (_) => TaskHistoryPage(
                  taskType: args as TaskType,
                ));
      case '/TaskListPage':
        return MaterialPageRoute(builder: (_) => const TaskListPage());

      default:
        return MaterialPageRoute(builder: (_) => Container());
    }
  }
}
