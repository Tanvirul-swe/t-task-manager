import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:t_task_manager/src/common/widget/common_dialog.dart';
import 'package:t_task_manager/src/common/widget/primary_buttom.dart';
import 'package:t_task_manager/src/common/widget/primary_textfield.dart';
import 'package:t_task_manager/src/constant/app_asset.dart';
import 'package:t_task_manager/src/constant/app_colors.dart';
import 'package:t_task_manager/src/constant/common_content.dart';
import 'package:t_task_manager/src/constant/text_style.dart';
import 'package:t_task_manager/src/feature/task/data/model/task_model.dart';
import 'package:t_task_manager/src/feature/task/data/model/task_tag_model.dart';
import 'package:t_task_manager/src/feature/task/presentation/taskBloc/task_bloc.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({super.key});

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  String selectedSound = "Ring";
  TextEditingController dateController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  DateTime? startTime;
  DateTime? endTime;
  String taskType = "Personal";
  String selectedTag = "Office";
  DateTime? selectedDate;

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
        padding: const EdgeInsets.symmetric(horizontal: scaffoldDefaultPadding),
        child: BlocConsumer<TaskBloc, TaskState>(
          listener: (context, state) {
            if (state is TaskCreateSuccess) {
              Navigator.pop(context);
            } else if (state is TaskError) {
              debugPrint("Error: ${state.message}");
            }
          },
          builder: (context, state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                PrimaryTextField(
                    hintText: "Enter your task title",
                    labelText: "Title",
                    controller: titleController),
                PrimaryTextField(
                  hintText: "",
                  suffixIcon: AppAsset.calender,
                  labelText: "Date",
                  readOnly: true,
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime(2101),
                      initialEntryMode: DatePickerEntryMode.calendarOnly,
                      builder: (BuildContext context, Widget? child) {
                        return Theme(
                          data: ThemeData(
                            splashColor: Colors.black,
                            textTheme: const TextTheme(
                              titleMedium:
                                  TextStyle(color: AppColors.primaryBlack),
                              labelLarge: TextStyle(color: Colors.black),
                            ),
                            colorScheme: const ColorScheme.light(
                              primary: AppColors.primaryBlack,
                              primaryContainer: Colors.white,
                              secondaryContainer: Colors.white,
                              onSecondary: Colors.white,
                              onPrimary: Colors.white,
                              surface: Colors.white,
                              onSurface: Colors.black,
                              secondary: Colors.black,
                            ),
                            dialogBackgroundColor: Colors.white,
                          ),
                          child: child ?? const Text(""),
                        );
                      },
                    );
                    if (pickedDate != null) {
                      String formattedDate =
                          DateFormat('dd MMMM yyyy').format(pickedDate);
                      selectedDate = pickedDate;
                      setState(() {
                        dateController.text = formattedDate;
                      });
                    }
                  },
                  controller: dateController,
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
                PrimaryTextField(
                    hintText: "Task description",
                    labelText: "Description",
                    controller: descriptionController),
                Text("Type", style: style14RegularGray),
                // const SizedBox(height: 8),
                SizedBox(
                  height: 50,
                  child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return SizedBox(
                          width: 120,
                          child: CheckboxListTile(
                            dense: true,
                            tristate: true,
                            contentPadding: EdgeInsets.zero,
                            controlAffinity: ListTileControlAffinity.leading,
                            checkboxShape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            title: Text(
                              getProfileContent()[index],
                              style: GoogleFonts.hindSiliguri(
                                fontSize: 16,
                                color: const Color(0xFF10275A),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            value: taskType == getProfileContent()[index],
                            onChanged: (value) {
                              setState(() {
                                taskType = getProfileContent()[index];
                              });
                            },
                          ),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const SizedBox(width: 8);
                      },
                      itemCount: getProfileContent().length - 1,
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics()),
                ),
                const SizedBox(height: 20),
                Text("Tag", style: style14RegularGray),
                const SizedBox(height: 8),

                // Task tag chips list
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: taskTag
                      .map((e) => GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedTag = e;
                              });
                            },
                            child: Chip(
                                shadowColor: Colors.white30,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(22),
                                  side: const BorderSide(
                                      color: Colors.transparent),
                                ),
                                label: Text(e, style: style10Medium),
                                backgroundColor: selectedTag == e
                                    ? const Color(0xFFFFE9ED)
                                    : AppColors.primaryGray),
                          ))
                      .toList(),
                ),
                const Spacer(),
                PrimaryButtom(
                    isLoading: state is TaskLoading,
                    title: "Create",
                    onPressed: () {
                      final taskTag = TaskTagModel(
                        takId: DateTime.now().millisecondsSinceEpoch,
                        id: DateTime.now().millisecondsSinceEpoch,
                        name: selectedTag,
                      );
                      TaskModel data = TaskModel(
                          id: taskTag.takId,
                          title: titleController.text,
                          date: selectedDate?.millisecondsSinceEpoch ?? 0,
                          startTime: startTime?.millisecondsSinceEpoch ?? 0,
                          endTime: endTime?.millisecondsSinceEpoch ?? 0,
                          description: descriptionController.text,
                          taskType: taskType,
                          createdAt: DateTime.now().millisecondsSinceEpoch,
                          updatedAt: DateTime.now().millisecondsSinceEpoch,
                          isDeleted: 0,
                          status: pendingStatus,
                          tags: [
                            taskTag,
                          ],
                          isSynced: 0);

                      context.read<TaskBloc>().add(TaskCreateRequest(
                            taskModel: data,
                          ));
                    }),
                const SizedBox(height: 22),
              ],
            );
          },
        ),
      ),
    );
  }
}
