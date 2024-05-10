import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:memorial_book/widgets/element_selection/generate_element.dart';
import 'package:sizer/sizer.dart';
import '../../helpers/constants.dart';

class SpinningCylinderWidget extends StatelessWidget {
  const SpinningCylinderWidget({
    Key? key,
    required this.title,
    required this.onSelectedItemChanged,
    required this.scrollController,
    this.titleTextStyle,
    required this.children,
  }) : super(key: key);

  final String title;

  final List children;

  final void Function(int) onSelectedItemChanged;

  final FixedExtentScrollController scrollController;

  final TextStyle? titleTextStyle;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 1.8.h,
        ),
        Text(
          title,
          style: titleTextStyle ?? TextStyle(
            color: const Color.fromRGBO(33, 33, 33, 1),
            fontFamily: ConstantsFonts.latoRegular,
            fontSize: 11.5.sp,
          ),
        ),
        SizedBox(
          height: 22.h,
          child: CupertinoPicker(
            scrollController: scrollController,
            backgroundColor: Theme.of(context).canvasColor,
            onSelectedItemChanged: onSelectedItemChanged,
            diameterRatio: 1.0,
            magnification: 1.1,
            itemExtent: 34.0,
            children: generateElement(
              array: children,
            ),
          ),
        ),
      ],
    );
  }
}
