import 'package:flutter/material.dart';
import 'package:memorial_book/helpers/constants.dart';
import 'package:memorial_book/widgets/animation/punching_animation.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher_string.dart';

class LinkWidget extends StatelessWidget {
  LinkWidget({
    super.key,
    required this.link,
  });

  final String link;

  final String thirstPattern = 'instagram';
  final String secondPattern = 'facebook';
  final String thirdPattern = 'twitter';
  final String fourthPattern = 'reddit';
  final String fifthPattern = 'snapchat';

  late RegExp thirstRegExp = RegExp(thirstPattern);
  late RegExp secondRegExp = RegExp(secondPattern);
  late RegExp thirdPRegExp = RegExp(thirdPattern);
  late RegExp fourthPRegExp = RegExp(fourthPattern);
  late RegExp fifthRegExp = RegExp(fifthPattern);

  String icon() {
    if(thirstRegExp.hasMatch(link)) {
      return ConstantsAssets.instagramImage;
    } else if(secondRegExp.hasMatch(link)) {
      return ConstantsAssets.facebookImage;
    } else if(thirdPRegExp.hasMatch(link)) {
      return ConstantsAssets.twitterImage;
    } else if(fourthPRegExp.hasMatch(link)) {
      return ConstantsAssets.redditImage;
    }  else if(fifthRegExp.hasMatch(link)) {
      return ConstantsAssets.snapchatImage;
    } else {
      return ConstantsAssets.websiteInternetImage;
    }
  }

  String text() {
    if(thirstRegExp.hasMatch(link)) {
      return 'Instagram';
    } else if(secondRegExp.hasMatch(link)) {
      return 'Facebook';
    } else if(thirdPRegExp.hasMatch(link)) {
      return 'Twitter';
    } else if(fourthPRegExp.hasMatch(link)) {
      return 'Reddit';
    }  else if(fifthRegExp.hasMatch(link)) {
      return 'Snapchat';
    } else {
      return link;
    }
  }

  @override
  Widget build(BuildContext context) {
    return PunchingAnimation(
      child: GestureDetector(
        onTap: () => launchUrlString(link),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              icon(),
              height: 2.4.h,
              color: const Color.fromRGBO(32, 30, 31, 1),
            ),
            SizedBox(
              width: 2.4.w,
            ),
            Expanded(
              child: Text(
                text(),
                style: TextStyle(
                  fontFamily: ConstantsFonts.latoSemiBold,
                  fontSize: 12.5.sp,
                  color: const Color.fromRGBO(32, 30, 31, 1),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
