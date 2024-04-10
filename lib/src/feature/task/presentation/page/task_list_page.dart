import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:t_task_manager/src/common/widget/primary_text_buttom.dart';
import 'package:t_task_manager/src/common/widget/primary_textfield.dart';
import 'package:t_task_manager/src/constant/app_asset.dart';
import 'package:t_task_manager/src/constant/app_colors.dart';
import 'package:t_task_manager/src/constant/common_content.dart';
import 'package:t_task_manager/src/constant/text_style.dart';
import 'package:t_task_manager/src/feature/history/presentation/page/task_history_page.dart';
import 'package:t_task_manager/src/feature/home/presentation/widget/task_card.dart';

class TaskListPage extends StatefulWidget {
  final TaskType taskType;
  const TaskListPage({super.key, this.taskType = TaskType.onGoing});

  @override
  State<TaskListPage> createState() => _TaskListPageState();
}

class _TaskListPageState extends State<TaskListPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Task",
                  style: smallHeadingTextStyle,
                ),
                Row(
                  children: [
                    SvgPicture.asset(
                      AppAsset.calender,
                      width: 14,
                      height: 14,
                    ),
                    const SizedBox(width: textLineGap * 2),
                    Text(
                      "August 2021",
                      style: style14RegularGray.copyWith(
                          fontSize: 12, color: const Color(0xFF525F77)),
                    )
                  ],
                ),
              ],
            ),
            const SizedBox(height: 15),
            // Date time view
            EasyDateTimeLine(
              initialDate: DateTime.now(),
              onDateChange: (selectedDate) {
                //`selectedDate` the new date selected.
              },
              headerProps: const EasyHeaderProps(showHeader: false),
              dayProps: const EasyDayProps(
                height: 71,
                width: 48,
                dayStructure: DayStructure.dayStrDayNum,
                activeDayStyle: DayStyle(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color(0xff3371FF),
                        Color(0xff8426D6),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 15),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Today",
                  style: smallHeadingTextStyle,
                ),
                Text("09 h 45 min",
                    style: style14RegularGray.copyWith(
                      color: AppColors.primaryBlack,
                    )),
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            Expanded(
              child: ListView.separated(
                  shrinkWrap: true,
                  itemBuilder: (context, int index) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (index == 2) ...[
                          Row(
                            children: [
                              const SizedBox(width: 8),
                              Text("09:00",
                                  style: style14RegularGray.copyWith(
                                    color: AppColors.primaryBlack,
                                  )),
                              const SizedBox(width: 8),
                              Text(
                                "You don’t have any schedule",
                                style: style14RegularGray,
                              ),
                              const SizedBox(width: 8),
                              PrimaryTextButtom(
                                title: "+Add",
                                onPressed: () {},
                                textColor: AppColors.primaryBlack,
                              )
                            ],
                          ),
                        ],
                        if (index != 2)
                          SizedBox(
                            height: 128,
                            child: ListView.separated(
                                scrollDirection: Axis.horizontal,
                                shrinkWrap: true,
                                itemBuilder: (context, int i) {
                                  return Row(
                                    children: [
                                      if (i == 0) ...[
                                        const SizedBox(width: 8),
                                        Text("08:00",
                                            style: style14RegularGray.copyWith(
                                              color: AppColors.primaryBlack,
                                            )),
                                        const SizedBox(width: 8),
                                      ],
                                      TaskCard(
                                        onChanged: (p0) {
                                          debugPrint("p0: $p0");
                                        },
                                        taskType: widget.taskType,
                                        color: widget.taskType ==
                                                TaskType.pending
                                            ? const Color(0xFFEEF0FF)
                                            : widget.taskType ==
                                                    TaskType.cancelled
                                                ? const Color(0xFFFFF2F2)
                                                : widget.taskType ==
                                                        TaskType.onGoing
                                                    ? const Color(0xFFCBF9D8)
                                                        .withOpacity(0.25)
                                                    : const Color(0xFFEBF9FF),
                                        dividerColor: widget.taskType ==
                                                TaskType.pending
                                            ? const Color(0xFF8F99EB)
                                            : widget.taskType ==
                                                    TaskType.cancelled
                                                ? const Color(0xFFE88B8C)
                                                : widget.taskType ==
                                                        TaskType.onGoing
                                                    ? const Color(0xFF67EF8D)
                                                        .withOpacity(0.25)
                                                    : const Color(0xFF46C7FE),
                                        index: i,
                                      ),
                                    ],
                                  );
                                },
                                separatorBuilder: (context, int i) {
                                  return const SizedBox(width: 8);
                                },
                                itemCount: 10),
                          )
                      ],
                    );
                  },
                  separatorBuilder: (context, int index) {
                    return const Divider(color: Color(0xFFE3E8F1));
                  },
                  itemCount: 12),
            )
          ],
        ),
      ),
    );
  }
}
