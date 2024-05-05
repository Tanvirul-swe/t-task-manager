import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:t_task_manager/src/common/widget/common_dialog.dart';
import 'package:t_task_manager/src/common/widget/common_widget.dart';
import 'package:t_task_manager/src/common/widget/primary_textfield.dart';
import 'package:t_task_manager/src/constant/app_asset.dart';
import 'package:t_task_manager/src/constant/app_constant.dart';
import 'package:t_task_manager/src/constant/common_content.dart';
import 'package:t_task_manager/src/constant/text_style.dart';
import 'package:t_task_manager/src/feature/home/presentation/widget/task_card.dart';
import 'package:t_task_manager/src/feature/task/data/model/task_model.dart';
import 'package:t_task_manager/src/feature/task/presentation/taskBloc/task_bloc.dart';

enum TaskType { completed, pending, cancelled, onGoing, all }

enum TaskCategory { personal, work, private, meeting, event }

class TaskHistoryPage extends StatefulWidget {
  final TaskType taskType;
  const TaskHistoryPage({super.key, required this.taskType});

  @override
  State<TaskHistoryPage> createState() => _TaskHistoryPageState();
}

class _TaskHistoryPageState extends State<TaskHistoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: Text(
            getTaskHistoryTitle(widget.taskType),
            style: appBarTextStyle,
          )),
      body: Padding(
        padding: const EdgeInsets.all(scaffoldDefaultPadding),
        child: BlocConsumer<TaskBloc, TaskState>(
          listener: (context, state) {
            if (state is TaskDeleteSuccess) {
              showCustomSnackBar(context, "Task Deleted Successfully");
              context
                  .read<TaskBloc>()
                  .add(TaskListRequested(taskType: widget.taskType));
            } else if (state is TaskStatusUpdateSuccess) {
              showCustomSnackBar(context, "Task Cancelled Successfully");
              context
                  .read<TaskBloc>()
                  .add(TaskListRequested(taskType: widget.taskType));
            } else if (state is TaskStatusUpdateSuccess) {
              showCustomSnackBar(context, "Task Completed Successfully");
              context
                  .read<TaskBloc>()
                  .add(TaskListRequested(taskType: widget.taskType));
            }
          },
          builder: (context, state) {
            if (state is TaskLoading) {
              return loadingPageWidget();
            } else if (state is TaskError) {
              return errorScreenWidget();
            } else if (state is TaskLoaded) {
              List<Map<String, List<TaskModel>>> finalTaskData =
                  context.read<TaskBloc>().taskGroupByDate(state.tasks);
              return Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: SearchTextField(
                          prefixIcon: AppAsset.searchIcon,
                          controller: TextEditingController(),
                          labelText: "Search",
                          hintText: "Search by task name",
                        ),
                      ),
                      const SizedBox(width: 10),
                      Container(
                        height: 45,
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF6F6F6),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(
                          Icons.filter_alt_outlined,
                          color: Color(0xFFBEC4D0),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  Row(
                    children: [
                      SvgPicture.asset(AppAsset.calender),
                      const SizedBox(width: textLineGap * 2),
                      Text(
                        "May 2021",
                        style: smallHeadingTextStyle,
                      )
                    ],
                  ),
                  Expanded(
                    child: ListView.separated(
                      itemCount: finalTaskData.length,
                      shrinkWrap: true,
                      itemBuilder: (context, int index) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 15),
                            Text(
                              finalTaskData[index].keys.first,
                              style: style14RegularGray.copyWith(
                                  color: const Color(0xFF525F77)),
                            ),
                            const SizedBox(height: 10),
                            SizedBox(
                              height: 128,
                              child: ListView.separated(
                                itemCount:
                                    finalTaskData[index].values.first.length,
                                scrollDirection: Axis.horizontal,
                                shrinkWrap: true,
                                itemBuilder: (context, int i) {
                                  return TaskCard(
                                    width:
                                        MediaQuery.of(context).size.width * 0.7,
                                    model: finalTaskData[index].values.first[i],
                                    onChanged: (p0) {
                                      switch (p0) {
                                        case "Edit":
                                          showCustomDialog(
                                            context,
                                            title: "Edit Task",
                                            content:
                                                "Do you want to edit this task?",
                                            onYes: () {
                                              Navigator.pushNamed(
                                                      context, '/AddTaskPage',
                                                      arguments:
                                                          finalTaskData[index]
                                                              .values
                                                              .first[i])
                                                  .then((value) {
                                                if (value != null) {
                                                  showCustomSnackBar(context,
                                                      "Task Updated Successfully");
                                                  context.read<TaskBloc>().add(
                                                      TaskListRequested(
                                                          taskType:
                                                              widget.taskType));
                                                }
                                              });
                                            },
                                            onCancel: () {},
                                          );

                                          break;
                                        case "Delete":
                                          showCustomDialog(
                                            context,
                                            title: "Delete",
                                            content:
                                                "Do you want to delete this task?",
                                            onYes: () {
                                              context.read<TaskBloc>().add(
                                                  TaskDeleteRequested(
                                                      taskId:
                                                          finalTaskData[index]
                                                              .values
                                                              .first[i]
                                                              .id));
                                            },
                                            onCancel: () {},
                                          );

                                          break;
                                        case "Cancel":
                                          showCustomDialog(context,
                                              title: "Cancel Task",
                                              content:
                                                  "Do you want to cancel this task?",
                                              onYes: () {
                                            context.read<TaskBloc>().add(
                                                TaskStatusUpdateRequested(
                                                    taskId: finalTaskData[index]
                                                        .values
                                                        .first[i]
                                                        .id,
                                                    taskStatus:
                                                        AppConstant.cancelled));
                                          }, onCancel: () {});
                                          break;
                                        case 'Complete':
                                          showCustomDialog(context,
                                              title: "Complete Task",
                                              content:
                                                  "Do you want to complete this task?",
                                              onYes: () {
                                            context.read<TaskBloc>().add(
                                                TaskStatusUpdateRequested(
                                                    taskId: finalTaskData[index]
                                                        .values
                                                        .first[i]
                                                        .id,
                                                    taskStatus:
                                                        AppConstant.completed));
                                          }, onCancel: () {});
                                          break;

                                        case "Restore":
                                          showCustomDialog(context,
                                              title: "Restore Task",
                                              content:
                                                  "Do you want to restore this task?",
                                              onYes: () {
                                            Navigator.pushNamed(
                                                    context, '/AddTaskPage',
                                                    arguments:
                                                        finalTaskData[index]
                                                            .values
                                                            .first[i])
                                                .then((value) {
                                              if (value != null) {
                                                showCustomSnackBar(context,
                                                    "Task Updated Successfully");
                                                context.read<TaskBloc>().add(
                                                    TaskListRequested(
                                                        taskType:
                                                            widget.taskType));
                                              }
                                            });
                                          }, onCancel: () {});

                                        default:
                                      }
                                    },
                                    taskType: widget.taskType,
                                    color: widget.taskType == TaskType.pending
                                        ? const Color(0xFFEEF0FF)
                                        : widget.taskType == TaskType.cancelled
                                            ? const Color(0xFFFFF2F2)
                                            : widget.taskType ==
                                                    TaskType.onGoing
                                                ? const Color(0xFFCBF9D8)
                                                    .withOpacity(0.25)
                                                : const Color(0xFFEBF9FF),
                                    dividerColor: widget.taskType ==
                                            TaskType.pending
                                        ? const Color(0xFF8F99EB)
                                        : widget.taskType == TaskType.cancelled
                                            ? const Color(0xFFE88B8C)
                                            : widget.taskType ==
                                                    TaskType.onGoing
                                                ? const Color(0xFF67EF8D)
                                                    .withOpacity(0.25)
                                                : const Color(0xFF46C7FE),
                                    index: i,
                                  );
                                },
                                separatorBuilder: (context, int i) {
                                  return const SizedBox(width: 10);
                                },
                              ),
                            )
                          ],
                        );
                      },
                      separatorBuilder: (context, int index) {
                        return const SizedBox(height: 10);
                      },
                    ),
                  )
                ],
              );
            } else if (state is TaskEmpty) {
              return Center(
                child: emptyScreenWidget(
                  "No Task Found",
                ),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
