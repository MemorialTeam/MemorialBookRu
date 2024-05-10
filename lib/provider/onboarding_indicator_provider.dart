import 'package:flutter/material.dart';

import '../helpers/constants.dart';
import '../widgets/indicator_gallery_point_widget.dart';
import '../widgets/indicator_logic_color_widget.dart';

class OnboardingIndicatorProvider extends ChangeNotifier {
  int currentPage = 0;

  final PageController calculatorController = PageController();
  final PageController submitController = PageController();
  final PageController filterController = PageController();
  final PageController analyticsController = PageController();

  final PageController pageController = PageController(
    initialPage: 0,
  );

  void pageStateController(PageController controller) {
    controller.nextPage(
      duration: const Duration(
        milliseconds: 500,
      ),
      curve: Curves.ease,
    );
    notifyListeners();
  }

  void pageStateAnalyticsController() {
    analyticsController.nextPage(
      duration: const Duration(
        milliseconds: 500,
      ),
      curve: Curves.ease,
    );
    notifyListeners();
  }

  void fastBounce() {
    calculatorController.nextPage(
      duration: const Duration(
        milliseconds: 100,
      ),
      curve: Curves.easeIn,
    );
    notifyListeners();
  }

  List<Widget> buildPageIndicator(BuildContext context) {
    List<Widget> list = [];
    for (int i = 0; i < 5; i++) {
      list.add(
        i == currentPage
            ? indicatorLogicColorWidget(true, currentPage, context)
            : indicatorLogicColorWidget(false, currentPage, context),
      );
    }
    return list;
  }

  List<Widget> buildGalleryPageIndicator(BuildContext context, int selectedImage, int length) {
    List<Widget> list = [];
    if(length != 1) {
      for (int i = 0; i < length; i++) {
        list.add(
          i == selectedImage
              ? indicatorGalleryPointWidget(true, selectedImage, context)
              : indicatorGalleryPointWidget(false, selectedImage, context),
        );
      }
    }
    return list;
  }

  void changeAnimationPointOnIndicator(int page) {
    currentPage = page;
    notifyListeners();
  }

  void disposeIndicator() {
    currentPage = 0;
    notifyListeners();
  }

  void changePages() {
    pageController.nextPage(
      duration: const Duration(
        milliseconds: 250,
      ),
      curve: Curves.easeIn,
    );
    notifyListeners();
  }

  AssetImage topImage() {
    switch(currentPage) {
      case 0:
        return firstFront;
      case 1:
        return secondFront;
      case 2:
        return thirdFront;
      case 3:
        return fourthFront;
      case 4:
        return fifthFront;
      default:
        return firstFront;
    }
  }
  AssetImage bottomImage() {
    switch(currentPage) {
      case 0:
        return thirstBack;
      case 1:
        return secondBack;
      case 2:
        return thirdBack;
      case 3:
        return fourthBack;
      case 4:
        return fifthBack;
      default:
        return thirstBack;
    }
  }

  AssetImage firstFront = AssetImage(ConstantsAssets.firstFrontOnbImage);
  AssetImage secondFront = AssetImage(ConstantsAssets.secondFrontOnbImage);
  AssetImage thirdFront = AssetImage(ConstantsAssets.thirdFrontOnbImage);
  AssetImage fourthFront = AssetImage(ConstantsAssets.fourthFrontOnbImage);
  AssetImage fifthFront = AssetImage(ConstantsAssets.fifthFrontOnbImage);
  AssetImage thirstBack = AssetImage(ConstantsAssets.firstBackOnbImage);
  AssetImage secondBack = AssetImage(ConstantsAssets.secondBackOnbImage);
  AssetImage thirdBack = AssetImage(ConstantsAssets.thirdBackOnbImage);
  AssetImage fourthBack = AssetImage(ConstantsAssets.fourthBackOnbImage);
  AssetImage fifthBack = AssetImage(ConstantsAssets.fifthBackOnbImage);

  OnboardingIndicatorProvider(BuildContext context) {
    precacheImage(firstFront, context);
    precacheImage(secondFront, context);
    precacheImage(thirdFront, context);
    precacheImage(fourthFront, context);
    precacheImage(fifthFront, context);
    precacheImage(thirstBack, context);
    precacheImage(secondBack, context);
    precacheImage(thirdBack, context);
    precacheImage(fourthBack, context);
    precacheImage(fifthBack, context);
  }
}
