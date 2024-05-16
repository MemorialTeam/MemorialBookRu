import 'package:flutter/material.dart';
import 'package:memorial_book/helpers/constants.dart';
import 'package:memorial_book/widgets/animation/punching_animation.dart';
import 'package:sizer/sizer.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    super.key,
    required this.height,
    required this.image,
    required this.title,
    required this.onTap,
  });

  final double height;

  final String image;
  final String title;

  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return PunchingAnimation(
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: onTap,
        child: Container(
          width: double.infinity,
          height: height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: const Color.fromRGBO(87, 167, 109, 1),
              width: 0.3.h,
            ),
            image: DecorationImage(
              image: AssetImage(image),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 3.2.w,
              vertical: 2.2.h,
            ),
            child: Text(
              title,
              style: TextStyle(
                color: const Color.fromRGBO(0, 0, 0, 1),
                fontFamily: ConstantsFonts.latoSemiBold,
                fontSize: 15.5.sp,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
