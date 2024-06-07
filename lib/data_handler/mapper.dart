import 'package:memorial_book/models/auth/responses/send_code_for_password_recovery_response_model.dart';
import 'package:memorial_book/models/communitites/response/getting_memorials_of_community_response_model.dart';
import 'package:memorial_book/models/pet/response/getting_created_pets_profiles_response_model.dart';
import 'package:memorial_book/models/user/response/user_info_response_model.dart';
import '../models/auth/responses/sign_up_response_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert';
import '../models/catalog/response/get_authorized_content_response_model.dart';
import '../models/catalog/response/get_guest_content_response_model.dart';
import '../models/catalog/response/main_catalog_response_model.dart';
import '../models/cemetery/response/get_cemetery_info_response_model.dart';
import '../models/cemetery/response/getting_the_users_cemeteries_response_model.dart';
import '../models/cemetery/response/search_cemetery_for_human_response_model.dart';
import '../models/cemetery/response/search_cemetery_info_response_model.dart';
import '../models/cemetery/response/search_memorials_response_model.dart';
import '../models/common/map_response_model.dart';
import '../models/common/status_response_model.dart';
import '../models/communitites/response/community_response_model.dart';
import '../models/communitites/response/get_community_info_response_model.dart';
import '../models/communitites/response/getting_posts_of_community_response_model.dart';
import '../models/communitites/response/search_community_info_response_model.dart';
import '../models/create_profile/response/get_hobbies_response_model.dart';
import '../models/create_profile/response/get_religions_response_model.dart';
import '../models/market/response/get_shop_response_model.dart';
import '../models/market/response/products_response_models/get_product_by_id_reponse_model.dart';
import '../models/market/response/products_response_models/get_products_category_response_model.dart';
import '../models/market/response/user_cart_response_model.dart';
import '../models/people/response/get_map_of_people_response_model.dart';
import '../models/people/response/get_people_info_response_model.dart';
import '../models/people/response/getting_created_humans_profiles_response_model.dart';
import '../models/people/response/related_profiles_response_model.dart';
import '../models/pet/response/get_pet_info_response_model.dart';

class Mapper {
  void signUpResponse(
      Response? response,
      ValueSetter<SignUpResponseModel?> completion,
      ) {
    if (response != null) {
      Map<String, dynamic> body = json.decode(response.body);
      SignUpResponseModel model = SignUpResponseModel.fromJson(body);
      completion(model);
    } else {
      completion(null);
    }
  }

  void logoutResponse(
      Response? response,
      ValueSetter<StatusResponseModel?> completion,
      ) {
    if (response != null) {
      Map<String, dynamic> body = json.decode(response.body);
      StatusResponseModel model = StatusResponseModel.fromJson(body);
      completion(model);
    } else {
      completion(null);
    }
  }

  void gettingAuthorizedMainContentResponse(
      Response? response,
      ValueSetter<GetAuthorizedContentResponseModel?> completion,
      ) {
    if (response != null) {
      Map<String, dynamic> body = json.decode(response.body);
      GetAuthorizedContentResponseModel model = GetAuthorizedContentResponseModel.fromJson(body);
      completion(model);
    } else {
      completion(null);
    }
  }

  void gettingGuestMainContentResponse(
      Response? response,
      ValueSetter<GetAuthorizedContentResponseModel?> completion,
      ) {
    if (response != null) {
      Map<String, dynamic> body = json.decode(response.body);
      GetAuthorizedContentResponseModel model = GetAuthorizedContentResponseModel.fromJson(body);
      completion(model);
    } else {
      completion(null);
    }
  }

  void gettingPostsOfCommunityResponse(
      Response? response,
      ValueSetter<GettingPostsOfCommunityResponseModel?> completion,
      ) {
    if (response != null) {
      Map<String, dynamic> body = json.decode(response.body);
      GettingPostsOfCommunityResponseModel model = GettingPostsOfCommunityResponseModel.fromJson(body);
      completion(model);
    } else {
      completion(null);
    }
  }

