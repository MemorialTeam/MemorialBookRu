import 'package:flutter/material.dart';
import 'package:memorial_book/widgets/memorial_app_bar.dart';
import 'package:sizer/sizer.dart';
import '../../helpers/constants.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MemorialAppBar(
      child: Scaffold(
        backgroundColor: const Color.fromRGBO(245, 247, 249, 1),
        body: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: 1.2.h,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 1.2.h,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                    ),
                    child: Text(
                      'Not viewed',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 10.sp,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 1.2.h,
                  ),
                  Column(
                    children: List.generate(
                      2, (index) => Container(
                      margin: const EdgeInsets.symmetric(
                        vertical: 1,
                      ),
                      color: const Color.fromRGBO(255, 255, 255, 1),
                      width: double.infinity,
                      height: 10.h,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 10,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Image.asset(
                              ConstantsAssets.avatarTestImage,
                              height: 7.h,
                              width: 7.h,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'General Motors',
                                  style: TextStyle(
                                    fontSize: 9.5.sp,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                SizedBox(
                                  height: 1.h,
                                ),
                                Text(
                                  'Added 2 new pictures today at 1:56 PM',
                                  style: TextStyle(
                                    fontSize: 8.5.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                            Image.asset(
                              ConstantsAssets.testGalleryImage,
                            ),
                          ],
                        ),
                      ),
                    ),
                    ),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                    ),
                    child: Text(
                      'Viewed',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 10.sp,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 1.2.h,
                  ),
                  Column(
                    children: List.generate(
                      10, (index) => Container(
                      margin: const EdgeInsets.symmetric(
                        vertical: 1,
                      ),
                      color: const Color.fromRGBO(255, 255, 255, 1),
                      width: double.infinity,
                      height: 10.h,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 10,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Image.asset(
                              ConstantsAssets.avatarTestImage,
                              height: 7.h,
                              width: 7.h,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'General Motors',
                                  style: TextStyle(
                                    fontSize: 9.5.sp,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                SizedBox(
                                  height: 1.h,
                                ),
                                Text(
                                  'Added 2 new pictures today at 1:56 PM',
                                  style: TextStyle(
                                    fontSize: 8.5.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                            Image.asset(
                              ConstantsAssets.testGalleryImage,
                            ),
                          ],
                        ),
                      ),
                    ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      automaticallyImplyBackLeading: true,
      automaticallyImplyBackTrailing: false,
    );
  }
}