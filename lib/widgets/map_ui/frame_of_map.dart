import 'package:memorial_book/widgets/map_ui/users_location_widget.dart';
import 'package:memorial_book/widgets/map_ui/search_header_widget.dart';
import 'package:memorial_book/widgets/map_ui/show_as_widget.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:loading_indicator/loading_indicator.dart';
import '../maps_scrollable_sheet_widget.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../helpers/enums.dart';

class FrameOfMap extends StatelessWidget {
  const FrameOfMap({
    super.key,
    required this.onMapCreated,
    required this.markers,
    required this.mapFlowType,
    required this.geoLoadValue,
    required this.sheetLoadValue,
    required this.geoIcon,
    required this.mainColor,
    this.total,
    required this.mapsScrollableSheetBuilder,
    required this.sheetController,
    required this.childSizeSheet,
    required this.searchFocusNode,
    required this.onSearch,
    required this.searchController,
    required this.filterCount,
    required this.context,
    required this.filterRoute,
    required this.dataList,
  });

  final void Function(GoogleMapController) onMapCreated;

  final Iterable<Marker> markers;

  final MapFlowType mapFlowType;

  final bool geoLoadValue;
  final bool sheetLoadValue;

  final String geoIcon;
  final String filterCount;

  final Widget filterRoute;

  final Widget Function(BuildContext, int) mapsScrollableSheetBuilder;
  final void Function(String) onSearch;

  final Color mainColor;

  final int? total;

  final double childSizeSheet;

  final FocusNode searchFocusNode;

  final TextEditingController searchController;

  final DraggableScrollableController sheetController;

  final BuildContext context;

  final List dataList;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GoogleMap(
          onTap: (latLng) => FocusScope.of(context).unfocus(),
          onMapCreated: onMapCreated,
          markers: Set<Marker>.of(markers),
          initialCameraPosition: const CameraPosition(
            target: LatLng(37.42796133580664, -122.085749655962),
            zoom: 14.4746,
          ),
          zoomControlsEnabled: false,
        ),
        Align(
          alignment: Alignment.centerRight,
          child: Padding(
            padding: EdgeInsets.only(
              top: 15.h,
              right: 3.2.w,
            ),
            child: UsersLocationWidget(
              mapFlowType: mapFlowType,
              isLoading: geoLoadValue,
              icon: geoIcon,
              loaderColor: mainColor,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
            top: 9.2.h,
            left: 3.2.w,
          ),
          child: ShowAsWidget(
            sheetController: sheetController,
            childSizeSheet: childSizeSheet,
            color: mainColor,
          ),
        ),
        MapsScrollableSheetWidget(
          color: mainColor,
          sheetController: sheetController,
          total: total,
          searchedName: mapFlowType == MapFlowType.places ?
          'кладб.' :
          'чел.',
          child: sheetLoadValue == false ?
          ListView.builder(
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: mapsScrollableSheetBuilder,
            itemCount: dataList.isNotEmpty ?
            dataList.length :
            1,
          ) :
          SizedBox(
            width: 7.h,
            height: 7.h,
            child: LoadingIndicator(
              indicatorType: Indicator.ballPulse,
              colors: [
                mainColor,
              ],
            ),
          ),
        ),
        SearchHeaderWidget(
          focusNode: searchFocusNode,
          onSearch: onSearch,
          controller: searchController,
          filterRoute: filterRoute,
          context: context,
          filterCount: filterCount,
          mainColor: mainColor,
        ),
      ],
    );
  }
}
