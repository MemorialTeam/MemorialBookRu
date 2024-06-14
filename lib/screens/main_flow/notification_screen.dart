import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:memorial_book/provider/catalog_provider.dart';
import 'package:memorial_book/widgets/memorial_app_bar.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../../helpers/constants.dart';
import '../../models/user/response/get_user_notifications_response_model.dart';
import '../../widgets/animation/punching_animation.dart';
import '../../widgets/boot_engine.dart';
import '../../widgets/platform_scroll_physics.dart';
import '../../widgets/skeleton_loader_widget.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {

  @override
  void initState() {
    final catalogProvider = Provider.of<CatalogProvider>(
      context,
      listen: false,
    );
    catalogProvider.getUserNotifications();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final catalogProvider = Provider.of<CatalogProvider>(context);
    GetUserNotificationsResponseModel? notificationsModel = catalogProvider.userNotifications;
    return MemorialAppBar(
      automaticallyImplyBackLeading: true,
      automaticallyImplyBackTrailing: false,
      child: Scaffold(
        backgroundColor: const Color.fromRGBO(245, 247, 249, 1),
        body: SafeArea(
          child: BootEngine(
            loadValue: catalogProvider.userNotificationsBool,
            loadingFlow: SingleChildScrollView(
              physics: const NeverScrollableScrollPhysics(),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 1.2.h,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 1.4.h,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 3.2.w,
                      ),
                      child: SkeletonLoaderWidget(
                        height: 2.2.h,
                        width: 25.w,
                        borderRadius: 10,
                      ),
                    ),
                    SizedBox(
                      height: 1.2.h,
                    ),
                    ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return SkeletonLoaderWidget(
                          height: index.isEven ?
                          9.4.h :
                          10.4.h,
                          width: double.infinity,
                        );
                      },
                      separatorBuilder: (context, index) {
                        return SizedBox(
                          height: 0.2.h,
                        );
                      },
                      itemCount: 10,
                    ),
                  ],
                ),
              ),
            ),
            activeFlow: SingleChildScrollView(
              physics: platformScrollPhysics(),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 1.2.h,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 1.2.h,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 3.2.w,
                      ),
                      child: Text(
                        'Уведомления',
                        style: TextStyle(
                          fontFamily: ConstantsFonts.latoBold,
                          color: Colors.black,
                          fontSize: 11.5.sp,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 1.2.h,
                    ),
                    ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        final model = notificationsModel!.data![index];
                        return Container(
                          color: const Color.fromRGBO(255, 255, 255, 1),
                          child: PunchingAnimation(
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                borderRadius: BorderRadius.circular(8),
                                onTap: () {},
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 3.6.w,
                                    vertical: 1.2.h,
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      CachedNetworkImage(
                                        imageUrl: model.avatar ?? '',
                                        imageBuilder: (context, imageProvider) {
                                          return Container(
                                            height: 7.h,
                                            width: 7.h,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              image: DecorationImage(
                                                image: imageProvider,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          );
                                        },
                                        errorWidget: (context, indicator, error) {
                                          return Container(
                                            height: 7.h,
                                            width: 7.h,
                                            decoration: const BoxDecoration(
                                              shape: BoxShape.circle,
                                            ),
                                            child: Image.asset(
                                              ConstantsAssets.memorialBookLogoImage,
                                              color: const Color.fromRGBO(23, 94, 217, 1),
                                            ),
                                          );
                                        },
                                        placeholder: (context, indicator) {
                                          return SkeletonLoaderWidget(
                                            height: 7.h,
                                            width: 7.h,
                                            borderRadius: 100,
                                          );
                                        },
                                      ),
                                      SizedBox(
                                        width: 3.8.w,
                                      ),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              model.title ?? '',
                                              style: TextStyle(
                                                fontFamily: ConstantsFonts.latoRegular,
                                                fontSize: 11.5.sp,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 0.6.h,
                                            ),
                                            Text(
                                              model.description ?? '',
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                fontFamily: ConstantsFonts.latoRegular,
                                                fontSize: 9.5.sp,
                                                color: Colors.grey.shade600,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return SizedBox(
                          height: 0.2.h,
                        );
                      },
                      itemCount: catalogProvider.userNotifications?.data?.length ?? 0,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}