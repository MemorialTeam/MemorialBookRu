import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:memorial_book/helpers/constants.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../provider/catalog_provider.dart';

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
              Container(
                height: 6.4.h,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(7),
                  color: const Color.fromRGBO(18, 175, 82, 1),
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () async {
                      final email = Uri.parse('mailto:kuchum.emile@gmail.com');
                      await launchUrl(email);
                    },
                    borderRadius: BorderRadius.circular(7),
                    child: Center(
                      child: Text(
                        'WRITE MESSAGE',
                        style: TextStyle(
                          color: const Color.fromRGBO(255, 255, 255, 1),
                          fontSize: 9.5.sp,
                          fontFamily: ConstantsFonts.latoBold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 1.8.h,
              ),
              Container(
                height: 6.4.h,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(7),
                  color: const Color.fromRGBO(255, 255, 255, 1),
                  border: Border.all(
                    color: const Color.fromRGBO(18, 175, 82, 1),
                  ),
                ),
                child: Center(
                  child: Text(
                    'PLOT ROUT',
                    style: TextStyle(
                      color: const Color.fromRGBO(18, 175, 82, 1),
                      fontSize: 9.5.sp,
                      fontFamily: ConstantsFonts.latoBold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
