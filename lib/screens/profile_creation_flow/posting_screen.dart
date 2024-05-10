import 'package:flutter/material.dart';
import 'package:memorial_book/helpers/common_data.dart';
import 'package:memorial_book/provider/catalog_provider.dart';
import 'package:memorial_book/provider/message_dialogs_provider.dart';
import 'package:memorial_book/widgets/creation_body_widget.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../../helpers/constants.dart';
import '../../provider/profile_creation_provider.dart';

class PostingScreen extends StatefulWidget {
  const PostingScreen({
    Key? key,
    required this.checkFlow,
  }) : super(key: key);

  final CheckFlow checkFlow;

  @override
  State<PostingScreen> createState() => _PostingScreenState();
}

class _PostingScreenState extends State<PostingScreen> {

  List generateAccesses() {
    switch(widget.checkFlow) {
      case CheckFlow.profile:
        return CommonData.listOfThreeAccesses;
      case CheckFlow.community:
        return CommonData.listOfTwoAccesses;
      case CheckFlow.cemetery:
        return CommonData.listOfTwoAccesses;
      case CheckFlow.pet:
        return CommonData.listOfThreeAccesses;
      case CheckFlow.editCommunity:
        return CommonData.listOfTwoAccesses;
    }
  }

  @override
  Widget build(BuildContext context) {
    final profileCreationProvider = Provider.of<ProfileCreationProvider>(context);
    final catalogProvider = Provider.of<CatalogProvider>(context);
    final messageDialogsProvider = Provider.of<MessageDialogsProvider>(context);
    print(profileCreationProvider.titleCard(widget.checkFlow).length);
    return SingleChildScrollView(
      padding: EdgeInsets.zero,
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          SizedBox(
            height: 12.h,
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 3.6.w,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  profileCreationProvider.generateTitle(widget.checkFlow),
                  style: TextStyle(
                    color: const Color.fromRGBO(32, 30, 31, 1),
                    fontFamily: ConstantsFonts.latoBlack,
                    fontSize: 21.sp,
                  ),
                ),
                SizedBox(
                  height: 4.h,
                ),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: profileCreationProvider.titleCard(widget.checkFlow).isNotEmpty ?
                    const Color.fromRGBO(255, 255, 255, 1) :
                    const Color.fromRGBO(245, 247, 249, 1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Stack(
                    children: [
                      Container(
                        width: double.infinity,
                        height: 18.8.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: const Color.fromRGBO(217, 217, 217, 1),
                          image: profileCreationProvider.generateBackgroundImage(widget.checkFlow) == null ?
                          null :
                          DecorationImage(
                            image: FileImage(
                              profileCreationProvider.generateBackgroundImage(widget.checkFlow)!,
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: profileCreationProvider.generateBackgroundImage(widget.checkFlow) == null ?
                        Center(
                          child: Icon(
                            Icons.camera_alt_rounded,
                            size: 53.sp,
                            color: const Color.fromRGBO(186, 186, 186, 1),
                          ),
                        ) :
                        null,
                      ),
                      Positioned(
                        top: 8.h,
                        child: Container(
                          height: 12.5.h,
                          width: 12.5.h,
                          margin: EdgeInsets.only(
                            left: 6.w,
                          ),
                          padding: const EdgeInsets.all(4),
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color.fromRGBO(245, 247, 249, 1),
                          ),
                          child: profileCreationProvider.generateAvatarImage(widget.checkFlow) != null ?
                          Container(
                            height: double.infinity,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: FileImage(profileCreationProvider.generateAvatarImage(widget.checkFlow)!),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ) :
                          Center(
                            child: Container(
                              width: double.infinity,
                              height: double.infinity,
                              decoration: BoxDecoration(
                                color: const Color.fromRGBO(217, 217, 217, 1),
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: Icon(
                                Icons.camera_alt_rounded,
                                size: 40.sp,
                                color: const Color.fromRGBO(186, 186, 186, 1),
                              ),
                            ),
                          ),
                        ),
                      ),
                      profileCreationProvider.titleCard(widget.checkFlow).isNotEmpty ?
                      Padding(
                        padding: EdgeInsets.only(
                          top: 22.h,
                          right: 1.8.h,
                          left: 1.8.h,
                          bottom: 2.2.h,
                        ),
                        child: Text(
                          profileCreationProvider.titleCard(widget.checkFlow),
                          style: TextStyle(
                            fontSize: 19.5.sp,
                            fontFamily: ConstantsFonts.latoBlack,
                            color: const Color.fromRGBO(32, 30, 31, 1),
                          ),
                        ),
                      ) :
                      Padding(
                        padding: EdgeInsets.only(
                          top: 10.h,
                          right: 1.8.h,
                          left: 1.8.h,
                          bottom: 10.h,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 1.4.h,
                ),
                CreationBodyWidget(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Public access settings',
                        style: TextStyle(
                          color: const Color.fromRGBO(32, 30, 31, 0.5),
                          fontFamily: ConstantsFonts.latoRegular,
                          fontSize: 9.5.sp,
                        ),
                      ),
                      SizedBox(
                        height: 2.8.h,
                      ),
                      ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          final dataList = generateAccesses()[index];
                          return GestureDetector(
                            behavior: HitTestBehavior.translucent,
                            onTap: () => profileCreationProvider.selectAccess(dataList['title'], index),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  height: 3.h,
                                  width: 3.h,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: const Color.fromRGBO(255, 255, 255, 1),
                                    border: Border.all(
                                      color: const Color.fromRGBO(23, 94, 217, 1),
                                      width: 2,
                                    ),
                                  ),
                                  child: profileCreationProvider.selectedItem == index ?
                                  Padding(
                                    padding: EdgeInsets.all(0.35.h),
                                    child: Container(
                                      height: double.infinity,
                                      width: double.infinity,
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Color.fromRGBO(23, 94, 217, 1),
                                      ),
                                    ),
                                  ) :
                                  null,
                                ),
                                SizedBox(
                                  width: 2.6.w,
                                ),
                                SizedBox(
                                  width: 71.w,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        dataList['title'],
                                        style: TextStyle(
                                          color: const Color.fromRGBO(32, 30, 31, 1),
                                          fontSize: 10.5.sp,
                                          fontFamily: ConstantsFonts.latoBold,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 0.3.h,
                                      ),
                                      Text(
                                        dataList['subtitle'],
                                        style: TextStyle(
                                          color: const Color.fromRGBO(32, 30, 31, 0.5),
                                          fontSize: 8.5.sp,
                                          fontFamily: ConstantsFonts.latoRegular,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return SizedBox(
                            height: 2.8.h,
                          );
                        },
                        itemCount: generateAccesses().length,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 1.2.h,
                ),
                widget.checkFlow != CheckFlow.editCommunity ?
                Column(
                  children: [
                    Container(
                      height: 6.h,
                      margin: EdgeInsets.symmetric(
                        horizontal: 20.w,
                      ),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(7),
                        color: const Color.fromRGBO(245, 247, 249, 1),
                        border: Border.all(
                          color: const Color.fromRGBO(23, 94, 217, 1),
                        ),
                      ),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(7),
                          onTap: () {
                            profileCreationProvider.generateRequest(
                              context,
                              widget.checkFlow,
                              1,
                            );
                          },
                          child: Center(
                            child: Text(
                              'SAVE AS DRAFT',
                              style: TextStyle(
                                color: const Color.fromRGBO(23, 94, 217, 1),
                                fontWeight: FontWeight.w500,
                                fontSize: 10.5.sp,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 1.2.h,
                    ),
                    Container(
                      height: 6.h,
                      margin: EdgeInsets.symmetric(
                        horizontal: 20.w,
                      ),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(7),
                        color: const Color.fromRGBO(23, 94, 217, 1),
                      ),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(7),
                          onTap: () {
                            profileCreationProvider.generateRequest(
                              context,
                              widget.checkFlow,
                              0,
                            );
                          },
                          child: Center(
                            child: Text(
                              'SAVE AND POSTING',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                fontSize: 10.5.sp,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ) :
                Container(
                  height: 6.h,
                  margin: EdgeInsets.symmetric(
                    horizontal: 20.w,
                  ),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(7),
                    color: const Color.fromRGBO(23, 94, 217, 1),
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(7),
                      onTap: () {
                        profileCreationProvider.editCommunity(
                          context,
                          ((model) async {
                            if(model != null) {
                              if(model.status == true) {
                                await catalogProvider.updateCommunityProfile(profileCreationProvider.communityEditModel.id);
                                await Navigator.maybePop(context).whenComplete(
                                  (() async => await messageDialogsProvider.informationWindow(
                                    context: context,
                                    title: model.message ?? 'The community data has been successfully updated',
                                    textButton: 'OK',
                                  )),
                                );
                              } else {
                                await messageDialogsProvider.informationWindow(
                                  context: context,
                                  title: model.message ?? 'The community data has been successfully updated',
                                  textButton: 'OK',
                                );
                              }
                            } else {
                              await messageDialogsProvider.informationWindow(
                                context: context,
                                title: 'Something went wrong...',
                                textButton: 'OK',
                              );
                            }
                          }),
                        );
                      },
                      child: Center(
                        child: Text(
                          'SAVE',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 10.5.sp,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 1.6.h,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
