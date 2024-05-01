import 'package:flutter/material.dart';
import 'package:t_task_manager/src/common/widget/primary_textfield.dart';
import 'package:t_task_manager/src/constant/app_asset.dart';
import 'package:t_task_manager/src/constant/app_colors.dart';
import 'package:t_task_manager/src/constant/common_content.dart';
import 'package:t_task_manager/src/constant/text_style.dart';
import 'package:t_task_manager/src/feature/history/presentation/page/task_history_page.dart';

class TaskListByCategoryPage extends StatefulWidget {
  final TaskCategory taskType;
  const TaskListByCategoryPage(
      {super.key, this.taskType = TaskCategory.personal});

  @override
  State<TaskListByCategoryPage> createState() => _TaskListByCategoryPageState();
}

class _TaskListByCategoryPageState extends State<TaskListByCategoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        tooltip: "Add Task",
        onPressed: () {},
        backgroundColor: AppColors.primaryBlue,
        child: const Icon(
          Icons.add,
          color: AppColors.primaryWhite,
        ),
      ),
      appBar: AppBar(
          centerTitle: true,
          title: Text(
            getTaskCategoryTitle(widget.taskType),
            style: appBarTextStyle,
          )),
      body: Padding(
        padding: const EdgeInsets.all(scaffoldDefaultPadding),
        child: Column(
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

            Expanded(
              child: ListView.separated(
                shrinkWrap: true,
                itemCount: 5,
                physics: const BouncingScrollPhysics(),
                itemBuilder: ((context, index) {
                  // return TaskCard(
                  //   color: widget.taskType == TaskCategory.personal
                  //       ? const Color(0xFFEEF0FF)
                  //       : widget.taskType == TaskCategory.private
                  //           ? const Color(0xFFFFF2F2)
                  //           : widget.taskType == TaskCategory.meeting
                  //               ? const Color(0xFFCBF9D8).withOpacity(0.25)
                  //               : const Color(0xFFEBF9FF),
                  //   dividerColor: widget.taskType == TaskCategory.event
                  //       ? const Color(0xFF8F99EB)
                  //       : widget.taskType == TaskCategory.meeting
                  //           ? const Color(0xFFE88B8C)
                  //           : widget.taskType == TaskCategory.personal
                  //               ? const Color(0xFF67EF8D).withOpacity(0.25)
                  //               : const Color(0xFF46C7FE),
                  //   onChanged: (p0) {
                  //     debugPrint("p0: $p0");
                  //   },
                  //   index: index,
                  // );
                }),
                separatorBuilder: (context, index) {
                  return const SizedBox(
                    height: 8,
                  );
                },
              ),
            )
            // Date time view
          ],
        ),
      ),
    );
  }
}
