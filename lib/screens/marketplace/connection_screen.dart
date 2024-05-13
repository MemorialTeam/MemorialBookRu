import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../helpers/constants.dart';

class ConnectionScreen extends StatelessWidget {
  const ConnectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 3.w,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 5.h,
                width: 5.h,
                child: CircularProgressIndicator(
                  color: Color.fromRGBO(171, 255, 86, 1),
                  strokeWidth: 2.w,
                ),
              ),
              SizedBox(
                height: 1.8.h,
              ),
              Text(
                'Перенаправление на платёжный шлюз. пожалуйста подождите',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: ConstantsFonts.latoSemiBold,
                  fontSize: 17.sp,
                  color: const Color.fromRGBO(0, 0, 0, 1),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
