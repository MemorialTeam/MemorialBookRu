import 'package:flutter/material.dart';
import 'package:memorial_book/widgets/memorial_book_icon_widget.dart';
import 'package:memorial_book/widgets/obscure_widget.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../../../provider/auth_provider.dart';
import '../../../provider/message_dialogs_provider.dart';
import '../../../widgets/custom_text_field_for_more_registration_screens_widget.dart';
import '../../../widgets/main_button.dart';
import '../../../widgets/unscope_scaffold.dart';
import 'auth&reg_frame.dart';

class ConfirmNewPasswordScreen extends StatefulWidget {
  const ConfirmNewPasswordScreen({super.key});

  @override
  State<ConfirmNewPasswordScreen> createState() => _ConfirmNewPasswordScreenState();
}

class _ConfirmNewPasswordScreenState extends State<ConfirmNewPasswordScreen> {

  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController repeatedNewPasswordController = TextEditingController();

  bool newPasswordState = true;
  bool repeatedNewPasswordState = true;

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final messageDialogsProvider = Provider.of<MessageDialogsProvider>(context);
    return UnScopeScaffold(
      backgroundColor: const Color.fromRGBO(245, 247, 249, 1),
      body: AuthRegFrame(
        title: 'Enter new password',
        body: Form(
          onChanged: () => setState(() {}),
          child: Column(
            children: [
              SizedBox(
                height: 2.h,
              ),
              CustomTextFieldForMoreRegistrationScreensWidget(
                keyboardType: TextInputType.text,
                hintText: 'Enter your password',
                obscureText: newPasswordState,
                controller: newPasswordController,
                showHide: ObscureWidget(
                  state: newPasswordState,
                  controller: newPasswordController,
                  onTap: () => setState(() => newPasswordState = !newPasswordState),
                ),
              ),
              SizedBox(
                height: 2.h,
              ),
              CustomTextFieldForMoreRegistrationScreensWidget(
                keyboardType: TextInputType.text,
                hintText: 'Enter your password again',
                obscureText: repeatedNewPasswordState,
                controller: repeatedNewPasswordController,
                showHide: ObscureWidget(
                  state: repeatedNewPasswordState,
                  controller: repeatedNewPasswordController,
                  onTap: () => setState(() => repeatedNewPasswordState = !repeatedNewPasswordState),
                ),
              ),
              SizedBox(
                height: 2.h,
              ),
              MainButton(
                text: 'Continue',
                condition: newPasswordController.text == repeatedNewPasswordController.text && newPasswordController.text.isNotEmpty && repeatedNewPasswordController.text.isNotEmpty,
                onTap: () async => await authProvider.passwordRecovery(
                  newPasswordController.text,
                  ((model) async {
                    if(model != null) {
                      if(model.status == true) {
                        await authProvider.signIn(
                          context,
                          authProvider.emailConfirm,
                          newPasswordController.text,
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
                  }),
                ),
              ),
              SizedBox(
                height: 2.h,
              ),
              const MemorialBookIconWidget(
                title: 'In development',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
