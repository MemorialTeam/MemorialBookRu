import 'package:flutter_svprogresshud/flutter_svprogresshud.dart';
import 'package:flutter/material.dart';

class UnScopeScaffold extends StatelessWidget {
  const UnScopeScaffold({
    Key? key,
    required this.body,
    this.floatingActionButton,
    this.backgroundColor,
  }) : super(key: key);

  final Widget body;
  final Widget? floatingActionButton;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        SVProgressHUD.dismiss();
      },
      child: Scaffold(
        backgroundColor: backgroundColor,
        body: SafeArea(
          child: body,
        ),
        floatingActionButton: floatingActionButton,
      ),
    );
  }
}
