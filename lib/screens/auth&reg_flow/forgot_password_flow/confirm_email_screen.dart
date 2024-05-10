import 'package:flutter/cupertino.dart';
import 'package:memorial_book/provider/auth_provider.dart';
import 'package:memorial_book/provider/message_dialogs_provider.dart';
import 'package:memorial_book/screens/auth&reg_flow/forgot_password_flow/auth&reg_frame.dart';
import 'package:memorial_book/screens/auth&reg_flow/forgot_password_flow/confirm_code_screen.dart';
import 'package:memorial_book/screens/auth&reg_flow/login_screen.dart';
import 'package:memorial_book/widgets/main_button.dart';
import 'package:memorial_book/widgets/unscope_scaffold.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../../../widgets/custom_text_field_for_more_registration_screens_widget.dart';
import '../../../widgets/text_button_widget.dart';

class ConfirmEmailScreen extends StatefulWidget {
  const ConfirmEmailScreen({super.key});

  @override
  State<ConfirmEmailScreen> createState() => _ConfirmEmailScreenState();
}

class _ConfirmEmailScreenState extends State<ConfirmEmailScreen> {
  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final messageDialogsProvider = Provider.of<MessageDialogsProvider>(context);
    return UnScopeScaffold(
      backgroundColor: const Color.fromRGBO(245, 247, 249, 1),
      body: AuthRegFrame(
        title: 'Forgot your password?',
        description: 'It happens! Just confirm your email and we\'ll send you a code to create a brand new password.',
        body: Form(
          onChanged: () => setState(() {}),
          child: Column(
            children: [
              SizedBox(
                height: 2.h,
              ),
              CustomTextFieldForMoreRegistrationScreensWidget(
                keyboardType: TextInputType.text,
                hintText: 'Enter your email',
                obscureText: false,
                controller: emailController,
              ),
              SizedBox(
                height: 2.h,
              ),
              MainButton(
                text: 'Continue',
                condition: emailController.text.isNotEmpty && RegExp('@').firstMatch(emailController.text) != null,
                onTap: () async {
                  authProvider.setEmail(emailController.text);
                  await authProvider.sendCodeForPasswordRecovery((model) async {
                    if(model != null) {
                      if(model.status == true) {
                        await Navigator.push(
                          context,
                          CupertinoPageRoute(
                            builder: (context) => const ConfirmCodeScreen(),
                          ),
                        );
                      } else {
                        await messageDialogsProvider.informationWindow(
                          context: context,
                          title: model.message ?? 'Error',
                          textButton: 'OK',
                        );
                      }
                    } else {
                      await messageDialogsProvider.informationWindow(
                        context: context,
                        title: 'Try again later',
                        textButton: 'OK',
                      );
                    }
                  });
                },
              ),
              SizedBox(
                height: 2.h,
              ),
              TextButtonWidget(
                text: 'I remembered the password',
                onTap: () async => Navigator.pushAndRemoveUntil(
                  context,
                  CupertinoDialogRoute(
                    builder: (context) => const LoginScreen(),
                    context: context,
                  ),
                  ((route) => false),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
