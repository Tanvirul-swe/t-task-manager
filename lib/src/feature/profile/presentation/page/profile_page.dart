import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:t_task_manager/src/common/widget/common_dialog.dart';
import 'package:t_task_manager/src/constant/app_asset.dart';
import 'package:t_task_manager/src/constant/app_colors.dart';
import 'package:t_task_manager/src/constant/common_content.dart';
import 'package:t_task_manager/src/constant/text_style.dart';
import 'package:t_task_manager/src/feature/history/presentation/page/task_history_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        actions: [
          DropdownButton<String>(
            borderRadius: BorderRadius.circular(14),
            iconSize: 20,
            elevation: 1,
            underline: const SizedBox.shrink(),
            icon: const Icon(
              Icons.more_vert_outlined,
              color: AppColors.primaryBlack,
            ),
            items: <String>["Setting", "Log Out"].map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Row(
                  children: [
                    SvgPicture.asset(getProfileIcon(value)),
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
            }).toList(),
            onChanged: (value) {
              if (value == "Setting") {
                Navigator.pushNamed(context, "/SettingPage");
              } else {
                showCustomDialog(context,
                    title: "Log Out",
                    content: "Are you sure to log out from this account ?");
              }
            },
            // onChanged: onChanged,
          ),
          const SizedBox(
            width: 15,
          ),
        ],
        automaticallyImplyLeading: false,
        title: Text(
          'Profile',
          style: appBarTextStyle,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(scaffoldDefaultPadding),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.primaryWhite,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        spreadRadius: 1,
                        blurRadius: 1,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.people_outlined,
                    size: 40,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'John Doe',
                  style: smallHeadingTextStyle,
                ),
                const SizedBox(height: textLineGap),
                Text("SteveJob@gmail.com", style: style14RegularGray),
                const SizedBox(height: 20),
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 1,
                  ),
                  itemCount: 6,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        switch (index) {
                          case 0:
                            Navigator.pushNamed(
                                context, "/TaskListByCategoryPage",
                                arguments: TaskCategory.personal);
                            break;
                          case 1:
                            Navigator.pushNamed(
                                context, "/TaskListByCategoryPage",
                                arguments: TaskCategory.work);
                            break;
                          case 2:
                            Navigator.pushNamed(
                                context, "/TaskListByCategoryPage",
                                arguments: TaskCategory.private);
                            break;

                          case 3:
                            Navigator.pushNamed(context, "/TaskListByCategoryPage",
                                arguments: TaskCategory.meeting);
                            break;

                          case 4:
                            Navigator.pushNamed(context, "/TaskListByCategoryPage",
                                arguments: TaskCategory.event);
                            break;
                          default:
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: AppColors.profileCardColor[index],
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: 48,
                              width: 48,
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: AppColors.profileSubCardColor[index],
                              ),
                              child: SvgPicture.asset(
                                AppAsset.profileItem[index],
                                color: AppColors.primaryWhite,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              getProfileContent()[index],
                              style: style14RegularBlack,
                            ),
                            const SizedBox(
                              height: 6,
                            ),
                            Text("Task 3", style: style14RegularGray),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
