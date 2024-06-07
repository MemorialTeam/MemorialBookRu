import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:memorial_book/helpers/constants.dart';
import 'package:memorial_book/widgets/post_card.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:sizer/sizer.dart';
import '../models/common/image_response_model.dart';
import 'open_image_core.dart';

class FullScreenGallery extends StatefulWidget {
  FullScreenGallery({
    super.key,
    this.galleryModels,
    this.gallery,
    this.title,
    this.initialIndex = 0,
  }) : pageController = PageController(
    initialPage: initialIndex,
  );

  final List<ImageResponseModel>? galleryModels;
  final List? gallery;
  final String? title;
  final PageController pageController;
  final int initialIndex;

  @override
  State<FullScreenGallery> createState() => _FullScreenGalleryState();
}

class _FullScreenGalleryState extends State<FullScreenGallery>
    with SingleTickerProviderStateMixin {

  @override
  void initState() {
    super.initState();

    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: SystemUiOverlay.values,
    );
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 300,
      ),
    );
    _animation = Tween<double>(
      begin: 0.0,
      end: 100.0,
    ).animate(_controller);
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: SystemUiOverlay.values,
    );
    _controller.dispose();
    super.dispose();
  }

  late AnimationController _controller;
  late Animation<double> _animation;

  Duration animationDuration = Duration.zero;

  double disposeLimit = 200;
  double initialPositionY = 0;
  double currentPositionY = 0;
  double positionYDelta = 0;
  double opacity = 1;

  Color backgroundColor = Colors.black;

  void _startVerticalDrag(details) {
    setState(() {
      if (_controller.isCompleted) {
      } else {
        SystemChrome.setEnabledSystemUIMode(
          SystemUiMode.manual,
          overlays: [
            SystemUiOverlay.bottom
          ],
        );
        _controller.forward();
      }
      initialPositionY = details.globalPosition.dy;
    });
  }
  void setOpacity() {
    double tmp = positionYDelta < 0 ?
    1 - ((positionYDelta / 300) * -1) :
    1 - (positionYDelta / 300);

    if (tmp > 1) {
      opacity = 1;
    } else if (tmp < 0) {
      opacity = 0;
    } else {
      opacity = tmp;
    }
  }

  void _whileVerticalDrag(details) {
    setState(() {
      currentPositionY = details.globalPosition.dy;
      positionYDelta = currentPositionY - initialPositionY;
      setOpacity();
    });
  }
  void _endVerticalDrag(DragEndDetails details) {
    if (positionYDelta > disposeLimit || positionYDelta < - disposeLimit) {
      Navigator.of(context).pop();
    } else {
      setState(() {
        animationDuration = const Duration(
          milliseconds: 200,
        );
        opacity = 1;
        positionYDelta = 0;
      });

      Future.delayed(animationDuration).then((_){
        setState(() {
          animationDuration = Duration.zero;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Container(
          color: backgroundColor.withOpacity(opacity),
          constraints: BoxConstraints.expand(
            height: MediaQuery.of(context).size.height,
          ),
          child: Stack(
            children: [
              AnimatedPositioned(
                duration: animationDuration,
                top: 0 + positionYDelta,
                bottom: 0 - positionYDelta,
                left: 0,
                right: 0,
                child: GestureDetector(
                  onVerticalDragStart: (details) => _startVerticalDrag(details),
                  onVerticalDragUpdate: (details) => _whileVerticalDrag(details),
                  onVerticalDragEnd: (details) => _endVerticalDrag(details),
                  onTap: () {
                    if (_controller.isCompleted) {
                      SystemChrome.setEnabledSystemUIMode(
                        SystemUiMode.manual,
                        overlays: SystemUiOverlay.values,
                      );
                      _controller.reverse();
                    } else {
                      SystemChrome.setEnabledSystemUIMode(
                        SystemUiMode.manual,
                        overlays: [
                          SystemUiOverlay.bottom
                        ],
                      );
                      _controller.forward();
                    }
                  },
                  child: PhotoViewGallery.builder(
                    pageController: widget.pageController,
                    backgroundDecoration: const BoxDecoration(
                      color: Colors.transparent,
                    ),
                    builder: (BuildContext context, int index) {
                      return PhotoViewGalleryPageOptions(
                        initialScale: PhotoViewComputedScale.contained,
                        minScale: PhotoViewComputedScale.contained,
                        maxScale: PhotoViewComputedScale.covered * 1.5,
                        imageProvider: NetworkImage(
                          widget.galleryModels?[index].url ?? widget.gallery?[index],
                        ),
                        heroAttributes: PhotoViewHeroAttributes(
                          tag: widget.galleryModels?[index].id.toString() ?? index,
                        ),
                      );
                    },
                    loadingBuilder: (BuildContext context, _) {
                      return Container(
                        width: double.infinity,
                        height: double.infinity,
                        color: backgroundColor.withOpacity(opacity),
                        child: Center(
                          child: SizedBox(
                            width: 7.h,
                            height: 7.h,
                            child: const LoadingIndicator(
                              indicatorType: Indicator.ballSpinFadeLoader,
                              colors: [
                                Colors.grey,
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                    itemCount: widget.galleryModels?.length ?? widget.gallery?.length,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: () => widget.pageController.previousPage(
                      duration: const Duration(
                        milliseconds: 10,
                      ),
                      curve: Curves.ease,
                    ),
                    child: SizedBox(
                      height: double.infinity,
                      width: 12.w,
                      // color: Colors.pink,
                    ),
                  ),
                  GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: () => widget.pageController.nextPage(
                      duration: const Duration(
                        milliseconds: 10,
                      ),
                      curve: Curves.ease,
                    ),
                    child: SizedBox(
                      height: double.infinity,
                      width: 12.w,
                      // color: Colors.pink,
                    ),
                  ),
                ],
              ),
              AnimatedBuilder(
                animation: _controller,
                builder: (context, child) => Positioned(
                  top: 0,
                  right: 0,
                  left: 0,
                  child: SafeArea(
                    child: Transform.translate(
                      offset: Offset(0, -_animation.value),
                      child: Container(
                        color: Colors.black26,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                GestureDetector(
                                  behavior: HitTestBehavior.translucent,
                                  onTap: () {
                                    if (_controller.isCompleted) {
                                    } else {
                                      SystemChrome.setEnabledSystemUIMode(
                                        SystemUiMode.manual,
                                        overlays: [
                                          SystemUiOverlay.bottom
                                        ],
                                      );
                                      _controller.forward();
                                    }
                                    setState(() {
                                      opacity = 0.4;
                                    });
                                    Navigator.pop(context);
                                  },
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                      vertical: 1.8.h,
                                      horizontal: 4.2.w,
                                    ),
                                    child: Image.asset(
                                      ConstantsAssets.leadingBackImage,
                                      height: 1.95.h,
                                      color: Colors.white.withOpacity(opacity),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 1.8.w,
                                ),
                                if(widget.title != null && widget.title!.isNotEmpty)
                                  Text(
                                    widget.title ?? '',
                                    style: TextStyle(
                                      fontFamily: ConstantsFonts.latoSemiBold,
                                      fontSize: 12.5.sp,
                                      color: Colors.white.withOpacity(opacity),
                                    ),
                                  ),
                              ],
                            ),
                            PopupMenuButton(
                              position: PopupMenuPosition.under,
                              constraints: BoxConstraints(
                                maxWidth: 55.w,
                              ),
                              color: const Color.fromRGBO(33,33, 33, 0.9),
                              surfaceTintColor: const Color.fromRGBO(33,33, 33, 0.9),
                              itemBuilder: ((context) => [
                                BoardTypePopupMenuItem(
                                  title: 'Поделиться',
                                  image: Icon(
                                    Icons.share_outlined,
                                    size: 15.sp,
                                    color: Colors.white,
                                  ),
                                  weight: 2.8.w,
                                  onTap: () {},
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 11.5.sp,
                                    fontFamily: ConstantsFonts.latoSemiBold,
                                  ),
                                ),
                                BoardTypePopupMenuItem(
                                  title: 'Сохранить в галерею',
                                  image: Icon(
                                    Icons.save,
                                    size: 15.sp,
                                    color: Colors.white,
                                  ),
                                  weight: 2.8.w,
                                  onTap: () async {},
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 11.5.sp,
                                    fontFamily: ConstantsFonts.latoSemiBold,
                                  ),
                                ),
                                BoardTypePopupMenuItem(
                                  title: 'Пожаловаться',
                                  image: Icon(
                                    Icons.error_outline_outlined,
                                    size: 15.sp,
                                    color: Colors.white,
                                  ),
                                  weight: 3.8.w,
                                  onTap: () async {},
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 11.5.sp,
                                    fontFamily: ConstantsFonts.latoSemiBold,
                                  ),
                                ),
                              ]),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                  vertical: 1.8.h,
                                  horizontal: 4.2.w,
                                ),
                                child: Image.asset(
                                  ConstantsAssets.settingsOfProfileImage,
                                  width: 6.w,
                                  color: Colors.white.withOpacity(opacity),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      onWillPop: () async {
        if (_controller.isCompleted) {
        } else {
          SystemChrome.setEnabledSystemUIMode(
            SystemUiMode.manual,
            overlays: [
              SystemUiOverlay.bottom
            ],
          );
          _controller.forward();
        }
        setState(() {
          opacity = 0.4;
        });
        return true;
      },
    );
  }
}
