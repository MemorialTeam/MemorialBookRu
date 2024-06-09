import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_multi_formatter/formatters/masked_input_formatter.dart';
import 'package:memorial_book/helpers/constants.dart';
import 'package:memorial_book/helpers/enums.dart';
import 'package:memorial_book/models/catalog/request/edit_post_request_model.dart';
import 'package:memorial_book/provider/message_dialogs_provider.dart';
import 'package:memorial_book/widgets/main_button.dart';
import 'package:memorial_book/widgets/unscope_scaffold.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../../provider/catalog_provider.dart';
import '../../provider/profile_creation_provider.dart';
import '../../widgets/memorial_app_bar.dart';
import '../../widgets/platform_scroll_physics.dart';
import '../../widgets/skeleton_loader_widget.dart';
import '../../widgets/text_field_profile_widget.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({
    Key? key,
    required this.communityId,
    required this.postType,
    this.type,
    this.postId,
  }) : super(key: key);

  final PostType postType;
  final int communityId;
  final int? postId;
  final PostContentType? type;

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {

  late final String titleOfScreen;
  late final String buttonText;

  late final void Function() onTap;

  @override
  void initState() {
    switch(widget.postType) {
      case PostType.addPost:
        titleOfScreen = 'Добавить пост';
        buttonText = 'ДОБАВИТЬ ПОСТ';
        onTap = () {
          final profileCreationProvider = Provider.of<ProfileCreationProvider>(context, listen: false);
          final catalogProvider = Provider.of<CatalogProvider>(context, listen: false);
          final messageDialogsProvider = Provider.of<MessageDialogsProvider>(context, listen: false);
          profileCreationProvider.createPost(
            context,
            widget.communityId,
            ((model) async {
              if(model?.status == true) {
                await catalogProvider.gettingPostsOfCommunity(widget.communityId);
                await Navigator.maybePop(context, true).whenComplete(() => messageDialogsProvider.informationWindow(
                  context: context,
                  title: 'Пост успешно создан',
                  textButton: 'Закрыть',
                ));
              } else {
                await messageDialogsProvider.informationWindow(
                  context: context,
                  title: model?.message ?? 'Что-то пошло не так',
                  textButton: 'Закрыть',
                );
              }
            }),
          );
        };
        break;
      case PostType.editPost:
        titleOfScreen = 'Редактировать пост';
        buttonText = 'СОХРАНИТЬ ИЗМЕНЕНИЯ';
        onTap = () async {
          final profileCreationProvider = Provider.of<ProfileCreationProvider>(context, listen: false);
          final catalogProvider = Provider.of<CatalogProvider>(context, listen: false);
          final messageDialogsProvider = Provider.of<MessageDialogsProvider>(context, listen: false);
          await messageDialogsProvider.theSelectionWindow(
            context: context,
            title: 'Вы уверены, что хотите изменить пост?',
            yesColorButton: const Color.fromRGBO(23, 94, 217, 1),
            yesButton: 'СОХРАНИТЬ ИЗМЕНЕНИЯ',
            noButton: 'Я ПЕРЕДУМАЛ',
            yesOnTap: () async => profileCreationProvider.editPost(
              EditPostRequestModel(
                postId: widget.postId ?? 0,
                communityId: widget.communityId,
                contentType: widget.type ?? PostContentType.textContent,
                title: profileCreationProvider.titleOfCreatePostController.text,
                description: profileCreationProvider.descriptionOfCreatePostController.text,
                postMedia: profileCreationProvider.createPostImagesAndMoves,
                postMediaRemovedIds: profileCreationProvider.removedIndexUrlsPostList,
              ),
              ((model) async {
                Navigator.pop(context);
                if(model?.status == true) {
                  await catalogProvider.gettingPostsOfCommunity(widget.communityId);
                  await Navigator.maybePop(context, true).whenComplete(() => messageDialogsProvider.informationWindow(
                    context: context,
                    title: 'Изменения сохранены',
                    textButton: 'Закрыть',
                  ));
                } else {
                  await messageDialogsProvider.informationWindow(
                    context: context,
                    title: model?.message ?? 'Что-то пошло не так',
                    textButton: 'Закрыть',
                  );
                }
              }),
            ),
          );
        };
        break;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final profileCreationProvider = Provider.of<ProfileCreationProvider>(context);
    return MemorialAppBar(
      automaticallyImplyBackLeading: true,
      child: UnScopeScaffold(
        backgroundColor: const Color.fromRGBO(245, 247, 249, 1),
        body: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 3.2.w,
          ),
          child: ListView(
            physics: platformScrollPhysics(),
            children: [
              SizedBox(
                height: 4.8.h,
              ),
              Text(
                titleOfScreen,
                style: TextStyle(
                  fontFamily: ConstantsFonts.latoBold,
                  fontSize: 20.5.sp,
                  color: const Color.fromRGBO(32, 30, 31, 1),
                ),
              ),
              SizedBox(
                height: 3.6.h,
              ),
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(
                  horizontal: 3.2.w,
                  vertical: 2.6.h,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color.fromRGBO(255, 255, 255, 1),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    widget.type != PostContentType.mediaContent|| widget.type == null ?
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Заголовок:',
                          style: TextStyle(
                            color: const Color.fromRGBO(32, 30, 31, 0.5),
                            fontFamily: ConstantsFonts.latoRegular,
                            fontSize: 9.5.sp,
                          ),
                        ),
                        SizedBox(
                          height: 0.5.h,
                        ),
                        TextFieldProfileWidget(
                          controller: profileCreationProvider.titleOfCreatePostController,
                          hintText: 'Заголовок',
                        ),
                        SizedBox(
                          height: 2.4.h,
                        ),
                        Text(
                          'Описание:',
                          style: TextStyle(
                            color: const Color.fromRGBO(32, 30, 31, 0.5),
                            fontFamily: ConstantsFonts.latoRegular,
                            fontSize: 9.5.sp,
                          ),
                        ),
                        SizedBox(
                          height: 0.5.h,
                        ),
                        TextFieldProfileWidget(
                          controller: profileCreationProvider.descriptionOfCreatePostController,
                          hintText: 'Какое-то описание...',
                          maxLines: 20,
                          minLines: 7,
                        ),
                      ],
                    ) :
                    const SizedBox(),
                    SizedBox(
                      height: 2.4.h,
                    ),
                    widget.type != PostContentType.textContent || widget.type == null ?
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Медиа:',
                          style: ConstantsTextStyles.unRequiredTextStyle,
                        ),
                        SizedBox(
                          height: 1.2.h,
                        ),
                        Container(
                          padding: EdgeInsets.only(
                            left: 1.2.h,
                            right: 0.8.h,
                            top: 0.8.h,
                            bottom: 1.2.h,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: const Color.fromRGBO(205, 209, 214, 1),
                            ),
                            color: const Color.fromRGBO(245, 247, 249, 1),
                          ),
                          child: GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 4,
                              mainAxisSpacing: 0.7.h,
                              crossAxisSpacing: 0.7.h,
                            ),
                            itemBuilder: (context, index) {
                              if(index != profileCreationProvider.createPostImagesAndMoves.length) {
                                if(profileCreationProvider.createPostImagesAndMoves[index].runtimeType.toString() != '_Map<String, dynamic>') {
                                  return Stack(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(
                                          top: 0.4.h,
                                          right: 0.4.h,
                                        ),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: FileImage(profileCreationProvider.createPostImagesAndMoves[index]),
                                              fit: BoxFit.cover,
                                            ),
                                            borderRadius: BorderRadius.circular(5),
                                          ),
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.topRight,
                                        child: Container(
                                          decoration: const BoxDecoration(
                                            boxShadow: [
                                              BoxShadow(
                                                offset: Offset(5, 5),
                                                color: Color.fromRGBO(0, 0, 0, 0.1),
                                                spreadRadius: 0,
                                                blurRadius: 25,
                                              ),
                                            ],
                                            shape: BoxShape.circle,
                                            color: Color.fromRGBO(255, 255, 255, 1),
                                          ),
                                          child: Material(
                                            color: Colors.transparent,
                                            child: InkWell(
                                              onTap: () {
                                                profileCreationProvider.removeImageFromCreatePost(index);
                                              },
                                              borderRadius: BorderRadius.circular(1000),
                                              child: Padding(
                                                padding: EdgeInsets.all(0.36.h),
                                                child: Icon(
                                                  Icons.close,
                                                  size: 16.sp,
                                                  color: const Color.fromRGBO(32, 30, 31, 1),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                } else {
                                  ///url
                                  return Stack(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(
                                          top: 0.4.h,
                                          right: 0.4.h,
                                        ),
                                        child: CachedNetworkImage(
                                          imageUrl: profileCreationProvider.createPostImagesAndMoves[index]['url'],
                                          imageBuilder: (context, image) {
                                            return Container(
                                              decoration: BoxDecoration(
                                                image: DecorationImage(
                                                  image: image,
                                                  fit: BoxFit.cover,
                                                ),
                                                borderRadius: BorderRadius.circular(5),
                                              ),
                                            );
                                          },
                                          placeholder: (context, loading) {
                                            return const SkeletonLoaderWidget(
                                              height: double.infinity,
                                              width: double.infinity,
                                              borderRadius: 5,
                                            );
                                          },
                                          errorWidget: (context, error, _) {
                                            return Container(
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(5),
                                              ),
                                              child: Icon(
                                                Icons.close,
                                                size: 7.sp,
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.topRight,
                                        child: Container(
                                          decoration: const BoxDecoration(
                                            boxShadow: [
                                              BoxShadow(
                                                offset: Offset(5, 5),
                                                color: Color.fromRGBO(0, 0, 0, 0.1),
                                                spreadRadius: 0,
                                                blurRadius: 25,
                                              ),
                                            ],
                                            shape: BoxShape.circle,
                                            color: Color.fromRGBO(255, 255, 255, 1),
                                          ),
                                          child: Material(
                                            color: Colors.transparent,
                                            child: InkWell(
                                              onTap: () {
                                                profileCreationProvider.removeUrlFromEditPost(
                                                  index,
                                                  profileCreationProvider.createPostImagesAndMoves[index]['id'],
                                                );
                                              },
                                              borderRadius: BorderRadius.circular(1000),
                                              child: Padding(
                                                padding: EdgeInsets.all(0.36.h),
                                                child: Icon(
                                                  Icons.close,
                                                  size: 16.sp,
                                                  color: const Color.fromRGBO(32, 30, 31, 1),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                }
                              } else {
                                return Container(
                                  width: 9.h,
                                  height: 9.h,
                                  decoration: BoxDecoration(
                                    color: const Color.fromRGBO(255, 255, 255, 1),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Material(
                                    color: Colors.transparent,
                                    child: InkWell(
                                      borderRadius: BorderRadius.circular(8),
                                      onTap: () {
                                        profileCreationProvider.getImagesInCreatePost(context);
                                      },
                                      child: Center(
                                        child: Icon(
                                          Icons.add,
                                          size: 24.sp,
                                          color: const Color.fromRGBO(229, 232, 235, 1),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }
                            },
                            itemCount: profileCreationProvider.createPostImagesAndMoves.length + 1,
                          ),
                        ),
                      ],
                    ) :
                    const SizedBox(),
                    widget.postType == PostType.addPost ?
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 2.4.h,
                        ),
                        Text(
                          'Задать время публикации:',
                          style: ConstantsTextStyles.unRequiredTextStyle,
                        ),
                        SizedBox(
                          height: 0.5.h,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: TextFieldProfileWidget(
                                onChanged: (text) => setState(() {}),
                                borderColor: profileCreationProvider.creatingPostValidate() ?
                                const Color.fromRGBO(205, 209, 214, 1) :
                                const Color.fromRGBO(250, 18, 46, 1),
                                keyboardType: TextInputType.number,
                                controller: profileCreationProvider.dateOfCreatePostController,
                                hintText: 'дд.мм.гггг',
                                inputFormatters: [
                                  MaskedInputFormatter('##.##.####'),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 2.w,
                            ),
                            Expanded(
                              child: TextFieldProfileWidget(
                                onChanged: (text) => setState(() {}),
                                borderColor: profileCreationProvider.creatingPostValidate() ?
                                const Color.fromRGBO(205, 209, 214, 1) :
                                const Color.fromRGBO(250, 18, 46, 1),
                                keyboardType: TextInputType.number,
                                controller: profileCreationProvider.timeOfCreatePostController,
                                hintText: 'чч:мм',
                                inputFormatters: [
                                  MaskedInputFormatter('##:##'),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 2.4.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              height: 2.8.h,
                              width: 2.8.h,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6),
                                color: profileCreationProvider.isPinned ?
                                const Color.fromRGBO(0, 113, 227, 1)  :
                                const Color.fromRGBO(255, 255, 255, 1),
                                border: Border.all(
                                  color: const Color.fromRGBO(0, 113, 227, 1),
                                ),
                              ),
                              child: Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  onTap: () => profileCreationProvider.switchPinned(),
                                  borderRadius: BorderRadius.circular(6),
                                  child: profileCreationProvider.isPinned ?
                                  Center(
                                    child: Image.asset(
                                      ConstantsAssets.checkMarkImage,
                                      height: 1.3.h,
                                    ),
                                  ) :
                                  null,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 2.w,
                            ),
                            Text(
                              'Закрепить пост',
                              style: ConstantsTextStyles.unRequiredTextStyle,
                            ),
                          ],
                        ),
                      ],
                    ) :
                    const SizedBox(),
                  ],
                ),
              ),
              SizedBox(
                height: 1.2.h,
              ),
              MainButton(
                text: buttonText,
                onTap: onTap,
                textStyle: TextStyle(
                  fontSize: 9.5.sp,
                  color: const Color.fromRGBO(255, 255, 255, 1),
                  fontFamily: ConstantsFonts.latoBold,
                ),
                margin: EdgeInsets.symmetric(
                  horizontal: 15.w,
                  vertical: 2.2.h,
                ),
              ),
              SizedBox(
                height: 1.2.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
