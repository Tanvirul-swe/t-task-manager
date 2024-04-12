import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:t_task_manager/src/constant/app_colors.dart';

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
