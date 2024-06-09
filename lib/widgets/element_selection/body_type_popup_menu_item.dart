import 'package:flutter/material.dart';
import '../../helpers/constants.dart';
import 'package:sizer/sizer.dart';

class BoardTypePopupMenuItem extends PopupMenuEntry {
  const BoardTypePopupMenuItem({
    super.key,
    required this.onTap,
    required this.title,
    required this.image,
    required this.weight,
    this.style,
  });

  final void Function()? onTap;

  final String title;

  final Widget image;

  final double weight;

  final TextStyle? style;

  @override
  double get height => 5.6.h;

  @override
  State<StatefulWidget> createState() {
    return _BoardTypePopupMenuItemState();
  }

  @override
  bool represents(value) {
    throw UnimplementedError();
  }
}

class _BoardTypePopupMenuItemState
    extends State<BoardTypePopupMenuItem> {

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: widget.onTap,
        child: SizedBox(
          height: widget.height,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 3.8.w,
              ),
              widget.image,
              SizedBox(
                width: widget.weight,
              ),
              Text(
                widget.title,
                style: widget.style ?? TextStyle(
                  color: const Color.fromRGBO(51, 51, 51, 1),
                  fontFamily: ConstantsFonts.latoBold,
                  fontSize: 10.5.sp,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}