import 'package:country_codes/country_codes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svprogresshud/flutter_svprogresshud.dart';
import 'package:memorial_book/data_handler/service.dart';
import 'package:memorial_book/models/auth/requests/password_recovery_request_model.dart';
import 'package:memorial_book/screens/defining_flow_account.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import '../data_handler/mapper.dart';
import '../data_handler/meta_device_data.dart';
import '../helpers/constants.dart';
import '../models/auth/requests/sign_up_request_model.dart';
import '../models/auth/responses/send_code_for_password_recovery_response_model.dart';
import '../models/auth/responses/sign_up_response_model.dart';
import '../models/common/device_info_model.dart';
import '../models/common/status_response_model.dart';
import '../screens/auth&reg_flow/login_screen.dart';

class AuthProvider extends ChangeNotifier {
  String newUser = '';
  String tokenUser = '';
  String userRules = '';

  final TextEditingController regUsernameController = TextEditingController();
  final TextEditingController regEmailController = TextEditingController();
  final TextEditingController regPasswordController = TextEditingController();
  final TextEditingController regRepeatPasswordController = TextEditingController();

  late DeviceInfoModel device;

  final service = Service();
  final mapper = Mapper();

  get getTokenUser => tokenUser;
  get getUserRules => userRules;

  void initHUDConfig() {
    SVProgressHUD.setDefaultStyle(SVProgressHUDStyle.light);
    SVProgressHUD.setDefaultMaskType(SVProgressHUDMaskType.black);
    SVProgressHUD.setDefaultAnimationType(SVProgressHUDAnimationType.flat);
    SVProgressHUD.setMinimumSize(const Size(0.0, 0.0));
    SVProgressHUD.setBackgroundColor(const Color.fromRGBO(23, 94, 217, 1));
    SVProgressHUD.setRingThickness(2);
    SVProgressHUD.setRingRadius(18);
    SVProgressHUD.setRingNoTextRadius(24);
    SVProgressHUD.setCornerRadius(14);
    SVProgressHUD.setHapticsEnabled(false);
  }

