import 'package:flutter/material.dart';

class BootEngine extends StatelessWidget {
  const BootEngine({
    super.key,
    required this.loadValue,
    required this.activeFlow,
    required this.loadingFlow,
  });

  final bool loadValue;

  final Widget activeFlow;
  final Widget loadingFlow;

  @override
  Widget build(BuildContext context) {
    if(loadValue == false) {
      return activeFlow;
    } else {
      return loadingFlow;
    }
  }
}
