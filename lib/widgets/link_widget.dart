import 'package:flutter/material.dart';
import 'package:memorial_book/helpers/constants.dart';
import 'package:memorial_book/models/common/link_model.dart';
import 'package:memorial_book/widgets/animation/punching_animation.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher_string.dart';

class LinkWidget extends StatelessWidget {
  LinkWidget({
    super.key,
    required this.link,
  });

  final String link;

  List<LinkModel> modelsList = [
    LinkModel(
      pattern: 'memorialbook',
      image: ConstantsAssets.memorialBookIconImage,
      name: 'MemorialBook',
    ),
    LinkModel(
      pattern: 'instagram',
      image: ConstantsAssets.instagramImage,
      name: 'Instagram',
    ),
    LinkModel(
      pattern: 'facebook',
      image: ConstantsAssets.facebookImage,
      name: 'Facebook',
    ),
    LinkModel(
      pattern: 'twitter',
      image: ConstantsAssets.twitterImage,
      name: 'Twitter',
    ),
    LinkModel(
      pattern: 'reddit',
      image: ConstantsAssets.redditImage,
      name: 'Reddit',
    ),
    LinkModel(
      pattern: 'snapchat',
      image: ConstantsAssets.snapchatImage,
      name: 'Snapchat',
    ),
    LinkModel(
      pattern: 'pinterest',
      image: ConstantsAssets.pinterestImage,
      name: 'Pinterest',
    ),
    LinkModel(
      pattern: 'tiktok',
      image: ConstantsAssets.tikTokImage,
      name: 'TikTok',
    ),
    LinkModel(
      pattern: 'linkedin',
      image: ConstantsAssets.linkedInImage,
      name: 'LinkedIn',
    ),
    LinkModel(
      pattern: 'youtube',
      image: ConstantsAssets.youtubeImage,
      name: 'YouTube',
    ),
    LinkModel(
      pattern: 'vk',
      image: ConstantsAssets.vkImage,
      name: 'Вконтакте',
    ),
    LinkModel(
      pattern: 'threads',
      image: ConstantsAssets.threadsImage,
      name: 'Threads',
    ),
  ];

  final String thirstPattern = 'instagram';
  final String secondPattern = 'facebook';
  final String thirdPattern = 'twitter';
  final String fourthPattern = 'reddit';
  final String fifthPattern = 'snapchat';
  final String sixthPattern = 'pinterest';
  final String seventhPattern = 'tiktok';
  final String eighthPattern = 'tiktok';

  late RegExp thirstRegExp = RegExp(thirstPattern);
  late RegExp secondRegExp = RegExp(secondPattern);
  late RegExp thirdPRegExp = RegExp(thirdPattern);
  late RegExp fourthPRegExp = RegExp(fourthPattern);
  late RegExp fifthRegExp = RegExp(fifthPattern);
  late RegExp sixthRegExp = RegExp(sixthPattern);
  late RegExp seventhRegExp = RegExp(seventhPattern);
  late RegExp eighthRegExp = RegExp(eighthPattern);

  // String icon() {
  //   if(thirstRegExp.hasMatch(link)) {
  //     return ConstantsAssets.instagramImage;
  //   } else if(secondRegExp.hasMatch(link)) {
  //     return ConstantsAssets.facebookImage;
  //   } else if(thirdPRegExp.hasMatch(link)) {
  //     return ConstantsAssets.twitterImage;
  //   } else if(fourthPRegExp.hasMatch(link)) {
  //     return ConstantsAssets.redditImage;
  //   } else if(fifthRegExp.hasMatch(link)) {
  //     return ConstantsAssets.snapchatImage;
  //   } else if(sixthRegExp.hasMatch(link)) {
  //     return ConstantsAssets.pinterestImage;
  //   } else if(seventhRegExp.hasMatch(link)) {
  //     return ConstantsAssets.tikTokImage;
  //   } else {
  //     return ConstantsAssets.websiteInternetImage;
  //   }
  // }

  String icon() {
    late RegExp regExp;
    late String icon;
    for(LinkModel model in modelsList) {
      regExp = RegExp(model.pattern);
      if(regExp.hasMatch(link)) {
        icon = model.image;
        break;
      } else {
        icon = ConstantsAssets.websiteInternetImage;
      }
    }
    return icon;
  }

  String text() {
    late RegExp regExp;
    late String text;
    for(LinkModel model in modelsList) {
      regExp = RegExp(model.pattern);
      if(regExp.hasMatch(link)) {
        text = model.name;
        break;
      } else {
        text = link;
      }
    }
    return text;
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
