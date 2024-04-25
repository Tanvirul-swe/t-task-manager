// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:t_task_manager/src/constant/app_asset.dart';
import 'package:t_task_manager/src/constant/app_colors.dart';
import 'package:t_task_manager/src/constant/common_content.dart';
import 'package:t_task_manager/src/constant/text_style.dart';

class TaskCategoryCard extends StatelessWidget {
  final int index;
  final int count;
  const TaskCategoryCard({super.key, required this.index, required this.count});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          right: 20,
          child: SvgPicture.asset(
            'asset/icon/shado.svg',
            height: 34,
            width: 54,
          ),
        ),
        Positioned(
          right: 50,
          child: SvgPicture.asset(
            'asset/icon/shado.svg',
            height: 34,
            width: 54,
          ),
        ),
        Positioned(
          top: 10,
          right: 12,
          child: SvgPicture.asset(
            AppAsset.arrowForword,
            height: 14,
            width: 14,
            color: AppColors.primaryBlack,
          ),
        ),
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              gradient: LinearGradient(
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight,
                  colors: colorInfo[index])),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SvgPicture.asset(AppAsset.homeItem[index],
                      height: 22, width: 22),
                ],
              ),
              const SizedBox(height: 10),
              Text(homeItemTitle[index],
                  style: style16Medum.copyWith(
                      color: index == 0 || index == 3
                          ? AppColors.primaryBlack
                          : AppColors.primaryWhite)),
              const SizedBox(height: 10),
              Text("$count Task",
                  style: GoogleFonts.hindSiliguri(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: index == 0 || index == 3
                          ? AppColors.primaryBlack
                          : AppColors.primaryWhite)),
            ],
          ),
        ),
      ],
    );
  }
}