  void gettingMemorialsOfCommunityResponse(
      Response? response,
      ValueSetter<GettingMemorialsOfCommunityResponseModel?> completion,
      ) {
    if (response != null) {
      Map<String, dynamic> body = json.decode(response.body);
      GettingMemorialsOfCommunityResponseModel model = GettingMemorialsOfCommunityResponseModel.fromJson(body);
      completion(model);
    } else {
      completion(null);
    }
  }

  void getProductsCategoryResponse(
      Response? response,
      ValueSetter<GetProductsCategoryResponseModel?> completion,
      ) {
    if (response != null) {
      Map<String, dynamic> body = json.decode(response.body);
      GetProductsCategoryResponseModel model = GetProductsCategoryResponseModel.fromJson(body);
      completion(model);
    } else {
      completion(null);
    }
  }

  void getServicesCategoryResponse(
      Response? response,
      ValueSetter<GetProductsCategoryResponseModel?> completion,
      ) {
    if (response != null) {
      Map<String, dynamic> body = json.decode(response.body);
      GetProductsCategoryResponseModel model = GetProductsCategoryResponseModel.fromJson(body);
      completion(model);
    } else {
      completion(null);
    }
  }

  void getProductByIdResponse(
      Response? response,
      ValueSetter<GetProductByIdResponseModel?> completion,
      ) {
    if (response != null) {
      Map<String, dynamic> body = json.decode(response.body);
      GetProductByIdResponseModel model = GetProductByIdResponseModel.fromJson(body);
      completion(model);
    } else {
      completion(null);
    }
  }

  void getShopResponse(
      Response? response,
      ValueSetter<GetShopResponseModel?> completion,
      ) {
    if (response != null) {
      Map<String, dynamic> body = json.decode(response.body);
      GetShopResponseModel model = GetShopResponseModel.fromJson(body);
      completion(model);
    } else {
      completion(null);
    }
  }

  void getUserCartResponse(
      Response? response,
      ValueSetter<UserCartResponseModel?> completion,
      ) {
    if (response != null) {
      Map<String, dynamic> body = json.decode(response.body);
      UserCartResponseModel model = UserCartResponseModel.fromJson(body);
      completion(model);
    } else {
      completion(null);
    }
  }

  void getProductsOnMainResponse(
      Response? response,
      ValueSetter<GetShopResponseModel?> completion,
      ) {
    if (response != null) {
      Map<String, dynamic> body = json.decode(response.body);
      GetShopResponseModel model = GetShopResponseModel.fromJson(body);
      completion(model);
    } else {
      completion(null);
    }
  }

  void gettingGuestCommunitiesResponse(
      Response? response,
      ValueSetter<GetCommunityInfoResponseModel?> completion,
      ) {
    if (response != null) {
      Map<String, dynamic> body = json.decode(response.body);
      GetCommunityInfoResponseModel model = GetCommunityInfoResponseModel.fromJson(body);
      completion(model);
    } else {
      completion(null);
    }
  }

  void gettingCemeteryResponse(
      Response? response,
      ValueSetter<GettingTheUsersCemeteriesResponseModel?> completion,
      ) {
    print('------${response?.body}');
    if (response != null) {
      Map<String, dynamic> body = json.decode(response.body);
      GettingTheUsersCemeteriesResponseModel model = GettingTheUsersCemeteriesResponseModel.fromJson(body);
      completion(model);
    } else {
      completion(null);
    }
  }

  void statusResponse(
      Response? response,
      ValueSetter<StatusResponseModel?> completion,
      ) {
    if (response != null) {
      Map<String, dynamic> body = json.decode(response.body);
      StatusResponseModel model = StatusResponseModel.fromJson(body);
      completion(model);
    } else {
      completion(null);
    }
  }

