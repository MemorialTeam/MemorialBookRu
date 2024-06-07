import 'package:memorial_book/models/catalog/response/get_authorized_content_response_model.dart';
import 'package:memorial_book/models/communitites/request/add_memorial_to_the_commnunity_request_model.dart';
import 'package:memorial_book/models/people/request/search_people_request_model.dart';
import '../models/cemetery/response/getting_the_users_cemeteries_response_model.dart';
import '../models/communitites/response/get_community_info_response_model.dart';
import '../models/cemetery/response/get_cemetery_info_response_model.dart';
import 'package:flutter_svprogresshud/flutter_svprogresshud.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../models/communitites/response/getting_memorials_of_community_response_model.dart';
import '../models/communitites/response/getting_posts_of_community_response_model.dart';
import '../widgets/cards/horizontal_mini_card_widget.dart';
import '../models/common/status_response_model.dart';
import 'package:location/location.dart';
import 'package:flutter/material.dart';
import '../data_handler/service.dart';
import '../data_handler/mapper.dart';
import '../helpers/constants.dart';
import 'package:sizer/sizer.dart';
import '../helpers/enums.dart';
import 'dart:async';

class CatalogProvider extends ChangeNotifier {
  final service = Service();
  final mapper = Mapper();

  ///Нужно будет в будущем установить модельки, а то кринге
  List<HumanDataResponseModel> humans = [];
  List<CemeteryDataResponseModel> cemeteries = [];
  List<CelebrityPetDataResponseModel> pets = [];
  List<CommunityDataResponseModel> communities = [];
  List news = [];
  List<CommunityDataResponseModel> communitiesFollowList() {
    if(isCommunitiesManaged == true) {
      return toEditManagedCommunitiesList;
    } else {
      return toEditFollowCommunitiesList;
    }
  }
  List<CommunityDataResponseModel> finalManagedCommunitiesList = [];
  List<CommunityDataResponseModel> toEditFollowCommunitiesList = [];
  List<CommunityDataResponseModel> toEditManagedCommunitiesList = [];
  List<CommunityDataResponseModel> featuredCommunitiesList = [];
  List<CommunityDataResponseModel> communitiesList = [];
  List<CemeteriesResponseModel> cemeteryList = [];
  List<SearchCemeteriesResponseModel> featuredCemeteriesList = [];
  List<CemeteryResponseModel> searchFeaturedCemeteriesList = [];
  List<HumanDataResponseModel>? peoples = [];
  List<SearchCemeteriesResponseModel>? places = [];
  List<HumanDataResponseModel> addPeopleFoundPeoples = [];
  List<MemorialsResponseModel> allMemorialsOfCommunityList = [];
  List<CommunityDataResponseModel> searchedCommunitiesList = [];
  List<CommunityDataResponseModel> searchedFeaturedCommunitiesList = [];
  List<CommunityDataResponseModel> searchedAllCommunitiesFollowList = [];
  List<CommunityDataResponseModel> searchedManagedCommunitiesList = [];

  bool isCommunitiesManaged = false;
  bool isCemeteriesManaged = false;
  bool peopleListLoading = false;
  bool placeListLoading = false;
  bool addPeopleIsLoading = false;
  bool isCommunitySearch = false;
  bool isCemeterySearch = false;
  bool isMemorialsCommunitySearch = false;
  bool isPeopleSearch = false;
  bool isPlaceSearch = false;
  bool geoPeopleLoader = false;
  bool geoPlaceLoader = false;
  bool checkBirth = false;
  bool checkDeath = false;

  final TextEditingController searchFollowController = TextEditingController();
  final TextEditingController followCommunitiesController = TextEditingController();
  final TextEditingController birthYearController = TextEditingController();
  final TextEditingController deathYearController = TextEditingController();
  final TextEditingController peopleController = TextEditingController();
  final TextEditingController placesController = TextEditingController();
  final TextEditingController countryController = TextEditingController();
  final TextEditingController communityController = TextEditingController();
  final TextEditingController cemeteryController = TextEditingController();
  final TextEditingController addPeopleController = TextEditingController();

  final Map<MarkerId, Marker> cemeteryMarkers = {};
  Map<MarkerId, Marker> peopleMarkers = {};
  Map<MarkerId, Marker> markersPlaces = {};

  String errorBirthYearsText = '';
  String errorDeathYearsText = '';

  late CameraPosition cemeteryCameraPosition;

  late final Marker cemeteryMarker;

  late BitmapDescriptor cemeteryImageMarker;
  late BitmapDescriptor mapMarker;

