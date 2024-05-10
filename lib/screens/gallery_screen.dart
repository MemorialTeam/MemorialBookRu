import 'package:flutter/material.dart';
import 'package:galleryimage/app_cached_network_image.dart';
import 'package:galleryimage/gallery_item_model.dart';
import 'package:galleryimage/galleryimage.dart';

class GalleryScreen extends StatefulWidget {
  const GalleryScreen({
    super.key,
    required this.model,
    required this.images,
    this.initialIndex,
  });

  final GalleryItemModel model;

  final List images;
  final int? initialIndex;

  @override
  State<GalleryScreen> createState() => _GalleryScreenState();
}

class _GalleryScreenState extends State<GalleryScreen> {

  late final PageController _controller =
  PageController(initialPage: widget.initialIndex ?? 0);
  int _currentPage = 0;

  @override
  void initState() {
    _currentPage = 0;
    _controller.addListener(() {
      setState(() {
        _currentPage = _controller.page?.toInt() ?? 0;
      });
    });
    super.initState();
  }

  PageController controller = PageController();

  // build image with zooming
  Widget _buildImage(GalleryItemModel item) {
    return Hero(
      tag: item.id,
      child: InteractiveViewer(
        minScale: 0.8,
        maxScale: 0.8,
        child: Center(
          child: AppCachedNetworkImage(
            imageUrl: item.imageUrl,
            radius: 0,
          ),
        ),
      ),
    );
  }

// build image with zooming
  Widget _buildLitImage(GalleryItemModel item) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: GestureDetector(
        onTap: () {
          setState(() {
            controller.jumpToPage(item.index);
          });
        },
        child: AppCachedNetworkImage(
          height: _currentPage == item.index ? 70 : 60,
          width: _currentPage == item.index ? 70 : 60,
          fit: BoxFit.cover,
          imageUrl: item.imageUrl,
          radius: 0,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          constraints:
          BoxConstraints.expand(height: MediaQuery.of(context).size.height),
          child: Column(
            children: [
              Expanded(
                child: GestureDetector(
                  onVerticalDragEnd: (details) {
                    if (
                    details.primaryVelocity! < 0) {
                      //'up'
                      Navigator.of(context).pop();
                    }
                    if (details.primaryVelocity! > 0) {
                      // 'down'
                      Navigator.of(context).pop();
                    }
                  },
                  child: PageView.builder(
                    controller: controller,
                    itemCount: widget.images.length,
                    itemBuilder: (context, index) => _buildImage(widget.model),
                  ),
                ),
              ),
              SizedBox(
                height: 80,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: widget.images.map(
                      ((e) => _buildLitImage(widget.model)),
                    ).toList(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