  void statusMultiPartResponse(
      StreamedResponse? response,
      ValueSetter<StatusResponseModel?> completion,
      ) async {
    try {
      if (response != null) {
        var responseString = await response.stream.bytesToString();
        print(responseString);
        if(responseString.isNotEmpty) {
          var body = json.decode(responseString);
          StatusResponseModel model = StatusResponseModel.fromJson(body);
          completion(model);
        }
      } else {
        completion(null);
      }
    } catch(error) {
      print('$error');
    }
  }

  void searchCemeteryForHumanResponse(
      Response? response,
      ValueSetter<SearchCemeteryForHumanResponseModel?> completion,
      ) async {
    try {
      if (response != null) {
        Map<String, dynamic> body = json.decode(response.body);
        SearchCemeteryForHumanResponseModel model = SearchCemeteryForHumanResponseModel.fromJson(body);
        completion(model);
      } else {
        completion(null);
      }
    } catch(error) {
      print('$error');
    }
  }

  void gettingPetProfileResponse(
      Response? response,
      ValueSetter<GetPetInfoResponseModel?> completion,
      ) {
    if (response != null) {
      Map<String, dynamic> body = json.decode(response.body);
      GetPetInfoResponseModel model = GetPetInfoResponseModel.fromJson(body);
      completion(model);
    } else {
      completion(null);
    }
  }

  void gettingPeopleProfileResponse(
      Response? response,
      ValueSetter<GetPeopleInfoResponseModel?> completion,
      ) {
    if (response != null) {
      Map<String, dynamic> body = json.decode(response.body);
      GetPeopleInfoResponseModel model = GetPeopleInfoResponseModel.fromJson(body);
      completion(model);
    } else {
      completion(null);
    }
  }

  void gettingCommunitiesProfileResponse(
      Response? response,
      ValueSetter<CommunityResponseModel?> completion,
      ) {
    if (response != null) {
      Map<String, dynamic> body = json.decode(response.body);
      CommunityResponseModel model = CommunityResponseModel.fromJson(body);
      completion(model);
    } else {
      completion(null);
    }
  }

  void searchingCommunitiesProfileResponse(
      Response? response,
      ValueSetter<SearchCommunityInfoResponseModel?> completion,
      ) {
    if (response != null) {
      Map<String, dynamic> body = json.decode(response.body);
      SearchCommunityInfoResponseModel model = SearchCommunityInfoResponseModel.fromJson(body);
      completion(model);
    } else {
      completion(null);
    }
  }

  void searchingCemeteryProfileResponse(
      Response? response,
      ValueSetter<SearchCemeteryInfoResponseModel?> completion,
      ) {
    if (response != null) {
      Map<String, dynamic> body = json.decode(response.body);
      SearchCemeteryInfoResponseModel model = SearchCemeteryInfoResponseModel.fromJson(body);
      completion(model);
    } else {
      completion(null);
    }
  }

  void communityMemorialsSearchResponse(
      Response? response,
      ValueSetter<SearchMemorialsResponseModel?> completion,
      ) {
    if (response != null) {
      Map<String, dynamic> body = json.decode(response.body);
      SearchMemorialsResponseModel model = SearchMemorialsResponseModel.fromJson(body);
      completion(model);
    } else {
      completion(null);
    }
  }

  void gettingCreatedHumansProfilesResponse(
      Response? response,
      ValueSetter<GettingCreatedHumansProfilesResponseModel?> completion,
      ) {
    if (response != null) {
      Map<String, dynamic> body = json.decode(response.body);
      GettingCreatedHumansProfilesResponseModel model = GettingCreatedHumansProfilesResponseModel.fromJson(body);
      completion(model);
    } else {
      completion(null);
    }
  }

  void gettingCreatedPetsProfilesResponse(
      Response? response,
      ValueSetter<GettingCreatedPetsProfilesResponseModel?> completion,
      ) {
    if (response != null) {
      Map<String, dynamic> body = json.decode(response.body);
      GettingCreatedPetsProfilesResponseModel model = GettingCreatedPetsProfilesResponseModel.fromJson(body);
      completion(model);
    } else {
      completion(null);
    }
  }

