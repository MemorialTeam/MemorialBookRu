import 'package:flutter/material.dart';
import 'package:flutter_multi_formatter/formatters/masked_input_formatter.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../../../helpers/constants.dart';
import '../../../provider/profile_creation_provider.dart';
import '../../creation_body_widget.dart';
import '../../text_field_profile_widget.dart';

class PIEditCommunityBody extends StatelessWidget {
  const PIEditCommunityBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final profileCreationProvider = Provider.of<ProfileCreationProvider>(context);
    return Column(
      children: [
        CreationBodyWidget(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Name:',
                style: ConstantsTextStyles.unRequiredTextStyle,
              ),
              SizedBox(
                height: 0.5.h,
              ),
              TextFieldProfileWidget(
                controller: profileCreationProvider.editCommunityNameController,
                hintText: profileCreationProvider.communityEditModel.title,
              ),
              /// SOON
              // SizedBox(
              //   height: 3.6.h,
              // ),
              // Text(
              //   'Name in Latin:',
              //   style: TextStyle(
              //     color: Colors.grey.shade500,
              //     fontWeight: FontWeight.w400,
              //     fontSize: 9.5.sp,
              //   ),
              // ),
              // SizedBox(
              //   height: 0.5.h,
              // ),
              // TextFieldProfileWidget(
              //   controller: profileCreationProvider.communitiesNameInLatinController,
              //   hintText: profileCreationProvider.communitiesNameController.text.isEmpty ?
              //   'Name in Latin' :
              //   profileCreationProvider.communitiesNameController.text,
              // ),
              SizedBox(
                height: 3.6.h,
              ),
              Text(
                'Signature:',
                style: ConstantsTextStyles.unRequiredTextStyle,
              ),
              SizedBox(
                height: 0.5.h,
              ),
              TextFieldProfileWidget(
                controller: profileCreationProvider.editCommunitySignatureController,
                hintText: profileCreationProvider.communityEditModel.subtitle,
              ),
              SizedBox(
                height: 3.6.h,
              ),
              Text(
                'Location:',
                style: ConstantsTextStyles.unRequiredTextStyle,
              ),
              SizedBox(
                height: 0.5.h,
              ),
              TextFieldProfileWidget(
                controller: profileCreationProvider.editCommunityLocationController,
                hintText: profileCreationProvider.communityEditModel.address,
                minLines: 1,
                maxLines: 1,
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
                style: ConstantsTextStyles.unRequiredTextStyle,
              ),
              SizedBox(
                height: 0.5.h,
              ),
              TextFieldProfileWidget(
                controller: profileCreationProvider.editCommunityEmailController,
                hintText: profileCreationProvider.communityEditModel.email,
                minLines: 1,
                maxLines: 14,
              ),
              SizedBox(
                height: 3.6.h,
              ),
              Text(
                'Phone number:',
                style: ConstantsTextStyles.unRequiredTextStyle,
              ),
              SizedBox(
                height: 0.5.h,
              ),
              TextFieldProfileWidget(
                controller: profileCreationProvider.editCommunityPhoneNumberController,
                hintText: profileCreationProvider.communityEditModel.phone,
                minLines: 1,
                maxLines: 1,
                inputFormatters: [
                  MaskedInputFormatter(
                    '+###############',
                  ),
                ],
                keyboardType: TextInputType.number,
              ),
              SizedBox(
                height: 3.6.h,
              ),
              Text(
                'Website:',
                style: ConstantsTextStyles.unRequiredTextStyle,
              ),
              SizedBox(
                height: 0.5.h,
              ),
              TextFieldProfileWidget(
                controller: profileCreationProvider.editWebsiteCommunityController,
                hintText: profileCreationProvider.communityEditModel.website != '' ?
                profileCreationProvider.communityEditModel.website :
                'Website',
                minLines: 1,
                maxLines: 1,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
