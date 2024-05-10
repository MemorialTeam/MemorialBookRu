import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:sizer/sizer.dart';
import '../helpers/constants.dart';

class ShareWidget extends StatelessWidget {
  const ShareWidget({
    Key? key,
    required this.shareText,
  }) : super(key: key);

  final String shareText;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color.fromRGBO(0, 0, 0, 0.05),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () async {
            await Share.share(shareText);
          },
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 3.8.w,
              vertical: 1.h,
            ),
            child: Image.asset(
              ConstantsAssets.shareImage,
              height: 1.8.h,
              width: 2.h,
              color: const Color.fromRGBO(0, 0, 0, 0.4),
            ),
          ),
        ),
      ),
    );
  }
}