  void gettingCemeteryProfileResponse(
      Response? response,
      ValueSetter<GetCemeteryInfoResponseModel?> completion,
      ) {
    if (response != null) {
      Map<String, dynamic> body = json.decode(response.body);
      print(body);
      GetCemeteryInfoResponseModel model = GetCemeteryInfoResponseModel.fromJson(body);
      completion(model);
    } else {
      completion(null);
    }
  }

  void gettingReligionsResponse(
      Response? response,
      ValueSetter<GetReligionsResponseModel?> completion,
      ) {
    if (response != null) {
      Map<String, dynamic> body = json.decode(response.body);
      GetReligionsResponseModel model = GetReligionsResponseModel.fromJson(body);
      completion(model);
    } else {
      completion(null);
    }
  }

  void gettingHobbiesResponse(
      Response? response,
      ValueSetter<GetHobbiesResponseModel?> completion,
      ) {
    if (response != null) {
      Map<String, dynamic> body = json.decode(response.body);
      GetHobbiesResponseModel model = GetHobbiesResponseModel.fromJson(body);
      completion(model);
    } else {
      completion(null);
    }
  }

  void sendCodeForPasswordRecoveryResponse(
      Response? response,
      ValueSetter<SendCodeForPasswordRecoveryResponseModel?> completion,
      ) {
    if (response != null) {
      Map<String, dynamic> body = json.decode(response.body);
      SendCodeForPasswordRecoveryResponseModel model = SendCodeForPasswordRecoveryResponseModel.fromJson(body);
      completion(model);
    } else {
      completion(null);
    }
  }

  void getPlaceResponse(
      Response? response,
      ValueSetter<MapResponseModel?> completion,
      ) {
    if (response != null) {
      Map<String, dynamic> body = json.decode(response.body);
      MapResponseModel model = MapResponseModel.fromJson(body);
      completion(model);
    } else {
      completion(null);
    }
  }

  void getUserInfoResponse(
      Response? response,
      ValueSetter<UserInfoResponseModel?> completion,
      ) {
    if (response != null) {
      Map<String, dynamic> body = json.decode(response.body);
      UserInfoResponseModel model = UserInfoResponseModel.fromJson(body);
      completion(model);
    } else {
      completion(null);
    }
  }

  void gettingRelatedProfilesResponse(
      Response? response,
      ValueSetter<RelatedProfilesResponseModel?> completion,
      ) {
    if (response != null) {
      Map<String, dynamic> body = json.decode(response.body);
      RelatedProfilesResponseModel model = RelatedProfilesResponseModel.fromJson(body);
      completion(model);
    } else {
      completion(null);
    }
  }

  void peopleSearchResponse(
      Response? response,
      ValueSetter<GetMapOfPeopleResponseModel?> completion,
      ) {
    if (response != null) {
      Map<String, dynamic> body = json.decode(response.body);
      GetMapOfPeopleResponseModel model = GetMapOfPeopleResponseModel.fromJson(body);
      completion(model);
    } else {
      completion(null);
    }
  }

  void placesSearchResponse(
      Response? response,
      ValueSetter<SearchCemeteryInfoResponseModel?> completion,
      ) {
    if (response != null) {
      Map<String, dynamic> body = json.decode(response.body);
      SearchCemeteryInfoResponseModel model = SearchCemeteryInfoResponseModel.fromJson(body);
      completion(model);
    } else {
      completion(null);
    }
  }
  // void updatingUserInformationResponse(
  //     StreamedResponse? response,
  //     ValueSetter<UserInfoResponseModel?> completion,
  //     ) {
  //   if (response != null) {
  //     Map<String, dynamic> body = json.decode(response.);
  //     UserInfoResponseModel model = UserInfoResponseModel.fromJson(body);
  //     completion(model);
  //   } else {
  //     completion(null);
  //   }
  // }
}
