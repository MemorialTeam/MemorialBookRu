import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:memorial_book/widgets/creation_body_widget.dart';
import 'package:memorial_book/widgets/creation_flow/required_text.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../../../helpers/constants.dart';
import '../../../provider/profile_creation_provider.dart';
import '../../../provider/tab_bar_provider.dart';
import '../../../screens/main_flow/choosing_place_screen.dart';
import '../../text_field_profile_widget.dart';

class PICemeteryBody extends StatelessWidget {
  const PICemeteryBody({Key? key}) : super(key: key);

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
                text: 'Name:',
              ),
              SizedBox(
                height: 0.5.h,
              ),
              TextFieldProfileWidget(
                controller: profileCreationProvider.placesNameController,
                hintText: 'Name',
              ),
              SizedBox(
                height: 3.6.h,
              ),
              Text(
                'Name in Latin:',
                style: ConstantsTextStyles.unRequiredTextStyle,
              ),
              SizedBox(
                height: 0.5.h,
              ),
              TextFieldProfileWidget(
                controller: profileCreationProvider.placesNameInLatinController,
                hintText: 'Name in Latin',
              ),
              SizedBox(
                height: 3.6.h,
              ),
              Text(
                'Signature:',
                style: TextStyle(
                  color: Colors.grey.shade500,
                  fontWeight: FontWeight.w400,
                  fontSize: 9.5.sp,
                ),
              ),
              SizedBox(
                height: 0.5.h,
              ),
              TextFieldProfileWidget(
                controller: profileCreationProvider.placesSignatureController,
                hintText: 'Signature',
              ),
              SizedBox(
                height: 3.6.h,
              ),
              RequiredText(
                text: 'Location:',
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
                      Navigator.push(
                        tabBarProvider.mainContext,
                        CupertinoPageRoute(
                          builder: (context) => const ChoosingPlaceScreen(),
                        ),
                      );
                    },
                    child: Padding(
                      padding: EdgeInsets.all(1.2.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              profileCreationProvider.selectedCemetery.isEmpty ?
                              'Point out on a map:' :
                              profileCreationProvider.selectedCemetery,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: profileCreationProvider.selectedCemetery.isEmpty ?
                                const Color.fromRGBO(23, 94, 217, 1) :
                                const Color.fromRGBO(32, 30, 31, 1),
                                fontSize: 13.sp,
                                fontFamily: ConstantsFonts.latoRegular,
                              ),
                            ),
                          ),
                          Image.asset(
                            ConstantsAssets.mapIconImage,
                            height: 2.6.h,
                            width: 2.6.h,
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
        CreationBodyWidget(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Email:',
                style: TextStyle(
                  color: Colors.grey.shade500,
                  fontWeight: FontWeight.w400,
                  fontSize: 9.5.sp,
                ),
              ),
              SizedBox(
                height: 0.5.h,
              ),
              TextFieldProfileWidget(
                controller: profileCreationProvider.placesEmailController,
                hintText: 'Email',
                minLines: 1,
                maxLines: 14,
              ),
              SizedBox(
                height: 3.6.h,
              ),
              Text(
                'Phone number:',
                style: TextStyle(
                  color: Colors.grey.shade500,
                  fontWeight: FontWeight.w400,
                  fontSize: 9.5.sp,
                ),
              ),
              SizedBox(
                height: 0.5.h,
              ),
              TextFieldProfileWidget(
                controller: profileCreationProvider.placesPhoneNumberController,
                hintText: 'Phone number',
                minLines: 1,
                maxLines: 14,
              ),
              SizedBox(
                height: 3.6.h,
              ),
              Text(
                'Work schedule:',
                style: TextStyle(
                  color: Colors.grey.shade500,
                  fontWeight: FontWeight.w400,
                  fontSize: 9.5.sp,
                ),
              ),
              SizedBox(
                height: 0.5.h,
              ),
              TextFieldProfileWidget(
                controller: profileCreationProvider.profileDeathCauseController,
                hintText: 'Work schedule',
                minLines: 1,
                maxLines: 14,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
