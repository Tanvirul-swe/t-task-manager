import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:t_task_manager/src/common/widget/primary_textfield.dart';
import 'package:t_task_manager/src/constant/app_asset.dart';
import 'package:t_task_manager/src/constant/common_content.dart';
import 'package:t_task_manager/src/constant/text_style.dart';
import 'package:t_task_manager/src/feature/home/presentation/widget/task_card.dart';

enum TaskType { completed, pending, cancelled, onGoing }

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
                  shrinkWrap: true,
                  itemBuilder: (context, int index) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 15),
                        Text(
                          "14 May 2021",
                          style: style14RegularGray.copyWith(
                              color: const Color(0xFF525F77)),
                        ),
                        const SizedBox(height: 10),
                        SizedBox(
                          height: 128,
                          child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
                              itemBuilder: (context, int i) {
                                return TaskCard(
                                  onChanged: (p0) {
                                    debugPrint("p0: $p0");
                                  },
                                  taskType: widget.taskType,
                                  color: widget.taskType == TaskType.pending
                                      ? const Color(0xFFEEF0FF)
                                      : widget.taskType == TaskType.cancelled
                                          ? const Color(0xFFFFF2F2)
                                          : widget.taskType == TaskType.onGoing
                                              ? const Color(0xFFCBF9D8)
                                                  .withOpacity(0.25)
                                              : const Color(0xFFEBF9FF),
                                  dividerColor: widget.taskType ==
                                          TaskType.pending
                                      ? const Color(0xFF8F99EB)
                                      : widget.taskType == TaskType.cancelled
                                          ? const Color(0xFFE88B8C)
                                          : widget.taskType == TaskType.onGoing
                                              ? const Color(0xFF67EF8D)
                                                  .withOpacity(0.25)
                                              : const Color(0xFF46C7FE),
                                  index: i,
                                );
                              },
                              separatorBuilder: (context, int i) {
                                return const SizedBox(width: 10);
                              },
                              itemCount: 10),
                        )
                      ],
                    );
                  },
                  separatorBuilder: (context, int index) {
                    return const SizedBox(height: 10);
                  },
                  itemCount: 12),
            )
          ],
        ),
      ),
    );
  }
}
