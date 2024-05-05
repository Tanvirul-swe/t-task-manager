// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:t_task_manager/src/common/widget/common_dialog.dart';
import 'package:t_task_manager/src/common/widget/common_widget.dart';
import 'package:t_task_manager/src/common/widget/primary_text_buttom.dart';
import 'package:t_task_manager/src/constant/app_asset.dart';
import 'package:t_task_manager/src/constant/common_content.dart';
import 'package:t_task_manager/src/constant/text_style.dart';
import 'package:t_task_manager/src/feature/history/presentation/page/task_history_page.dart';
import 'package:t_task_manager/src/feature/home/presentation/bloc/home_bloc.dart';
import 'package:t_task_manager/src/feature/home/presentation/widget/task_card.dart';
import 'package:t_task_manager/src/feature/home/presentation/widget/task_category_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Padding(
            padding: const EdgeInsets.only(left: 8),
            child: Text(
              'Hi, Steven',
              style: largeHeadingTextStyle
                  .copyWith(fontWeight: FontWeight.bold, shadows: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 1,
                  offset: const Offset(0, 3), // changes position of shadow
                ),
              ]),
            ),
          ),
          actions: [
            // Profile image
            Container(
              margin: const EdgeInsets.only(right: 20),
              child: const CircleAvatar(
                radius: 20,
                backgroundImage: AssetImage(AppAsset.profilePng),
              ),
            ),
          ],
        ),
        body: Padding(
          padding:
              const EdgeInsets.symmetric(horizontal: scaffoldDefaultPadding),
          child: BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) {
              if (state is HomeLoading) {
                return loadingPageWidget();
              } else if (state is TodayTaskLoaded) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Let’s make this day productive',
                      style: GoogleFonts.hindSiliguri(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: const Color(0xFF575757)),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text("My Task", style: mediumHeadingTextStyle),
                    const SizedBox(
                      height: 10,
                    ),
                    // Task Type card gridview like Pending ,complete,cancell, on going

                    SizedBox(
                      height: 260,
                      child: GridView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          // shrinkWrap: true,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 10,
                                  mainAxisSpacing: 10,
                                  childAspectRatio: 1.5),
                          itemCount: 4,
                          itemBuilder: (context, index) {
                            return InkWell(
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, '/TaskHistoryPage',
                                      arguments: TaskType.values[index]);
                                },
                                child: TaskCategoryCard(
                                    index: index,
                                    count: index == 0
                                        ? state.complete
                                        : index == 1
                                            ? state.pending
                                            : index == 2
                                                ? state.cancelled
                                                : state.onGoing));
                          }),
                    ),

                    Row(
                      children: [
                        Text("Today Task", style: mediumHeadingTextStyle),
                        const Spacer(),
                        PrimaryTextButtom(title: "View all", onPressed: () {}),
                      ],
                    ),

                    const SizedBox(
                      height: 10,
                    ),
                    if (state.tasks.isEmpty) ...[
                      emptyScreenWidget(
                        "You don't have any task today",
                      ),
                    ],
                    Expanded(
                      child: ListView.separated(
                        shrinkWrap: true,
                        itemCount: state.tasks.length,
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: ((context, index) {
                          return TaskCard(
                            taskType: TaskType.onGoing,
                            model: state.tasks[index],
                            onChanged: (p0) {
                              switch (p0) {
                                case "Edit":
                                  showCustomDialog(
                                    context,
                                    title: "Edit Task",
                                    content: "Do you want to edit this task?",
                                    onYes: () {
                                      Navigator.pushNamed(
                                              context, '/AddTaskPage',
                                              arguments: state.tasks[index])
                                          .then((value) {
                                        if (value != null) {
                                          showCustomSnackBar(context,
                                              "Task Updated Successfully");
                                          context
                                              .read<HomeBloc>()
                                              .add(const TodayTaskRequested());
                                        }
                                      });
                                    },
                                    onCancel: () {},
                                  );

                                  break;
                                case "Delete":
                                  showCustomDialog(context,
                                      title: "Delete Task",
                                      content:
                                          "Do you want to delete this task?",
                                      onYes: () {
                                    context.read<HomeBloc>().add(
                                        TaskDeleteRequested(
                                            taskId: state.tasks[index].id));
                                  }, onCancel: () {});

                                  break;
                                case "Cancel":
                                  break;
                                case "Start":
                                  break;
                                case "End":
                                  break;
                                default:
                              }
                            },
                            index: index,
                          );
                        }),
                        separatorBuilder: (context, index) {
                          return const SizedBox(
                            height: 8,
                          );
                        },
                      ),
                    )
                  ],
                );
              }
              return Container();
            },
          ),
        ));
  }
}
