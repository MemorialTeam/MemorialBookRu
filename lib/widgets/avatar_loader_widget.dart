import 'package:loading_indicator/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class AvatarLoaderWidget extends StatelessWidget {
  const AvatarLoaderWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 7.h,
      width: 7.h,
      child: const Center(
        child: LoadingIndicator(
          indicatorType: Indicator.ballRotateChase,
          colors: [
            Color.fromRGBO(23, 94, 217, 1),
            Color.fromRGBO(23, 94, 217, 0.7),
            Color.fromRGBO(23, 94, 217, 0.5),
          ],
        ),
      ),
    );
  }
}
