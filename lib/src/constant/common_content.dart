// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:t_task_manager/src/constant/app_asset.dart';
import 'package:t_task_manager/src/constant/app_colors.dart';
import 'package:t_task_manager/src/constant/text_style.dart';
import 'package:t_task_manager/src/feature/history/presentation/page/task_history_page.dart';
import 'package:t_task_manager/src/utils/flutter_time_picker_spiner.dart';

const scaffoldDefaultPadding = 25.0;
const textLineGap = 4.0;
const completedStatus = 1;
const pendingStatus = 2;
const cancelledStatus = 3;
const onGoingStatus = 4;
List<String> taskTag = ["Office", "Home", "Urgent", "Work"];
Widget dontHaveAccout(
    {required String title,
    required String content,
    required void Function()? onPressed}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text(
        'Don\'t have an account?',
        style: GoogleFonts.hindSiliguri(
          fontSize: 14,
          color: const Color(0xFF2C406E),
          fontWeight: FontWeight.w400,
        ),
      ),
      TextButton(
        onPressed: onPressed,
        child: Text(
          'Sign Up',
          style: GoogleFonts.hindSiliguri(
            fontSize: 14,
            color: const Color(0xFF2C406E),
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    ],
  );
}

List<String> homeItemTitle = ["Completed", "Pending", "Canceled", "On Going"];
List<List<Color>> colorInfo = [
  [
    const Color(0xFF7DC8E7),
    const Color(0xFF7DC8E7).withOpacity(0.7),
    const Color(0xFF7DC8E7).withOpacity(0.5),
  ],
  [
    const Color(0xFF7D88E7),
    const Color(0xFF7D88E7).withOpacity(0.7),
  ],
  [
    const Color(0xFFE77D7D),
    const Color(0xFFE77D7D).withOpacity(0.7),
  ],
  [
    const Color(0xFF81E89E),
    const Color(0xFF81E89E).withOpacity(0.31),
  ]
];

String getTaskHistoryTitle(TaskType taskType) {
  switch (taskType) {
    case TaskType.pending:
      return "Pending";
    case TaskType.completed:
      return "Completed";
    case TaskType.cancelled:
      return "Cancelled";
    case TaskType.onGoing:
      return "On Going";
    case TaskType.all:
      return "All";
  }
}

String getIconFromType(String actionName) {
  switch (actionName) {
    case "Enable":
      return AppAsset.tickSqure;
    case "Edit":
      return AppAsset.edit;
    case "Delete":
      return AppAsset.delete;
    case "Restore":
      return AppAsset.upload;
    default:
      return AppAsset.closeSquare;
  }
}

String getProfileIcon(String title) {
  switch (title) {
    case "Setting":
      return AppAsset.setting;

    default:
      return AppAsset.logOut;
  }
}

List<DropdownMenuItem<String>>? getDropDownItem(TaskType taskType) {
  switch (taskType) {
    case TaskType.pending:
      return <String>["Enable", "Edit", "Delete"].map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Row(
            children: [
              SvgPicture.asset(getIconFromType(value)),
              const SizedBox(
                width: 8,
              ),
              Text(
                value,
                style: style16Medum,
              ),
            ],
          ),
        );
      }).toList();
    case TaskType.completed:
      return <String>["Restore", "Delete"].map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Row(
            children: [
              SvgPicture.asset(getIconFromType(value)),
              const SizedBox(
                width: 8,
              ),
              Text(
                value,
                style: style16Medum,
              ),
            ],
          ),
        );
      }).toList();
    case TaskType.cancelled:
      return <String>["Edit", "Restore", "Delete"].map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Row(
            children: [
              SvgPicture.asset(getIconFromType(value)),
              const SizedBox(
                width: 8,
              ),
              Text(
                value,
                style: style16Medum,
              ),
            ],
          ),
        );
      }).toList();
    case TaskType.onGoing:
      return <String>["Disable", "Edit", "Delete"].map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Row(
            children: [
              SvgPicture.asset(
                getIconFromType(value),
                color: AppColors.primaryBlack,
              ),
              const SizedBox(
                width: 8,
              ),
              Text(
                value,
                style: style16Medum,
              ),
            ],
          ),
        );
      }).toList();
    case TaskType.all:
      return <String>["Enable", "Edit", "Delete"].map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Row(
            children: [
              SvgPicture.asset(getIconFromType(value)),
              const SizedBox(
                width: 8,
              ),
              Text(
                value,
                style: style16Medum,
              ),
            ],
          ),
        );
      }).toList();
  }
}

List<String> getProfileContent() {
  return [
    "Personal",
    "Work",
    "Private",
    "Meeting",
    "Event",
    "Sync Server",
  ];
}

String getTaskCategoryTitle(TaskCategory taskCategory) {
  switch (taskCategory) {
    case TaskCategory.personal:
      return "Personal";
    case TaskCategory.work:
      return "Work";
    case TaskCategory.private:
      return "Private";
    case TaskCategory.meeting:
      return "Meeting";
    case TaskCategory.event:
      return "Event";
  }
}

/// SAMPLE
Widget hourMinute12H(
    {required BuildContext context,
    required Function(DateTime)? onTimeChange}) {
  return TimePickerSpinner(
    spacing: MediaQuery.of(context).size.width / 4.7,
    normalTextStyle: GoogleFonts.hindSiliguri(
        fontSize: 22,
        color: const Color(0xFFBFBFDF),
        fontWeight: FontWeight.w500),
    highlightedTextStyle: GoogleFonts.hindSiliguri(
        fontSize: 26,
        color: AppColors.primaryBlue,
        fontWeight: FontWeight.w500),
    is24HourMode: false,
    onTimeChange: (val) {
      onTimeChange!.call(val);
    },
  );
}

Widget getSoundIcon(String sound) {
  switch (sound) {
    case "Ring":
      return const Icon(
        Icons.notifications_active_outlined,
        color: AppColors.primaryBlack,
      );
    case "Mute":
      return const Icon(
        Icons.notifications_off_outlined,
        color: AppColors.primaryBlack,
      );
    default:
      return const Icon(
        Icons.notifications_active_outlined,
        color: AppColors.primaryBlack,
      );
  }
}

// Empty Screen Widget
Widget emptyScreenWidget(String content) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      SvgPicture.asset(AppAsset.emptyImage),
      const SizedBox(height: 20),
      Center(
        child: Text(
          content,
          style: style14RegularBlack.copyWith(color: const Color(0xFF575757)),
        ),
      ),
    ],
  );
}

// Error Screen Widget
Widget errorScreenWidget([String content = "Something went wrong"]) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      SvgPicture.asset(AppAsset.emptyImage),
      const SizedBox(height: 20),
      Center(
        child: Text(
          content,
          style: style14RegularBlack.copyWith(color: const Color(0xFF575757)),
        ),
      ),
    ],
  );
}

// Loading page widget
Widget loadingPageWidget() {
  return const Center(
    child: SpinKitRipple(
      size: 80,
      color: AppColors.primaryBlue,
    ),
  );
}
