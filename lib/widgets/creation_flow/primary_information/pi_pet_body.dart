import 'package:flutter/material.dart';
import 'package:flutter_multi_formatter/formatters/masked_input_formatter.dart';
import 'package:memorial_book/widgets/creation_body_widget.dart';
import 'package:memorial_book/widgets/creation_flow/required_text.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../../../helpers/constants.dart';
import '../../../provider/profile_creation_provider.dart';
import '../../../provider/tab_bar_provider.dart';
import '../../chooser_widget.dart';
import '../../text_field_profile_widget.dart';

class PIPetBody extends StatelessWidget {
  const PIPetBody({Key? key}) : super(key: key);

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
                text: 'Pet name:',
              ),
              SizedBox(
                height: 0.5.h,
              ),
              TextFieldProfileWidget(
                controller: profileCreationProvider.petNameController,
                hintText: 'Pet name',
              ),
              SizedBox(
                height: 3.6.h,
              ),
              const RequiredText(
                text: 'Breed:',
              ),
              SizedBox(
                height: 0.5.h,
              ),
              TextFieldProfileWidget(
                controller: profileCreationProvider.petBreedController,
                hintText: 'Breed',
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
              TextFieldProfileWidget(
                controller: profileCreationProvider.petBirthDateController,
                hintText: 'dd.mm.yyyy',
                keyboardType: TextInputType.number,
                inputFormatters: [
                  MaskedInputFormatter('##.##.####'),
                ],
              ),
              SizedBox(
                height: 3.6.h,
              ),
              const RequiredText(
                text: 'Death date',
              ),
              SizedBox(
                height: 0.5.h,
              ),
              TextFieldProfileWidget(
                controller: profileCreationProvider.petDeathDateController,
                hintText: 'dd.mm.yyyy',
                keyboardType: TextInputType.number,
                inputFormatters: [
                  MaskedInputFormatter('##.##.####'),
                ],
              ),
              SizedBox(
                height: 3.6.h,
              ),
              const RequiredText(
                text: 'Death cause:',
              ),
              SizedBox(
                height: 0.5.h,
              ),
              TextFieldProfileWidget(
                controller: profileCreationProvider.petDeathCauseController,
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
                controller: profileCreationProvider.petBirthPlaceController,
                hintText: 'Birth place',
              ),
              SizedBox(
                height: 3.6.h,
              ),
              // Text(
              //   'Burial place:',
              //   style: ConstantsTextStyles.unRequiredTextStyle,
              // ),
              // SizedBox(
              //   height: 0.5.h,
              // ),
              // TextFieldProfileWidget(
              //   controller: profileCreationProvider.petBurialPlaceController,
              //   hintText: 'Burial place',
              // ),
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
                text: 'Pet owner',
              ),
              SizedBox(
                height: 0.5.h,
              ),
              ChooserWidget(
                humansList: profileCreationProvider.husbandWifeList,
                list: null,
                tag: 'owner',
                text: profileCreationProvider.petOwner,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
