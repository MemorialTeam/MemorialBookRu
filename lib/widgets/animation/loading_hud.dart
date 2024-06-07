import 'package:flutter/material.dart';
import 'package:gradient_progress_indicator/widget/gradient_progress_indicator_widget.dart';
import 'package:sizer/sizer.dart';

class LoadingOverlayAlt extends StatelessWidget {
  LoadingOverlayAlt({Key? key, required this.child})
      : _isLoadingNotifier = ValueNotifier(false),
        super(key: key);

  final ValueNotifier<bool> _isLoadingNotifier;
  final Widget child;

  static LoadingOverlayAlt of(BuildContext context) {
    return context.findAncestorWidgetOfExactType<LoadingOverlayAlt>()!;
  }

  void show() {
    _isLoadingNotifier.value = true;
  }

  void hide() {
    _isLoadingNotifier.value = false;
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: _isLoadingNotifier,
      child: child,
      builder: (context, isLoading, child) {
        return Stack(
          children: [
            child!,
            if (isLoading)
              const Opacity(
                opacity: 0.8,
                child: ModalBarrier(dismissible: false, color: Colors.black),
              ),
            if (isLoading)
              Center(
                child: GradientProgressIndicator(
                  duration: 1,
                  child: SizedBox(),
                  radius: 52,
                  strokeWidth: 5.w,
                  gradientStops: const [
                    0.02,
                    0.98,
                  ],
                  gradientColors: const [
                    Color.fromRGBO(211, 255, 86, 1),
                    Color.fromRGBO(0, 175, 170, 0)],
                ),
              ),
          ],
        );
      },
    );
  }
}