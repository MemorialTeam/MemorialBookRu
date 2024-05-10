import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:memorial_book/provider/tab_bar_provider.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class OpenImage extends StatelessWidget {
  const OpenImage({
    Key? key,
    required this.child,
    this.backgroundColor = Colors.black,
    this.backgroundIsTransparent = true,
    required this.disposeLevel,
    required this.dataImage,
    required this.initialIndex,
    this.imageUrl,
  }) : super(key: key);

  final Widget child;

  final Color backgroundColor;

  final bool backgroundIsTransparent;

  final DisposeLevel disposeLevel;

  final String? imageUrl;

  final List dataImage;

  final int initialIndex;

  @override
  Widget build(BuildContext context) {
    final tabBarProvider = Provider.of<TabBarProvider>(context);
    return GestureDetector(
      onTap: () {
        Navigator.push(
          tabBarProvider.mainContext,
          PageRouteBuilder(
            opaque: false,
            barrierColor: backgroundIsTransparent
                ? Colors.white.withOpacity(0)
                : backgroundColor,
            pageBuilder: (BuildContext context, _, __) {
              return PageCore(
                backgroundColor: backgroundColor,
                backgroundIsTransparent: backgroundIsTransparent,
                disposeLevel: disposeLevel,
                dataImage: dataImage,
                initialIndex: initialIndex,
                imageUrl: imageUrl,
              );
            },
          ),
        );
      },
      child: child,
    );
  }
}

enum DisposeLevel {
  High,
  Medium,
  Low,
}

class PageCore extends StatefulWidget {
  PageCore({Key? key,
    this.backgroundColor = Colors.black,
    this.backgroundIsTransparent = true,
    this.disposeLevel = DisposeLevel.Medium,
    required this.dataImage,
    this.initialIndex = 0,
    this.imageUrl,
  }) : pageController = PageController(initialPage: initialIndex), super(key: key);

  PageController pageController = PageController();

  final Color backgroundColor;

  final bool backgroundIsTransparent;

  final DisposeLevel disposeLevel;

  final List dataImage;

  final String? imageUrl;

  final int initialIndex;

  @override
  State<PageCore> createState() => _PageCoreState();
}

class _PageCoreState extends State<PageCore> {
  double initialPositionY = 0;
  double currentPositionY = 0;
  double positionYDelta = 0;
  double opacity = 1;
  double disposeLimit = 150;

  late int currentIndex = widget.initialIndex;

  Duration animationDuration = Duration.zero;

  TapDownDetails? _doubleTapDetails;

  TransformationController controller = TransformationController();

  late Matrix4 initialControllerValue;

  @override
  void initState() {
    super.initState();
    setDisposeLevel();
  }

  void onPageChanged(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  setDisposeLevel() {
    setState(() {
      if (widget.disposeLevel == DisposeLevel.High) {
        disposeLimit = 300;
      } else if (widget.disposeLevel == DisposeLevel.Medium) {
        disposeLimit = 200;
      } else {
        disposeLimit = 100;
      }
    });
  }

  void _startVerticalDrag(details) {
    setState(() {
      initialPositionY = details.globalPosition.dy;
    });
  }

  void _whileVerticalDrag(details) {
    setState(() {
      currentPositionY = details.globalPosition.dy;
      positionYDelta = currentPositionY - initialPositionY;
      setOpacity();
    });
  }

  setOpacity() {
    double tmp = positionYDelta < 0
        ? 1 - ((positionYDelta / 1000) * -1)
        : 1 - (positionYDelta / 1000);

    if (tmp > 1) {
      opacity = 1;
    } else if (tmp < 0) {
      opacity = 0;
    } else {
      opacity = tmp;
    }

    if (positionYDelta > disposeLimit || positionYDelta < -disposeLimit) {
      opacity = 0.7;
    }
  }

  _endVerticalDrag(DragEndDetails details) {
    if (positionYDelta > disposeLimit || positionYDelta < - disposeLimit) {
      Navigator.of(context).pop();
    } else {
      setState(() {
        animationDuration = const Duration(milliseconds: 200);
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

  bool detector = false;

  void _handleDoubleTap() {
    if (controller.value != Matrix4.identity()) {
      controller.value = Matrix4.identity();
      setState(() {
        detector = false;
      });
    } else {
      setState(() {
        detector = true;
      });
      final position = _doubleTapDetails!.localPosition;
      controller.value = Matrix4.identity()
        ..translate(-position.dx * 2, -position.dy * 2)
        ..scale(3.0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener(
      onNotification: (OverscrollIndicatorNotification overscroll) {
        overscroll.disallowIndicator();
        return true;
      },
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: GestureDetector(
          onVerticalDragStart: detector != true ? (details) => _startVerticalDrag(details) : null,
          onVerticalDragUpdate: detector != true ? (details) => _whileVerticalDrag(details) : null,
          onVerticalDragEnd: detector != true ? (details) => _endVerticalDrag(details) : null,
          onDoubleTapDown: (d) => _doubleTapDetails = d,
          onDoubleTap: _handleDoubleTap,
          child: Container(
            color: widget.backgroundColor.withOpacity(opacity),
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
                  child: PageView.builder(
                    controller: widget.pageController,
                    onPageChanged: onPageChanged,
                    itemCount: widget.dataImage.length,
                    physics: detector != true ?
                    null :
                    const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) => InteractiveViewer(
                      transformationController: controller,
                      trackpadScrollCausesScale: true,
                      scaleEnabled: false,
                      child: CachedNetworkImage(
                        imageUrl: widget.imageUrl != null ?
                        widget.dataImage[index][widget.imageUrl] :
                        widget.dataImage[index],
                        fit: BoxFit.contain,
                        filterQuality: FilterQuality.high,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 24,
                    right: 6,
                  ),
                  child: Align(
                    alignment: Alignment.topRight,
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        borderRadius: BorderRadius.circular(32),
                        child: Padding(
                          padding: EdgeInsets.all(12.sp),
                          child: Icon(
                            Icons.close,
                            color: Colors.white,
                            size: 25.sp,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                AnimatedPositioned(
                  duration: animationDuration,
                  top: 0 + positionYDelta,
                  bottom: 0 - positionYDelta,
                  left: 0,
                  right: 0,
                  child: Align(
                    alignment: AlignmentDirectional.bottomCenter,
                    child: Container(
                      height: 2.8.h,
                      width: 26.w,
                      decoration: BoxDecoration(
                        color: const Color.fromRGBO(236, 236, 236, 1),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 9,
                      ),
                      margin: EdgeInsets.only(
                        bottom: 4.h,
                      ),
                      child: Center(
                        child: Text(
                          '${currentIndex + 1} / ${widget.dataImage.length}',
                          style: TextStyle(
                            fontSize: 12.sp,
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
      ),
    );
  }
}