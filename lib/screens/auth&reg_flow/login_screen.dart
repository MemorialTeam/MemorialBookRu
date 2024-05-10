import 'package:memorial_book/provider/tab_bar_provider.dart';
import 'package:memorial_book/screens/auth&reg_flow/forgot_password_flow/auth&reg_frame.dart';
import 'package:memorial_book/screens/auth&reg_flow/forgot_password_flow/confirm_email_screen.dart';
import 'package:memorial_book/widgets/main_button.dart';
import '../../widgets/custom_text_field_for_more_registration_screens_widget.dart';
import 'package:memorial_book/screens/terms_and_conditions_screen.dart';
import 'package:memorial_book/widgets/text_button_widget.dart';
import 'package:memorial_book/widgets/unscope_scaffold.dart';
import 'package:memorial_book/helpers/constants.dart';
import '../../managers/messaging_manager.dart';
import '../../provider/auth_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../widgets/obscure_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  @override
  void initState() {
    final _authProvider = Provider.of<AuthProvider>(context, listen: false);
    FirebaseMessagingManager.init();
    FirebaseMessagingManager.getFCMToken();
    _authProvider.initHUDConfig();
    _authProvider.requestDeviceInfo();
    super.initState();
  }

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();

  bool passwordState = true;

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final tabBarProvider = Provider.of<TabBarProvider>(context);
    return UnScopeScaffold(
      backgroundColor: const Color.fromRGBO(245, 247, 249, 1),
      body: AuthRegFrame(
        title: 'Вход',
        body: Form(
          onChanged: () => setState(() {}),
          child: Column(
            children: [
              SizedBox(
                height: 2.h,
              ),
              CustomTextFieldForMoreRegistrationScreensWidget(
                keyboardType: TextInputType.text,
                hintText: 'Введите email',
                obscureText: false,
                controller: emailController,
              ),
              SizedBox(
                height: 2.h,
              ),
              CustomTextFieldForMoreRegistrationScreensWidget(
                keyboardType: TextInputType.text,
                hintText: 'Введите пароль',
                obscureText: passwordState,
                controller: passController,
                showHide: ObscureWidget(
                  state: passwordState,
                  controller: passController,
                  onTap: () => setState(() => passwordState = !passwordState),
                ),
              ),
              SizedBox(
                height: 2.h,
              ),
              MainButton(
                text: 'Продолжить',
                condition: emailController.text.isNotEmpty && passController.text.length > 5,
                onTap: () async {
                  await authProvider.signIn(
                    context,
                    emailController.text,
                    passController.text,
                  );
                  tabBarProvider.tabBarDispose();
                },
              ),
              SizedBox(
                height: 2.h,
              ),
              Center(
                child: Text(
                  'или',
                  style: TextStyle(
                    fontFamily: ConstantsFonts.latoRegular,
                    fontSize: 11.5.sp,
                    color: const Color.fromRGBO(0, 0, 0, 1),
                  ),
                ),
              ),
              SizedBox(
                height: 2.h,
              ),
              Container(
                height: 7.h,
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(51, 51, 51, 1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {
                      authProvider.signAsGuest(context);
                      tabBarProvider.tabBarDispose();
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          ConstantsAssets.profileImage,
                          color: const Color.fromRGBO(255, 255, 255, 1),
                          height: 3.4.h,
                          width: 3.4.h,
                        ),
                        SizedBox(
                          width: 2.6.w,
                        ),
                        Text(
                          'Войти как гость',
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontFamily: ConstantsFonts.latoRegular,
                            color: const Color.fromRGBO(255, 255, 255, 1),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 1.8.h,
              ),
              RichText(
                text: TextSpan(
                  text: 'Нет учетной записи?',
                  style: TextStyle(
                    fontFamily: ConstantsFonts.latoRegular,
                    fontSize: 11.sp,
                    color: const Color.fromRGBO(51, 51, 51, 1),
                  ),
                  children: [
                    WidgetSpan(
                      child: TextButtonWidget(
                        text: 'Зарегистрироваться',
                        onTap: () => Navigator.push(
                          context,
                          CupertinoPageRoute(
                            builder: (context) => const TermsAndConditionsScreen(
                              isConfirm: true,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 1.8.h,
              ),
              TextButtonWidget(
                text: 'Забыли свой пароль?',
                onTap: () => Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (context) => const ConfirmEmailScreen(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