  final FocusNode searchFollowNode = FocusNode();
  final FocusNode addPeopleFocusNode = FocusNode();



  late Completer<GoogleMapController> peopleMapController;
  late Completer<GoogleMapController> placesMapController;

  void switchStateCommunityManage() {
    isCommunitiesManaged = !isCommunitiesManaged;
    notifyListeners();
  }

  void toSortCommunitiesFollowList(String enteredKeyword) {
    List<CommunityDataResponseModel> managedCommunitiesResults = [];
    List<CommunityDataResponseModel> followCommunitiesResults = [];
    if(enteredKeyword.isNotEmpty) {
      managedCommunitiesResults = finalManagedCommunitiesList.where(
        ((community) => community.title!.toLowerCase().contains(
          enteredKeyword.toLowerCase(),
        )),
      ).toList();
      followCommunitiesResults = communitiesList.where(
        ((community) => community.title!.toLowerCase().contains(
          enteredKeyword.toLowerCase(),
        )),
      ).toList();

      toEditManagedCommunitiesList = managedCommunitiesResults;
      toEditFollowCommunitiesList = followCommunitiesResults;
      notifyListeners();
    } else {
      toEditManagedCommunitiesList = finalManagedCommunitiesList;
      toEditFollowCommunitiesList = communitiesList;
      notifyListeners();
    }
  }

  void setManagedCommunityList() {
    print('true');
    searchFollowNode.unfocus();
    searchFollowController.clear();
    toEditManagedCommunitiesList.clear();
    finalManagedCommunitiesList.clear();
    for(CommunityDataResponseModel model in communitiesList) {
      if(model.isOwner == true) {
        finalManagedCommunitiesList.add(model);
        toEditManagedCommunitiesList.add(model);
        notifyListeners();
      }
    }
    toEditFollowCommunitiesList = communitiesList;
    notifyListeners();
  }

  bool cemeteryProfileMapLoading = false;

  Future setMarkers() async {
    cemeteryProfileMapLoading = true;
    notifyListeners();
    MarkerId markerId = const MarkerId('1');
    cemeteryImageMarker = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration(
        size: Size(0.2.h, 0.2.h),
        devicePixelRatio: 0.2.h,
      ),
      ConstantsAssets.cemeteryPointMapImage,
    );

    final latText = cemeteryProfileModel?.addressCoords?.lat;
    final lngText = cemeteryProfileModel?.addressCoords?.lng;
    notifyListeners();

