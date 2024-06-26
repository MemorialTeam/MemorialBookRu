import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:memorial_book/models/create_profile/response/get_religions_response_model.dart';
import 'package:memorial_book/provider/catalog_provider.dart';
import 'package:memorial_book/provider/profile_creation_provider.dart';
import 'package:memorial_book/widgets/platform_scroll_physics.dart';
import 'package:provider/provider.dart';
import '../helpers/constants.dart';
import 'package:sizer/sizer.dart';
import '../helpers/enums.dart';
import '../models/create_profile/response/get_hobbies_response_model.dart';
import '../models/people/response/related_profiles_response_model.dart';

class ChooserWidget extends StatefulWidget {
  ChooserWidget({
    Key? key,
    this.list,
    this.humansList,
    this.religionsList,
    this.hobbiesList,
    required this.tag,
    this.text = '',
    this.condition = LoadingState.active,
    this.loadingColor = const Color.fromRGBO(23, 94, 217, 1),
    this.errorText = 'Список пуст',
  }) : super(key: key);

  final List? list;
  final List<HumansResponseModel>? humansList;
  final List<ReligionResponseModel>? religionsList;
  final List<HobbiesResponseModel>? hobbiesList;
  final String tag;
  late String text;
  final LoadingState condition;
  final Color loadingColor;
  final String errorText;

  @override
  State<ChooserWidget> createState() => _ChooserWidgetState();
}

class _ChooserWidgetState extends State<ChooserWidget> with TickerProviderStateMixin {

  late AnimationController _controller;

  late Animation<double> _animation;

