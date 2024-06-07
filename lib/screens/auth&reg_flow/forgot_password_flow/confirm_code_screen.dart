import 'package:flutter/cupertino.dart';
import 'package:memorial_book/screens/auth&reg_flow/forgot_password_flow/confirm_new_password_screen.dart';
import 'package:memorial_book/widgets/main_button.dart';
import 'package:memorial_book/widgets/retry_code_widget.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../../../provider/auth_provider.dart';
import '../../../widgets/custom_text_field_for_more_registration_screens_widget.dart';
import '../../../widgets/text_button_widget.dart';
import '../../../widgets/unscope_scaffold.dart';
import '../login_screen.dart';
import 'auth&reg_frame.dart';

class ConfirmCodeScreen extends StatefulWidget {
  const ConfirmCodeScreen({super.key});

  @override
  State<ConfirmCodeScreen> createState() => _ConfirmCodeScreenState();
}

class _ConfirmCodeScreenState extends State<ConfirmCodeScreen> {
  final TextEditingController codeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    return UnScopeScaffold(
      backgroundColor: const Color.fromRGBO(245, 247, 249, 1),
      body: AuthRegFrame(
        title: 'Please check your email',
        description: 'We have sent an email with the code to ${authProvider.emailConfirm} To reset the password.',
        body: Form(
          onChanged: () => setState(() {}),
          child: Column(
            children: [
              SizedBox(
                height: 2.h,
              ),
              CustomTextFieldForMoreRegistrationScreensWidget(
                keyboardType: TextInputType.text,
                hintText: 'Enter code',
                obscureText: false,
                controller: codeController,
              ),
              const RetryCodeWidget(),
              MainButton(
                text: 'Продолжить',
                condition: codeController.text == authProvider.codeConfirm,
                onTap: () => Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (context) => const ConfirmNewPasswordScreen(),
                  ),
                ),
              ),
              TextButtonWidget(
                text: 'I remembered the password',
                isBigButton: true,
                onTap: () => Navigator.pushAndRemoveUntil(
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
