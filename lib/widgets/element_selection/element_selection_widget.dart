import 'package:flutter/material.dart';
import '../../helpers/constants.dart';
import 'package:sizer/sizer.dart';

Future elementSelectionWidget({
  required BuildContext context,
  required String title,
  required String textButton,
  TextStyle? titleTextStyle,
  TextStyle? buttonTextStyle,
  Color? buttonColor,
  required Widget child,
}) async {
  return await showModalBottomSheet(
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topRight: Radius.circular(28.0),
        topLeft: Radius.circular(28.0),
      ),
    ),
    context: context,
    builder: (BuildContext context) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            height: 1.8.h,
          ),
          Text(
            title,
            style: titleTextStyle ?? TextStyle(
              color: const Color.fromRGBO(33, 33, 33, 1),
              fontFamily: ConstantsFonts.latoBold,
              fontSize: 13.5.sp,
            ),
          ),
          SizedBox(
            height: 1.8.h,
          ),
          Container(
            height: 0.1.h,
            width: double.infinity,
            color: const Color.fromRGBO(33, 33, 33, 0.2),
          ),
          SizedBox(
            height: 30.h,
            child: child,
          ),
          SizedBox(
            height: 1.8.h,
          ),
          Container(
            width: double.infinity,
            height: 6.2.h,
            margin: EdgeInsets.symmetric(
              horizontal: 15.w,
            ),
            decoration: BoxDecoration(
              color: buttonColor ?? const Color.fromRGBO(23, 94, 217, 1),
              borderRadius: BorderRadius.circular(7),
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(7),
                onTap: () => Navigator.pop(context),
                child: Center(
                  child: Text(
                    textButton,
                    style: buttonTextStyle ?? TextStyle(
                      color: Colors.white,
                      fontSize: 11.5.sp,
                      fontFamily: ConstantsFonts.latoRegular,
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 1.8.h,
          ),
        ],
      );
    },
  );
}
