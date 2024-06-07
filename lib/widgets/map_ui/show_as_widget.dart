import 'package:flutter/material.dart';
import '../../helpers/constants.dart';
import 'package:sizer/sizer.dart';

class ShowAsWidget extends StatelessWidget {
  const ShowAsWidget({
    super.key,
    required this.sheetController,
    required this.childSizeSheet,
    this.title,
    this.image,
    this.color,
  });

  final DraggableScrollableController sheetController;

  final double childSizeSheet;

  final Color? color;

  final String? title;
  final String? image;

  void onTap() {
    sheetController.animateTo(
      childSizeSheet,
      // childSizeSheet,
      duration: const Duration(
        milliseconds: 500,
      ),
      curve: Curves.ease,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color.fromRGBO(255, 255, 255, 1),
        borderRadius: BorderRadius.circular(30),
        boxShadow: const [
          BoxShadow(
            offset: Offset(0, 4),
            spreadRadius: 0,
            blurRadius: 30,
            color: Color.fromRGBO(0, 0, 0, 0.1),
          ),
          BoxShadow(
            offset: Offset(0, 4),
            spreadRadius: 0,
            blurRadius: 30,
            color: Color.fromRGBO(0, 0, 0, 0.1),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(30),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 5.w,
              vertical: 1.5.h,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  image ?? ConstantsAssets.menuBarImage,
                  height: 1.4.h,
                  color: color ?? const Color.fromRGBO(23, 94, 217, 1),
                ),
                SizedBox(
                  width: 2.4.w,
                ),
                Text(
                  title ?? 'Показать в виде списка',
                  style: TextStyle(
                    color: const Color.fromRGBO(0, 0, 0, 1),
                    fontFamily: ConstantsFonts.latoRegular,
                    fontSize: 9.5.sp,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
