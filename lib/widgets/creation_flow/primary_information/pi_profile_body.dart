import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:memorial_book/screens/main_flow/search_burial_place_screen.dart';
import 'package:memorial_book/widgets/animation/punching_animation.dart';
import 'package:memorial_book/widgets/creation_body_widget.dart';
import 'package:memorial_book/widgets/creation_flow/required_text.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../../../helpers/constants.dart';
import '../../../provider/profile_creation_provider.dart';
import '../../../provider/tab_bar_provider.dart';
import '../../../screens/main_flow/choosing_place_screen.dart';
import '../../chooser_widget.dart';
import '../../text_field_profile_widget.dart';

class PIProfileBody extends StatelessWidget {
  const PIProfileBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final profileCreationProvider = Provider.of<ProfileCreationProvider>(context);
    final tabBarProvider = Provider.of<TabBarProvider>(context);
    return Column(
      children: [
        CreationBodyWidget(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const RequiredText(
                text: 'First name:',
              ),
              SizedBox(
                height: 0.5.h,
              ),
              TextFieldProfileWidget(
                controller: profileCreationProvider.firstNameController,
                hintText: 'First name',
              ),
              SizedBox(
                height: 3.6.h,
              ),
              const RequiredText(
                text: 'Last name:',
              ),
              SizedBox(
                height: 0.5.h,
              ),
              TextFieldProfileWidget(
                controller: profileCreationProvider.lastNameController,
                hintText: 'Last name',
              ),
              SizedBox(
                height: 3.6.h,
              ),
              Text(
                'Middle name:',
                style: TextStyle(
                  color: const Color.fromRGBO(32, 30, 31, 0.5),
                  fontFamily: ConstantsFonts.latoRegular,
                  fontSize: 9.5.sp,
                ),
              ),
              SizedBox(
                height: 0.5.h,
              ),
              TextFieldProfileWidget(
                controller: profileCreationProvider.middleNameController,
                hintText: 'Middle name',
              ),
              SizedBox(
                height: 3.6.h,
              ),
              const RequiredText(
                text: 'Gender',
              ),
              SizedBox(
                height: 0.5.h,
              ),
              ChooserWidget(
                list: const [
                  'Male',
                  'Female',
                ],
                tag: 'gender',
                text: profileCreationProvider.gender,
              ),
            ],
          ),
        ),
        SizedBox(
          height: 1.2.h,
        ),
        CreationBodyWidget(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const RequiredText(
                text: 'Birth date',
              ),
              SizedBox(
                height: 0.5.h,
              ),
              Container(
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
                    onTap: () {
                      profileCreationProvider.humanBirthDatePicker(context);
                    },
                    child: Padding(
                      padding: EdgeInsets.all(1.2.h),
                      child: Text(
                        profileCreationProvider.humanBirthDate == null ?
                        'dd.mm.yyyy' :
                        '${profileCreationProvider.humanBirthDate!.day.toString().padLeft(2, '0')}.${profileCreationProvider.humanBirthDate!.month.toString().padLeft(2, '0')}.${profileCreationProvider.humanBirthDate!.year}',
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: profileCreationProvider.humanBirthDate == null ?
                          const Color.fromRGBO(32, 30, 31, 0.5) :
                          const Color.fromRGBO(32, 30, 31, 1),
                          fontSize: 13.sp,
                          fontFamily: ConstantsFonts.latoRegular,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              // TextFieldProfileWidget(
              //   keyboardType: TextInputType.number,
              //   controller: profileCreationProvider.birthDateNameController,
              //   hintText: 'dd.mm.yyyy',
              //   inputFormatters: [
              //     MaskedInputFormatter('##.##.####'),
              //   ],
              // ),
              SizedBox(
                height: 3.6.h,
              ),
              const RequiredText(
                text: 'Death date',
              ),
              SizedBox(
                height: 0.5.h,
              ),
              Container(
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
                    onTap: () {
                      profileCreationProvider.humanDeathDatePicker(context);
                    },
                    child: Padding(
                      padding: EdgeInsets.all(1.2.h),
                      child: Text(
                        profileCreationProvider.humanDeathDate == null ?
                        'dd.mm.yyyy' :
                        '${profileCreationProvider.humanDeathDate!.day.toString().padLeft(2, '0')}.${profileCreationProvider.humanDeathDate!.month.toString().padLeft(2, '0')}.${profileCreationProvider.humanDeathDate!.year}',
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: profileCreationProvider.humanDeathDate == null ?
                          const Color.fromRGBO(32, 30, 31, 0.5) :
                          const Color.fromRGBO(32, 30, 31, 1),
                          fontSize: 13.sp,
                          fontFamily: ConstantsFonts.latoRegular,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              // TextFieldProfileWidget(
              //   keyboardType: TextInputType.number,
              //   controller: profileCreationProvider.deathDateNameController,
              //   hintText: 'dd.mm.yyyy',
              //   inputFormatters: [
              //     MaskedInputFormatter('##.##.####'),
              //   ],
              // ),
              SizedBox(
                height: 3.6.h,
              ),
              Text(
                'Death cause:',
                style: TextStyle(
                  color: const Color.fromRGBO(32, 30, 31, 0.5),
                  fontFamily: ConstantsFonts.latoRegular,
                  fontSize: 9.5.sp,
                ),
              ),
              SizedBox(
                height: 0.5.h,
              ),
              TextFieldProfileWidget(
                controller: profileCreationProvider.profileDeathCauseController,
                hintText: 'Specify а cause',
                minLines: 1,
                maxLines: 14,
              ),
              SizedBox(
                height: 3.6.h,
              ),
              const RequiredText(
                text: 'Birth place:',
              ),
              SizedBox(
                height: 0.5.h,
              ),
              TextFieldProfileWidget(
                controller: profileCreationProvider.profileBirthPlaceController,
                hintText: 'Birth place',
              ),
              SizedBox(
                height: 3.6.h,
              ),
              Text(
                'Burial place:',
                style: ConstantsTextStyles.unRequiredTextStyle,
              ),
              SizedBox(
                height: 0.5.h,
              ),
              Container(
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
                    borderRadius: BorderRadius.circular(8),
                    onTap: () {
                      Navigator.push(
                        tabBarProvider.mainContext,
                        CupertinoPageRoute(
                          builder: (context) => const SearchBurialPlaceScreen(),
                        ),
                      );
                    },
                    child: Padding(
                      padding: EdgeInsets.all(1.2.h),
                      child: Stack(
                        children: [
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            physics: const BouncingScrollPhysics(),
                            child: Text(
                              profileCreationProvider.selectedCemetery.isEmpty ?
                              'Burial place:' :
                              profileCreationProvider.selectedCemetery,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: profileCreationProvider.selectedCemetery.isEmpty ?
                                const Color.fromRGBO(32, 30, 31, 0.5) :
                                const Color.fromRGBO(32, 30, 31, 1),
                                fontSize: 13.sp,
                                fontFamily: ConstantsFonts.latoRegular,
                              ),
                            ),
                          ),
                          profileCreationProvider.selectedCemetery.isNotEmpty ?
                          Positioned(
                            right: 0,
                            top: 0,
                            bottom: 0,
                            child: PunchingAnimation(
                              child: GestureDetector(
                                onTap: () => profileCreationProvider.clearSelectedCemetery(),
                                child: Icon(
                                  Icons.close,
                                  size: 20.sp,
                                  color: const Color.fromRGBO(23, 94, 217, 1),
                                ),
                              ),
                            ),
                          ) :
                          const SizedBox(),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 3.6.h,
              ),
              Text(
                'Death certificate:',
                style: ConstantsTextStyles.unRequiredTextStyle,
              ),
              SizedBox(
                height: 0.5.h,
              ),
              Container(
                width: profileCreationProvider.profileCertificate == null ?
                double.infinity :
                null,
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
                    onTap: () {
                      profileCreationProvider.pdfPick(context);
                    },
                    child: profileCreationProvider.profileCertificate == null ?
                    Padding(
                      padding: EdgeInsets.all(1.2.h),
                      child: Text(
                        '+ Upload a file',
                        style: TextStyle(
                          color: const Color.fromRGBO(23, 94, 217, 1),
                          fontSize: 13.sp,
                          fontFamily: ConstantsFonts.latoBold,
                        ),
                      ),
                    ) : SizedBox(
                      height: 9.h,
                      width: 9.h,
                      child: Stack(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                              top: 1.h,
                              left: 1.h,
                              right: 1.h,
                              bottom: 1.h,
                            ),
                            child: Container(
                              height: double.infinity,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: const Color.fromRGBO(255, 255, 255, 1),
                              ),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                  vertical: 1.h,
                                  horizontal: 0.6.h,
                                ),
                                child: Image.asset(
                                  ConstantsAssets.pdfFileImage,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.topRight,
                            child: Container(
                              decoration: const BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    offset: Offset(5, 5),
                                    color: Color.fromRGBO(0, 0, 0, 0.1),
                                    spreadRadius: 0,
                                    blurRadius: 25,
                                  ),
                                ],
                                shape: BoxShape.circle,
                                color: Color.fromRGBO(255, 255, 255, 1),
                              ),
                              child: Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  onTap: () {
                                    profileCreationProvider.removePDF();
                                  },
                                  borderRadius: BorderRadius.circular(1000),
                                  child: Padding(
                                    padding: EdgeInsets.all(0.36.h),
                                    child: Icon(
                                      Icons.close,
                                      size: 16.sp,
                                      color: const Color.fromRGBO(32, 30, 31, 1),
                                    ),
                                  ),
                                ),
                              ),
                            ),
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
        SizedBox(
          height: 1.2.h,
        ),
        profileCreationProvider.fatherList.isEmpty &&
            profileCreationProvider.husbandWifeList.isEmpty &&
            profileCreationProvider.motherList.isEmpty ?
        const SizedBox() :
        CreationBodyWidget(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              profileCreationProvider.fatherList.isNotEmpty ?
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Father',
                    style: ConstantsTextStyles.unRequiredTextStyle,
                  ),
                  SizedBox(
                    height: 0.5.h,
                  ),
                  ChooserWidget(
                    humansList: profileCreationProvider.fatherList,
                    list: null,
                    tag: 'father',
                    text: profileCreationProvider.father,
                  ),
                ],
              ) :
              const SizedBox(),
              profileCreationProvider.husbandWifeList.isNotEmpty ?
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 3.6.h,
                  ),
                  Text(
                    'Husband / wife',
                    style: ConstantsTextStyles.unRequiredTextStyle,
                  ),
                  SizedBox(
                    height: 0.5.h,
                  ),
                  ChooserWidget(
                    list: null,
                    tag: 'husband',
                    text: profileCreationProvider.husbandWife,
                    humansList: profileCreationProvider.husbandWifeList,
                  ),
                ],
              ) :
              const SizedBox(),
              profileCreationProvider.motherList.isNotEmpty ?
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 3.6.h,
                  ),
                  Text(
                    'Mother',
                    style: ConstantsTextStyles.unRequiredTextStyle,
                  ),
                  SizedBox(
                    height: 0.5.h,
                  ),
                  ChooserWidget(
                    list: null,
                    tag: 'mother',
                    text: profileCreationProvider.mother,
                    humansList: profileCreationProvider.motherList,
                  ),
                ],
              ) :
              const SizedBox(),
            ],
          ),
        ),
      ],
    );
  }
}
