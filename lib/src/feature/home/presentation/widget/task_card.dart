import 'package:flutter/material.dart';
import 'package:t_task_manager/src/constant/app_colors.dart';
import 'package:t_task_manager/src/constant/common_content.dart';
import 'package:t_task_manager/src/constant/text_style.dart';
import 'package:t_task_manager/src/feature/history/presentation/page/task_history_page.dart';

class TaskCard extends StatelessWidget {
  final Color color;
  final int index;
  final Color dividerColor;
  final TaskType taskType;
  final Function(String?)? onChanged;
  final double? width;
  const TaskCard({
    super.key,
    this.color = AppColors.primaryGray,
    required this.index,
    this.dividerColor = const Color(0xFF8F99EB),
    this.taskType = TaskType.onGoing,
    this.onChanged,
    this.width
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      width: width,
      // height: 120,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          IntrinsicHeight(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: VerticalDivider(
                    color: dividerColor,
                    thickness: 2,
                  ),
                ),
                Flexible(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Cleaning Clothes",
                            style: style16Medum.copyWith(
                                color: const Color(0xFF2C406E),
                                letterSpacing: 0.5),
                          ),
                          // const Spacer(),
                          DropdownButton<String>(
                            borderRadius: BorderRadius.circular(14),
                            iconSize: 15,
                            elevation: 1,
                            underline: const SizedBox.shrink(),
                            icon: const Icon(
                              Icons.more_vert_outlined,
                              color: AppColors.primaryBlack,
                            ),
                            items: getDropDownItem(taskType),
                            onChanged: (value) {
                              onChanged!(value);
                            },
                            // onChanged: onChanged,
                          ),
                        ],
                      ),
                      // const SizedBox(
                      //   height: textLineGap,
                      // ),
                      Text(
                        "07:00 - 07:15",
                        style: style14RegularGray,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: textLineGap * 3,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15),
            child: Row(
              children: List.generate(
                  2,
                  (index) => Container(
                        margin: const EdgeInsets.only(right: 5),
                        padding: const EdgeInsets.all(5),
                        // height: 20,
                        decoration: BoxDecoration(
                            color: const Color(0xFFFFE9ED),
                            borderRadius: BorderRadius.circular(3)),
                        child: Text("Home", style: style10Medium),
                      )),
            ),
          ),
        ],
      ),
    );
  }
}
