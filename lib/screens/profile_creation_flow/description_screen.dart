import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:memorial_book/widgets/creation_body_widget.dart';
import 'package:memorial_book/widgets/creation_flow/required_text.dart';
import 'package:memorial_book/widgets/main_button.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../../helpers/constants.dart';
import '../../helpers/enums.dart';
import '../../provider/profile_creation_provider.dart';
import '../../widgets/chooser_widget.dart';
import '../../widgets/platform_scroll_physics.dart';
import '../../widgets/skeleton_loader_widget.dart';

class DescriptionScreen extends StatefulWidget {
  const DescriptionScreen({
    Key? key,
    required this.checkFlow,
  }) : super(key: key);

  final CheckFlow checkFlow;

  @override
  State<DescriptionScreen> createState() => _DescriptionScreenState();
}

class _DescriptionScreenState extends State<DescriptionScreen> {

  @override
  Widget build(BuildContext context) {
    final profileCreationProvider = Provider.of<ProfileCreationProvider>(context);
    return Form(
      onChanged: () {
        setState(() {});
      },
      child: ListView(
        padding: EdgeInsets.zero,
        physics: platformScrollPhysics(),
        children: [
          SizedBox(
            height: 12.h,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
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
                    height: 0.9.sp,
                  ),
                ),
                SizedBox(
                  height: 4.h,
                ),
                CreationBodyWidget(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Фотографии:',
                        style: ConstantsTextStyles.unRequiredTextStyle,
                      ),
                      SizedBox(
                        height: 1.2.h,
                      ),
                      widget.checkFlow != CheckFlow.editCommunity ?
                      Container(
                        padding: EdgeInsets.only(
                          left: 1.2.h,
                          right: 0.8.h,
                          top: 0.8.h,
                          bottom: 1.2.h,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: const Color.fromRGBO(205, 209, 214, 1),
                          ),
                          color: const Color.fromRGBO(245, 247, 249, 1),
                        ),
                        child: GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4,
                            mainAxisSpacing: 0.7.h,
                            crossAxisSpacing: 0.7.h,
                          ),
                          itemBuilder: (context, index) {
                            return (index != profileCreationProvider.validatePicturesAndMoves(widget.checkFlow).length) ?
                            Stack(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                    top: 0.4.h,
                                    right: 0.4.h,
                                  ),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: FileImage(profileCreationProvider.validatePicturesAndMoves(widget.checkFlow)[index]),
                                        fit: BoxFit.cover,
                                      ),
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.topRight,
                                  child: Container(
                                    decoration: const BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                          offset: Offset(5, 5),
                                          color: Color.fromRGBO(0, 0, 0, 0.1),
                                          spreadRadius: 0,
                                          blurRadius: 25,
                                        ),
                                      ],
                                      shape: BoxShape.circle,
                                      color: Color.fromRGBO(255, 255, 255, 1),
                                    ),
                                    child: Material(
                                      color: Colors.transparent,
                                      child: InkWell(
                                        onTap: () {
                                          profileCreationProvider.removeImage(index, widget.checkFlow);
                                        },
                                        borderRadius: BorderRadius.circular(1000),
                                        child: Padding(
                                          padding: EdgeInsets.all(0.36.h),
                                          child: Icon(
                                            Icons.close,
                                            size: 16.sp,
                                            color: const Color.fromRGBO(32, 30, 31, 1),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ) :
                            Container(
                              width: 9.h,
                              height: 9.h,
                              decoration: BoxDecoration(
                                color: const Color.fromRGBO(255, 255, 255, 1),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(8),
                                  onTap: () {
                                    profileCreationProvider.getImages(context, widget.checkFlow);
                                  },
                                  child: Center(
                                    child: Icon(
                                      Icons.add,
                                      size: 24.sp,
                                      color: const Color.fromRGBO(229, 232, 235, 1),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                          itemCount: profileCreationProvider.validatePicturesAndMoves(widget.checkFlow).length + 1,
                        ),
                      ) :
                      Container(
                        padding: EdgeInsets.only(
                          left: 1.2.h,
                          right: 0.8.h,
                          top: 0.8.h,
                          bottom: 1.2.h,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: const Color.fromRGBO(205, 209, 214, 1),
                          ),
                          color: const Color.fromRGBO(245, 247, 249, 1),
                        ),
                        child: GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4,
                            mainAxisSpacing: 0.7.h,
                            crossAxisSpacing: 0.7.h,
                          ),
                          itemBuilder: (context, index) {
                            if(index != profileCreationProvider.editCommunitiesImagesAndMoves.length) {
                              if(profileCreationProvider.editCommunitiesImagesAndMoves[index].runtimeType.toString() == 'String') {
                                ///url
                                return Stack(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                        top: 0.4.h,
                                        right: 0.4.h,
                                      ),
                                      child: CachedNetworkImage(
                                        imageUrl: profileCreationProvider.editCommunitiesImagesAndMoves[index],
                                        imageBuilder: (context, image) {
                                          return Container(
                                            decoration: BoxDecoration(
                                              image: DecorationImage(
                                                image: image,
                                                fit: BoxFit.cover,
                                              ),
                                              borderRadius: BorderRadius.circular(5),
                                            ),
                                          );
                                        },
                                        placeholder: (context, loading) {
                                          return const SkeletonLoaderWidget(
                                            height: double.infinity,
                                            width: double.infinity,
                                            borderRadius: 5,
                                          );
                                        },
                                        errorWidget: (context, error, _) {
                                          return Container(
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(5),
                                            ),
                                            child: Icon(
                                              Icons.close,
                                              size: 7.sp,
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.topRight,
                                      child: Container(
                                        decoration: const BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                              offset: Offset(5, 5),
                                              color: Color.fromRGBO(0, 0, 0, 0.1),
                                              spreadRadius: 0,
                                              blurRadius: 25,
                                            ),
                                          ],
                                          shape: BoxShape.circle,
                                          color: Color.fromRGBO(255, 255, 255, 1),
                                        ),
                                        child: Material(
                                          color: Colors.transparent,
                                          child: InkWell(
                                            onTap: () {
                                              profileCreationProvider.removeUrlFromEditCommunity(
                                                index,
                                                profileCreationProvider.editCommunitiesImagesAndMoves[index]['id'],
                                              );
                                            },
                                            borderRadius: BorderRadius.circular(1000),
                                            child: Padding(
                                              padding: EdgeInsets.all(0.36.h),
                                              child: Icon(
                                                Icons.close,
                                                size: 16.sp,
                                                color: const Color.fromRGBO(32, 30, 31, 1),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              } else {
                                return Stack(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                        top: 0.4.h,
                                        right: 0.4.h,
                                      ),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: FileImage(profileCreationProvider.editCommunitiesImagesAndMoves[index]),
                                            fit: BoxFit.cover,
                                          ),
                                          borderRadius: BorderRadius.circular(5),
                                        ),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.topRight,
                                      child: Container(
                                        decoration: const BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                              offset: Offset(5, 5),
                                              color: Color.fromRGBO(0, 0, 0, 0.1),
                                              spreadRadius: 0,
                                              blurRadius: 25,
                                            ),
                                          ],
                                          shape: BoxShape.circle,
                                          color: Color.fromRGBO(255, 255, 255, 1),
                                        ),
                                        child: Material(
                                          color: Colors.transparent,
                                          child: InkWell(
                                            onTap: () {
                                              profileCreationProvider.removeImageFromEditCommunity(index);
                                            },
                                            borderRadius: BorderRadius.circular(1000),
                                            child: Padding(
                                              padding: EdgeInsets.all(0.36.h),
                                              child: Icon(
                                                Icons.close,
                                                size: 16.sp,
                                                color: const Color.fromRGBO(32, 30, 31, 1),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              }
                            } else {
                              return Container(
                                width: 9.h,
                                height: 9.h,
                                decoration: BoxDecoration(
                                  color: const Color.fromRGBO(255, 255, 255, 1),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    borderRadius: BorderRadius.circular(8),
                                    onTap: () {
                                      profileCreationProvider.getImagesInEditCommunity(context);
                                    },
                                    child: Center(
                                      child: Icon(
                                        Icons.add,
                                        size: 24.sp,
                                        color: const Color.fromRGBO(229, 232, 235, 1),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }
                          },
                          itemCount: profileCreationProvider.editCommunitiesImagesAndMoves.length + 1,
                        ),
                      ),
                      SizedBox(
                        height: 2.4.h,
                      ),
                      widget.checkFlow == CheckFlow.editCommunity ?
                      Text(
                        'Описание:',
                        style: ConstantsTextStyles.unRequiredTextStyle,
                      ) :
                      const RequiredText(
                        text: 'Описание:',
                      ),
                      SizedBox(
                        height: 1.2.h,
                      ),
                      TextFormField(
                        controller: profileCreationProvider.validateDescriptionController(widget.checkFlow),
                        enableSuggestions: false,
                        autocorrect: false,
                        maxLines: 14,
                        minLines: 7,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(1000),
                        ],
                        decoration: InputDecoration(
                          hintStyle: TextStyle(
                            color: const Color.fromRGBO(32, 30, 31, 0.5),
                            fontSize: 13.sp,
                            fontFamily: ConstantsFonts.latoRegular,
                          ),
                          isDense: true,
                          filled: true,
                          hintText: 'Какое-то описание...',
                          fillColor: const Color.fromRGBO(245, 247, 249, 1),
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(7.0),
                            ),
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black,
                            ),
                            borderRadius: BorderRadius.all(
                              Radius.circular(8.0),
                            ),
                          ),
                          enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color.fromRGBO(205, 209, 214, 1),
                            ),
                            borderRadius: BorderRadius.all(
                              Radius.circular(8.0),
                            ),
                          ),
                          contentPadding: EdgeInsets.only(
                            bottom: 10,
                            top: 10,
                            left: 1.6.h,
                          ),
                        ),
                      ),
                      widget.checkFlow == CheckFlow.profile ?
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 2.4.h,
                          ),
                          Text(
                            'Хобби:',
                            style: ConstantsTextStyles.unRequiredTextStyle,
                          ),
                          SizedBox(
                            height: 1.2.h,
                          ),
                          ChooserWidget(
                            hobbiesList: profileCreationProvider.hobbiesList,
                            tag: 'hobbies',
                            text: '',
                          ),
                          SizedBox(
                            height: 1.2.h,
                          ),
                          profileCreationProvider.selectedHobbiesList.isNotEmpty ?
                          Wrap(
                            children: profileCreationProvider.selectedHobbiesList.map(
                              ((String index) => Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    index,
                                    style: TextStyle(
                                      fontSize: 11.sp,
                                      fontFamily: ConstantsFonts.latoRegular,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 1.5.w,
                                  ),
                                  GestureDetector(
                                    behavior: HitTestBehavior.translucent,
                                    onTap: () {
                                      profileCreationProvider.removeFromHobbies(index);
                                    },
                                    child: Icon(
                                      Icons.close,
                                      color: Colors.black,
                                      size: 13.sp,
                                    ),
                                  ),
                                ],
                              )),
                            ).map(
                              ((widget) => Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 1.6.w,
                                  vertical: 6,
                                ),
                                margin: EdgeInsets.only(
                                  right: 1.2.h,
                                  bottom: 1.2.h,
                                ),
                                decoration: const BoxDecoration(
                                  color: Color.fromRGBO(23, 94, 217, 0.1),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(5),
                                  ),
                                ),
                                child: widget,
                              )),
                            ).toList(),
                          ) :
                          const SizedBox(),
                          profileCreationProvider.religionsList.isNotEmpty ?
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 2.4.h,
                              ),
                              Text(
                                'Религиозные взгляды:',
                                style: ConstantsTextStyles.unRequiredTextStyle,
                              ),
                              SizedBox(
                                height: 1.2.h,
                              ),
                              ChooserWidget(
                                religionsList: profileCreationProvider.religionsList,
                                tag: 'religion',
                                text: profileCreationProvider.religion,
                              ),
                            ],
                          ) :
                          const SizedBox(),
                        ],
                      ) :
                      const SizedBox(),
                    ],
                  ),
                ),
                SizedBox(
                  height: 1.2.h,
                ),
                MainButton(
                  margin: EdgeInsets.symmetric(
                    vertical: 2.2.h,
                    horizontal: 15.w,
                  ),
                  text: 'ПРОДОЛЖИТЬ',
                  textStyle: TextStyle(
                    fontSize: 9.5.sp,
                    color: const Color.fromRGBO(255, 255, 255, 1),
                    fontFamily: ConstantsFonts.latoBold,
                  ),
                  onTap: (() {
                    profileCreationProvider.pageController.nextPage(
                      duration: const Duration(
                        milliseconds: 500,
                      ),
                      curve: Curves.ease,
                    );
                  }),
                  condition: profileCreationProvider.descriptionCheck(widget.checkFlow),
                ),
                SizedBox(
                  height: 1.2.h,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
