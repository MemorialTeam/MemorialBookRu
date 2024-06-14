import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
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
import '../../widgets/skeleton_loader_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  @override
  void initState() {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    FirebaseMessagingManager.init();
    FirebaseMessagingManager.getFCMToken();
    authProvider.initHUDConfig();
    authProvider.requestDeviceInfo();
    super.initState();
  }

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  bool passwordState = true;

  ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final tabBarProvider = Provider.of<TabBarProvider>(context);
    return UnScopeScaffold(
      backgroundColor: const Color.fromRGBO(245, 247, 249, 1),
      body: AuthRegFrame(
        controller: scrollController,
        title: 'Вход',
        body: Form(
          key: _formKey,
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
                validate: (value) {
                  if(value == null || value.isEmpty) {
                    return 'Почта не может быть пустой';
                  } else if(!value.contains('@')) {
                    return 'Не правильный формат почты';
                  }
                  return null;
                },
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
                validate: (value) {
                  if(value == null || value.isEmpty) {
                    return 'Введите Ваш пароль';
                  } else if(value.length < 6) {
                    return 'Пароль должен содержать не менее 6 символов';
                  }
                  return null;
                },
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
                condition: emailController.text.isNotEmpty && passController.text.isNotEmpty,
                onTap: () async {
                  FocusScope.of(context).unfocus();
                  if(_formKey.currentState!.validate()) {
                    await authProvider.signIn(
                      context,
                      emailController.text,
                      passController.text,
                    );
                    tabBarProvider.tabBarDispose();
                  }
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
              Row(
                children: [
                  Expanded(
                    child: MainButton(
                      onTap: () async {
                        FocusScope.of(context).unfocus();
                        Future.delayed(
                          const Duration(
                            milliseconds: 500,
                          ),
                        ).whenComplete(
                          (() {
                            authProvider.signAsGuest(context);
                            tabBarProvider.tabBarDispose();
                          }),
                        );
                      },
                      activeColor: const Color.fromRGBO(51, 51, 51, 1),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
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
                              color: Colors.white,
                              fontFamily: ConstantsFonts.latoRegular,
                              fontSize: 12.sp,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 2.4.w,
                  ),
                  Expanded(
                    child: MainButton(
                      onTap: () async {
                        FocusScope.of(context).unfocus();
                        await authProvider.signIn(
                          context,
                          'p4elka872209@gmail.com',
                          'Vvadik28',
                        );
                        tabBarProvider.tabBarDispose();
                      },
                      activeColor: const Color.fromRGBO(87, 167, 109, 1),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CachedNetworkImage(
                            imageUrl: 'https:\/\/memorialbook.site\/storage\/335\/conversions\/1000000068-thumb.jpg',
                            imageBuilder: (context, imageProvider) {
                              return Container(
                                height: 3.4.h,
                                width: 3.4.h,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                    image: imageProvider,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              );
                            },
                            errorWidget: (context, error, _) {
                              return Container(
                                height: 3.4.h,
                                width: 3.4.h,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                    image: AssetImage(ConstantsAssets.memorialBookLogoImage),
                                  ),
                                ),
                              );
                            },
                            placeholder: (context, indicator) {
                              return SkeletonLoaderWidget(
                                height: 3.4.h,
                                width: 3.4.h,
                                borderRadius: 50,
                              );
                            },
                          ),
                          SizedBox(
                            width: 2.w,
                          ),
                          Text(
                            'Войти как Iryna',
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: ConstantsFonts.latoRegular,
                              fontSize: 12.sp,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 1.6.h,
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
                          CupertinoDialogRoute(
                            builder: (context) => const TermsAndConditionsScreen(
                              isConfirm: true,
                            ),
                            context: context,
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
              SizedBox(
                height: 1.8.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
