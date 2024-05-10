import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:memorial_book/helpers/constants.dart';
import 'package:memorial_book/test_data.dart';
import 'package:memorial_book/widgets/animation/animated_fade_out_in.dart';
import 'package:memorial_book/widgets/animation/punching_animation.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../../models/common/onboarding_part_model.dart';
import '../../provider/auth_provider.dart';
import '../../provider/onboarding_indicator_provider.dart';
import '../auth&reg_flow/login_screen.dart';

class OnboardingFlow extends StatelessWidget {
  const OnboardingFlow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final onboardingIndicatorProvider = Provider.of<OnboardingIndicatorProvider>(context);
    final authProvider = Provider.of<AuthProvider>(context);
    final OnboardingPartModel onboardingsDataList = TestData().onboardingsDataList[onboardingIndicatorProvider.currentPage];
    const Duration animationSpeed = Duration(
      milliseconds: 250,
    );
    return Scaffold(
      body: NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (OverscrollIndicatorNotification overscroll) {
          overscroll.disallowIndicator();
          return false;
        },
        child: Container(
          width: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0.34, 1],
              colors: [
                Colors.white,
                Color.fromRGBO(23, 94, 217, 1),
              ],
            ),
          ),
          child: Stack(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 5.w,
                ),
                child: Stack(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        bottom: 3.h,
                      ),
                      child: AnimatedAlign(
                        alignment: onboardingIndicatorProvider.currentPage.isEven ?
                        Alignment.centerRight :
                        Alignment.centerLeft,
                        duration: animationSpeed,
                        child: Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: onboardingIndicatorProvider.bottomImage(),
                            ),
                            borderRadius: BorderRadius.circular(5),
                            boxShadow: const [
                              BoxShadow(
                                offset: Offset(5, 0),
                                blurRadius: 30,
                                spreadRadius: 0,
                                color: Color.fromRGBO(0, 0, 0, 0.1),
                              ),
                            ],
                          ),
                          height: 61.5.h,
                          width: 65.w,
                        ),
                      ),
                    ),
                    AnimatedPadding(
                      duration: animationSpeed,
                      padding: EdgeInsets.only(
                        top: onboardingsDataList.paddingTop,
                        bottom: onboardingsDataList.paddingBottom,
                      ),
                      child: AnimatedAlign(
                        duration: animationSpeed,
                        alignment: onboardingIndicatorProvider.currentPage.isEven ?
                        Alignment.centerLeft :
                        Alignment.centerRight,
                        child: Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: onboardingIndicatorProvider.topImage(),
                            ),
                            borderRadius: BorderRadius.circular(5),
                            boxShadow: const [
                              BoxShadow(
                                offset: Offset(5, 0),
                                blurRadius: 30,
                                spreadRadius: 0,
                                color: Color.fromRGBO(0, 0, 0, 0.1),
                              ),
                            ],
                          ),
                          height: 48.h,
                          width: 62.4.w,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: AnimatedContainer(
                  duration: const Duration(
                    milliseconds: 250,
                  ),
                  height: onboardingsDataList.descriptionFrameSize,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(0, -10),
                        blurRadius: 60,
                        spreadRadius: 0,
                        color: Color.fromRGBO(0, 0, 0, 0.4),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 3.4.w,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          height: 3.h,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 6.6.w,
                          ),
                          child: AnimatedFadeOutIn<String>(
                            data: onboardingsDataList.description,
                            initialData: onboardingsDataList.description,
                            duration: animationSpeed,
                            builder: (value) => Text(
                              value,
                              style: TextStyle(
                                fontSize: 12.2.sp,
                                height: 1.2.sp,
                                fontFamily: ConstantsFonts.latoRegular,
                                color: const Color.fromRGBO(32, 30, 31, 0.7),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 5.2.h,
                        ),
                        SizedBox(
                          height: 7.h,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: 7.h,
                ),
                child: Flex(
                  direction: Axis.horizontal,
                  children: [
                    Flex(
                      direction: Axis.vertical,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 5.w,
                            vertical: 1.8.h,
                          ),
                          decoration: const BoxDecoration(
                            color: Color.fromRGBO(23, 94, 217, 1),
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(10),
                              bottomRight: Radius.circular(10),
                            ),
                          ),
                          child: Center(
                            child: AnimatedFadeOutIn<String>(
                              duration: animationSpeed,
                              data: onboardingsDataList.title,
                              initialData: onboardingsDataList.title,
                              builder: (value) => Text(
                                value,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18.sp,
                                  fontFamily: ConstantsFonts.latoBold,
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              PageView(
                onPageChanged: (int page) => onboardingIndicatorProvider.changeAnimationPointOnIndicator(page),
                controller: onboardingIndicatorProvider.pageController,
                children: const [
                  SizedBox(),
                  SizedBox(),
                  SizedBox(),
                  SizedBox(),
                  SizedBox(),
                ],
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: onboardingIndicatorProvider.currentPage == 4 ?
                Padding(
                  padding: EdgeInsets.only(
                    bottom: 3.4.h,
                  ),
                  child: PunchingAnimation(
                    child: Container(
                      height: 7.h,
                      margin: EdgeInsets.symmetric(
                        horizontal: 3.4.w,
                      ),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: const Color.fromRGBO(23, 94, 217, 1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Material(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(10),
                        child: InkWell(
                          onTap: () async {
                            authProvider.setOldUser();
                            Navigator.pushAndRemoveUntil(
                              context,
                              CupertinoPageRoute(
                                builder: (context) => const LoginScreen(),
                              ),
                                  (context) => false,
                            );
                          },
                          child: Center(
                            child: Text(
                              'Continue',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ) :
                Padding(
                  padding: EdgeInsets.only(
                    bottom: 6.h,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: onboardingIndicatorProvider.buildPageIndicator(context),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
