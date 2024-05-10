import 'package:flutter/material.dart';
import 'package:memorial_book/provider/profile_creation_provider.dart';
import 'package:memorial_book/screens/profile_creation_flow/description_screen.dart';
import 'package:memorial_book/screens/profile_creation_flow/posting_screen.dart';
import 'package:memorial_book/screens/profile_creation_flow/primary_inforamtion_screen.dart';
import 'package:memorial_book/widgets/unscope_scaffold.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../../helpers/constants.dart';
import '../../widgets/animation/sprite_painter.dart';
import '../../widgets/memorial_app_bar.dart';

class CreationFlow extends StatefulWidget {
  const CreationFlow({
    Key? key,
    required this.checkFlow,
  }) : super(key: key);

  final CheckFlow checkFlow;

  @override
  State<CreationFlow> createState() => _CreationFlowState();
}

class _CreationFlowState extends State<CreationFlow> with SingleTickerProviderStateMixin {

  late AnimationController _animationController;

  void _initialization() {
    _animationController = AnimationController(
      vsync: this,
    );
  }

  void _startAnimation() {
    _animationController.stop();
    _animationController.reset();
    _animationController.repeat(
      period: const Duration(
        seconds: 1,
      ),
    );
  }

  void _finishAnimation() {
    _animationController.dispose();
  }

  @override
  void initState() {
    final profileCreationProvider = Provider.of<ProfileCreationProvider>(context, listen: false);
    switch(widget.checkFlow) {
      case CheckFlow.profile:
        profileCreationProvider.gettingReligions().whenComplete(() => profileCreationProvider.gettingRelatedProfiles(
          context: context,
          gender: 'male',
        ).whenComplete(
          (() async => await profileCreationProvider.gettingRelatedProfiles(
            context: context,
            gender: 'female',
          ).whenComplete(
            (() async => await profileCreationProvider.gettingRelatedProfiles(
              context: context,
            )),
          )),
        )).whenComplete(() => profileCreationProvider.gettingHobbies());
        break;
      case CheckFlow.pet:
        profileCreationProvider.gettingRelatedProfiles(
          context: context,
        );
        break;
      case CheckFlow.cemetery:
        break;
      case CheckFlow.community:
        break;
      case CheckFlow.editCommunity:
        break;
    }
    profileCreationProvider.animationDispose();
    _initialization();
    _startAnimation();
    super.initState();
  }

  @override
  void dispose() {
    _finishAnimation();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final profileCreationProvider = Provider.of<ProfileCreationProvider>(context);
    return MemorialAppBar(
      automaticallyImplyBackLeading: true,
      child: UnScopeScaffold(
        backgroundColor: const Color.fromRGBO(245, 247, 249, 1),
        body: SafeArea(
          child: Stack(
            children: [
              PageView(
                controller: profileCreationProvider.pageController,
                physics: const BouncingScrollPhysics(),
                onPageChanged: (index) => profileCreationProvider.onChangePage(index),
                children: [
                  PrimaryInformationScreen(
                    checkFlow: widget.checkFlow,
                  ),
                  DescriptionScreen(
                    checkFlow: widget.checkFlow,
                  ),
                  PostingScreen(
                    checkFlow: widget.checkFlow,
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: 2.6.h,
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 5.5.w,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomPaint(
                            painter: profileCreationProvider.indexPage == 0 ?
                            SpritePainter(_animationController) :
                            null,
                            child: Container(
                              height: 1.8.h,
                              width: 1.8.h,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color.fromRGBO(23, 94, 217, 1),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              height: 1,
                              width: double.infinity,
                              color: profileCreationProvider.indexPage < 1 ?
                              const Color.fromRGBO(32, 30, 31, 0.3) :
                              const Color.fromRGBO(23, 94, 217, 0.3),
                              margin: EdgeInsets.symmetric(
                                horizontal: 1.4.h,
                              ),
                            ),
                          ),
                          CustomPaint(
                            painter: profileCreationProvider.indexPage == 1 ?
                            SpritePainter(_animationController) :
                            null,
                            child: Container(
                              height: 1.8.h,
                              width: 1.8.h,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: profileCreationProvider.indexPage >= 1 ?
                                const Color.fromRGBO(23, 94, 217, 1) :
                                const Color.fromRGBO(32, 30, 31, 0.3),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              height: 1,
                              width: double.infinity,
                              color: profileCreationProvider.indexPage < 2 ?
                              const Color.fromRGBO(32, 30, 31, 0.3) :
                              const Color.fromRGBO(23, 94, 217, 0.3),
                              margin: EdgeInsets.symmetric(
                                horizontal: 1.4.h,
                              ),
                            ),
                          ),
                          CustomPaint(
                            painter: profileCreationProvider.indexPage == 2 ?
                            SpritePainter(_animationController) :
                            null,
                            child: Container(
                              height: 1.8.h,
                              width: 1.8.h,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: profileCreationProvider.indexPage >= 2 ?
                                const Color.fromRGBO(23, 94, 217, 1) :
                                const Color.fromRGBO(32, 30, 31, 0.3),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 1.8.h,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                      ),
                      child: Stack(
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Primary info...',
                              style: TextStyle(
                                color: const Color.fromRGBO(23, 94, 217, 1),
                                fontFamily: ConstantsFonts.latoRegular,
                                fontSize: 9.sp,
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: Text(
                              'Description',
                              style: TextStyle(
                                color: profileCreationProvider.indexPage >= 1 ?
                                const Color.fromRGBO(23, 94, 217, 1) :
                                const Color.fromRGBO(32, 30, 31, 0.3),
                                fontFamily: ConstantsFonts.latoRegular,
                                fontSize: 9.sp,
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              'Posting',
                              style: TextStyle(
                                color: profileCreationProvider.indexPage >= 2 ?
                                const Color.fromRGBO(23, 94, 217, 1) :
                                const Color.fromRGBO(32, 30, 31, 0.3),
                                fontFamily: ConstantsFonts.latoRegular,
                                fontSize: 9.sp,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