  Future dialogMessage(
      String title,
      BuildContext context,
      ) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Container(
            margin: const EdgeInsets.symmetric(
              horizontal: 20.0,
            ),
            decoration: BoxDecoration(
              color: const Color.fromRGBO(245, 247, 249, 1),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    top: 19.0,
                    bottom: 10.0,
                  ),
                  child: Column(
                    children: [
                      Text(
                        title,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: ConstantsFonts.latoBold,
                          color: const Color.fromRGBO(33, 33, 33, 1),
                          fontSize: 14.sp,
                        ),
                      ),
                      const SizedBox(
                        height: 26.0,
                      ),
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Container(
                          height: 45.0,
                          margin: const EdgeInsets.symmetric(
                            horizontal: 20.0,
                          ),
                          decoration: const BoxDecoration(
                            color: Color.fromRGBO(23, 94, 217, 1),
                            borderRadius: BorderRadius.all(
                              Radius.circular(10.0),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              'Ok',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 11.5.sp,
                                fontFamily: ConstantsFonts.latoRegular,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 2.0,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void stateChange() {
    notifyListeners();
  }

  void requestDeviceInfo() {
    MetaDeviceData().getDeviceInfoData(
      ((info) async {
        if (info != null) {
          device = info;
          notifyListeners();
        }
      }),
    );
  }

  bool checkRegistration() {
    if(regUsernameController.text.isNotEmpty &&
        regEmailController.text.isNotEmpty &&
        regRepeatPasswordController.text.isNotEmpty &&
        regRepeatPasswordController.text.isNotEmpty &&
        regPasswordController.text == regRepeatPasswordController.text) {
      return true;
    } else {
      return false;
    }
  }

  void defineRole() async {
    final storage = await SharedPreferences.getInstance();

    tokenUser = storage.getString(ConstantsKeys.userTOKEN) ?? '';
    userRules = storage.getString(ConstantsKeys.userRules) ?? '';
    notifyListeners();
  }

  void showOnboardingForNewFag() async {
    final storage = await SharedPreferences.getInstance();

    newUser = storage.getString(ConstantsKeys.newUser) ?? 'new';
    notifyListeners();
  }

  void setOldUser() async {
    final storage = await SharedPreferences.getInstance();
    await storage.setString(ConstantsKeys.newUser, 'old');
  }

  void signUp(BuildContext context, String username, String email, String password, ValueSetter<SignUpResponseModel?> completion) async {
    try {
      SVProgressHUD.show();
      await CountryCodes.init();
      final Locale? deviceLocale = CountryCodes.getDeviceLocale();
      String? countryCode = deviceLocale?.languageCode;

      final SharedPreferences storage = await SharedPreferences.getInstance();
      final String fcmToken = storage.getString(ConstantsKeys.fcm) ?? '';

      final requestModel = SignUpRequestModel(
        username: username,
        email: email,
        password: password,
        passwordConfirmation: password,
        fcmToken: fcmToken,
        deviceName: device.type,
        location: countryCode ?? 'none',
      );
      service.signUpRequest(requestModel, (response) {
        mapper.signUpResponse(response, (model) async {
          SVProgressHUD.dismiss();
          if(model != null) {
            if(model.status == true){
              final storage = await SharedPreferences.getInstance();
              await storage.setString(ConstantsKeys.userRules, 'authorized');
              userRules = 'authorized';
              notifyListeners();
              await storage.setString(ConstantsKeys.userTOKEN, model.token ?? '').whenComplete(() => Navigator.push(
                context,
                CupertinoPageRoute(
                  builder: (context) => DefiningFlowAccount(
                    userToken: model.token ?? '',
                    userRules: userRules,
                  ),
                ),
              ));
            }
            completion(model);
          }
          else {
            completion(null);
          }
        });
      });
    }
    catch (error) {
      print('the following error occurred (sign up request) ---> $error');
    }

  }

  Future signIn(
      BuildContext context,
      String email,
      String password,
      ) async {
    SVProgressHUD.show();
    try {
      final SharedPreferences storage = await SharedPreferences.getInstance();
      final String fcmToken = storage.getString(ConstantsKeys.fcm) ?? '';

      final requestModel = SignUpRequestModel(
        email: email,
        password: password,
        fcmToken: fcmToken,
        deviceName: device.type,
      );
      service.signInRequest(requestModel, (response) {
        SVProgressHUD.dismiss();
        mapper.signUpResponse(response, (model) async {
          if(model != null) {
            if(model.status == true) {
              final storage = await SharedPreferences.getInstance();
              await storage.setString(ConstantsKeys.userRules, 'authorized');
              userRules = 'authorized';
              notifyListeners();
              await storage.setString(ConstantsKeys.userTOKEN, model.token ?? '')
                  .whenComplete(
                    () => Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (context) => DefiningFlowAccount(
                      userToken: model.token ?? '',
                      userRules: userRules,
                    ),
                  ),
                ),
              );
            } else {
              dialogMessage(
                model.message ?? 'error',
                context,
              );
            }
          }
        },
        );
      },
      );
    } catch (error) {
      SVProgressHUD.dismiss();
      print('the following error occurred (sign up request) ---> $error');
    }

  }

  void signAsGuest(BuildContext context) async {
    final SharedPreferences storage = await SharedPreferences.getInstance();
    await storage.setString(ConstantsKeys.userRules, 'guest');
    await storage.setString(ConstantsKeys.userTOKEN, '');
    userRules = 'guest';
    notifyListeners();
    Navigator.push(
      context,
      CupertinoPageRoute(
        builder: (context) => DefiningFlowAccount(
          userToken: '',
          userRules: userRules,
        ),
      ),
    );
  }

  void logoutAuthorized(
      BuildContext context,
      ) async {
    SVProgressHUD.show();

    service.logoutRequest((response) {
      SVProgressHUD.dismiss();
      mapper.logoutResponse(response, (model) async {
        if(response != null) {
          final storage = await SharedPreferences.getInstance();
          await storage.setString(ConstantsKeys.userTOKEN, '');
          await storage.setString(ConstantsKeys.userRules, '');
          Navigator.of(context).pushAndRemoveUntil(
            CupertinoPageRoute(
              builder: (_) => const LoginScreen(),
            ),
                (route) => false,
          );
        } else {
          print('error');
        }
      });
    });
  }

  void logoutGuest(
      BuildContext context,
      ) async {
    final storage = await SharedPreferences.getInstance();
    await storage.setString(ConstantsKeys.userTOKEN, '');
    await storage.setString(ConstantsKeys.userRules, '');
    Navigator.of(context).pushAndRemoveUntil(
      CupertinoPageRoute(
        builder: (_) => const LoginScreen(),
      ),
          (route) => false,
    );
  }

  String emailConfirm = '';
  String codeConfirm = '';

  void setEmail(String email) {
    emailConfirm = email;
    notifyListeners();
  }
  void setCode(String code) {
    codeConfirm = code;
    notifyListeners();
  }

  Future sendCodeForPasswordRecovery(ValueSetter<SendCodeForPasswordRecoveryResponseModel?> completion) async {
    SVProgressHUD.show();
    service.sendCodeForPasswordRecoveryRequest(emailConfirm, (response) {
      mapper.sendCodeForPasswordRecoveryResponse(response, (model) {
        SVProgressHUD.dismiss();
        if(model != null) {
          if(model.status == true) {
            setCode(model.verificationCode.toString());
          }
          completion(model);
        } else {
          completion(null);
        }
      });
    });
  }

  Future passwordRecovery(String password, ValueSetter<StatusResponseModel?> completion) async {
    SVProgressHUD.show();

    final PasswordRecoveryRequestModel model = PasswordRecoveryRequestModel(
      email: emailConfirm,
      password: password,
      passwordConfirmation: password,
      verificationCode: codeConfirm,
    );

    service.passwordRecoveryRequest(model, (response) {
      mapper.statusResponse(response, (model) {
        SVProgressHUD.dismiss();
        if(model != null) {
          print(response?.body);
          completion(model);
        } else {
          completion(null);
        }
      });
    });
  }
}