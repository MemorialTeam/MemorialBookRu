import 'package:flutter/material.dart';
import 'package:memorial_book/helpers/constants.dart';
import 'package:sizer/sizer.dart';

class VerticalProductCard extends StatelessWidget {
  const VerticalProductCard({
    super.key,
    required this.image,
    this.symbol,
    this.width,
  });

  final String image;
  final String? symbol;

  final double? width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: EdgeInsets.all(1.h),
            alignment: Alignment.bottomRight,
            height: 20.h,
            // width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              image: DecorationImage(
                image: AssetImage(image),
                fit: BoxFit.fill,
              ),
            ),
            child: symbol != null ?
            Image.asset(
              symbol!,
              height: 4.h,
            ) :
            null,
          ),
          SizedBox(
            height: 1.h,
          ),
          Padding(
            padding: EdgeInsets.only(
              left: 1.6.w,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Товар',
                  style: TextStyle(
                    fontFamily: ConstantsFonts.latoBold,
                    fontSize: 11.5.sp,
                    color: const Color.fromRGBO(0, 0, 0, 1),
                  ),
                ),
                SizedBox(
                  height: 0.6.h,
                ),
                Text(
                  'US \$29,99',
                  style: TextStyle(
                    fontFamily: ConstantsFonts.latoRegular,
                    fontSize: 9.5.sp,
                    color: const Color.fromRGBO(0, 0, 0, 1),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
