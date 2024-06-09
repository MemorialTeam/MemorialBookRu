import 'package:flutter/material.dart';
import 'package:flutter_multi_formatter/formatters/masked_input_formatter.dart';
import 'package:memorial_book/helpers/constants.dart';
import 'package:memorial_book/widgets/creation_body_widget.dart';
import 'package:memorial_book/widgets/creation_flow/required_text.dart';
import 'package:memorial_book/widgets/social_links_adder_widget.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../../../provider/profile_creation_provider.dart';
import '../../text_field_profile_widget.dart';

class PICommunityBody extends StatelessWidget {
  const PICommunityBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final profileCreationProvider = Provider.of<ProfileCreationProvider>(context);
    return Column(
      children: [
        CreationBodyWidget(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const RequiredText(
                text: 'Название:',
              ),
              SizedBox(
                height: 0.5.h,
              ),
              TextFieldProfileWidget(
                controller: profileCreationProvider.communitiesNameController,
                hintText: 'Название',
              ),
              SizedBox(
                height: 3.6.h,
              ),
              const RequiredText(
                text: 'Подпись:',
              ),
              SizedBox(
                height: 0.5.h,
              ),
              TextFieldProfileWidget(
                controller: profileCreationProvider.communitiesSignatureController,
                hintText: 'Подпись',
              ),
              SizedBox(
                height: 3.6.h,
              ),
              const RequiredText(
                text: 'Местоположение:',
              ),
              SizedBox(
                height: 0.5.h,
              ),
              TextFieldProfileWidget(
                controller: profileCreationProvider.communitiesLocationController,
                hintText: 'Местоположение',
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
              const RequiredText(
                text: 'Email:',
              ),
              SizedBox(
                height: 0.5.h,
              ),
              TextFieldProfileWidget(
                controller: profileCreationProvider.communitiesEmailController,
                hintText: 'Email',
                minLines: 1,
                maxLines: 14,
              ),
              SizedBox(
                height: 3.6.h,
              ),
              const RequiredText(
                text: 'Номер телефона:',
              ),
              SizedBox(
                height: 0.5.h,
              ),
              TextFieldProfileWidget(
                controller: profileCreationProvider.communitiesPhoneNumberController,
                hintText: 'Номер телефона',
                minLines: 1,
                maxLines: 1,
                inputFormatters: [
                  MaskedInputFormatter(
                    '+# (###) ###-##-##',
                    allowedCharMatcher: RegExp(r'[0-9]'),
                  ),
                ],
                keyboardType: TextInputType.number,
              ),
              SizedBox(
                height: 3.6.h,
              ),
              Text(
                'Сайт:',
                style: ConstantsTextStyles.unRequiredTextStyle,
              ),
              SizedBox(
                height: 0.5.h,
              ),
              TextFieldProfileWidget(
                controller: profileCreationProvider.websiteController,
                hintText: 'Сайт',
                minLines: 1,
                maxLines: 1,
              ),
              SocialLinksAdderWidget(
                dataList: profileCreationProvider.communitiesSocialLinks,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
