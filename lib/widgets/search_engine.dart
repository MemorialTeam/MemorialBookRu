import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:memorial_book/widgets/text_field_search_widget.dart';
import 'package:sizer/sizer.dart';
import '../helpers/constants.dart';

class SearchEngine extends StatefulWidget {
  const SearchEngine({
    super.key,
    required this.focusNode,
    required this.controller,
    this.isSearching,
    this.autofocus,
    this.activeColor,
    this.inactiveColor,
    this.backgroundColor,
    this.enabledBorder,
    this.focusedBorder,
    this.textStyle,
    this.title,
    this.isEmptyFunc,
    required this.isNotEmptyFunc,
    this.suffixIcon,
  });

  final FocusNode focusNode;

  final TextEditingController controller;

  final bool? isSearching;
  final bool? autofocus;

  final Color? activeColor;
  final Color? inactiveColor;
  final Color? backgroundColor;

  final InputBorder? enabledBorder;
  final InputBorder? focusedBorder;

  final TextStyle? textStyle;

  final String? title;

  final Widget? suffixIcon;

  final void Function()? isEmptyFunc;
  final void Function(String) isNotEmptyFunc;

  @override
  State<SearchEngine> createState() => _SearchEngineState();
}

class _SearchEngineState extends State<SearchEngine> {
  Widget loading() {
    if(widget.isSearching == true) {
      return SizedBox(
        height: 1.6.h,
        width: 1.6.h,
        child: LoadingIndicator(
          indicatorType: Indicator.ballSpinFadeLoader,
          colors: [
            widget.activeColor ?? const Color.fromRGBO(23, 94, 217, 1),
          ],
        ),
      );
    } else {
      return Image.asset(
        ConstantsAssets.searchImage,
        height: 1.6.h,
        width: 1.6.h,
        color: widget.controller.text.isNotEmpty ?
        widget.activeColor ?? const Color.fromRGBO(23, 94, 217, 1) :
        widget.inactiveColor ?? const Color.fromRGBO(79, 79, 79, 1),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextFieldSearchWidget(
      autofocus: widget.autofocus ?? false,
      focusNode: widget.focusNode,
      controller: widget.controller,
      hintText: widget.title ?? 'Поиск',
      enabledBorder: widget.enabledBorder,
      textStyle: widget.textStyle,
      focusedBorder: widget.focusedBorder,
      backgroundColor: widget.backgroundColor,
      onChanged: (text) {
        if(text.isEmpty) {
          if(widget.isEmptyFunc != null) {
            widget.isEmptyFunc!();
          }
        } else if(text.length % 3 == 0) {
          widget.isNotEmptyFunc(text);
        }
        setState(() {});
      },
      prefixIcon: Container(
        margin: EdgeInsets.symmetric(
          vertical: 1.2.h,
          horizontal: 3.2.w,
        ),
        child: loading(),
      ),
      suffixIcon: widget.suffixIcon,
    );
  }
}
