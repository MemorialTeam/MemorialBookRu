import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'image_in_post_widget.dart';

class NewsItemWidget extends StatelessWidget {
  const NewsItemWidget({
    Key? key,
    required this.dataImages,
  }) : super(key: key);

  final List dataImages;

  @override
  Widget build(BuildContext context) {
    final int itemCount = dataImages.length;

    if(itemCount == 0) {
      return const SizedBox();
    }
    if(itemCount == 1) {
      return ImageInPostWidget(
        isExpanded: false,
        dataImages: dataImages,
        initialIndex: 0,
      );
    }
    if(itemCount == 2) {
      return Row(
        children: [
          ImageInPostWidget(
            isExpanded: true,
            dataImages: dataImages,
            initialIndex: 0,
          ),
          SizedBox(
            width: 0.6.h,
          ),
          ImageInPostWidget(
            isExpanded: true,
            dataImages: dataImages,
            initialIndex: 1,
          ),
        ],
      );
    }
    if(itemCount == 3) {
      return Row(
        children: [
          ImageInPostWidget(
            isExpanded: true,
            dataImages: dataImages,
            initialIndex: 0,
          ),
          SizedBox(
            width: 0.6.h,
          ),
          ImageInPostWidget(
            isExpanded: true,
            dataImages: dataImages,
            initialIndex: 1,
          ),
          SizedBox(
            width: 0.6.h,
          ),
          ImageInPostWidget(
            isExpanded: true,
            dataImages: dataImages,
            initialIndex: 2,
          ),
        ],
      );
    }
    if(itemCount == 4) {
      return Column(
        children: [
          Row(
            children: [
              ImageInPostWidget(
                isExpanded: true,
                dataImages: dataImages,
                initialIndex: 0,
              ),
              SizedBox(
                width: 0.6.h,
              ),
              ImageInPostWidget(
                isExpanded: true,
                dataImages: dataImages,
                initialIndex: 1,
              ),
              SizedBox(
                width: 0.6.h,
              ),
              ImageInPostWidget(
                isExpanded: true,
                dataImages: dataImages,
                initialIndex: 2,
              ),
            ],
          ),
          SizedBox(
            height: 0.6.h,
          ),
          ImageInPostWidget(
            isExpanded: false,
            dataImages: dataImages,
            initialIndex: 3,
          ),
        ],
      );
    }
    if(itemCount == 5) {
      return Column(
        children: [
          Row(
            children: [
              ImageInPostWidget(
                isExpanded: true,
                dataImages: dataImages,
                initialIndex: 0,
              ),
              SizedBox(
                width: 0.6.h,
              ),
              ImageInPostWidget(
                isExpanded: true,
                dataImages: dataImages,
                initialIndex: 1,
              ),
              SizedBox(
                width: 0.6.h,
              ),
              ImageInPostWidget(
                isExpanded: true,
                dataImages: dataImages,
                initialIndex: 2,
              ),
            ],
          ),
          SizedBox(
            height: 0.6.h,
          ),
          Row(
            children: [
              ImageInPostWidget(
                isExpanded: true,
                dataImages: dataImages,
                initialIndex: 3,
              ),
              SizedBox(
                width: 0.6.h,
              ),
              ImageInPostWidget(
                isExpanded: true,
                dataImages: dataImages,
                initialIndex: 4,
              ),
            ],
          ),
        ],
      );
    }
    if(itemCount == 6) {
      return Column(
        children: [
          Row(
            children: [
              ImageInPostWidget(
                isExpanded: true,
                dataImages: dataImages,
                initialIndex: 0,
              ),
              SizedBox(
                width: 0.6.h,
              ),
              ImageInPostWidget(
                isExpanded: true,
                dataImages: dataImages,
                initialIndex: 1,
              ),
              SizedBox(
                width: 0.6.h,
              ),
              ImageInPostWidget(
                isExpanded: true,
                dataImages: dataImages,
                initialIndex: 2,
              ),
            ],
          ),
          SizedBox(
            height: 0.6.h,
          ),
          Row(
            children: [
              ImageInPostWidget(
                isExpanded: true,
                dataImages: dataImages,
                initialIndex: 3,
              ),
              SizedBox(
                width: 0.6.h,
              ),
              ImageInPostWidget(
                isExpanded: true,
                dataImages: dataImages,
                initialIndex: 4,
              ),
              SizedBox(
                width: 0.6.h,
              ),
              ImageInPostWidget(
                isExpanded: true,
                dataImages: dataImages,
                initialIndex: 5,
              ),
            ],
          ),
        ],
      );
    }
    else {
      return const SizedBox();
    }
  }
}