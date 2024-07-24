import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:t_task_manager/src/constant/app_colors.dart';
import 'package:t_task_manager/src/constant/common_content.dart';
import 'package:t_task_manager/src/constant/text_style.dart';

void showCustomDialog(BuildContext context,
    {String title = "Are you sure?",
    String content = "Are you sure to delete this account ?",
    Function()? onYes,
    Function()? onCancel}) {
  showGeneralDialog(
    context: context,
    barrierLabel: "Barrier",
    barrierDismissible: true,
    barrierColor: Colors.black.withOpacity(0.5),
    transitionDuration: const Duration(milliseconds: 400),
    pageBuilder: (_, __, ___) {
      return Material(
        color: Colors.transparent,
        child: Center(
          child: Container(
              height: 203,
              margin: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(20)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.hindSiliguri(
                      fontSize: 20,
                      color: const Color(0xFF10275A),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    content,
                    style: GoogleFonts.hindSiliguri(
                      fontSize: 18,
                      color: const Color(0xFF10275A),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          maximumSize: const Size(100, 40),
                          minimumSize: const Size(100, 40),
                          side: const BorderSide(
                            color: Color(0xFF10275A),
                          ),
                          backgroundColor: AppColors.primaryWhite,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                          if (onCancel != null) {
                            onCancel.call();
                          }
                        },
                        child: Text(
                          "Cancel",
                          style: GoogleFonts.hindSiliguri(
                            fontSize: 14,
                            color: const Color(0xFF10275A),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          maximumSize: const Size(100, 40),
                          minimumSize: const Size(100, 40),
                          elevation: 0,
                          backgroundColor: const Color(0xFF5B67CA),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                          if (onYes != null) {
                            onYes.call();
                          }
                        },
                        child: Text(
                          "Sure",
                          style: GoogleFonts.hindSiliguri(
                            fontSize: 14,
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              )),
        ),
      );
    },
    transitionBuilder: (_, anim, __, child) {
      // Add animation to the dialog small to large

      Tween<Offset> tween = Tween(begin: const Offset(0, 1), end: Offset.zero);

      return SlideTransition(
        position: tween.animate(anim),
        child: FadeTransition(
          opacity: anim,
          child: child,
        ),
      );
    },
  );
}

// Language selction dialog with language name and checkbox to select at a time on one language
void showLanguageDialog(BuildContext context, List<String> languages,
    {Function(String)? onSelected}) {
  StreamController<String> controller = StreamController<String>.broadcast();
  showGeneralDialog(
    context: context,
    barrierLabel: "Barrier",
    barrierDismissible: true,
    barrierColor: Colors.black.withOpacity(0.5),
    transitionDuration: const Duration(milliseconds: 400),
    pageBuilder: (_, __, ___) {
      return Material(
        color: Colors.transparent,
        child: Center(
          child: Container(
              height: 260,
              padding: const EdgeInsets.all(15),
              margin: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(20)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Language",
                    style: GoogleFonts.hindSiliguri(
                      fontSize: 20,
                      color: const Color(0xFF10275A),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 15),
                  Column(
                    children: languages
                        .map((e) => StreamBuilder<String>(
                            stream: controller.stream,
                            builder: (context, snapshot) {
                              String? selectedLanguage = snapshot.data;
                              return CheckboxListTile(
                                checkboxShape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                title: Text(
                                  e,
                                  style: GoogleFonts.hindSiliguri(
                                    fontSize: 18,
                                    color: const Color(0xFF10275A),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                value: selectedLanguage == e,
                                onChanged: (value) {
                                  if (onSelected != null) {
                                    onSelected(e);
                                  }
                                  controller.sink.add(value! ? e : "");
                                },
                              );
                            }))
                        .toList(),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          maximumSize: const Size(100, 40),
                          minimumSize: const Size(100, 40),
                          side: const BorderSide(
                            color: Color(0xFF10275A),
                          ),
                          backgroundColor: AppColors.primaryWhite,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          "Cancel",
                          style: GoogleFonts.hindSiliguri(
                            fontSize: 14,
                            color: const Color(0xFF10275A),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          maximumSize: const Size(100, 40),
                          minimumSize: const Size(100, 40),
                          elevation: 0,
                          backgroundColor: const Color(0xFF5B67CA),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          "Sure",
                          style: GoogleFonts.hindSiliguri(
                            fontSize: 14,
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              )),
        ),
      );
    },
    transitionBuilder: (_, anim, __, child) {
      // Add animation to the dialog small to large

      Tween<Offset> tween = Tween(begin: const Offset(0, 1), end: Offset.zero);

      return SlideTransition(
        position: tween.animate(anim),
        child: FadeTransition(
          opacity: anim,
          child: child,
        ),
      );
    },
  );
}

// Show time picker dialog with hour and minute selection
void showTimePickerDialog(BuildContext context,
    {Function()? onYes,
    Function()? onCancel,
    required Function(DateTime)? onTimeChange,
    required Function(String?)? onSoundChange}) {
  StreamController<String> soundStream = StreamController<String>.broadcast();
  String selectedSound = "Ring";
  showGeneralDialog(
    context: context,
    barrierLabel: "Barrier",
    barrierDismissible: true,
    barrierColor: Colors.black.withOpacity(0.5),
    transitionDuration: const Duration(milliseconds: 400),
    pageBuilder: (_, __, ___) {
      return Material(
        color: Colors.transparent,
        child: Center(
          child: Container(
              height: 450,
              margin: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(20)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Edit Time",
                    style: GoogleFonts.hindSiliguri(
                      fontSize: 20,
                      color: const Color(0xFF10275A),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 20),
                  hourMinute12H(onTimeChange: onTimeChange, context: context),
                  const Divider(
                    color: AppColors.secondaryGray,
                    thickness: 1,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        "Remainder mode",
                        style: GoogleFonts.hindSiliguri(
                          fontSize: 16,
                          color: const Color(0xFF10275A),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      // const SizedBox(width: 10),
                      StreamBuilder<String>(
                          stream: soundStream.stream,
                          builder: (context, snapshot) {
                            return DropdownButton<String>(
                              borderRadius: BorderRadius.circular(14),
                              iconSize: 20,
                              elevation: 1,
                              underline: const SizedBox.shrink(),
                              value: selectedSound,
                              icon: const Icon(
                                Icons.arrow_drop_down,
                                color: AppColors.primaryBlack,
                              ),
                              items:
                                  <String>["Ring", "Mute"].map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Row(
                                    children: [
                                      getSoundIcon(value),
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
                                soundStream.sink.add(value!);
                                selectedSound = value;
                                onSoundChange!.call(selectedSound);
                              },
                            );
                          }),
                    ],
                  ),
                  const Divider(
                    color: AppColors.secondaryGray,
                    thickness: 1,
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          maximumSize: const Size(100, 40),
                          minimumSize: const Size(100, 40),
                          elevation: 0,
                          side: const BorderSide(
                            color: Color(0xFF10275A),
                          ),
                          backgroundColor: AppColors.primaryWhite,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                          if (onCancel != null) {
                            onCancel.call();
                          }
                        },
                        child: Text(
                          "Cancel",
                          style: GoogleFonts.hindSiliguri(
                            fontSize: 14,
                            color: const Color(0xFF10275A),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          maximumSize: const Size(100, 40),
                          minimumSize: const Size(100, 40),
                          elevation: 0,
                          backgroundColor: const Color(0xFF5B67CA),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                          if (onYes != null) {
                            onYes.call();
                          }
                        },
                        child: Text(
                          "Sure",
                          style: GoogleFonts.hindSiliguri(
                            fontSize: 14,
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              )),
        ),
      );
    },
    transitionBuilder: (_, anim, __, child) {
      // Add animation to the dialog small to large

      Tween<Offset> tween = Tween(begin: const Offset(0, 1), end: Offset.zero);

      return SlideTransition(
        position: tween.animate(anim),
        child: FadeTransition(
          opacity: anim,
          child: child,
        ),
      );
    },
  );
}
