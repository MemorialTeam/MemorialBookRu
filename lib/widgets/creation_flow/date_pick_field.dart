import 'package:flutter/material.dart';
import '../../helpers/constants.dart';
import 'package:sizer/sizer.dart';

class DatePickField extends StatelessWidget {
  const DatePickField({
    super.key,
    required this.onTap,
    required this.dateTime,
  });

  final void Function()? onTap;
  final DateTime? dateTime;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: const Color.fromRGBO(205, 209, 214, 1),
        ),
        color: const Color.fromRGBO(245, 247, 249, 1),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(7),
          onTap: onTap,
          child: Padding(
            padding: EdgeInsets.all(1.2.h),
            child: Text(
              dateTime == null ?
              'дд.мм.гггг' :
              '${dateTime!.day.toString().padLeft(2, '0')}.${dateTime!.month.toString().padLeft(2, '0')}.${dateTime!.year}',
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: dateTime == null ?
                const Color.fromRGBO(32, 30, 31, 0.5) :
                const Color.fromRGBO(32, 30, 31, 1),
                fontSize: 13.sp,
                fontFamily: ConstantsFonts.latoRegular,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
