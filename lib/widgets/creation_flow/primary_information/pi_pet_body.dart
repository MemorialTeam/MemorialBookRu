import 'package:flutter/material.dart';
import 'package:memorial_book/widgets/creation_body_widget.dart';
import 'package:memorial_book/widgets/creation_flow/required_text.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../../../helpers/constants.dart';
import '../../../provider/profile_creation_provider.dart';
import '../../text_field_profile_widget.dart';
import '../date_pick_field.dart';

class PIPetBody extends StatelessWidget {
  const PIPetBody({Key? key}) : super(key: key);

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
                text: 'Имя питомца:',
              ),
              SizedBox(
                height: 0.5.h,
              ),
              TextFieldProfileWidget(
                controller: profileCreationProvider.petNameController,
                hintText: 'Имя питомца',
              ),
              SizedBox(
                height: 3.6.h,
              ),
              const RequiredText(
                text: 'Порода:',
              ),
              SizedBox(
                height: 0.5.h,
              ),
              TextFieldProfileWidget(
                controller: profileCreationProvider.petBreedController,
                hintText: 'Порода',
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
                onTap: () => profileCreationProvider.petBirthDatePicker(context),
                dateTime: profileCreationProvider.petBirthDate,
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
                onTap: () => profileCreationProvider.petDeathDatePicker(context),
                dateTime: profileCreationProvider.petDeathDate,
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
                controller: profileCreationProvider.petDeathCauseController,
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
                controller: profileCreationProvider.petBirthPlaceController,
                hintText: 'Место рождения',
              ),
            ],
          ),
        ),
      ],
    );
  }
}
