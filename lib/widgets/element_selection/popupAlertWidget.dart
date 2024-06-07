import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../helpers/constants.dart';
import '../main_button.dart';

Future popupAlertWidget({
  required String title,
  required String subtitle,
  required BuildContext context,
  required Function() onCancel,
  required Function() onAgree,
}) async {
  return await showModalBottomSheet(
    context: context,
    builder: (context) {
      return Padding(
        padding: EdgeInsets.only(
          top: 3.h,
          left: 6.w,
          right: 6.w,
          bottom: 3.h,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              ConstantsAssets.questionMarkImage,
              height: 8.6.h,
              width: 8.6.h,
            ),
            SizedBox(
              height: 3.h,
            ),
            Text(
              title,
              style: TextStyle(
                color: const Color.fromRGBO(0, 0, 0, 1),
                fontSize: 19.5.sp,
                fontFamily: ConstantsFonts.latoSemiBold,
              ),
            ),
            SizedBox(
              height: 1.h,
            ),
            Text(
              subtitle,
              style: TextStyle(
                color: const Color.fromRGBO(0, 0, 0, 0.5),
                fontSize: 9.5.sp,
                fontFamily: ConstantsFonts.latoSemiBold,
              ),
            ),
            SizedBox(
              height: 3.h,
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: MainButton(
                    text: 'НЕТ, Я ПЕРЕДУМАЛ',
                    onTap: () => onCancel(),
                    activeColor: const Color.fromRGBO(225, 228, 231, 1),
                    textStyle: TextStyle(
                      color: const Color.fromRGBO(0, 0, 0, 0.5),
                      fontFamily: ConstantsFonts.latoSemiBold,
                      fontSize: 9.5.sp,
                    ),
                  ),
                ),
                SizedBox(
                  width: 4.w,
                ),
                Expanded(
                  child: MainButton(
                    text: 'ДА',
                    onTap: () => onAgree(),
                    activeColor: const Color.fromRGBO(255, 76, 94, 1),
                    textStyle: TextStyle(
                      color: const Color.fromRGBO(255, 255, 255, 1),
                      fontFamily: ConstantsFonts.latoSemiBold,
                      fontSize: 9.5.sp,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    },
  );
}