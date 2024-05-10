import 'package:memorial_book/provider/auth_provider.dart';
import 'package:memorial_book/provider/tab_bar_provider.dart';
import '../helpers/enums.dart';
import '../provider/account_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import '../helpers/constants.dart';
import 'package:sizer/sizer.dart';

class FlowBuild extends StatefulWidget {
  FlowBuild({
    super.key,
    required this.loadingFlow,
    required this.activeFlow,
    this.guestFlow,
    required this.errorText,
  });

  final Widget loadingFlow;
  final Widget activeFlow;
  final Widget? guestFlow;

  late String errorText;

  @override
  State<FlowBuild> createState() => _FlowBuildState();
}

class _FlowBuildState extends State<FlowBuild> {
  @override
  Widget build(BuildContext context) {
    final accountProvider = Provider.of<AccountProvider>(context);
    final authProvider = Provider.of<AuthProvider>(context);
    if(authProvider.userRules == 'authorized') {
      if(accountProvider.loadingState == LoadingState.loading) {
        return widget.loadingFlow;
      } else if (accountProvider.loadingState == LoadingState.active) {
        return widget.activeFlow;
      } else if (accountProvider.loadingState == LoadingState.error) {
        return SizedBox(
          width: 54.w,
          child: Text(
            widget.errorText,
            style: TextStyle(
              fontFamily: ConstantsFonts.latoBold,
              fontSize: 13.0.sp,
              color: const Color.fromRGBO(33, 33, 33, 1),
            ),
          ),
        );
      } else {
        return const SizedBox();
      }
    } else {
      return widget.guestFlow ?? widget.activeFlow;
    }
  }
}
