import 'package:flutter/material.dart';
import 'package:memorial_book/widgets/main_button.dart';
import 'package:sizer/sizer.dart';
import '../helpers/constants.dart';

class MessageDialogsProvider extends ChangeNotifier {
  Future informationWindow({
    required BuildContext context,
    required String title,
    required String textButton,
    Color? buttonColor,
    Color? buttonTextColor,
}) async {
    return await showDialog(
      context: context,
      builder: ((BuildContext context) {
        return Dialog(
          insetPadding: EdgeInsets.symmetric(
            horizontal: 5.8.w,
          ),
          backgroundColor: Colors.transparent,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              color: const Color.fromRGBO(255, 255, 255, 1),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 3.w,
                vertical: 2.6.h,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: ConstantsFonts.latoBold,
                      fontSize: 13.sp,
                      color: const Color.fromRGBO(0, 0, 0, 1),
                    ),
                  ),
                  SizedBox(
                    height: 1.2.h,
                  ),
                  MainButton(
                    text: textButton,
                    onTap: () => Navigator.pop(context),
                    activeColor: buttonColor ?? const Color.fromRGBO(23, 94, 217, 1),
                    textStyle: TextStyle(
                      fontSize: 9.5.sp,
                      fontFamily: ConstantsFonts.latoBold,
                      color: buttonTextColor ?? const Color.fromRGBO(255, 255, 255, 1),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }

  Future theSelectionWindow({
    required BuildContext context,
    required String title,
    String? subtitle,
    required String yesButton,
    required String noButton,
    required Function() yesOnTap,
    Color? yesColorButton,
    Function()? noOnTap,
  }) async {
    return await showDialog(
      context: context,
      builder: ((BuildContext context) {
        return Dialog(
          insetPadding: EdgeInsets.symmetric(
            horizontal: 5.8.w,
          ),
          backgroundColor: Colors.transparent,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              color: const Color.fromRGBO(255, 255, 255, 1),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 3.w,
                vertical: 2.6.h,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: ConstantsFonts.latoBold,
                      fontSize: 13.sp,
                      color: const Color.fromRGBO(0, 0, 0, 1),
                    ),
                  ),
                  subtitle != null && subtitle.isNotEmpty ?
                  Column(
                    children: [
                      SizedBox(
                        height: 0.6.h,
                      ),
                      Text(
                        subtitle,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: ConstantsFonts.latoRegular,
                          fontSize: 9.5.sp,
                          color: const Color.fromRGBO(32, 30, 31, 0.8),
                          height: 0.2.h,
                        ),
                      ),
                    ],
                  ) :
                  const SizedBox(),
                  SizedBox(
                    height: subtitle != null && subtitle.isNotEmpty ?
                    1.2.h :
                    2.6.h,
                  ),
                  MainButton(
                    text: yesButton,
                    onTap: yesOnTap,
                    activeColor: yesColorButton ?? const Color.fromRGBO(250, 18, 46, 1),
                    textStyle: TextStyle(
                      fontSize: 9.5.sp,
                      fontFamily: ConstantsFonts.latoBold,
                      color: const Color.fromRGBO(255, 255, 255, 1),
                    ),
                  ),
                  SizedBox(
                    height: 1.h,
                  ),
                  MainButton(
                    text: noButton,
                    onTap: noOnTap ?? () => Navigator.pop(context),
                    activeColor: Colors.transparent,
                    textStyle: TextStyle(
                      fontSize: 9.5.sp,
                      fontFamily: ConstantsFonts.latoBold,
                      color: const Color.fromRGBO(32, 30, 31, 1),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}