import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:t_task_manager/firebase_options.dart';
import 'package:t_task_manager/src/constant/app_colors.dart';
import 'package:t_task_manager/src/constant/app_constant.dart';
import 'package:t_task_manager/src/routing/routing.dart';
import 'package:t_task_manager/src/service/local_database_helper.dart';
import 'package:t_task_manager/src/service/permission_helper.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await PermissionHelper.getPermission();
  await DatabaseHelper.instance.database();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: RouteGenerator.generateRoute,
      title: AppConstant.appName,
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.primaryWhite,
          elevation: 0,
        ),
        primaryColor: AppColors.primaryBlue,
        scaffoldBackgroundColor: AppColors.scaffoldBackgroundColor,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: 'HindSiliguri',
        useMaterial3: true,
      ),
      initialRoute: '/IntroScreen',
    );
  }
}
