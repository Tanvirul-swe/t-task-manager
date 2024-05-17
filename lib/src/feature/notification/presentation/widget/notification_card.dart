import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:t_task_manager/src/common/widget/common_widget.dart';
import 'package:t_task_manager/src/constant/app_colors.dart';
import 'package:t_task_manager/src/constant/text_style.dart';

class NotificationCard extends StatelessWidget {
  const NotificationCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          color: const Color(0XFFE5E4DF),
          elevation: 0,
          margin: const EdgeInsets.all(12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              "12-th of August 2021",
              style: TextStyle(
                  color: Color(0XFF7F7B70),
                  fontSize: 13,
                  fontWeight: FontWeight.w600),
            ),
          ),
        ),
        const SizedBox(
          height: 6,
        ),
        ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              return Dismissible(
                key: UniqueKey(),
                direction: DismissDirection.endToStart,
                background: Container(
                  padding: const EdgeInsets.only(right: 16),
                  alignment: Alignment.centerRight,
                  color: Colors.red,
                  child: const Icon(
                    FontAwesomeIcons.trashCan,
                    color: AppColors.primaryWhite,
                  ),
                ),
                onDismissed: (direction) {
                  // setState(() {
                  //   _items.removeAt(index);
                  // });
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: AppColors.primaryWhite,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      // Image.asset(AppAsset.appLogo, width: 55, height: 55),
                      networkImageBuild(
                          url:
                              "https://www.sender.net/wp-content/uploads/2022/01/What-are-SMS-notifications-smaller-1024x658.png",
                          size: 40,
                          borderRadius: 25),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Flutter update version 3.3.1",
                                  maxLines: 1,
                                  style: style10Medium.copyWith(
                                      fontSize: 16,
                                      letterSpacing: 0.5,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.primaryBlack),
                                ),
                                Text("12:30 PM",
                                    style: GoogleFonts.poppins(
                                      color: AppColors.primaryBlack,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                    )),
                              ],
                            ),
                            const SizedBox(height: 4),
                            ReadMoreText(
                              "Flutter is Google’s mobile UI open source framework to build high-quality native (super fast) interfaces for iOS and Android apps with the unified codebase.",
                              style: style14RegularBlack,
                              trimLines: 2,
                              colorClickableText: AppColors.primaryBlue.withOpacity(0.6),
                              trimMode: TrimMode.Line,
                              trimCollapsedText: ' Show more',
                              trimExpandedText: ' show less',
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return const SizedBox(
                height: 8,
                child: Divider(
                  thickness: 1,
                ),
              );
            },
            itemCount: 4),
      ],
    );
  }
}
