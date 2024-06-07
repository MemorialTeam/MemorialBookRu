import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:memorial_book/helpers/constants.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:sizer/sizer.dart';
import '../models/common/image_response_model.dart';
import 'marketplace_widgets/indicator_product_gallery.dart';

class FullScreenGalleryMarket extends StatefulWidget {
  FullScreenGalleryMarket({
    super.key,
    required this.gallery,
    this.title,
    this.initialIndex = 0,
  }) : pageController = PageController(
    initialPage: initialIndex,
  );

  final List<ImageResponseModel>? gallery;
  final String? title;
  final PageController pageController;
  final int initialIndex;

  @override
  State<FullScreenGalleryMarket> createState() => _FullScreenGalleryMarketState();
}

class _FullScreenGalleryMarketState extends State<FullScreenGalleryMarket>
    with SingleTickerProviderStateMixin {

  late int page = widget.initialIndex;

  Color backgroundColor = const Color.fromRGBO(255, 255, 255, 1);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        color: backgroundColor,
        constraints: BoxConstraints.expand(
          height: MediaQuery.of(context).size.height,
        ),
        child: Stack(
          children: [
            PhotoViewGallery.builder(
              pageController: widget.pageController,
              backgroundDecoration: const BoxDecoration(
                color: Colors.transparent,
              ),
              onPageChanged: (value) => setState(() => page = value),
              builder: (BuildContext context, int index) {
                return PhotoViewGalleryPageOptions(
                  initialScale: PhotoViewComputedScale.contained,
                  minScale: PhotoViewComputedScale.contained,
                  maxScale: PhotoViewComputedScale.covered * 1.5,
                  imageProvider: NetworkImage(
                    widget.gallery?[index].url ?? '',
                  ),
                  heroAttributes: PhotoViewHeroAttributes(
                    tag: widget.gallery?[index].id.toString() ?? '',
                  ),
                );
              },
              loadingBuilder: (BuildContext context, _) {
                return Container(
                  width: double.infinity,
                  height: double.infinity,
                  color: backgroundColor,
                  child: Center(
                    child: Image.asset(
                      ConstantsAssets.memorialBookIconImage,
                      width: 10.h,
                      height: 10.h,
                    ),
                  ),
                );
              },
              itemCount: widget.gallery?.length ?? 0,
            ),
            Positioned(
              top: 0,
              // right: 0,
              left: 0,
              child: SafeArea(
                child: IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 1.h,
                      horizontal: 1.2.w,
                    ),
                    child: Icon(
                      Icons.close,
                      color: const Color.fromRGBO(87, 167, 109, 1),
                      size: 22.sp,
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              right: 0,
              left: 0,
              bottom: 3.4.h,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  widget.gallery?.length ?? 0,
                  ((index) => Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 2.w,
                    ),
                    child: IndicatorProductGallery(
                      isActive: page == index,
                    ),
                  )),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
