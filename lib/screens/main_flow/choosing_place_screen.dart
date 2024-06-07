import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../../helpers/constants.dart';
import '../../provider/profile_creation_provider.dart';
import '../../widgets/text_field_profile_widget.dart';

class ChoosingPlaceScreen extends StatefulWidget {
  const ChoosingPlaceScreen({Key? key}) : super(key: key);

  @override
  State<ChoosingPlaceScreen> createState() => _ChoosingPlaceScreenState();
}

class _ChoosingPlaceScreenState extends State<ChoosingPlaceScreen> {

  TextEditingController searchController = TextEditingController();

  String selectedCountry = '';

  late BitmapDescriptor mapMarker;

  void setCustomMarker() async {
    mapMarker = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration(
        size: Size(0.2.h, 0.2.h),
        devicePixelRatio: 0.2.h,
      ),
      ConstantsAssets.mapPointImage,
    );
  }

  @override
  void initState() {
    setCustomMarker();
    super.initState();
  }
  Completer completer = Completer();

  @override
  Widget build(BuildContext context) {
    final profileCreationProvider = Provider.of<ProfileCreationProvider>(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          GoogleMap(
            onTap: (latLng) {
              FocusScope.of(context).unfocus();
            },
            compassEnabled: false,
            onMapCreated: profileCreationProvider.onMapCreated,
            markers: Set<Marker>.of(profileCreationProvider.markersAddress.values),
            initialCameraPosition: const CameraPosition(
              target: LatLng(37.42796133580664, -122.085749655962),
              zoom: 14.4746,
            ),
            zoomControlsEnabled: false,
          ),
          Positioned(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            left: 0,
            right: 0,
            child: GestureDetector(
              onTap: () {
                FocusScope.of(context).unfocus();
              },
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 2.h,
                    vertical: 2.h,
                  ),
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(
                      horizontal: 2.h,
                      vertical: 2.4.h,
                    ),
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(255, 255, 255, 1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Choice address:',
                          style: TextStyle(
                            fontFamily: ConstantsFonts.latoRegular,
                            fontSize: 10.sp,
                            color: const Color.fromRGBO(32, 30, 31, 0.5),
                          ),
                        ),
                        SizedBox(
                          height: 0.6.h,
                        ),
                        TextFieldProfileWidget(
                          controller: searchController,
                          hintText: 'Specify а cause',
                          minLines: 1,
                          maxLines: 14,
                          onChanged: (text) => profileCreationProvider.getPlace(text, context, (model) {}),
                        ),
                        SizedBox(
                          height: profileCreationProvider.countryList.isNotEmpty ?
                          1.h :
                          0,
                        ),
                        profileCreationProvider.countryList.isNotEmpty ?
                        ListView.builder(
                          padding: EdgeInsets.zero,
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            final dataList = profileCreationProvider.countryList[index];
                            return SizedBox(
                              width: double.infinity,
                              child: Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  onTap: () async {
                                    profileCreationProvider.selectCountry(context, dataList.place ?? '', searchController, mapMarker);
                                    selectedCountry = dataList.place ?? '';
                                  },
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 3.w,
                                      vertical: 1.h,
                                    ),
                                    child: Text(
                                      dataList.place ?? '',
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                      style: TextStyle(
                                        fontSize: 11.5.sp,
                                        fontFamily: ConstantsFonts.latoRegular,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                          itemCount: profileCreationProvider.countryList.length < 5 ?
                          profileCreationProvider.countryList.length :
                          5,
                        ) :
                        const SizedBox(),
                        SizedBox(
                          height: profileCreationProvider.countryList.isNotEmpty ?
                          1.h :
                          2.h,
                        ),
                        Container(
                          height: 6.h,
                          margin: EdgeInsets.symmetric(
                            horizontal: 10.w,
                          ),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(7),
                            color: selectedCountry.isEmpty ?
                            const Color.fromRGBO(23, 94, 217, 0.5) :
                            const Color.fromRGBO(23, 94, 217, 1),
                          ),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              borderRadius: BorderRadius.circular(7),
                              onTap: selectedCountry.isNotEmpty ? () {
                                profileCreationProvider.saveCountry(selectedCountry);
                                Navigator.pop(context);
                              } :
                              null,
                              child: Center(
                                child: Text(
                                  'СОХРАНИТЬ И ПРОДОЛЖИТЬ',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: ConstantsFonts.latoRegular,
                                    fontSize: 10.5.sp,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: Align(
        alignment: Alignment.topRight,
        child: Container(
          height: 6.4.h,
          width: 6.4.h,
          margin: EdgeInsets.symmetric(
            vertical: 8.h,
          ),
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Color.fromRGBO(229, 232, 235, 1),
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () => Navigator.pop(context),
              borderRadius: BorderRadius.circular(50),
              child: Center(
                child: Icon(
                  Icons.close,
                  size: 2.4.h,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
