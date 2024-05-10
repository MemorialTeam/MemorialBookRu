import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:memorial_book/helpers/constants.dart';
import 'package:memorial_book/widgets/memorial_app_bar.dart';
import 'package:memorial_book/widgets/main_button.dart';
import 'package:sizer/sizer.dart';

import 'auth&reg_flow/registration_screen.dart';

class TermsAndConditionsScreen extends StatelessWidget {
  const TermsAndConditionsScreen({
    Key? key,
    required this.isConfirm,
  }) : super(key: key);

  final bool isConfirm;

  @override
  Widget build(BuildContext context) {
    return MemorialAppBar(
      automaticallyImplyBackLeading: true,
      automaticallyImplyBackTrailing: true,
      child: Scaffold(
        backgroundColor: const Color.fromRGBO(245, 247, 249, 1),
        body: Stack(
          children: [
            ListView(
              physics: const BouncingScrollPhysics(),
              children: [
                SizedBox(
                  height: 1.4.h,
                ),
                Container(
                  color: const Color.fromRGBO(255, 255, 255, 1),
                  padding: EdgeInsets.symmetric(
                    horizontal: 3.w,
                    vertical: 3.2.h,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'DeepL Pro – Terms and Conditions',
                        style: TextStyle(
                          fontSize: 13.5.sp,
                          fontFamily: ConstantsFonts.latoRegular,
                          color: const Color.fromRGBO(32, 30, 31, 1),
                        ),
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      Text(
                        'DeepL SE, Maarweg 165, 50825 Cologne, Germany (“DeepL”) specialises in machine translation services and provides the online translation service deepl.com.',
                        style: TextStyle(
                          height: 0.215.h,
                          fontSize: 11.5.sp,
                          fontFamily: ConstantsFonts.latoRegular,
                          color: const Color.fromRGBO(32, 30, 31, 0.7),
                        ),
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      Text(
                        'Customer wishes to utilize DeepL\'s translation services in its own software products and/or for other business or private purposes. In order to allow Customer to make use of the services, Customer is granted access to the subscribed DeepL Pro Products in accordance with and to the extent of these Terms and Conditions.',
                        style: TextStyle(
                          height: 0.215.h,
                          fontSize: 11.5.sp,
                          fontFamily: ConstantsFonts.latoRegular,
                          color: const Color.fromRGBO(32, 30, 31, 0.7),
                        ),
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      Text(
                        'These DeepL Pro License Terms and Conditions (“Terms and Conditions”) are available at https://www.deepl.com/pro-license.html and can be downloaded and printed by the Customer. DeepL does not save this agreement text after conclusion of the contract.',
                        style: TextStyle(
                          height: 0.215.h,
                          fontSize: 11.5.sp,
                          fontFamily: ConstantsFonts.latoRegular,
                          color: const Color.fromRGBO(32, 30, 31, 0.7),
                        ),
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      Text(
                        '1 Definitions\n1.1 “Agreement“ refers to the agreement between Customer and DeepL concerning the subscription to and the use of DeepL’s Products in accordance with these Terms and Conditions.\n1.2 “API“ refers to the Application Programming Interface provided by DeepL to Customer as set out in the Service Specification and the Documentation provided by DeepL.\n1.3 “API-CAT-Key“ refers to a special license key to connect computer-assisted-translation tools to the API.\n1.4 “API Response” refers to the API’s response to API Requests.\n1.5 “API Request” refers to an HTTP request transmitted by the Application to the API.\n1.6 “Application” refers to the software or service developed by or on behalf of Customer which utilizes the API.',
                        style: TextStyle(
                          height: 0.215.h,
                          fontSize: 11.5.sp,
                          fontFamily: ConstantsFonts.latoRegular,
                          color: const Color.fromRGBO(32, 30, 31, 0.7),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: isConfirm == true ?
                  6.4.h :
                  1.4.h,
                ),
              ],
            ),
            isConfirm == true ?
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 3.w,
                  vertical: 2.h,
                ),
                child: MainButton(
                  text: 'Да, я согласен.',
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      CupertinoPageRoute(
                        builder: (context) => const RegistrationScreen(),
                      ),
                    );
                  },
                ),
              ),
            ) :
            const SizedBox(),
          ],
        ),
      ),
    );
  }
}
