import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:memorial_book/screens/main_flow/search_burial_place_screen.dart';
import 'package:memorial_book/widgets/animation/punching_animation.dart';
import 'package:memorial_book/widgets/creation_body_widget.dart';
import 'package:memorial_book/widgets/creation_flow/date_pick_field.dart';
import 'package:memorial_book/widgets/creation_flow/required_text.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../../../helpers/constants.dart';
import '../../../provider/profile_creation_provider.dart';
import '../../../provider/tab_bar_provider.dart';
import '../../chooser_widget.dart';
import '../../platform_scroll_physics.dart';
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
                text: 'Имя:',
              ),
              SizedBox(
                height: 0.5.h,
              ),
              TextFieldProfileWidget(
                controller: profileCreationProvider.firstNameController,
                hintText: 'Имя',
              ),
              SizedBox(
                height: 3.6.h,
              ),
              const RequiredText(
                text: 'Фамилия:',
              ),
              SizedBox(
                height: 0.5.h,
              ),
              TextFieldProfileWidget(
                controller: profileCreationProvider.lastNameController,
                hintText: 'Фамилия',
              ),
              SizedBox(
                height: 3.6.h,
              ),
              Text(
                'Отчество:',
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
                hintText: 'Отчество',
              ),
              SizedBox(
                height: 3.6.h,
              ),
              const RequiredText(
                text: 'Пол',
              ),
              SizedBox(
                height: 0.5.h,
              ),
              ChooserWidget(
                list: const [
                  'Мужской',
                  'Женский',
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
                text: 'Дата рождения:',
              ),
              SizedBox(
                height: 0.5.h,
              ),
              DatePickField(
                onTap: () => profileCreationProvider.humanBirthDatePicker(context),
                dateTime: profileCreationProvider.humanBirthDate,
              ),
              SizedBox(
                height: 3.6.h,
              ),
              const RequiredText(
                text: 'Дата смерти:',
              ),
              SizedBox(
                height: 0.5.h,
              ),
              DatePickField(
                onTap: () => profileCreationProvider.humanDeathDatePicker(context),
                dateTime: profileCreationProvider.humanDeathDate,
              ),
              SizedBox(
                height: 3.6.h,
              ),
              Text(
                'Причина смерти:',
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
                hintText: 'Укажите причину',
                minLines: 1,
                maxLines: 14,
              ),
              SizedBox(
                height: 3.6.h,
              ),
              const RequiredText(
                text: 'Место рождения:',
              ),
              SizedBox(
                height: 0.5.h,
              ),
              TextFieldProfileWidget(
                controller: profileCreationProvider.profileBirthPlaceController,
                hintText: 'Место рождения',
              ),
              SizedBox(
                height: 3.6.h,
              ),
              Text(
                'Место захоронения:',
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
                        CupertinoDialogRoute(
                          builder: (context) => const SearchBurialPlaceScreen(),
                          context: context,
                        ),
                      );
                    },
                    child: Padding(
                      padding: EdgeInsets.all(1.2.h),
                      child: Row(
                        children: [
                          Expanded(
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              physics: platformScrollPhysics(),
                              child: Text(
                                profileCreationProvider.selectedCemetery.isEmpty ?
                                'Место захоронения' :
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
                          ),
                          profileCreationProvider.selectedCemetery.isNotEmpty ?
                          PunchingAnimation(
                            child: GestureDetector(
                              onTap: () => profileCreationProvider.clearSelectedCemetery(),
                              child: Icon(
                                Icons.close,
                                size: 20.sp,
                                color: const Color.fromRGBO(23, 94, 217, 1),
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
                'Свидетельство о смерти:',
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
                        '+ Загрузить файл',
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
      ],
    );
  }
}
