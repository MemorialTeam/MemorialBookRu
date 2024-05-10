import 'package:flutter/material.dart';
import 'package:memorial_book/helpers/constants.dart';
import 'package:memorial_book/widgets/animation/punching_animation.dart';
import 'package:sizer/sizer.dart';

class MaxVerticalProductCard extends StatelessWidget {
  const MaxVerticalProductCard({
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
          ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: Image.asset(
              image,
              width: double.infinity,
            ),
          ),
          SizedBox(
            height: 1.h,
          ),
          Padding(
            padding: EdgeInsets.only(
              left: 1.w,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
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
                      height: 1.h,
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
                PunchingAnimation(
                  child: GestureDetector(
                    onTap: () {},
                    behavior: HitTestBehavior.translucent,
                    child: Padding(
                      padding: EdgeInsets.all(1.w),
                      child: Image.asset(
                        ConstantsAssets.productAddImage,
                        height: 3.6.h,
                      ),
                    ),
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
