import 'package:flutter/material.dart';
import 'package:memorial_book/helpers/constants.dart';
import 'package:memorial_book/provider/auth_provider.dart';
import 'package:memorial_book/provider/message_dialogs_provider.dart';
import 'package:memorial_book/screens/auth&reg_flow/forgot_password_flow/auth&reg_frame.dart';
import 'package:memorial_book/widgets/main_button.dart';
import 'package:memorial_book/widgets/unscope_scaffold.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../../provider/account_provider.dart';
import '../../widgets/custom_text_field_for_more_registration_screens_widget.dart';
import '../../widgets/text_button_widget.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    final authProvider = Provider.of<AuthProvider>(
      context,
      listen: false,
    );
    authProvider.clearRegControllers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final accountProvider = Provider.of<AccountProvider>(context);
    final messageDialogsProvider = Provider.of<MessageDialogsProvider>(context);
    return UnScopeScaffold(
      backgroundColor: const Color.fromRGBO(245, 247, 249, 1),
      floatingActionButton: Align(
        alignment: Alignment.topLeft,
        child: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () => Navigator.pop(context),
          child: Padding(
            padding: const EdgeInsets.only(
              left: 31,
              top: 70,
            ),
            child: Image.asset(
              ConstantsAssets.leadingBackImage,
              width: 20,
              height: 16,
            ),
          ),
        ),
      ),
      body: Form(
        key: _formKey,
        child: AuthRegFrame(
          title: 'Регистрация',
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 2.h,
              ),
              CustomTextFieldForMoreRegistrationScreensWidget(
                keyboardType: TextInputType.text,
                hintText: 'Введите имя пользователя',
                obscureText: false,
                validate: (value) {
                  if(value == null || value.isEmpty) {
                    return 'Имя не может быть пустым';
                  } else if(value.length < 3) {
                    return 'Имя должно содержать более 3 символов';
                  }
                  return null;
                },
                controller: authProvider.regUsernameController,
              ),
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
                controller: authProvider.regEmailController,
              ),
              SizedBox(
                height: 2.h,
              ),
              CustomTextFieldForMoreRegistrationScreensWidget(
                keyboardType: TextInputType.text,
                hintText: 'Введите пароль',
                obscureText: false,
                validate: (value) {
                  if(value == null || value.isEmpty) {
                    return 'Введите какой-нибудь пароль';
                  } else if(value.length < 6) {
                    return 'Пароль должен содержать не менее 6 символов';
                  }
                  return null;
                },
                controller: authProvider.regPasswordController,
              ),
              SizedBox(
                height: 2.h,
              ),
              CustomTextFieldForMoreRegistrationScreensWidget(
                keyboardType: TextInputType.text,
                hintText: 'Повторите пароль',
                obscureText: false,
                validate: (value) {
                  if(value == null || value.isEmpty) {
                    return 'Повторите пароль';
                  } else if(value != authProvider.regPasswordController.text) {
                    return 'Пароли не совпадают';
                  }
                  return null;
                },
                controller: authProvider.regRepeatPasswordController,
              ),
              SizedBox(
                height: 2.h,
              ),
              MainButton(
                text: 'Продолжить',
                // condition: authProvider.checkRegistration() == true,
                onTap: () {
                  if (_formKey.currentState!.validate()) {
                    authProvider.signUp(context, authProvider.regUsernameController.text, authProvider.regEmailController.text, authProvider.regRepeatPasswordController.text, (model) async {
                      if(model != null) {
                        if(model.status == true) {
                          return accountProvider.setLoading();
                        } else {
                          return messageDialogsProvider.informationWindow(
                            context: context,
                            title: model.message ?? 'Something went wrong...\Try again later',
                            textButton: 'OK',
                          );
                        }
                      }
                      else {
                        return messageDialogsProvider.informationWindow(
                          context: context,
                          title: 'Something went wrong...\Try again later',
                          textButton: 'OK',
                        );
                      }
                    });
                  }
                },
              ),
              SizedBox(
                height: 2.h,
              ),
              RichText(
                text: TextSpan(
                  text: 'У меня есть аккаунт,',
                  style: TextStyle(
                    fontFamily: ConstantsFonts.latoRegular,
                    fontSize: 11.sp,
                    color: const Color.fromRGBO(51, 51, 51, 1),
                  ),
                  children: [
                    WidgetSpan(
                      child: TextButtonWidget(
                        text: 'Войти',
                        onTap: () => Navigator.pop(context),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 2.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
