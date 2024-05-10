import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:memorial_book/provider/catalog_provider.dart';
import 'package:memorial_book/widgets/animation/punching_animation.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../../helpers/enums.dart';

///Нужен рефакторинг, нужно допилить работу с контроллером и реализовать функционал внутри этого виджета
class UsersLocationWidget extends StatefulWidget {
  const UsersLocationWidget({
    super.key,
    required this.icon,
    required this.mapFlowType,
    required this.isLoading,
    required this.loaderColor,
  });

  final String icon;

  final MapFlowType mapFlowType;

  final bool isLoading;

  final Color loaderColor;

  @override
  State<UsersLocationWidget> createState() => _UsersLocationWidgetState();
}

class _UsersLocationWidgetState extends State<UsersLocationWidget> {

  @override
  Widget build(BuildContext context) {
    final catalogProvider = Provider.of<CatalogProvider>(context);
    if(widget.isLoading == true) {
      return SizedBox(
        height: 6.2.h,
        width: 6.2.h,
        child: LoadingIndicator(
          indicatorType: Indicator.ballSpinFadeLoader,
          colors: [
            widget.loaderColor,
          ],
        ),
      );
    } else {
      return PunchingAnimation(
        child: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () async => widget.mapFlowType == MapFlowType.people ?
          await catalogProvider.userGeolocationPeopleSearch() :
          await catalogProvider.userGeolocationPlacesSearch(),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              image: DecorationImage(
                image: AssetImage(
                  widget.icon,
                ),
              ),
            ),
            height: 6.2.h,
            width: 6.2.h,
          ),
        ),
      );
    }
  }
}
