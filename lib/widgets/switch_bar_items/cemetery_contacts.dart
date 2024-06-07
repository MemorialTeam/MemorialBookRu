import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:memorial_book/helpers/constants.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../provider/catalog_provider.dart';
import '../main_button.dart';

class CemeteryContacts extends StatefulWidget {
  const CemeteryContacts({
    Key? key,
  }) : super(key: key);


  @override
  State<CemeteryContacts> createState() => _CemeteryContactsState();
}

class _CemeteryContactsState extends State<CemeteryContacts> {

  static TextStyle titleStyle = TextStyle(
    fontFamily: ConstantsFonts.latoRegular,
    color: const Color.fromRGBO(32, 30, 31, 1),
    fontSize: 9.5.sp,
  );

  static TextStyle subtitleStyle = TextStyle(
    fontFamily: ConstantsFonts.latoRegular,
    color: const Color.fromRGBO(32, 30, 31, 1),
    fontSize: 12.5.sp,
  );

  @override
  Widget build(BuildContext context) {
    final catalogProvider = Provider.of<CatalogProvider>(context);
    return Column(
      children: [
        if(catalogProvider.cemeteryProfileMapLoading == false)
        SizedBox(
          height: 46.h,
          width: double.infinity,
          child: GoogleMap(
            initialCameraPosition: catalogProvider.cemeteryCameraPosition,
            mapToolbarEnabled: false,
            compassEnabled: false,
            scrollGesturesEnabled: false,
            zoomGesturesEnabled: false,
            myLocationButtonEnabled: false,
            tiltGesturesEnabled: false,
            zoomControlsEnabled: false,
            markers: Set<Marker>.of(catalogProvider.cemeteryMarkers.values),
          ),
        ) else SizedBox(
          height: 6.2.h,
          width: 6.2.h,
          child: const LoadingIndicator(
            indicatorType: Indicator.ballSpinFadeLoader,
            colors: [
              Color.fromRGBO(18, 175, 82, 1),
            ],
          ),
        ),
        SizedBox(
          height: 4.h,
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 3.2.w,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                'Email:',
                style: titleStyle,
              ),
              SizedBox(
                height: 0.5.h,
              ),
              Text(
                'skeletee@@mail.ru',
                style: subtitleStyle,
              ),
              SizedBox(
                height: 2.4.h,
              ),
              Text(
                'Phone number:',
                style: titleStyle,
              ),
              SizedBox(
                height: 0.5.h,
              ),
              Text(
                '+7 902 222-33-33',
                style: subtitleStyle,
              ),
              SizedBox(
                height: 2.4.h,
              ),
              Text(
                'Working hours:',
                style: titleStyle,
              ),
              SizedBox(
                height: 0.5.h,
              ),
              Text(
                'Mon-Sun: 09:00 - 20:00',
                style: subtitleStyle,
              ),
              SizedBox(
                height: 6.4.h,
              ),
              MainButton(
                text: 'НАПИСАТЬ СООБЩЕНИЕ',
                onTap: () async {
                  final email = Uri.parse('mailto:kuchum.emile@gmail.com');
                  await launchUrl(email);
                },
                textStyle: TextStyle(
                  color: const Color.fromRGBO(255, 255, 255, 1),
                  fontSize: 9.5.sp,
                  fontFamily: ConstantsFonts.latoBold,
                ),
                activeColor: const Color.fromRGBO(18, 175, 82, 1),
              ),
              SizedBox(
                height: 1.8.h,
              ),
              MainButton(
                text: 'ПРОЛОЖИТЬ МАРШРУТ',
                onTap: () async {

                },
                border: Border.all(
                  color: const Color.fromRGBO(18, 175, 82, 1),
                ),
                textStyle: TextStyle(
                  color: const Color.fromRGBO(18, 175, 82, 1),
                  fontSize: 9.5.sp,
                  fontFamily: ConstantsFonts.latoBold,
                ),
                activeColor: const Color.fromRGBO(255, 255, 255, 1),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
