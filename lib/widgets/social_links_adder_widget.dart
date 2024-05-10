import 'package:flutter/material.dart';
import 'package:memorial_book/helpers/constants.dart';
import 'package:memorial_book/widgets/animation/punching_animation.dart';
import 'package:memorial_book/widgets/text_button_widget.dart';
import 'package:memorial_book/widgets/text_field_profile_widget.dart';
import 'package:sizer/sizer.dart';

class SocialLinksAdderWidget extends StatefulWidget {
  const SocialLinksAdderWidget({
    super.key,
    required this.dataList,
  });

  final List<TextEditingController> dataList;

  @override
  State<SocialLinksAdderWidget> createState() => _SocialLinksAdderWidgetState();
}

class _SocialLinksAdderWidgetState extends State<SocialLinksAdderWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.only(
                top: 3.6.h,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Social link',
                    style: TextStyle(
                      fontSize: 10.sp,
                      fontFamily: ConstantsFonts.latoRegular,
                      color: const Color.fromRGBO(32, 30, 31, 0.5),
                    ),
                  ),
                  SizedBox(
                    height: 0.5.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: TextFieldProfileWidget(
                          controller: widget.dataList[index],
                          hintText: 'link',
                          minLines: 1,
                          maxLines: 1,
                        ),
                      ),
                      SizedBox(
                        width: 3.2.w,
                      ),
                      PunchingAnimation(
                        child: GestureDetector(
                          onTap: () => setState(() => widget.dataList.removeAt(index)),
                          child: Icon(
                            Icons.remove_circle,
                            size: 20.sp,
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
          itemCount: widget.dataList.length,
        ),
        SizedBox(
          height: 0.5.h,
        ),
        TextButtonWidget(
          text: '+  Add social link',
          textStyle: TextStyle(
            fontFamily: ConstantsFonts.latoSemiBold,
            fontSize: 11.5.sp,
            color: const Color.fromRGBO(23, 94, 217, 1),
          ),
          onTap: () => setState(() => widget.dataList.add(TextEditingController())),
        ),
      ],
    );
  }
}
