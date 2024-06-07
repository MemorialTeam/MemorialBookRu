import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../helpers/constants.dart';
import 'package:sizer/sizer.dart';
import '../search_engine.dart';

class SearchHeaderWidget extends StatelessWidget {
  const SearchHeaderWidget({
    super.key,
    required this.focusNode,
    required this.onSearch,
    required this.controller,
    required this.filterRoute,
    required this.context,
    required this.filterCount,
    this.mainColor,
  });

  final FocusNode focusNode;

  final void Function(String) onSearch;

  final TextEditingController controller;

  final Widget filterRoute;

  final BuildContext context;

  final String filterCount;

  final Color? mainColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 7.6.h,
      width: double.infinity,
      color: const Color.fromRGBO(255, 255, 255, 1),
      padding: EdgeInsets.only(
        bottom: 1.2.h,
        left: 3.2.w,
        right: 3.2.w,
      ),
      child: Row(
        children: [
          Expanded(
            child: SearchEngine(
              focusNode: focusNode,
              controller: controller,
              isNotEmptyFunc: onSearch,
              activeColor: mainColor,
            ),
          ),
          SizedBox(
            width: 2.w,
          ),
          GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () => Navigator.push(
              context,
              CupertinoPageRoute(
                builder: (context) => filterRoute,
              ),
            ),
            child: Row(
              children: [
                Text(
                  'Фильтр',
                  style: TextStyle(
                    color: mainColor ?? const Color.fromRGBO(23, 94, 217, 1),
                    fontFamily: ConstantsFonts.latoBold,
                    fontSize: 11.5.sp,
                  ),
                ),
                SizedBox(
                  width: 1.4.w,
                ),
                Container(
                  height: 2.5.h,
                  width: 2.5.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: mainColor ?? const Color.fromRGBO(23, 94, 217, 1),
                  ),
                  child: Center(
                    child: Text(
                      filterCount,
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: ConstantsFonts.latoRegular,
                        fontSize: 9.5.sp,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