  bool animationCheck = true;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(
        milliseconds: 300,
      ),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.fastLinearToSlowEaseIn,
      reverseCurve: Curves.fastEaseInToSlowEaseOut,
    );
  }

  _toggleContainer() {
    setState(() {
      animationCheck = !animationCheck;
      if(animationCheck == false) {
        _controller.forward();
      } else {
        _controller.animateBack(
            0,
            duration: const Duration(
              milliseconds: 300,
            ),
            curve: Curves.fastLinearToSlowEaseIn
        );
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final profileCreationProvider = Provider.of<ProfileCreationProvider>(context);
    final catalogProvider = Provider.of<CatalogProvider>(context);
    switch(widget.condition) {
      case LoadingState.loading:
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: const Color.fromRGBO(245, 247, 249, 1),
            border: Border.all(
              color: const Color.fromRGBO(205, 209, 214, 1),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: 1.2.h,
            ),
            child: Center(
              child: SizedBox(
                height: 2.5.h,
                width: 2.5.h,
                child: LoadingIndicator(
                  indicatorType: Indicator.ballSpinFadeLoader,
                  colors: [
                    widget.loadingColor,
                  ],
                ),
              ),
            ),
          ),
        );
      case LoadingState.active:
        final int length = widget.list?.length ?? widget.humansList?.length ?? widget.religionsList?.length ?? widget.hobbiesList?.length ?? 0;
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: const Color.fromRGBO(245, 247, 249, 1),
            border: Border.all(
              color: const Color.fromRGBO(205, 209, 214, 1),
            ),
          ),
          child: Column(
            children: [
              GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () => _toggleContainer(),
                child: Padding(
                  padding: EdgeInsets.all(1.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.text != '' ?
                        widget.text :
                        'Выберите из списка',
                        style: TextStyle(
                          color: widget.text == '' ?
                          const Color.fromRGBO(32, 30, 31, 0.5) :
                          const Color.fromRGBO(32, 30, 31, 1),
                          fontSize: 13.sp,
                          fontFamily: ConstantsFonts.latoRegular,
                        ),
                      ),
                      widget.text != '' ?
                      Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () {
                            switch(widget.tag) {
                              case 'gender':
                                profileCreationProvider.removeGender();
                                break;
                              case 'father':
                                profileCreationProvider.removeFather();
                                break;
                              case 'husband':
                                profileCreationProvider.removeHusband();
                                break;
                              case 'mother':
                                profileCreationProvider.removeMother();
                                break;
                              case 'owner':
                                profileCreationProvider.removeOwner();
                                break;
                              case 'religion':
                                profileCreationProvider.removeReligion();
                                break;
                              case 'district':
                                catalogProvider.removeDistrict();
                                break;
                            }
                          },
                          borderRadius: BorderRadius.circular(150),
                          child: Icon(
                            Icons.close,
                            color: Colors.black,
                            size: 18.sp,
                          ),
                        ),
                      ) :
                      Padding(
                        padding: EdgeInsets.only(
                          right: 0.7.w,
                        ),
                        child: AnimatedSwitcher(
                          duration: const Duration(
                            milliseconds: 100,
                          ),
                          transitionBuilder: (child, anim) => RotationTransition(
                            turns: child.key == const ValueKey('icon1') ?
                            Tween<double>(begin: 0.5, end: 1).animate(anim) :
                            Tween<double>(begin: 1, end: 0.5).animate(anim),
                            child: FadeTransition(opacity: anim, child: child,),
                          ),
                          child: animationCheck == false ?
                          Image.asset(
                            ConstantsAssets.arrowTopImage,
                            key: const ValueKey('icon1'),
                            width: 4.4.w,
                            height: 1.4.h,
                            color: const Color.fromRGBO(33, 33, 33, 1),
                          ) :
                          Image.asset(
                            ConstantsAssets.arrowTopImage,
                            key: const ValueKey('icon2'),
                            width: 4.4.w,
                            height: 1.4.h,
                            color: const Color.fromRGBO(33, 33, 33, 1),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizeTransition(
                sizeFactor: _animation,
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxHeight: 30.h,
                  ),
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      final list = widget.list?.length ?? widget.humansList?.length ?? widget.religionsList?.length ?? widget.hobbiesList?.length;
                      return Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () {
                            print(widget.list?[index]);
                            _toggleContainer();
                            setState(() {
                              widget.text = widget.list?[index] ?? widget.humansList?[index].fullName ?? widget.religionsList?[index].title ?? widget.hobbiesList?[index].title;
                            });
                            switch(widget.tag) {
                              case 'gender':
                                profileCreationProvider.setGender(widget.list![index]);
                                break;
                              case 'father':
                                profileCreationProvider.setFather(
                                  widget.humansList![index].fullName!,
                                  widget.humansList![index].id!.toString(),
                                );
                                break;
                              case 'husband':
                                profileCreationProvider.setHusband(
                                  widget.humansList![index].fullName!,
                                  widget.humansList![index].id!.toString(),
                                );
                                break;
                              case 'mother':
                                profileCreationProvider.setMother(
                                  widget.humansList![index].fullName!,
                                  widget.humansList![index].id!.toString(),
                                );
                                break;
                              case 'owner':
                                profileCreationProvider.setOwner(
                                  widget.humansList![index].fullName!,
                                  widget.humansList![index].id!.toString(),
                                );
                                break;
                              case 'religion':
                                profileCreationProvider.setReligion(
                                  widget.religionsList?[index].title ?? '',
                                  widget.religionsList?[index].id ?? 0,
                                );
                                break;
                              case 'hobbies':
                                profileCreationProvider.addHobbies(widget.hobbiesList![index]);
                                break;
                              case 'district':
                                catalogProvider.addDistrict(widget.list?[index] ?? '');
                                break;
                            }
                          },
                          borderRadius: list! - 1 == index ?
                          const BorderRadius.only(
                            bottomLeft: Radius.circular(8),
                            bottomRight: Radius.circular(8),
                          ) :
                          null,
                          child: SizedBox(
                            width: double.infinity,
                            height: 6.h,
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: EdgeInsets.only(
                                  left: 1.2.h,
                                ),
                                child: Text(
                                  widget.list?[index] ?? widget.humansList?[index].fullName ?? widget.religionsList?[index].title ?? widget.hobbiesList?[index].title,
                                  style: TextStyle(
                                    color: const Color.fromRGBO(33, 33, 33, 1),
                                    fontSize: 13.sp,
                                    fontFamily: ConstantsFonts.latoRegular,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                    itemCount: length,
                    physics: length > 5?
                    platformScrollPhysics() :
                    const NeverScrollableScrollPhysics(),
                  ),
                ),
              ),
            ],
          ),
        );
      case LoadingState.error:
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: const Color.fromRGBO(245, 247, 249, 0.6),
            border: Border.all(
              color: const Color.fromRGBO(205, 209, 214, 0.6),
            ),
          ),
          child: Column(
            children: [
              GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () => _toggleContainer(),
                child: Padding(
                  padding: EdgeInsets.all(1.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.errorText,
                        style: TextStyle(
                          color: const Color.fromRGBO(32, 30, 31, 0.5),
                          fontSize: 13.sp,
                          fontFamily: ConstantsFonts.latoRegular,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
    }
  }
}