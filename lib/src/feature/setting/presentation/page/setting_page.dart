import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:t_task_manager/src/common/widget/common_dialog.dart';
import 'package:t_task_manager/src/constant/app_colors.dart';
import 'package:t_task_manager/src/constant/common_content.dart';
import 'package:t_task_manager/src/constant/text_style.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Setting',
          style: appBarTextStyle,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(scaffoldDefaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "General",
              style: style16SemiBold,
            ),
            const SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () {
                showLanguageDialog(context, ["Bangla", "English"]);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Language",
                    style: style16Medum.copyWith(color: const Color(0xFF10275A)),
                  ),
                  Row(
                    children: [
                      Text(
                        "English",
                        style:
                            style16Medum.copyWith(color: const Color(0xFF10275A)),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      const Icon(Icons.arrow_forward_ios_rounded),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () {
                showCustomDialog(context);
              },
              child: Text(
                "Delete Account",
                style: style16Medum.copyWith(color:AppColors.primaryRead),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              "Notification",
              style: style16SemiBold,
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Allow Notification",
                  style: style16Medum.copyWith(color: const Color(0xFF10275A)),
                ),
                Switch(
                  value: true,
                  onChanged: (value) {},
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Allow the Notification Rings",
                  style: style16Medum.copyWith(color: const Color(0xFF10275A)),
                ),
                Switch(
                  value: false,
                  onChanged: (value) {},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
