import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:memorial_book/helpers/constants.dart';
import 'package:memorial_book/screens/main_flow/notification_screen.dart';
import 'package:memorial_book/widgets/animation/punching_animation.dart';
import 'package:sizer/sizer.dart';

class MarketplaceAppBar extends StatelessWidget {
  MarketplaceAppBar({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return CupertinoTheme(
      data: CupertinoThemeData(
        barBackgroundColor: const Color.fromRGBO(255, 255, 255, 1),
        textTheme: CupertinoTextThemeData(
          primaryColor: Theme.of(context).primaryColorDark,
        ),
      ),
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () => FocusScope.of(context).unfocus(),
        child: CupertinoPageScaffold(
          navigationBar: CupertinoNavigationBar(
            backgroundColor: const Color.fromRGBO(255, 255, 255, 0.9),
            border: Border.all(
                color: const Color.fromRGBO(255, 255, 255, 0.9)
            ),
            transitionBetweenRoutes: false,
            leading: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () => Navigator.pop(context),
                  child: Padding(
                    padding: const EdgeInsets.only(
                      right: 10,
                      top: 5,
                      bottom: 5,
                    ),
                    child: Image.asset(
                      ConstantsAssets.leadingBackImage,
                      width: 20,
                      height: 16,
                      color: const Color.fromRGBO(87, 167, 109, 1),
                    ),
                  ),
                ),
                SizedBox(
                  width: 5.w,
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Delivery: Calvary Cemetery',
                      style: TextStyle(
                        color: const Color.fromRGBO(32, 30, 31, 1),
                        fontSize: 11.5.sp,
                        fontFamily: ConstantsFonts.latoSemiBold,
                      ),
                    ),
                    Text(
                      '49-02 Laurel Hill Blvd., Woodside, NY 11377',
                      style: TextStyle(
                        color: const Color.fromRGBO(32, 30, 31, 1),
                        fontSize: 7.5.sp,
                        fontFamily: ConstantsFonts.latoSemiBold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                PunchingAnimation(
                  child: GestureDetector(
                    onTap: () {

                    },
                    child: Image.asset(
                      ConstantsAssets.orderHistoryImage,
                      height: 3.2.h,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                SizedBox(
                  width: 5.w,
                ),
                PunchingAnimation(
                  child: GestureDetector(
                    onTap: () {

                    },
                    child: Image.asset(
                      ConstantsAssets.basketImage,
                      height: 3.2.h,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ],
            ),
          ),
          child: Container(
            color: const Color.fromRGBO(255, 255, 255, 1),
            child: child,
          ),
        ),
      ),
    );
  }
}

// return Scaffold(
//   backgroundColor: const Color.fromRGBO(245, 245, 245, 1),
//   body: Column(
//     mainAxisSize: MainAxisSize.min,
//     children: [
//       Padding(
//         padding: EdgeInsets.symmetric(
//           horizontal: 4.w,
//           vertical: 1.6.h,
//         ),
//         child: Row(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             GestureDetector(
//               behavior: HitTestBehavior.translucent,
//               onTap: () => Navigator.pop(context),
//               child: Padding(
//                 padding: const EdgeInsets.only(
//                   right: 10,
//                   top: 5,
//                   bottom: 5,
//                 ),
//                 child: Image.asset(
//                   ConstantsAssets.leadingBackImage,
//                   width: 20,
//                   height: 16,
//                   color: const Color.fromRGBO(87, 167, 109, 1),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//       child,
//     ],
//   ),
// );