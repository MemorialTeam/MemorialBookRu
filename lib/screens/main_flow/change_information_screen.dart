import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:memorial_book/provider/auth_provider.dart';
import 'package:memorial_book/widgets/memorial_app_bar.dart';
import 'package:memorial_book/widgets/main_button.dart';
import 'package:memorial_book/widgets/unscope_scaffold.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../../helpers/constants.dart';
import '../../models/user/response/user_info_response_model.dart';
import '../../provider/account_provider.dart';
import '../../widgets/platform_scroll_physics.dart';
import '../../widgets/skeleton_loader_widget.dart';
import '../../widgets/text_field_profile_widget.dart';

class ChangeInformationScreen extends StatefulWidget {
  const ChangeInformationScreen({
    Key? key,
    required this.model,
  }) : super(key: key);

  final UserInformation model;

  @override
  State<ChangeInformationScreen> createState() => _ChangeInformationScreenState();
}

class _ChangeInformationScreenState extends State<ChangeInformationScreen> {

  Future invitationBox(
      BuildContext context,
      bool toShowDesc,
      ) {
    return showDialog(
        context: context,
        builder: (_) => AlertDialog(
          insetPadding: EdgeInsets.symmetric(
            horizontal: 3.2.w,
          ),
          contentPadding: EdgeInsets.zero,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            ),
          ),
          content: Builder(
            builder: (context) {
              var width = MediaQuery.of(context).size.width;
              return Container(
                width: width,
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 16,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Invitation',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 17.sp,
                      ),
                    ),
                    SizedBox(
                      height: 1.2.h,
                    ),
                    SizedBox(
                      width: 68.w,
                      child: Text(
                        'Enrich the service together with friends and loved ones',
                        style: TextStyle(
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 3.8.h,
                    ),
                    Text(
                      'E-mail:',
                      style: TextStyle(
                        fontSize: 9.5.sp,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey.shade500,
                      ),
                    ),
                    SizedBox(
                      height: 0.7.h,
                    ),
                    TextFieldProfileWidget(
                      controller: TextEditingController(),
                    ),
                    SizedBox(
                      height: 2.6.h,
                    ),
                    Container(
                      height: 5.3.h,
                      width: 25.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(7),
                        color: const Color.fromRGBO(23, 94, 217, 1),
                      ),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(7),
                          onTap: () {

                          },
                          child: Center(
                            child: Text(
                              'SEND',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                fontSize: 10.5.sp,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 3.4.h,
                    ),
                    Text(
                      'Related profiles',
                      style: TextStyle(
                        fontSize: 9.5.sp,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey.shade500,
                      ),
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: List.generate(
                        2, (index) => Padding(
                        padding: EdgeInsets.only(
                          top: 1.4.h,
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.asset(
                              ConstantsAssets.avatarTestImage,
                              height: 3.4.h,
                              width: 3.4.h,
                            ),
                            SizedBox(
                              width: 3.w,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Алексей В.Н.',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 9.5.sp,
                                  ),
                                ),
                                SizedBox(
                                  height: 0.4.h,
                                ),
                                Text(
                                  index.isEven ?
                                  'Admin' :
                                  'Pending for confirmation',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 9.5.sp,
                                    color: index.isEven ?
                                    Colors.grey.shade500 :
                                    const Color.fromRGBO(211, 133, 15, 1),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        )
    );
  }

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController newPassController = TextEditingController();
  final TextEditingController repeatPassController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final accountProvider = Provider.of<AccountProvider>(context);
    return MemorialAppBar(
      automaticallyImplyBackLeading: true,
      child: UnScopeScaffold(
        backgroundColor: const Color.fromRGBO(245, 247, 249, 1),
        body: Form(
          onChanged: () => authProvider.stateChange(),
          child: ListView(
            physics: platformScrollPhysics(),
            children: [
              SizedBox(
                height: 1.7.h,
              ),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: const Color.fromRGBO(255, 255, 255, 1),
                ),
                padding: EdgeInsets.all(
                  2.h,
                ),
                margin: EdgeInsets.symmetric(
                  horizontal: 3.2.w,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Stack(
                        children: [
                          CircleAvatar(
                            radius: 8.h,
                            backgroundColor: const Color.fromRGBO(217, 217, 217, 1),
                            child: accountProvider.avatar == null ?
                            widget.model.avatar != null && widget.model.avatar != '' ?
                            CachedNetworkImage(
                              imageUrl: widget.model.avatar ?? '',
                              imageBuilder: (context, imageProvider) {
                                return Container(
                                  height: double.infinity,
                                  width: double.infinity,
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
                                  height: double.infinity,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                      image: AssetImage(ConstantsAssets.memorialBookLogoImage),
                                    ),
                                  ),
                                );
                              },
                              placeholder: (context, indicator) {
                                return const SkeletonLoaderWidget(
                                  height: double.infinity,
                                  width: double.infinity,
                                  borderRadius: 50,
                                );
                              },
                            ) :
                            Center(
                              child: Icon(
                                Icons.camera_alt_rounded,
                                size: 53.sp,
                                color: const Color.fromRGBO(186, 186, 186, 1),
                              ),
                            ) :
                            Container(
                              height: double.infinity,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  image: FileImage(
                                    accountProvider.avatar!,
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 0.1.h,
                            right: 0.2.w,
                            child: Container(
                              height: 5.2.h,
                              width: 5.2.h,
                              child: Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  onTap: () {
                                    accountProvider.pickAvatar();
                                  },
                                  borderRadius: BorderRadius.circular(50),
                                  child: Center(
                                    child: Icon(
                                      Icons.photo_camera,
                                      color: const Color.fromARGB(255, 255, 255, 255),
                                      size: 17.sp,
                                    ),
                                  ),
                                ),
                              ),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  width: 3,
                                  color: const Color.fromARGB(255, 17, 106, 189),
                                ),
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(50),
                                ),
                                color: const Color.fromARGB(255, 17, 106, 189),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 3.6.h,
                    ),
                    Text(
                      'Первичная информация',
                      style: TextStyle(
                        fontSize: 17.5.sp,
                        fontFamily: ConstantsFonts.latoBlack,
                      ),
                    ),
                    SizedBox(
                      height: 3.6.h,
                    ),
                    Text(
                      'Полное имя:',
                      style: TextStyle(
                        fontFamily: ConstantsFonts.latoRegular,
                        fontSize: 9.5.sp,
                        color: const Color.fromRGBO(32, 30, 31, 0.5),
                      ),
                    ),
                    SizedBox(
                      height: 0.5.h,
                    ),
                    TextFieldProfileWidget(
                      controller: usernameController,
                      hintText: widget.model.username,
                    ),
                    SizedBox(
                      height: 3.1.h,
                    ),
                    Text(
                      'E-mail:',
                      style: TextStyle(
                        fontFamily: ConstantsFonts.latoRegular,
                        fontSize: 9.5.sp,
                        color: const Color.fromRGBO(32, 30, 31, 0.5),
                      ),
                    ),
                    SizedBox(
                      height: 0.5.h,
                    ),
                    TextFieldProfileWidget(
                      controller: emailController,
                      hintText: widget.model.email,
                    ),
                    SizedBox(
                      height: 3.1.h,
                    ),
                    Text(
                      'Новый пароль:',
                      style: TextStyle(
                        fontFamily: ConstantsFonts.latoRegular,
                        fontSize: 9.5.sp,
                        color: const Color.fromRGBO(32, 30, 31, 0.5),
                      ),
                    ),
                    SizedBox(
                      height: 0.5.h,
                    ),
                    TextFieldProfileWidget(
                      controller: newPassController,
                    ),
                    SizedBox(
                      height: 3.1.h,
                    ),
                    Text(
                      'Повторите пароль:',
                      style: TextStyle(
                        fontFamily: ConstantsFonts.latoRegular,
                        fontSize: 9.5.sp,
                        color: const Color.fromRGBO(32, 30, 31, 0.5),
                      ),
                    ),
                    SizedBox(
                      height: 0.5.h,
                    ),
                    TextFieldProfileWidget(
                      controller: repeatPassController,
                    ),
                    SizedBox(
                      height: 3.1.h,
                    ),
                    MainButton(
                      text: 'СОХРАНИТЬ ИЗМЕНЕНИЯ',
                      onTap: () => accountProvider.updatingUserInformation(
                        context,
                        usernameController.text == '' ?
                        widget.model.username ?? '' :
                        usernameController.text,
                        emailController.text == '' ?
                        widget.model.email ?? '' :
                        emailController.text,
                        newPassController.text,
                        repeatPassController.text,
                        accountProvider.avatar,
                      ),
                      condition: newPassController.text == repeatPassController.text,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 2.4.h,
              ),
              Center(
                child: Text(
                  'Удалить учетную запись',
                  style: TextStyle(
                    color: const Color.fromRGBO(32, 30, 31, 0.5),
                    fontSize: 11.5.sp,
                    fontFamily: ConstantsFonts.latoRegular
                  ),
                ),
              ),
              SizedBox(
                height: 2.4.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
