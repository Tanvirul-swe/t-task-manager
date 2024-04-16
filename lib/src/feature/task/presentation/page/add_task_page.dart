import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:t_task_manager/src/common/widget/common_dialog.dart';
import 'package:t_task_manager/src/common/widget/primary_textfield.dart';
import 'package:t_task_manager/src/constant/common_content.dart';
import 'package:t_task_manager/src/constant/text_style.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({super.key});

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  String selectedSound = "Ring";

  DateTime? startTime;
  DateTime? endTime;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Add Task",
          style: appBarTextStyle,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(scaffoldDefaultPadding),
        child: Column(
          children: [
            PrimaryTextField(
              hintText: "Enter your task title",
              labelText: "Title",
              controller: TextEditingController(),
            ),
            PrimaryTextField(
              hintText: "Task description",
              labelText: "Description",
              controller: TextEditingController(),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: PrimaryTextField(
                    onTap: () async {
                      showTimePickerDialog(
                        context,
                        onSoundChange: (p0) {},
                        onTimeChange: (p0) {
                          setState(() {
                            startTime = p0;
                          });
                        },
                      );
                    },
                    hintText: "",
                  
                    labelText: "Start Time",
                    readOnly: true,
                    // Date time format Example : 8.30 AM
                  
                    controller: TextEditingController(
                        text: startTime != null
                            ? DateFormat('h.mm a')
                                .format(startTime ?? DateTime.now())
                            : ""),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: PrimaryTextField(
                    onTap: () async {
                      showTimePickerDialog(
                        context,
                        onSoundChange: (p0) {},
                        onTimeChange: (p0) {
                          setState(() {
                            endTime = p0;
                          });
                        },
                      );
                    },
                    hintText: "",
                  
                    labelText: "End Time",
                    readOnly: true,
                    // Date time format Example : 8.30 AM
                  
                    controller: TextEditingController(
                        text: endTime != null
                            ? DateFormat('h.mm a')
                                .format(endTime ?? DateTime.now())
                            : ""),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
