import 'package:flutter/material.dart';
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
                  Container(
                    width: double.infinity,
                    height: 6.6.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(7),
                      color: buttonColor ?? const Color.fromRGBO(23, 94, 217, 1),
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(7),
                        onTap: () => Navigator.pop(context),
                        child: Center(
                          child: Text(
                            textButton,
                            style: TextStyle(
                              fontSize: 9.5.sp,
                              fontFamily: ConstantsFonts.latoBold,
                              color: buttonTextColor ?? const Color.fromRGBO(255, 255, 255, 1),
                            ),
                          ),
                        ),
                      ),
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
                          fontSize: 10.sp,
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
                  Container(
                    width: double.infinity,
                    height: 6.6.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(7),
                      color: yesColorButton ?? const Color.fromRGBO(250, 18, 46, 1),
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(7),
                        onTap: yesOnTap,
                        child: Center(
                          child: Text(
                            yesButton,
                            style: TextStyle(
                              fontSize: 9.5.sp,
                              fontFamily: ConstantsFonts.latoBold,
                              color: const Color.fromRGBO(255, 255, 255, 1),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 1.h,
                  ),
                  Container(
                    width: double.infinity,
                    height: 6.6.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(7),
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: noOnTap ?? () => Navigator.pop(context),
                        borderRadius: BorderRadius.circular(7),
                        child: Center(
                          child: Text(
                            noButton,
                            style: TextStyle(
                              fontSize: 8.5.sp,
                              fontFamily: ConstantsFonts.latoBold,
                              color: const Color.fromRGBO(32, 30, 31, 1),
                            ),
                          ),
                        ),
                      ),
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