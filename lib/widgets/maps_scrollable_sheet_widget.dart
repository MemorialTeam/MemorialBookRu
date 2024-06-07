import 'package:flutter/material.dart';
import 'package:memorial_book/widgets/map_ui/show_as_widget.dart';
import 'package:memorial_book/widgets/platform_scroll_physics.dart';
import 'package:sizer/sizer.dart';
import '../helpers/constants.dart';

class MapsScrollableSheetWidget extends StatefulWidget {
  const MapsScrollableSheetWidget({
    Key? key,
    this.total,
    required this.color,
    required this.child,
    required this.sheetController,
  }) : super(key: key);

  final int? total;
  final Color color;
  final Widget child;
  final DraggableScrollableController sheetController;

  @override
  State<MapsScrollableSheetWidget> createState() => _MapsScrollableSheetWidgetState();
}

class _MapsScrollableSheetWidgetState extends State<MapsScrollableSheetWidget> {

  final double initialSizeSheet = 0.35;
  final double minChildSizeSheet = 0.35;

  bool isVisible = true;

  @override
  Widget build(BuildContext context) {
    return NotificationListener(
      onNotification: (DraggableScrollableNotification notification) {
        if(notification.extent > 0.86) {
          setState(() => isVisible = false);
        }
        else {
          setState(() => isVisible = true);
        }
        return true;
      },
      child: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: AnimatedContainer(
              duration: const Duration(
                milliseconds: 1000,
              ),
              color: isVisible == true ?
              Colors.transparent :
              const Color.fromRGBO(245, 247, 249, 1),
              height: 8.h,
              width: double.infinity,
            ),
          ),
          DraggableScrollableSheet(
            controller: widget.sheetController,
            initialChildSize: initialSizeSheet,
            minChildSize: minChildSizeSheet,
            maxChildSize: 0.902,
            snap: true,
            snapAnimationDuration: const Duration(
              milliseconds: 200,
            ),
            builder: (context, scrollController) => AnimatedContainer(
              duration: const Duration(
                milliseconds: 300,
              ),
              decoration: BoxDecoration(
                borderRadius: isVisible == true ?
                const BorderRadius.only(
                  topRight: Radius.circular(20),
                  topLeft: Radius.circular(20),
                ) :
                null,
                color: const Color.fromRGBO(255, 255, 255, 1),
              ),
              child: SingleChildScrollView(
                physics: platformScrollPhysics(),
                controller: scrollController,
                padding: EdgeInsets.zero,
                child: Column(
                  children: [
                    SizedBox(
                      height: 2.2.h,
                    ),
                    Container(
                      height: 0.7.h,
                      width: double.infinity,
                      margin: EdgeInsets.symmetric(
                        horizontal: 35.w,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.0),
                        color: const Color.fromRGBO(32, 30, 31, 0.3),
                      ),
                    ),
                    SizedBox(
                      height: 2.2.h,
                    ),
                    widget.child,
                    SizedBox(
                      height: 1.2.h,
                    ),
                    widget.total != null ?
                    Column(
                      children: [
                        Container(
                          width: double.infinity,
                          height: 0.1.h,
                          color: const Color.fromRGBO(0, 0, 0, 0.2),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: 2.4.h,
                          ),
                          child: Text(
                            '${widget.total} people were found',
                            style: TextStyle(
                              color: const Color.fromRGBO(0, 0, 0, 0.5),
                              fontSize: 9.5.sp,
                              fontFamily: ConstantsFonts.latoRegular,
                            ),
                          ),
                        ),
                      ],
                    ) :
                    const SizedBox(),
                    SizedBox(
                      height: 6.2.h,
                    ),
                  ],
                ),
              ),
            ),
          ),
          isVisible == false ?
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.only(
                bottom: 2.2.h,
              ),
              child: ShowAsWidget(
                sheetController: widget.sheetController,
                childSizeSheet: 0.3,
                image: ConstantsAssets.showAsMapImage,
                title: 'Показать в виде карты',
                color: widget.color,
              ),
            ),
          ) :
          const SizedBox(),
        ],
      ),
    );
  }
}
