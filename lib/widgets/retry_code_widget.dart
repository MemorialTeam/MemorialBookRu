import 'dart:async';
import 'package:memorial_book/provider/auth_provider.dart';
import 'package:memorial_book/provider/message_dialogs_provider.dart';
import 'package:memorial_book/widgets/text_button_widget.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import '../../helpers/constants.dart';
import 'package:sizer/sizer.dart';

class RetryCodeWidget extends StatefulWidget {
  const RetryCodeWidget({Key? key}) : super(key: key);

  @override
  State<RetryCodeWidget> createState() => _RetryCodeWidgetState();
}

class _RetryCodeWidgetState extends State<RetryCodeWidget> {

  bool showTimer = true;

  Timer? timer;

  int start = 60;

  void startTimer() {
    const oneSec = Duration(
      seconds: 1,
    );
    timer = Timer.periodic(
      oneSec,
      ((Timer timer) {
        if (start == 0) {
          timer.cancel();
          showTimer = true;
          start = 60;
          setState(() {});
        } else {
          start--;setState(() {});
        }
      }),
    );
  }

  void pressingTheTimerButton() {
    startTimer();
    showTimer = false;
    setState(() {});
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final messageDialogsProvider = Provider.of<MessageDialogsProvider>(context);
    return showTimer ?
    TextButtonWidget(
      text: 'Request new code',
      isBigButton: true,
      onTap: () => authProvider.sendCodeForPasswordRecovery(
        ((model) {
          if(model != null) {
            if (model.status == true) {
              pressingTheTimerButton();
              authProvider.setCode(model.verificationCode.toString());
            } else {
              messageDialogsProvider.informationWindow(
                context: context,
                title: model.message ?? 'Error',
                textButton: 'OK',
              );
            }
          } else {
            messageDialogsProvider.informationWindow(
              context: context,
              title: 'Try again later',
              textButton: 'OK',
            );
          }
        }),
      ),
    ) :
    SizedBox(
      height: 7.h,
      child: Center(
        child: Text(
          'Request new code, after $start seconds.',
          style: TextStyle(
            fontFamily: ConstantsFonts.latoRegular,
            fontSize: 12.sp,
            color: const Color.fromRGBO(130, 130, 130, 1),
          ),
        ),
      ),
    );
  }
}
