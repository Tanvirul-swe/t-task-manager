import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:t_task_manager/src/common/widget/common_widget.dart';
import 'package:t_task_manager/src/common/widget/primary_buttom.dart';
import 'package:t_task_manager/src/common/widget/primary_textfield.dart';
import 'package:t_task_manager/src/constant/app_asset.dart';
import 'package:t_task_manager/src/constant/app_colors.dart';
import 'package:t_task_manager/src/constant/common_content.dart';
import 'package:t_task_manager/src/constant/text_style.dart';

Future<void> filterTaskButtonSheet(
    {required BuildContext context, required Function(dynamic) onApply}) {
  final TextEditingController startDateController = TextEditingController();
  final TextEditingController endDateController = TextEditingController();
  DateTime selectedStartDate = DateTime.now();
  DateTime selectedEndDate = DateTime.now();
  return showModalBottomSheet<void>(
    context: context,
    isDismissible: true,
    backgroundColor: Colors.transparent,
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder:
            (BuildContext context, void Function(void Function()) setState) {
          return SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height * 0.3,
              padding: const EdgeInsets.all(15),
              decoration: const BoxDecoration(
                color: AppColors.primaryWhite,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                ),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(""),
                      Text(
                        "Filter your task",
                        style: appBarTextStyle,
                      ),
                      Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.2),
                            shape: BoxShape.circle),
                        child: InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: const Icon(Icons.close)),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: textfieldgap,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: PrimaryTextField(
                          hintText: "Start date",
                          suffixIcon: AppAsset.calender,
                          labelText: "Start date",
                          readOnly: true,
                          onTap: () async {
                            DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(DateTime.now().year),
                              lastDate: DateTime(2101),
                              initialEntryMode:
                                  DatePickerEntryMode.calendarOnly,
                              builder: (BuildContext context, Widget? child) {
                                return Theme(
                                  data: dateTimeTheme(),
                                  child: child ?? const Text(""),
                                );
                              },
                            );
                            if (pickedDate != null) {
                              String formattedDate =
                                  DateFormat('dd MMMM yyyy').format(pickedDate);
                              // selectedDate = pickedDate;
                              setState(() {
                                selectedStartDate = pickedDate;
                                startDateController.text = formattedDate;
                              });
                            }
                          },
                          controller: startDateController,
                        ),
                      ),
                      const SizedBox(
                        width: textfieldgap,
                      ),
                      Expanded(
                        child: PrimaryTextField(
                          hintText: "End date",
                          suffixIcon: AppAsset.calender,
                          labelText: "End date",
                          readOnly: true,
                          onTap: () async {
                            DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(DateTime.now().year),
                              lastDate: DateTime(2101),
                              initialEntryMode:
                                  DatePickerEntryMode.calendarOnly,
                              builder: (BuildContext context, Widget? child) {
                                return Theme(
                                  data: dateTimeTheme(),
                                  child: child ?? const Text(""),
                                );
                              },
                            );
                            if (pickedDate != null) {
                              String formattedDate =
                                  DateFormat('dd MMMM yyyy').format(pickedDate);
                              // selectedDate = pickedDate;
                              setState(() {
                                selectedEndDate = pickedDate;
                                endDateController.text = formattedDate;
                              });
                            }
                          },
                          controller: endDateController,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  PrimaryButtom(
                      title: "Apply",
                      onPressed: () {
                        onApply.call({
                          "startDate": selectedStartDate.millisecondsSinceEpoch,
                          "endDate": selectedEndDate
                              .add(const Duration(days: 1))
                              .millisecondsSinceEpoch
                        });
                        Navigator.pop(context);
                      }),
                ],
              ),
            ),
          );
        },
      );
    },
  );
}
