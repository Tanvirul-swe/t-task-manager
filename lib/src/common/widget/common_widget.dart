import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_svg/svg.dart';
import 'package:t_task_manager/src/constant/app_asset.dart';
import 'package:t_task_manager/src/constant/app_colors.dart';

void showCustomSnackBar(BuildContext context, String message,
    {bool isError = false}) {
  if (message.isNotEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        dismissDirection: DismissDirection.horizontal,
        // margin: const EdgeInsets.all(8),
        duration: const Duration(seconds: 2),
        backgroundColor: isError ? Colors.red : Colors.green,
        behavior: SnackBarBehavior.fixed,

        // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        content: Text(
          message,
          style: const TextStyle(fontSize: 15, color: AppColors.primaryWhite),
        ),
      ),
    );
  }
}

ThemeData dateTimeTheme() {
  return ThemeData(
    splashColor: Colors.black,
    textTheme: const TextTheme(
      titleMedium: TextStyle(color: AppColors.primaryBlack),
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
  );
}


Widget networkImageBuild({
  required String url,
  required double size,
  double? borderRadius,
  double? height,
  double? width,
  VoidCallback? onTap,
}) {
  if (url.contains('https')) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius ?? 8),
      child: InkWell(
        onTap: onTap,
        child: CachedNetworkImage(
          // color: AppColors.transparent,
          height: height ?? size,
          width: width ?? size,
          fit: BoxFit.fill,
          imageUrl: url,
          cacheManager: CacheManager(Config(
            url,
            stalePeriod: const Duration(days: 7),
            //one week cache period
          )),
          placeholder: (context, url) => const Center(
            child: CircularProgressIndicator(
              strokeWidth: 2,
              valueColor:
                  AlwaysStoppedAnimation<Color>(AppColors.primaryBlack),
            ),
          ),
          errorWidget: (context, url, error) => SvgPicture.asset(
            AppAsset.closeSquare,
            height: height ?? size,
            width: width ?? size,
          ),
        ),
      ),
    );
  } else {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius ?? 8),
      child: InkWell(
        onTap: onTap,
        child: Image.file(File(url),
            height: height ?? size,
            width: width ?? size,
            fit: BoxFit.fill,
            frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
              if (wasSynchronouslyLoaded) {
                return child;
              }
              return AnimatedOpacity(
                opacity: frame == null ? 0 : 1,
                duration: const Duration(seconds: 1),
                curve: Curves.easeOut,
                child: child,
              );
            },
            cacheWidth: 1000,
            cacheHeight: 1000,
            errorBuilder: (context, error, stackTrace) => SvgPicture.asset(
                  AppAsset.closeSquare,
                  height: height ?? size,
                  width: width ?? size,
                )),
      ),
    );
  }
}