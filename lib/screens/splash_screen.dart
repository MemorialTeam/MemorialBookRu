import 'package:flutter/material.dart';
import 'package:memorial_book/helpers/constants.dart';
import 'package:sizer/sizer.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(245, 247, 249, 1),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              ConstantsAssets.memorialBookLogoImage,
              height: 52,
              width: 52,
            ),
            SizedBox(
              height: 3.h,
            ),
            Image.asset(
              ConstantsAssets.memorialBookTextImage,
              height: 17,
            ),
          ],
        ),
      ),
    );
  }
}
