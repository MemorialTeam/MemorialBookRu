import 'package:carousel_slider/carousel_options.dart';
import 'package:flutter/cupertino.dart';

class MarketplaceProvider extends ChangeNotifier {
  int currentPost = 0;

  void onPageChanged(int page, CarouselPageChangedReason controller) {
    currentPost = page;
    notifyListeners();
  }
}