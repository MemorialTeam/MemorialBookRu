import 'package:flutter/material.dart';
import 'package:memorial_book/widgets/creation_flow/primary_information/pi_cemetery_body.dart';
import 'package:memorial_book/widgets/creation_flow/primary_information/pi_edit_community_body.dart';
import 'package:memorial_book/widgets/creation_flow/primary_information/pi_pet_body.dart';
import 'package:memorial_book/widgets/creation_flow/primary_information/pi_profile_body.dart';
import 'package:memorial_book/widgets/main_button.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../../helpers/constants.dart';
import '../../provider/profile_creation_provider.dart';
import '../../widgets/creation_flow/primary_information/pi_community_body.dart';

class PrimaryInformationScreen extends StatefulWidget {
  const PrimaryInformationScreen({
    Key? key,
    required this.checkFlow,
  }) : super(key: key);

  final CheckFlow checkFlow;

  @override
  State<PrimaryInformationScreen> createState() => _PrimaryInformationScreenState();
}

class _PrimaryInformationScreenState extends State<PrimaryInformationScreen> {

  Widget piBody() {
    switch(widget.checkFlow) {
      case CheckFlow.profile:
        return const PIProfileBody();
      case CheckFlow.cemetery:
        return const PICemeteryBody();
      case CheckFlow.community:
        return const PICommunityBody();
      case CheckFlow.pet:
        return const PIPetBody();
      case CheckFlow.editCommunity:
        return const PIEditCommunityBody();
      default:
        return const SizedBox();
    }
  }

  @override
  Widget build(BuildContext context) {
    final profileCreationProvider = Provider.of<ProfileCreationProvider>(context);
    return Form(
      onChanged: () {
        setState(() {});
      },
      child: SingleChildScrollView(
        padding: EdgeInsets.zero,
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 3.2.w,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 12.h,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    profileCreationProvider.generateTitle(widget.checkFlow),
                    style: TextStyle(
                      color: const Color.fromRGBO(32, 30, 31, 1),
                      fontFamily: ConstantsFonts.latoBlack,
                      fontSize: 21.sp,
                    ),
                  ),
                  SizedBox(
                    height: 4.h,
                  ),
                  SizedBox(
                    height: 30.8.h,
                    child: Stack(
                      children: [
                        Container(
                          width: double.infinity,
                          height: 28.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: const Color.fromRGBO(217, 217, 217, 1),
                            image: profileCreationProvider.generateBackgroundImage(widget.checkFlow) == null ?
                            null :
                            DecorationImage(
                              image: FileImage(
                                profileCreationProvider.generateBackgroundImage(widget.checkFlow)!,
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: profileCreationProvider.generateBackgroundImage(widget.checkFlow) == null ?
                          Center(
                            child: Icon(
                              Icons.camera_alt_rounded,
                              size: 53.sp,
                              color: const Color.fromRGBO(186, 186, 186, 1),
                            ),
                          ) :
                          null,
                        ),
                        Align(
                          alignment: Alignment.topRight,
                          child: Container(
                            height: 5.5.h,
                            width: 5.5.h,
                            margin: EdgeInsets.all(3.w),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: const Color.fromRGBO(255, 255, 255, 1),
                            ),
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                borderRadius: BorderRadius.circular(100),
                                onTap: () {
                                  profileCreationProvider.pickBackgroundImage(widget.checkFlow);
                                },
                                child: Center(
                                  child: Icon(
                                    Icons.camera_alt_outlined,
                                    size: 20.sp,
                                    color: const Color.fromRGBO(23, 94, 217, 1),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomLeft,
                          child: Stack(
                            children: [
                              Container(
                                height: 15.h,
                                width: 15.h,
                                margin: EdgeInsets.only(
                                  left: 4.w,
                                ),
                                padding: const EdgeInsets.all(4),
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color.fromRGBO(245, 247, 249, 1),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Color.fromRGBO(0, 0, 0, 0.05),
                                      blurRadius: 30,
                                      spreadRadius: 0,
                                      offset: Offset(3, 5),
                                    ),
                                  ],
                                ),
                                child: profileCreationProvider.generateAvatarImage(widget.checkFlow) != null ?
                                Container(
                                  height: double.infinity,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                      image: FileImage(profileCreationProvider.generateAvatarImage(widget.checkFlow)!),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ) :
                                Center(
                                  child: Container(
                                    width: double.infinity,
                                    height: double.infinity,
                                    decoration: BoxDecoration(
                                      color: const Color.fromRGBO(217, 217, 217, 1),
                                      borderRadius: BorderRadius.circular(100),
                                    ),
                                    child: Icon(
                                      Icons.camera_alt_rounded,
                                      size: 53.sp,
                                      color: const Color.fromRGBO(186, 186, 186, 1),
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: 0.1,
                                right: 0.1,
                                child: Container(
                                  height: 5.5.h,
                                  width: 5.5.h,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Color.fromRGBO(255, 255, 255, 1),
                                  ),
                                  child: Material(
                                    color: Colors.transparent,
                                    child: InkWell(
                                      borderRadius: BorderRadius.circular(100),
                                      onTap: () {
                                        profileCreationProvider.pickAvatarImage(widget.checkFlow);
                                      },
                                      child: Center(
                                        child: Icon(
                                          Icons.camera_alt_outlined,
                                          size: 20.sp,
                                          color: const Color.fromRGBO(23, 94, 217, 1),
                                        ),
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
                  SizedBox(
                    height: 1.4.h,
                  ),
                  piBody(),
                  SizedBox(
                    height: 1.2.h,
                  ),
                  MainButton(
                    margin: EdgeInsets.symmetric(
                      vertical: 2.2.h,
                      horizontal: 15.w,
                    ),
                    text: 'CONTINUE',
                    onTap: (() {
                      profileCreationProvider.pageController.nextPage(
                        duration: const Duration(
                          milliseconds: 500,
                        ),
                        curve: Curves.ease,
                      );
                    }),
                    condition: profileCreationProvider.primaryInfoCheck(widget.checkFlow),
                  ),
                  // Container(
                  //   height: 6.h,
                  //   margin: EdgeInsets.symmetric(
                  //     vertical: 2.2.h,
                  //     horizontal: 20.w,
                  //   ),
                  //   width: double.infinity,
                  //   decoration: BoxDecoration(
                  //     borderRadius: BorderRadius.circular(7),
                  //     color: profileCreationProvider.primaryInfoCheck(widget.checkFlow) != true ?
                  //     const Color.fromRGBO(23, 94, 217, 0.5) :
                  //     const Color.fromRGBO(23, 94, 217, 1),
                  //   ),
                  //   child: Material(
                  //     color: Colors.transparent,
                  //     child: InkWell(
                  //       borderRadius: BorderRadius.circular(7),
                  //       onTap: profileCreationProvider.primaryInfoCheck(widget.checkFlow) != true ?
                  //       null :
                  //       (() {
                  //         profileCreationProvider.pageController.nextPage(
                  //           duration: const Duration(
                  //             milliseconds: 500,
                  //           ),
                  //           curve: Curves.ease,
                  //         );
                  //       }),
                  //       child: Center(
                  //         child: Text(
                  //           'CONTINUE',
                  //           style: TextStyle(
                  //             color: Colors.white,
                  //             fontFamily: ConstantsFonts.latoRegular,
                  //             fontSize: 10.5.sp,
                  //           ),
                  //         ),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  SizedBox(
                    height: 1.6.h,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
