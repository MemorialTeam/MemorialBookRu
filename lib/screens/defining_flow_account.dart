import 'package:flutter_svprogresshud/flutter_svprogresshud.dart';
import 'package:memorial_book/screens/onboarding_flow/onboarding_flow.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import '../provider/auth_provider.dart';
import '../provider/tab_bar_provider.dart';
import '../widgets/tab_bar_widget/tab_bar_widget.dart';
import 'auth&reg_flow/login_screen.dart';

class DefiningFlowAccount extends StatefulWidget {
  const DefiningFlowAccount({Key? key,
    required this.userToken,
    required this.userRules,
  }) : super(key: key);

  final String userToken;
  final String userRules;

  @override
  State<DefiningFlowAccount> createState() => _DefiningFlowAccountState();
}

class _DefiningFlowAccountState extends State<DefiningFlowAccount> {

  @override
  void initState() {
    final tabBarProvider = Provider.of<TabBarProvider>(
      context,
      listen: false,
    );
    SVProgressHUD.dismiss();
    tabBarProvider.setContext(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    if (widget.userToken != '' || widget.userRules != '') {
      return const TabBarWidget();
    } else {
      return authProvider.newUser == 'new' ?
      const OnboardingFlow() :
      const LoginScreen();
    }
  }
}