    if(latText != null && lngText != null) {
      double lat = double.parse(latText);
      double lng = double.parse(lngText);
      final Marker marker = Marker(
        icon: cemeteryImageMarker,
        markerId: markerId,
        position: LatLng(
          lat,
          lng,
        ),
      );
      cemeteryMarkers[markerId] = marker;
      cemeteryCameraPosition = CameraPosition(
        target: LatLng(lat, lng),
        zoom: 10.8,
      );
      cemeteryProfileMapLoading = false;
      notifyListeners();
    } else {
      cemeteryCameraPosition = const CameraPosition(
        target: LatLng(55.751244, 37.618423),
        zoom: 10.8,
      );
      cemeteryProfileMapLoading = false;
      notifyListeners();
    }
  }

  // void clearMainContent() {
  //   humans.clear();
  //   cemeteries.clear();
  //   pets.clear();
  //   communities.clear();
  //   notifyListeners();
  // }

  Future gettingAuthorizedMainContent(
      BuildContext context,
      ValueSetter<GetAuthorizedContentResponseModel?> completion,
      ) async {
    SVProgressHUD.show();

    service.gettingAuthorizedMainContentRequest((response) {
      SVProgressHUD.dismiss();
      mapper.gettingAuthorizedMainContentResponse(response, (model) async {
        print('---${response?.body}');
        if (model != null) {
          humans = model.feed?.humans ?? [];
          cemeteries = model.feed?.cemeteries ?? [];
          pets = model.feed?.pets ?? [];
          communities = model.feed?.communities ?? [];
          notifyListeners();
          completion(model);
        } else {
          completion(null);
        }
      });
    });
  }

  Future gettingGuestMainContent(
      BuildContext context,
      ValueSetter<GetAuthorizedContentResponseModel?> completion,
      ) async {
    SVProgressHUD.show();
    service.gettingGuestMainContentRequest((response) {
      SVProgressHUD.dismiss();
      mapper.gettingGuestMainContentResponse(response, (model) async {
        if (model != null) {
          if(model.status == true) {
            humans = model.feed?.humans ?? [];
            cemeteries = model.feed?.cemeteries ?? [];
            pets = model.feed?.pets ?? [];
            communities = model.feed?.communities ?? [];
            notifyListeners();
          }
          completion(model);
        } else {
          completion(null);
        }
      },
      );
    },
    );
  }

  // Future showChooserPostPublicationTime(BuildContext context) async {
  //   return await elementSelectionWidget(
  //     context: context,
  //     title: 'Choose post publication time',
  //     textButton: 'Close',
  //     child: Row(
  //       children: [
  //         Expanded(
  //           child: SpinningCylinderWidget(
  //             title: 'Day',
  //             onSelectedItemChanged: (item) {
  //               Text text = generateElement(
  //                 array: dayList(),
  //               )[item] as Text;
  //               dayBirthDate = item;
  //               dayBirthDateText = text.data?.length == 1 ?
  //               '0${text.data}' :
  //               text.data ?? '';
  //               notifyListeners();
  //             },
  //             scrollController: FixedExtentScrollController(
  //               initialItem: dayBirthDate,
  //             ),
  //             children: dayList(),
  //           ),
  //         ),
  //         Expanded(
  //           child: SpinningCylinderWidget(
  //             title: 'Month',
  //             onSelectedItemChanged: (item) {
  //               Text text = generateElement(
  //                 array: monthList(),
  //               )[item] as Text;
  //               monthBirthDate = item;
  //               monthBirthDateText = text.data?.length == 1 ?
  //               '0${text.data}' :
  //               text.data ?? '';
  //               notifyListeners();
  //             },
  //             scrollController: FixedExtentScrollController(
  //               initialItem: monthBirthDate,
  //             ),
  //             children: monthList(),
  //           ),
  //         ),
  //         Expanded(
  //           child: SpinningCylinderWidget(
  //             title: 'Year',
  //             onSelectedItemChanged: (item) {
  //               Text text = generateElement(
  //                 array: yearList(),
  //               )[item] as Text;
  //               yearBirthDate = item;
  //               yearBirthDateText = text.data ?? '';
  //               notifyListeners();
  //             },
  //             scrollController: FixedExtentScrollController(
  //               initialItem: yearBirthDate,
  //             ),
  //             children: yearList(),
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  PostsDataResponseModel? postsDataModel;
  bool postsPaginationLoading = false;
  int postsPageNumber = 1;

  Future gettingPostsOfCommunity(int id) async {
    postsPageNumber = 1;
    postsDataModel = null;
    notifyListeners();
    service.gettingPostsOfCommunityRequest(id, postsPageNumber, (response) {
      mapper.gettingPostsOfCommunityResponse(response, (model) {
        if(model != null) {
          if (model.status == true) {
            if (model.posts?.data != null && model.posts!.data!.isNotEmpty) {
              postsDataModel = model.posts;
              notifyListeners();
            }
          }
        }
      });
    });
  }
  Future paginationPostsOfCommunity(int id) async {
    postsPageNumber++;
    postsPaginationLoading = true;
    notifyListeners();
    service.gettingPostsOfCommunityRequest(id, postsPageNumber, (response) {
      mapper.gettingPostsOfCommunityResponse(response, (model) {
        postsPaginationLoading = false;
        notifyListeners();
        if(model != null) {
          if (model.status == true) {
            if (model.posts?.data != null) {
              postsDataModel!.data!.addAll(model.posts!.data!);
              notifyListeners();
            }
          }
        }
      });
    });
  }

  MemorialsDataResponseModel? memorialDataModel;
  bool memorialPaginationLoading = false;
  int memorialPageNumber = 1;
  int memorialLastPageNumber = 1;

  Future gettingMemorialsOfCommunity(int id, ValueSetter<GettingMemorialsOfCommunityResponseModel?> completion) async {
    memorialPageNumber = 1;
    memorialLastPageNumber = 1;
    memorialDataModel = null;
    notifyListeners();
    await service.gettingMemorialsOfCommunityRequest(id, memorialPageNumber, (response) {
      mapper.gettingMemorialsOfCommunityResponse(response, (model) {
        print(response?.body);
        if(model != null) {
          if (model.status == true) {
            if (model.posts?.data != null) {
              memorialDataModel = model.posts;
              memorialLastPageNumber = model.posts?.lastPage ?? 0;
              notifyListeners();
            }
          }
          completion(model);
        } else {
          completion(null);
        }
      });
    });
  }
  Future updateMemorialsOfCommunity(int id) async {
    memorialPageNumber = 1;
    memorialLastPageNumber = 1;
    notifyListeners();
    await service.gettingMemorialsOfCommunityRequest(id, memorialPageNumber, (response) {
      mapper.gettingMemorialsOfCommunityResponse(response, (model) {
        if(model != null) {
          if (model.status == true) {
            if (model.posts?.data != null) {
              memorialDataModel = model.posts;
              memorialLastPageNumber = model.posts?.lastPage ?? 0;
              notifyListeners();
            }
          }
        }
      });
    });
  }
  Future paginationMemorialsOfCommunity(int id) async {
    memorialPaginationLoading = true;
    memorialPageNumber++;
    notifyListeners();
    SVProgressHUD.show();
    service.gettingMemorialsOfCommunityRequest(id, memorialPageNumber, (response) {
      SVProgressHUD.dismiss();
      mapper.gettingMemorialsOfCommunityResponse(response, (model) {
        memorialPaginationLoading = false;
        notifyListeners();
        if(model != null) {
          if (model.status == true) {
            if (model.posts?.data != null) {
              memorialDataModel!.data!.addAll(model.posts?.data ?? []);
              notifyListeners();
            }
          }
        }
      });
    });
  }

  Future subscribeToTheCommunity(
      int id,
      BuildContext context,
      ValueSetter<StatusResponseModel?> completion,
      ) async {
    await service.subscribeToTheCommunityRequest(id, (response) {
      mapper.statusResponse(response, (model) async {
        if(model != null) {
          if(model.status == true) {
            await Future.delayed(
              const Duration(
                seconds: 1,
              ),
            ).whenComplete(() async {
              await gettingPostsOfCommunity(id);
              await gettingGuestCommunities(context, (model) {});
            });
          }
          completion(model);
        }
        else {
          completion(null);
        }
        print('subscribe----${model?.status}----');
      });
    });
  }

  Future unsubscribeFromTheCommunity(
      int id,
      BuildContext context,
      ValueSetter<StatusResponseModel?> completion,
      ) async {
    await service.unsubscribeFromTheCommunityRequest(id, (response) {
      mapper.statusResponse(response, (model) async {
        if(model != null) {
          if(model.status == true) {
            await Future.delayed(
              const Duration(
                seconds: 1,
              ),
            ).whenComplete(() async {
              await gettingPostsOfCommunity(id);
              await gettingGuestCommunities(context, (model) {});
            });
          }
          completion(model);
        }
        else {
          completion(null);
        }
        print('subscribe----${model?.status}----');
      });
    });
  }

  Future updatingCemetery(
      BuildContext context,
      int id,
      ValueSetter<GetCemeteryInfoResponseModel?> completion,
      ) async {
    try {
      service.gettingCemeteryProfileRequest(id, (response) {
        mapper.gettingCemeteryProfileResponse(response, (model) {
          if(model?.status == true) {
            cemeteryProfileModel = model!.cemetery!;
            notifyListeners();
          }
          if(model != null) {
            completion(model);
          } else {
            completion(null);
          }
        });
      });
    } catch (error) {
      SVProgressHUD.dismiss();
      print('the following error occurred (sign up request) ---> $error');
    }
  }

  Future subscribeToTheCemetery(
      int id,
      BuildContext context,
      ValueSetter<StatusResponseModel?> completion,
      ) async {
    await service.subscribeToTheCemeteryRequest(id, (response) {
      mapper.statusResponse(response, (model) async {
        if(model != null) {
          if(model.status == true) {
            await Future.delayed(
              const Duration(
                seconds: 1,
              ),
            ).whenComplete(() async {
              await updatingCemetery(context, id, (model) {});
              await gettingCemeteries(context, (model) {});
            });
          }
          completion(model);
        }
        else {
          completion(null);
        }
        print('subscribe----${model?.status}----');
      });
    });
  }

  Future unsubscribeFromTheCemetery(
      int id,
      BuildContext context,
      ValueSetter<StatusResponseModel?> completion,
      ) async {
    await service.unsubscribeFromTheCemeteryRequest(id, (response) {
      mapper.statusResponse(response, (model) async {
        if(model != null) {
          if(model.status == true) {
            await Future.delayed(
              const Duration(
                seconds: 1,
              ),
            ).whenComplete(() async {
              await updatingCemetery(context, id, (model) {});
              await gettingCemeteries(context, (model) {});
            });
          }
          completion(model);
        }
        else {
          completion(null);
        }
        print('subscribe----${model?.status}----');
      });
    });
  }

  bool getCommunityProfileState = false;
  CommunitiesInfoResponseModel? communityProfileModel;

  Future gettingCommunityProfile(
      BuildContext context,
      int id,
      ) async {
    try {
      communityProfileModel = null;
      getCommunityProfileState = true;
      notifyListeners();
      await service.gettingCommunitiesProfileRequest(id, (response) {
        getCommunityProfileState = false;
        notifyListeners();
        mapper.gettingCommunitiesProfileResponse(response, (model) async {
          if(model != null) {
            if(model.status == true) {
              communityProfileModel = model.communities!;
              notifyListeners();
              await gettingPostsOfCommunity(id).whenComplete(
                (() async => await gettingMemorialsOfCommunity(
                  id,
                  ((model) {

                  }),
                )),
              );
            }
          }
        });
      });
    } catch (error) {
      SVProgressHUD.dismiss();
    }
  }

  Future updateCommunityProfile(
      int id,
      ) async {
    try {
      SVProgressHUD.show();
      await service.gettingCommunitiesProfileRequest(id, (response) {
        mapper.gettingCommunitiesProfileResponse(response, (model) async {
          SVProgressHUD.dismiss();
          if(model != null) {
            if(model.status == true) {
              communityProfileModel = model.communities!;
              notifyListeners();
            }
          }
        });
      });
    } catch (error) {
      SVProgressHUD.dismiss();
    }
  }

  Future gettingGuestCommunities(
      BuildContext context,
      ValueSetter<GetCommunityInfoResponseModel?> completion,
      ) async {
    service.gettingGuestCommunitiesRequest((response) {
      mapper.gettingGuestCommunitiesResponse(response, (model) async {
        if (model != null) {
          print('тут${response?.body}');
          searchedCommunitiesList = model.communities ?? [];
          searchedFeaturedCommunitiesList = model.featuredCommunities ?? [];
          featuredCommunitiesList = model.featuredCommunities ?? [];
          communitiesList = model.communities ?? [];
          notifyListeners();
          completion(model);
        } else {
          completion(null);
        }
      });
    });
  }

  Future gettingCemeteries(
      BuildContext context,
      ValueSetter<GettingTheUsersCemeteriesResponseModel?> completion,
      ) async {

    await service.gettingCemeteryRequest((response) {
      mapper.gettingCemeteryResponse(response, (model) async {
        if (model != null) {
          print(model.status);
          cemeteryList = model.cemeteries ?? [];
          featuredCemeteriesList = model.featuredCemeteries ?? [];
          notifyListeners();
          completion(model);
        } else {
          completion(null);
        }
      });
    });
  }

  Future setCustomMarker() async {
    mapMarker = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration(
        size: Size(0.2.h, 0.2.h),
        devicePixelRatio: 0.2.h,
      ),
      ConstantsAssets.mapPointImage,
    );
  }

  Future onMapPeopleCreated(GoogleMapController controller) async {
    peopleMapController = Completer();
    peopleMapController.complete(controller);
    notifyListeners();
  }

  void onMapPlacesCreated(GoogleMapController controller) {
    placesMapController = Completer();
    placesMapController.complete(controller);
    notifyListeners();
  }

  Future userGeolocationPlacesSearch() async {
    Location location = Location();
    startGeoPlaceLoader();
    LocationData data = await location.getLocation().whenComplete(() {
      turnOffGeoPlaceLoader();
    });
    GoogleMapController gcontroller = await placesMapController.future;
    await gcontroller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(data.latitude ?? 0.0, data.longitude ?? 0.0),
          zoom: 14,
        ),
      ),
    );
  }

  Future userGeolocationPeopleSearch() async {
    Location location = Location();
    startGeoPeopleLoader();
    LocationData data = await location.getLocation().whenComplete(() {
      turnOffGeoPeopleLoader();
    });
    GoogleMapController gcontroller = await peopleMapController.future;
    await gcontroller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(data.latitude ?? 0.0, data.longitude ?? 0.0),
          zoom: 14,
        ),
      ),
    );
  }

  void disposeAddPeopleScreen() {
    addPeopleIsLoading = false;
    addPeopleController.clear();
    addPeopleFoundPeoples.clear();
    addPeopleFocusNode.unfocus();
    notifyListeners();
  }

  StateOfMemorial isAdded(int index) {
    for (var elementOfCommunity in memorialDataModel?.data ?? []) {
      if(elementOfCommunity.id == addPeopleFoundPeoples[index].id) {
        addPeopleFoundPeoples[index].isAdded = StateOfMemorial.added;
        break;
      } else {
        addPeopleFoundPeoples[index].isAdded = StateOfMemorial.notAdded;
      }
    }
    return addPeopleFoundPeoples[index].isAdded ?? StateOfMemorial.notAdded;
  }

  void clearAddPeopleFoundPeoples() {
    addPeopleFoundPeoples.clear();
    notifyListeners();
  }

  int? mapPeoplesTotal;
  int? mapPlacesTotal;

  Future peopleSearch() async {
    mapPeoplesTotal = null;
    peopleListLoading = true;
    String? birthFrom;
    String? birthTo;
    String? deathFrom;
    String? deathTo;
    if(birthYearController.text.isNotEmpty && deathYearController.text.isNotEmpty) {
      birthFrom = birthYearController.text[0] + birthYearController.text[1] + birthYearController.text[2] + birthYearController.text[3];
      birthTo = birthYearController.text[5] + birthYearController.text[6] + birthYearController.text[7] + birthYearController.text[8];
      deathFrom = deathYearController.text[0] + deathYearController.text[1] + deathYearController.text[2] + deathYearController.text[3];
      deathTo = deathYearController.text[5] + deathYearController.text[6] + deathYearController.text[7] + deathYearController.text[8];
    }

    notifyListeners();
    SearchPeopleRequestModel model = SearchPeopleRequestModel(
      fullName: peopleController.text,
      birthYearFrom: birthFrom,
      birthYearTo: birthTo,
      deathYearFrom: deathFrom,
      deathYearTo: deathTo,
      country: '',
    );

    await service.peopleSearchRequest(model, (response) {
      mapper.peopleSearchResponse(response, (model) async {
        if(model != null) {
          GoogleMapController gcontroller = await peopleMapController.future;
          peopleMarkers.clear();
          peopleListLoading = false;
          if(model.humans != null && model.humans!.isNotEmpty) {
            for (var element in model.humans!) {
              if(element.burialCord?.lat != null && element.burialCord?.lng != null) {
                String markerIdVal = '${element.id}';
                MarkerId markerId = MarkerId(markerIdVal);
                final Marker marker = Marker(
                  markerId: markerId,
                  icon: mapMarker,
                  position: LatLng(
                    double.parse(element.burialCord!.lat!),
                    double.parse(element.burialCord!.lng!),
                  ),
                );
                peopleMarkers[markerId] = marker;
                notifyListeners();
              }
            }
            if(model.humans?[0].burialCord?.lat != null && model.humans?[0].burialCord?.lng != null) {
              double lat = double.parse(model.humans![0].burialCord!.lat);
              double lng = double.parse(model.humans![0].burialCord!.lng);
              gcontroller.animateCamera(
                CameraUpdate.newCameraPosition(
                  CameraPosition(
                    target: LatLng(lat, lng),
                    zoom: 14,
                  ),
                ),
              );
            }
          }
          mapPeoplesTotal = model.total;
          peoples = model.humans ?? [];
          print(response?.body);
          notifyListeners();
        }
      });
    });
  }

  Future placeSearch() async {
    placeListLoading = true;
    mapPlacesTotal = null;
    notifyListeners();
    CemeteryResponseModel model = CemeteryResponseModel(
      name: placesController.text,
    );
    await service.placesSearchRequest(model, (response) {
      mapper.placesSearchResponse(response, (model) async {
        if(model != null) {
          GoogleMapController gcontroller = await placesMapController.future;
          markersPlaces.clear();
          placeListLoading = false;
          if(model.cemeteryList != null && model.cemeteryList!.isNotEmpty) {
            for (var element in model.cemeteryList!) {
              if(element.coords?.lat != null && element.coords?.lng != null) {
                String markerIdVal = '${element.id}';
                MarkerId markerId = MarkerId(markerIdVal);
                final Marker marker = Marker(
                  markerId: markerId,
                  icon: mapMarker,
                  position: LatLng(
                    double.parse(element.coords!.lat!),
                    double.parse(element.coords!.lng!),
                  ),
                );
                markersPlaces[markerId] = marker;
                notifyListeners();
              }
            }
            if(model.cemeteryList?[0].coords?.lat != null && model.cemeteryList?[0].coords?.lng != null) {
              double lat = double.parse(model.cemeteryList![0].coords!.lat);
              double lng = double.parse(model.cemeteryList![0].coords!.lng);
              gcontroller.animateCamera(
                CameraUpdate.newCameraPosition(
                  CameraPosition(
                    target: LatLng(lat, lng),
                    zoom: 14,
                  ),
                ),
              );
            }
          }
          mapPlacesTotal = model.total;
          places = model.cemeteryList ?? [];
          notifyListeners();
        }
      });
    });
  }

  Future addToCommunityPeopleSearch() async {
    addPeopleIsLoading = true;
    SearchPeopleRequestModel model = SearchPeopleRequestModel(
      fullName: addPeopleController.text,
      birthYearFrom: '',
      deathYearFrom: '',
      country: '',
    );
    notifyListeners();

    Future.delayed(
      const Duration(
        milliseconds: 250,
      ),
    ).whenComplete(() async {
      return await service.peopleSearchRequest(model, (response) {
        print(response?.body);
        mapper.peopleSearchResponse(response, (model) async {
          addPeopleIsLoading = false;
          addPeopleFoundPeoples = model?.humans ?? [];
          notifyListeners();
        });
      });
    });
  }
  Future updateCommunityPeopleSearch() async {
    SearchPeopleRequestModel model = SearchPeopleRequestModel(
      fullName: addPeopleController.text,
      birthYearFrom: '',
      deathYearFrom: '',
      country: '',
    );

    await service.peopleSearchRequest(model, (response) {
      mapper.peopleSearchResponse(response, (model) async {
        addPeopleFoundPeoples = model?.humans ?? [];
        notifyListeners();
      });
    });
  }

  void startGeoPeopleLoader() {
    geoPeopleLoader = true;
    notifyListeners();
  }

  void turnOffGeoPeopleLoader() {
    geoPeopleLoader = false;
    notifyListeners();
  }

  void startGeoPlaceLoader() {
    geoPlaceLoader = true;
    notifyListeners();
  }

  void turnOffGeoPlaceLoader() {
    geoPlaceLoader = false;
    notifyListeners();
  }

  bool getCemeteryProfileState = false;
  CemeteryResponseModel? cemeteryProfileModel;

  Future gettingCemeteryProfile(
      BuildContext context,
      int id,
      ) async {
    try {
      getCemeteryProfileState = true;
      notifyListeners();
      service.gettingCemeteryProfileRequest(id, (response) {
        getCemeteryProfileState = false;
        notifyListeners();
        mapper.gettingCemeteryProfileResponse(response, (model) async {
          if(model != null) {
            if(model.status == true) {
              cemeteryProfileModel = model.cemetery;
              notifyListeners();
              await setMarkers();
            }
          }
        });
      });
    } catch (error) {
      SVProgressHUD.dismiss();
    }
  }

  ///add memorial
  Future addMemorialToTheCommunity(BuildContext context, int communityId, AddMemorialToTheCommunityRequestModel model, ValueSetter<StatusResponseModel?> completion) async {
    service.addMemorialToTheCommunityRequest(communityId, model, (response) {
      mapper.statusResponse(response, (model) async {
        if(model != null) {
          completion(model);
        } else {
          completion(null);
        }
      });
    });
  }

  Future removeMemorialFromTheCommunity(BuildContext context, int communityId, AddMemorialToTheCommunityRequestModel model, ValueSetter<StatusResponseModel?> completion) async {
    await service.removeMemorialFromTheCommunityRequest(communityId, model, (response) {
      mapper.statusResponse(response, (model) async {
        if(model != null) {
          completion(model);
        } else {
          completion(null);
        }
      });
    });
  }

  void activateMainCommunitiesFilter(String enteredKeyword) {
    List<CommunityDataResponseModel> defaultCommunitiesResults = [];
    List<CommunityDataResponseModel> featuredCommunitiesResults = [];
    if (enteredKeyword.isEmpty) {
      defaultCommunitiesResults = communitiesList;
      featuredCommunitiesResults = featuredCommunitiesList;
      notifyListeners();
    } else {
      defaultCommunitiesResults = communitiesList.where(
          ((user) => user.title!.toLowerCase().contains(
            enteredKeyword.toLowerCase(),
          )),
      ).toList();
      featuredCommunitiesResults = featuredCommunitiesList.where(
          ((user) => user.title!.toLowerCase().contains(
            enteredKeyword.toLowerCase(),
          )),
      ).toList();
      notifyListeners();
    }

    searchedCommunitiesList = defaultCommunitiesResults;
    searchedFeaturedCommunitiesList = featuredCommunitiesResults;
    notifyListeners();
  }

  void activateCommunitiesFollowFilter(String enteredKeyword) {
    List<CommunityDataResponseModel> defaultCommunitiesResults = [];
    List<CommunityDataResponseModel> featuredCommunitiesResults = [];
    if (enteredKeyword.isEmpty) {

      defaultCommunitiesResults = communitiesList;
      featuredCommunitiesResults = featuredCommunitiesList;
      notifyListeners();
    } else {
      defaultCommunitiesResults = communitiesList.where(
          ((user) => user.title!.toLowerCase().contains(
            enteredKeyword.toLowerCase(),
          )),
      ).toList();
      featuredCommunitiesResults = featuredCommunitiesList.where(
          ((user) => user.title!.toLowerCase().contains(
            enteredKeyword.toLowerCase(),
          )),
      ).toList();
      notifyListeners();
    }

    searchedCommunitiesList = defaultCommunitiesResults;
    searchedFeaturedCommunitiesList = featuredCommunitiesResults;
    notifyListeners();
  }

  Future communitySearch() async {
    isCommunitySearch = true;
    await service.communitySearchRequest(communityController.text, (response) {
      mapper.searchingCommunitiesProfileResponse(response, (model) {
        isCommunitySearch = false;
        featuredCommunitiesList = model?.communities ?? [];
        notifyListeners();
      });
    });
    notifyListeners();
  }

  Future cemeterySearch() async {
    isCemeterySearch = true;
    notifyListeners();
    await service.cemeterySearchRequest(cemeteryController.text, (response) {
      mapper.searchingCemeteryProfileResponse(response, (model) {
        isCemeterySearch = false;
        featuredCemeteriesList = model?.cemeteryList ?? [];
        notifyListeners();
      });
    });
    notifyListeners();
  }

  Future communityMemorialsSearch(String name, int communityID) async {
    isMemorialsCommunitySearch = true;
    await service.communityMemorialsSearchRequest(name, communityID, (response) {
      mapper.communityMemorialsSearchResponse(response, (model) {
        isMemorialsCommunitySearch = false;
        // selectedCommunity.memorials = model?.memorialsList ?? [];

        notifyListeners();
      });
    });
    notifyListeners();
  }

  int countEnabledParameters(MapFlowType filterCheckFlow) {
    int count = 0;
    switch(filterCheckFlow) {
      case MapFlowType.people:
        if(peopleController.text.isNotEmpty) {
          count++;
        }
        if(birthYearController.text.isNotEmpty) {
          count++;
        }
        if(deathYearController.text.isNotEmpty) {
          count++;
        }
        if(countryController.text.isNotEmpty) {
          count++;
        }
        return count;
      case MapFlowType.places:
        if(placesController.text.isNotEmpty) {
          count++;
        }
        return count;
    }

  }

  void errorChecking() {
    // String birth = birthYearController.text;
    // String death = deathYearController.text;
    // if(birth.isNotEmpty && death.isNotEmpty) {
    //   if(birth.length == 4 && death.length != 4) {
    //     errorDeathYearsText = 'Incorrect year format';
    //     errorBirthYearsText = '';
    //     checkDeath = true;
    //     checkBirth = false;
    //     notifyListeners();
    //   }
    //   else if(birth.length != 4 && death.length == 4) {
    //     errorBirthYearsText = 'Incorrect year format';
    //     errorDeathYearsText = '';
    //     checkBirth = true;
    //     checkDeath = false;
    //     notifyListeners();
    //   }
    //   else if(int.parse(birth) > int.parse(death)) {
    //     errorBirthYearsText = 'Wrong fork years';
    //     errorDeathYearsText = 'Wrong fork years';
    //     checkDeath = true;
    //     checkBirth = true;
    //     notifyListeners();
    //   }
    //   else {
    //     errorBirthYearsText = '';
    //     errorDeathYearsText = '';
    //     checkDeath = false;
    //     checkBirth = false;
    //     notifyListeners();
    //   }
    // }
    // else if(birth.isEmpty && death.isNotEmpty) {
    //   if(death.length != 4) {
    //     errorDeathYearsText = 'Incorrect death year format';
    //     errorBirthYearsText = '';
    //     checkDeath = true;
    //     checkBirth = false;
    //     notifyListeners();
    //   } else {
    //     errorBirthYearsText = '';
    //     errorDeathYearsText = '';
    //     checkDeath = false;
    //     checkBirth = false;
    //     notifyListeners();
    //   }
    // }
    // else if(birth.isNotEmpty && death.isEmpty) {
    //   if(birth.length != 4) {
    //     errorBirthYearsText = 'Incorrect year format';
    //     errorDeathYearsText = '';
    //     checkBirth = true;
    //     checkDeath = false;
    //     notifyListeners();
    //   } else {
    //     errorBirthYearsText = '';
    //     errorDeathYearsText = '';
    //     checkBirth = false;
    //     checkDeath = false;
    //     notifyListeners();
    //   }
    // }
    // else {
    //   errorBirthYearsText = '';
    //   errorDeathYearsText = '';
    //   checkDeath = false;
    //   checkBirth = false;
    //   notifyListeners();
    // }
  }
}