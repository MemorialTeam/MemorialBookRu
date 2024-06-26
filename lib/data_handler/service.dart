import 'dart:io';
import 'package:flutter_svprogresshud/flutter_svprogresshud.dart';
import 'package:memorial_book/models/auth/requests/password_recovery_request_model.dart';
import 'package:memorial_book/models/communitites/request/edit_community_request_model.dart';
import 'package:memorial_book/models/create_profile/request/creating_community_profile_request_model.dart';
import 'package:memorial_book/models/user/request/updating_user_information_request_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/auth/requests/sign_up_request_model.dart';
import 'package:flutter/material.dart';
import '../managers/api_manager.dart';
import '../helpers/constants.dart';
import 'package:http/http.dart';
import '../models/catalog/request/edit_post_request_model.dart';
import '../models/cemetery/request/cemetery_search_request.dart';
import '../models/cemetery/request/creating_cemetery_request_model.dart';
import '../models/communitites/request/add_memorial_to_the_commnunity_request_model.dart';
import '../models/create_profile/request/create_post_request_model.dart';
import '../models/people/request/creating_persons_profile_request_model.dart';
import '../models/people/request/search_people_request_model.dart';
import '../models/pet/request/creating_pet_request_model.dart';

class Service {
  void signUpRequest(
      SignUpRequestModel model,
      ValueSetter<Response?> completion,
      ) async {

    Map<String, String> headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    };

    Map<String, dynamic> body = {
      'username': model.username,
      'email': model.email,
      'password': model.password,
      'password_confirmation': model.passwordConfirmation,
      'fcm_token': model.fcmToken,
      'device_name': model.deviceName,
      'location': model.location,
    };

    print(body);

    String endpoint = ConstEndpoints.signUpEndPoint;
    String startPoint = ConstantsUrls.baseUrl;

    APIManager().postRequestWithBody(
      startPoint,
      endpoint,
      headers,
      body,
      ((response) {
        if (response != null) {
          completion(response);
        } else {
          completion(null);
        }
      }),
    );
  }

  void signInRequest(
      SignUpRequestModel model,
      ValueSetter<Response?> completion,
      ) async {

    Map<String, String> headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    };

    Map<String, dynamic> body = {
      'email': model.email,
      'password': model.password,
      'fcm_token': model.fcmToken,
      'device_name': model.deviceName,
    };

    String endpoint = ConstEndpoints.signInEndPoint;
    String startPoint = ConstantsUrls.baseUrl;

    APIManager().postRequestWithBody(
      startPoint,
      endpoint,
      headers,
      body,
      ((response) {
        if (response != null) {
          completion(response);
        } else {
          completion(null);
        }
      }),
    );
  }

  Future peopleSearchRequest(
      SearchPeopleRequestModel model,
      ValueSetter<Response?> completion,
      ) async {

    Map<String, String> headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    };

    Map<String, dynamic> body = {
      'full_name': model.fullName,
    };

    if(model.country != null && model.country!.isNotEmpty) {
      body.addAll({
        'country': model.country,
      });
    }
    if(model.birthYearFrom != null && model.birthYearTo != null) {
      body.addAll({
        'birth_year[from]': model.birthYearFrom,
        'birth_year[to]': model.birthYearTo,
      });
    }
    if(model.deathYearFrom != null && model.deathYearTo != null) {
      body.addAll({
        'death_year[from]': model.deathYearFrom,
        'death_year[to]': model.deathYearTo,
      });
    }

    String endpoint = ConstEndpoints.peopleSearch;

    await APIManager().getRequestEncodedBody(
      endpoint,
      body,
      headers,
      ((response) {
        if (response != null) {
          completion(response);
        } else {
          completion(null);
        }
      }),
    );
  }

  Future communitySearchRequest(
      String title,
      ValueSetter<Response?> completion,
      ) async {
    final storage = await SharedPreferences.getInstance();
    final token = storage.getString(ConstantsKeys.userTOKEN);

    Map<String, String> headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    Map<String, dynamic> body = {
      'title': title,
    };

    String endpoint = ConstEndpoints.communitiesSearch;

    await APIManager().getRequestEncodedBody(
      endpoint,
      body,
      headers,
      ((response) {
        if (response != null) {
          completion(response);
        } else {
          completion(null);
        }
      }),
    );
  }

  Future cemeterySearchRequest(
      String title,
      ValueSetter<Response?> completion,
      ) async {
    final storage = await SharedPreferences.getInstance();
    final token = storage.getString(ConstantsKeys.userTOKEN);

    Map<String, String> headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    Map<String, dynamic> body = {
      'title': title,
    };

    String endpoint = ConstEndpoints.placesSearch;

    await APIManager().getRequestEncodedBody(
      endpoint,
      body,
      headers,
      ((response) {
        if (response != null) {
          completion(response);
        } else {
          completion(null);
        }
      }),
    );
  }

  Future gettingCreatedHumansProfilesRequest(
      String? link,
      ValueSetter<Response?> completion,
      ) async {
    final storage = await SharedPreferences.getInstance();
    final token = storage.getString(ConstantsKeys.userTOKEN);

    Map<String, String> headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    String endpoint = link ?? '';

    await APIManager().getRequest(
      endpoint,
      headers,
      ((response) {
        if (response != null) {
          completion(response);
        } else {
          completion(null);
        }
      }),
    );
  }

  Future getShopRequest(
      int cemeteryId,
      ValueSetter<Response?> completion,
      ) async {
    final storage = await SharedPreferences.getInstance();
    final token = storage.getString(ConstantsKeys.userTOKEN);

    Map<String, String> headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    String endpoint = 'shop/$cemeteryId';

    await APIManager().getRequest(
      endpoint,
      headers,
      ((response) {
        if (response != null) {
          completion(response);
        } else {
          completion(null);
        }
      }),
    );
  }

  Future getUserCartRequest(
      ValueSetter<Response?> completion,
      ) async {
    final storage = await SharedPreferences.getInstance();
    final token = storage.getString(ConstantsKeys.userTOKEN);

    Map<String, String> headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    String endpoint = ConstEndpoints.getUserCart;

    await APIManager().getRequest(
      endpoint,
      headers,
      ((response) {
        if (response != null) {
          completion(response);
        } else {
          completion(null);
        }
      }),
    );
  }

  Future addProductToBasketRequest(
      int productId,
      ValueSetter<Response?> completion,
      ) async {
    final storage = await SharedPreferences.getInstance();
    final token = storage.getString(ConstantsKeys.userTOKEN);

    Map<String, String> headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    print(headers);

    String endpoint = 'cart/product/$productId/add';

    await APIManager().postRequest(
      endpoint,
      headers,
      ((response) {
        if (response != null) {
          completion(response);
        } else {
          completion(null);
        }
      }),
    );
  }

  Future removeProductFromBasketRequest(
      int productId,
      ValueSetter<Response?> completion,
      ) async {
    final storage = await SharedPreferences.getInstance();
    final token = storage.getString(ConstantsKeys.userTOKEN);

    Map<String, String> headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    String endpoint = 'cart/item/$productId/delete';

    await APIManager().deleteRequest(
      endpoint,
      headers,
      null,
      ((response) {
        if (response != null) {
          completion(response);
        } else {
          completion(null);
        }
      }),
    );
  }

  Future changeItemQuantityRequest(
      int itemId,
      int quantity,
      ValueSetter<Response?> completion,
      ) async {
    final storage = await SharedPreferences.getInstance();
    final token = storage.getString(ConstantsKeys.userTOKEN);

    Map<String, String> headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    String endpoint = 'cart/item/$itemId/quantity/$quantity';

    await APIManager().postRequest(
      endpoint,
      headers,
      ((response) {
        if (response != null) {
          completion(response);
        } else {
          completion(null);
        }
      }),
    );
  }

  Future getProductsOnMainRequest(
      int shopId,
      ValueSetter<Response?> completion,
      ) async {
    final storage = await SharedPreferences.getInstance();
    final token = storage.getString(ConstantsKeys.userTOKEN);

    Map<String, String> headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    String endpoint = 'shop/$shopId/products';

    await APIManager().getRequest(
      endpoint,
      headers,
      ((response) {
        if (response != null) {
          completion(response);
        } else {
          completion(null);
        }
      }),
    );
  }

  Future gettingCreatedPetsProfilesRequest(
      String? link,
      ValueSetter<Response?> completion,
      ) async {
    final storage = await SharedPreferences.getInstance();
    final token = storage.getString(ConstantsKeys.userTOKEN);

    Map<String, String> headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    String endpoint = link ?? '';

    await APIManager().getRequest(
      endpoint,
      headers,
      ((response) {
        if (response != null) {
          completion(response);
        } else {
          completion(null);
        }
      }),
    );
  }

  Future getProductsCategoryRequest(
      int page,
      int shopId,
      String? name,
      ValueSetter<Response?> completion,
      ) async {
    final storage = await SharedPreferences.getInstance();
    final token = storage.getString(ConstantsKeys.userTOKEN);

    Map<String, String> headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    String endpoint = 'shop/$shopId/products?page=$page${name != null && name.isNotEmpty ? '&name=$name' : ''}';

    await APIManager().getRequest(
      endpoint,
      headers,
      ((response) {
        if (response != null) {
          completion(response);
        } else {
          completion(null);
        }
      }),
    );
  }

  Future getServicesCategoryRequest(
      int page,
      int shopId,
      String? name,
      ValueSetter<Response?> completion,
      ) async {
    final storage = await SharedPreferences.getInstance();
    final token = storage.getString(ConstantsKeys.userTOKEN);

    Map<String, String> headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    String endpoint = 'shop/$shopId/services?page=$page${name != null && name.isNotEmpty ? '&name=$name' : ''}';

    await APIManager().getRequest(
      endpoint,
      headers,
      ((response) {
        if (response != null) {
          completion(response);
        } else {
          completion(null);
        }
      }),
    );
  }

  Future getProductByIdRequest(
      int id,
      ValueSetter<Response?> completion,
      ) async {
    final storage = await SharedPreferences.getInstance();
    final token = storage.getString(ConstantsKeys.userTOKEN);

    Map<String, String> headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    String endpoint = 'shop/product/$id';

    await APIManager().getRequest(
      endpoint,
      headers,
      ((response) {
        if (response != null) {
          completion(response);
        } else {
          completion(null);
        }
      }),
    );
  }

  Future getServiceByIdRequest(
      int id,
      ValueSetter<Response?> completion,
      ) async {
    final storage = await SharedPreferences.getInstance();
    final token = storage.getString(ConstantsKeys.userTOKEN);

    Map<String, String> headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    String endpoint = 'shop/service/$id';

    await APIManager().getRequest(
      endpoint,
      headers,
      ((response) {
        if (response != null) {
          completion(response);
        } else {
          completion(null);
        }
      }),
    );
  }

  Future communityMemorialsSearchRequest(
      String name,
      int communityID,
      ValueSetter<Response?> completion,
      ) async {
    final storage = await SharedPreferences.getInstance();
    final token = storage.getString(ConstantsKeys.userTOKEN);

    Map<String, String> headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    Map<String, dynamic> body = {
      'name': name,
    };

    String endpoint = 'communities/$communityID/memorials/search';

    await APIManager().getRequestEncodedBody(
      endpoint,
      body,
      headers,
      ((response) {
        if (response != null) {
          completion(response);
        } else {
          completion(null);
        }
      }),
    );
  }

  Future placesSearchRequest(
      CemeterySearchRequest model,
      ValueSetter<Response?> completion,
      ) async {

    Map<String, String> headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    };

    Map<String, dynamic> body = {
      'name': model.name,
    };
    if(model.region.isNotEmpty) {
      body.addAll({
        'region': model.region,
      });
    }
    if(model.district.isNotEmpty) {
      body.addAll({
        'district': model.district,
      });
    }

    String endpoint = 'profiles/cemeteries/search';

    await APIManager().getRequestEncodedBody(
      endpoint,
      body,
      headers,
      ((response) {
        if (response != null) {
          completion(response);
        } else {
          completion(null);
        }
      }),
    );
  }

  void logoutRequest(
      ValueSetter<Response?> completion,
      ) async {
    final storage = await SharedPreferences.getInstance();
    final token = storage.getString(ConstantsKeys.userTOKEN);

    Map<String, String> headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    String endpoint = ConstEndpoints.logoutEndPoint;

    APIManager().postRequest(
      endpoint,
      headers,
      ((response) {
        if (response != null) {
          completion(response);
        } else {
          completion(null);
        }
      }),
    );
  }

  Future gettingAuthorizedMainContentRequest(
      ValueSetter<Response?> completion,
      ) async {
    final storage = await SharedPreferences.getInstance();
    final token = storage.getString(ConstantsKeys.userTOKEN);

    Map<String, String> headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    String endpoint = ConstEndpoints.authorizedMainPage;

    await APIManager().getRequest(
      endpoint,
      headers,
      ((response) {
        if (response != null) {
          completion(response);
        } else {
          completion(null);
        }
      }),
    );
  }

  Future getNotificationCountRequest(
      ValueSetter<Response?> completion,
      ) async {
    final storage = await SharedPreferences.getInstance();
    final token = storage.getString(ConstantsKeys.userTOKEN);

    Map<String, String> headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    String endpoint = ConstEndpoints.getNotificationCount;

    await APIManager().getRequest(
      endpoint,
      headers,
      ((response) {
        if (response != null) {
          completion(response);
        } else {
          completion(null);
        }
      }),
    );
  }

  Future getUserNotificationsRequest(
      ValueSetter<Response?> completion,
      ) async {
    final storage = await SharedPreferences.getInstance();
    final token = storage.getString(ConstantsKeys.userTOKEN);

    Map<String, String> headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    String endpoint = ConstEndpoints.getUserNotifications;

    await APIManager().getRequest(
      endpoint,
      headers,
      ((response) {
        if (response != null) {
          completion(response);
        } else {
          completion(null);
        }
      }),
    );
  }

  Future gettingRelatedProfilesRequest(
      String? gender,
      ValueSetter<Response?> completion,
      ) async {
    final storage = await SharedPreferences.getInstance();
    final token = storage.getString(ConstantsKeys.userTOKEN);

    Map<String, String> headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    String params = gender != null ?
    '?gender=' :
    '';
    String finalGender = gender ?? '';

    String endpoint = ConstEndpoints.gettingRelatedProfiles + params + finalGender;

    await APIManager().getRequest(
      endpoint,
      headers,
      ((response) {
        if (response != null) {
          completion(response);
        } else {
          completion(null);
        }
      }),
    );
  }

  Future gettingReligionsRequest(
      ValueSetter<Response?> completion,
      ) async {
    final storage = await SharedPreferences.getInstance();
    final token = storage.getString(ConstantsKeys.userTOKEN);

    Map<String, String> headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    String endpoint = ConstEndpoints.gettingReligions;

    await APIManager().getRequest(
      endpoint,
      headers,
      ((response) {
        if (response != null) {
          completion(response);
        } else {
          completion(null);
        }
      }),
    );
  }

  Future gettingHobbiesRequest(
      ValueSetter<Response?> completion,
      ) async {
    final storage = await SharedPreferences.getInstance();
    final token = storage.getString(ConstantsKeys.userTOKEN);

    Map<String, String> headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    String endpoint = ConstEndpoints.gettingHobbies;

    await APIManager().getRequest(
      endpoint,
      headers,
      ((response) {
        if (response != null) {
          completion(response);
        } else {
          completion(null);
        }
      }),
    );
  }

  void gettingGuestMainContentRequest(
      ValueSetter<Response?> completion,
      ) {

    Map<String, String> headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    };

    String endpoint = ConstEndpoints.guestMainPage;

    APIManager().getRequest(
      endpoint,
      headers,
      ((response) {
        if (response != null) {
          completion(response);
        } else {
          completion(null);
        }
      }),
    );
  }

  Future gettingGuestCommunitiesRequest(
      ValueSetter<Response?> completion,
      ) async {
    final storage = await SharedPreferences.getInstance();
    final token = storage.getString(ConstantsKeys.userTOKEN);

    Map<String, String> headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    String endpoint = ConstEndpoints.gettingCommunitiesProfile;

    APIManager().getRequest(
      endpoint,
      headers,
      ((response) {
        if (response != null) {
          completion(response);
        } else {
          completion(null);
        }
      }),
    );
  }

  Future gettingCemeteryRequest(
      ValueSetter<Response?> completion,
      ) async {
    final storage = await SharedPreferences.getInstance();
    final token = storage.getString(ConstantsKeys.userTOKEN);

    Map<String, String> headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    String endpoint = ConstEndpoints.gettingCemeteries;

    APIManager().getRequest(
      endpoint,
      headers,
      ((response) {
        if (response != null) {
          completion(response);
        } else {
          completion(null);
        }
      }),
    );
  }

  void getPlaceRequest(
      String input,
      ValueSetter<Response?> completion,
      ) {

    Map<String, String> headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    };

    Map<String, String> params = {
      'key': ConstantsKeys.googleAPIKEY,
      'input': input,
    };

    APIManager().getPlaceRequest(
      headers,
      params,
      ((response) {
        if (response != null) {
          completion(response);
        } else {
          completion(null);
        }
      }),
    );
  }

  Future subscribeToTheCommunityRequest(
      int id,
      ValueSetter<Response?> completion,
      ) async {
    final storage = await SharedPreferences.getInstance();
    final token = storage.getString(ConstantsKeys.userTOKEN);

    Map<String, String> headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    String endpoint = 'communities/$id/subscribe';

    APIManager().postRequest(
      endpoint,
      headers,
      ((response) {
        if (response != null) {
          completion(response);
        } else {
          completion(null);
        }
      }),
    );
  }

  Future unsubscribeFromTheCommunityRequest(
      int id,
      ValueSetter<Response?> completion,
      ) async {
    final storage = await SharedPreferences.getInstance();
    final token = storage.getString(ConstantsKeys.userTOKEN);

    Map<String, String> headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    String endpoint = 'communities/$id/unsubscribe';

    APIManager().postRequest(
      endpoint,
      headers,
      ((response) {
        if (response != null) {
          completion(response);
        } else {
          completion(null);
        }
      }),
    );
  }


  Future subscribeToTheCemeteryRequest(
      int id,
      ValueSetter<Response?> completion,
      ) async {
    final storage = await SharedPreferences.getInstance();
    final token = storage.getString(ConstantsKeys.userTOKEN);

    Map<String, String> headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    String endpoint = 'profiles/cemeteries/$id/subscribe';

    await APIManager().postRequest(
      endpoint,
      headers,
      ((response) {
        if (response != null) {
          completion(response);
        } else {
          completion(null);
        }
      }),
    );
  }

  Future unsubscribeFromTheCemeteryRequest(
      int id,
      ValueSetter<Response?> completion,
      ) async {
    final storage = await SharedPreferences.getInstance();
    final token = storage.getString(ConstantsKeys.userTOKEN);

    Map<String, String> headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    String endpoint = 'profiles/cemeteries/$id/unsubscribe';

    APIManager().postRequest(
      endpoint,
      headers,
      ((response) {
        if (response != null) {
          completion(response);
        } else {
          completion(null);
        }
      }),
    );
  }

  Future gettingPetProfileRequest(
      int id,
      ValueSetter<Response?> completion,
      ) async {
    final storage = await SharedPreferences.getInstance();
    final token = storage.getString(ConstantsKeys.userTOKEN);

    Map<String, String> headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    String endpoint = ConstEndpoints.gettingPetProfile + id.toString();

    APIManager().getRequest(
      endpoint,
      headers,
      ((response) {
        if (response != null) {
          completion(response);
        } else {
          completion(null);
        }
      }),
    );
  }

  Future getUserEventsRequest(
      ValueSetter<Response?> completion,
      ) async {
    final storage = await SharedPreferences.getInstance();
    final token = storage.getString(ConstantsKeys.userTOKEN);

    Map<String, String> headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    String endpoint = ConstEndpoints.getUserEvents;

    APIManager().getRequest(
      endpoint,
      headers,
      ((response) {
        if (response != null) {
          completion(response);
        } else {
          completion(null);
        }
      }),
    );
  }

  Future gettingPeopleProfileRequest(
      int id,
      ValueSetter<Response?> completion,
      ) async {
    final storage = await SharedPreferences.getInstance();
    final token = storage.getString(ConstantsKeys.userTOKEN);

    Map<String, String> headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    print(token);

    String endpoint = ConstEndpoints.gettingPeopleProfile + id.toString();

    APIManager().getRequest(
      endpoint,
      headers,
      ((response) {
        if (response != null) {
          completion(response);
        } else {
          completion(null);
        }
      }),
    );
  }

  void getUserInfoRequest(
      ValueSetter<Response?> completion,
      ) async {
    final storage = await SharedPreferences.getInstance();
    final token = storage.getString(ConstantsKeys.userTOKEN);

    Map<String, String> headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    print(token);

    String endpoint = ConstEndpoints.getUserInfo;

    APIManager().getRequest(
      endpoint,
      headers,
      ((response) {
        if (response != null) {
          completion(response);
        } else {
          completion(null);
        }
      }),
    );
  }

  Future gettingCommunitiesProfileRequest(
      int id,
      ValueSetter<Response?> completion,
      ) async {
    try {
      final storage = await SharedPreferences.getInstance();
      final token = storage.getString(ConstantsKeys.userTOKEN);

      Map<String, String> headers = {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      };

      print(token);

      String endpoint = 'communities/' + id.toString();

      await APIManager().getRequest(
        endpoint,
        headers,
        ((response) {
          if (response != null) {
            completion(response);
          } else {
            completion(null);
          }
        }),
      );
    } catch(error) {
      SVProgressHUD.dismiss();
      print('$error');
    }
  }

  void gettingCemeteryProfileRequest(
      int id,
      ValueSetter<Response?> completion,
      ) async {
    final storage = await SharedPreferences.getInstance();
    final token = storage.getString(ConstantsKeys.userTOKEN);

    Map<String, String> headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    print(token);

    String endpoint = ConstEndpoints.gettingCemeteryProfile + id.toString();

    APIManager().getRequest(
      endpoint,
      headers,
      ((response) {
        if (response != null) {
          completion(response);
        } else {
          completion(null);
        }
      }),
    );
  }

  void addMemorialToTheCommunityRequest(
      int communityId,
      AddMemorialToTheCommunityRequestModel model,
      ValueSetter<Response?> completion,
      ) async {
    final storage = await SharedPreferences.getInstance();
    final token = storage.getString(ConstantsKeys.userTOKEN);

    Map<String, String> headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    Map<String, dynamic> body = {
      'memorial_id': model.memorialId,
      'memorial_type': model.memorialType,
    };

    String startPoint = ConstantsUrls.baseUrl;
    String endpoint = 'communities/$communityId/memorials/add';

    APIManager().postRequestWithBody(
      startPoint,
      endpoint,
      headers,
      body,
      ((response) {
        if (response != null) {
          completion(response);
        } else {
          completion(null);
        }
      }),
    );
  }

  Future createPostRequest(
      CreatePostRequestModel model,
      ValueSetter<StreamedResponse?> completion,
      ) async {
    final storage = await SharedPreferences.getInstance();
    final token = storage.getString(ConstantsKeys.userTOKEN);

    Map<String, String> headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    late final Map<String, String> body;

    body = {
      'community_id': model.communityId.toString(),
    };
    if(model.title.isNotEmpty) {
      body.addAll({
        'title': model.title,
      });
    }
    if(model.description.isNotEmpty) {
      body.addAll({
        'description': model.description,
      });
    }
    if(model.publishedAt.isNotEmpty) {
      body.addAll({
        'published_at': model.publishedAt,
      });
    }

    print(body);

    String endpoint = ConstEndpoints.createPost;

    APIManager().multiPartRequestForCreatePost(
      endpoint,
      model.postMedia,
      body,
      headers,
      ((response) {
        if (response != null) {
          completion(response);
        }
        else {
          completion(null);
        }
      }),
    );
  }

  void sendCodeForPasswordRecoveryRequest(
      String email,
      ValueSetter<Response?> completion,
      ) async {
    final Map<String, String> headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    };

    String endpoint = ConstEndpoints.sendCodeForPasswordRecovery + '?email=$email';

    APIManager().postRequest(
      endpoint,
      headers,
      ((response) {
        if (response != null) {
          completion(response);
        } else {
          completion(null);
        }
      }),
    );
  }

  void passwordRecoveryRequest(
      PasswordRecoveryRequestModel model,
      ValueSetter<Response?> completion,
      ) async {
    final Map<String, String> headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    };

    final Map<String, dynamic> body = {
      'email': model.email,
      'password': model.password,
      'password_confirmation': model.passwordConfirmation,
      'verification_code': model.verificationCode,
    };

    String startPoint = ConstantsUrls.baseUrl;
    String endpoint = ConstEndpoints.passwordRecovery;

    APIManager().postRequestWithBody(
      startPoint,
      endpoint,
      headers,
      body,
      ((response) {
        if (response != null) {
          completion(response);
        } else {
          completion(null);
        }
      }),
    );
  }

  void gettingPostsOfCommunityRequest(
      int id,
      int page,
      ValueSetter<Response?> completion,
      ) async {
    final storage = await SharedPreferences.getInstance();
    final token = storage.getString(ConstantsKeys.userTOKEN);

    final Map<String, String> headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    String endpoint = 'communities/$id/posts?page=$page';

    APIManager().getRequest(
      endpoint,
      headers,
      ((response) {
        if (response != null) {
          completion(response);
        } else {
          completion(null);
        }
      }),
    );
  }

  Future gettingMemorialsOfCommunityRequest(
      int id,
      int page,
      ValueSetter<Response?> completion,
      ) async {
    final storage = await SharedPreferences.getInstance();
    final token = storage.getString(ConstantsKeys.userTOKEN);

    final Map<String, String> headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    String endpoint = 'communities/$id/memorials?page=$page';

    await APIManager().getRequest(
      endpoint,
      headers,
      ((response) {
        if (response != null) {
          completion(response);
        } else {
          completion(null);
        }
      }),
    );
  }

  Future deletePostRequest(
      int postId,
      ValueSetter<Response?> completion,
      ) async {
    final storage = await SharedPreferences.getInstance();
    final token = storage.getString(ConstantsKeys.userTOKEN);

    Map<String, String> headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    String endpoint = 'communities/posts/$postId';

    APIManager().deleteRequest(
      endpoint,
      headers,
      null,
      ((response) {
        if (response != null) {
          completion(response);
        }
        else {
          completion(null);
        }
      }),
    );
  }

  Future pinPostRequest(
      int postId,
      ValueSetter<Response?> completion,
      ) async {
    final storage = await SharedPreferences.getInstance();
    final token = storage.getString(ConstantsKeys.userTOKEN);

    Map<String, String> headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    String endpoint = 'communities/posts/$postId/pin';

    APIManager().putRequest(
      endpoint,
      headers,
      ((response) {
        if (response != null) {
          completion(response);
        }
        else {
          completion(null);
        }
      }),
    );
  }

  Future unPinPostRequest(
      int postId,
      ValueSetter<Response?> completion,
      ) async {
    final storage = await SharedPreferences.getInstance();
    final token = storage.getString(ConstantsKeys.userTOKEN);

    Map<String, String> headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    String endpoint = 'communities/posts/$postId/unpin';

    APIManager().putRequest(
      endpoint,
      headers,
      ((response) {
        if (response != null) {
          completion(response);
        }
        else {
          completion(null);
        }
      }),
    );
  }

  Future editPostRequest(
      EditPostRequestModel model,
      ValueSetter<StreamedResponse?> completion,
      ) async {
    final storage = await SharedPreferences.getInstance();
    final token = storage.getString(ConstantsKeys.userTOKEN);

    late final Map<String, String> body;
    final Map<String, String> headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    body = {
      'title': model.title ?? '',
      'description': model.description ?? '',
      '_method': model.method,
    };

    if(model.title != null && model.title!.isNotEmpty) {
      body.addAll({
        'title': model.title ?? '',
      });
    }
    if(model.description != null && model.description!.isNotEmpty) {
      body.addAll({
        'description': model.description ?? '',
      });
    }

    String endpoint = 'communities/posts/${model.postId}';

    APIManager().multiPartRequestForEditPost(
      model,
      endpoint,
      body,
      headers,
      ((response) {
        if(response != null) {
          completion(response);
        } else {
          completion(null);
        }
      }),
    );
  }

  Future removeMemorialFromTheCommunityRequest(
      int communityId,
      AddMemorialToTheCommunityRequestModel model,
      ValueSetter<Response?> completion,
      ) async {
    final storage = await SharedPreferences.getInstance();
    final token = storage.getString(ConstantsKeys.userTOKEN);

    Map<String, String> headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    Map<String, dynamic> body = {
      'memorial_id': model.memorialId,
      'memorial_type': model.memorialType,
    };

    print(body);

    String endpoint = 'communities/$communityId/memorials/remove';

    await APIManager().deleteRequest(
      endpoint,
      headers,
      body,
      ((response) {
        if (response != null) {
          completion(response);
        } else {
          completion(null);
        }
      }),
    );
  }

  Future creatingProfileRequest(
      File? avatar,
      File? banner,
      File? deathCertificate,
      List<File>? gallery,
      List<String> hobbies,
      CreatingPersonsProfileRequestModel model,
      ValueSetter<StreamedResponse?> completion,
      ) async {
    final storage = await SharedPreferences.getInstance();
    final token = storage.getString(ConstantsKeys.userTOKEN);

    Map<String, String> headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

   Map<String, String> body = {
     'first_name': model.firstName,
     'last_name': model.lastName,
     'middle_name': model.middleName ?? '',
     'gender': model.gender.toLowerCase(),
     'date_birth': model.dateBirth,
     'date_death': model.dateDeath,
     'death_reason': model.deathReason ?? '',
     'birth_place': model.birthPlace,
     'description': model.description,
     'access': model.access.toLowerCase(),
     'burial_coords[lat]': model.coords.lat.toString(),
     'burial_coords[lng]': model.coords.lng.toString(),
     'as_draft': model.asDraft,
    };

    if(model.religion != null && model.religion != 0) {
      body.addAll({
        'religion_id': model.religion.toString(),
      });
    }

    if(model.cemeteryId != null && model.cemeteryId != 0) {
      body.addAll({
        'cemetery_id': model.cemeteryId.toString(),
      });
    }

   String endpoint = ConstEndpoints.creatingProfile;

    await APIManager().multiPartRequestForProfile(
      avatar,
      banner,
      deathCertificate,
      gallery,
      hobbies,
      null,
      endpoint,
      body,
      headers,
      ((response) {
        if (response != null) {
          completion(response);
        } else {
          completion(null);
        }
      }),
    );
  }

  void creatingPetRequest(
      File? avatar,
      File? banner,
      List<File>? gallery,
      CreatingPetRequestModel model,
      ValueSetter<StreamedResponse?> completion,
      ) async {
    final storage = await SharedPreferences.getInstance();
    final token = storage.getString(ConstantsKeys.userTOKEN);

    Map<String, String> headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    Map<String, String> body = {
      'name': model.name,
      'breed': model.breed,
      'date_birth': model.dateBirth,
      'date_death': model.dateDeath,
      'death_reason': model.deathReason,
      'birth_place': model.birthPlace,
      'description': model.description,
      'access': model.access.toLowerCase(),
      'as_draft': model.asDraft,
    };

    String endpoint = ConstEndpoints.creatingPet;

    APIManager().multiPartRequestForProfile(
      avatar,
      banner,
      null,
      gallery,
      null,
      null,
      endpoint,
      body,
      headers,
      ((response) {
        if (response != null) {
          completion(response);
        }
        else {
          completion(null);
        }
      }),
    );
  }

  void creatingCemeteryRequest(
      File? avatar,
      File? banner,
      List<File>? gallery,
      CreatingCemeteryRequestModel model,
      ValueSetter<StreamedResponse?> completion,
      ) async {
    final storage = await SharedPreferences.getInstance();
    final token = storage.getString(ConstantsKeys.userTOKEN);

    Map<String, String> headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    Map<String, String> body = {
      'title': model.title,
      'subtitle': model.subtitle,
      'email': model.email,
      'phone': model.phone,
      'schedule': model.schedule ?? '',
      'description': model.description ?? '',
      'access': model.access,
      'as_draft': model.asDraft,
    };

    String endpoint = ConstEndpoints.creatingPet;

    APIManager().multiPartRequestForProfile(
      avatar,
      banner,
      null,
      gallery,
      null,
      null,
      endpoint,
      body,
      headers,
      (response) {
        if (response != null) {
          completion(response);
        } else {
          completion(null);
        }
      },
    );
  }

  Future creatingCommunityRequest(
      CreatingCommunityProfileRequestModel model,
      ValueSetter<StreamedResponse?> completion,
      ) async {
    final storage = await SharedPreferences.getInstance();
    final token = storage.getString(ConstantsKeys.userTOKEN);

    Map<String, String> headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    Map<String, String> body = {
      'title': model.title,
      'subtitle': model.subtitle,
      'description': model.description,
      'email': model.email,
      'phone': model.phone,
      'website': model.website ?? '',
      'address': model.address,
    };

    int i = 0;
    if(model.socialLinks.isNotEmpty) {
      for (String element in model.socialLinks) {
        i++;
        body['social_links[internet$i]'] = element;
      }
    }

    String endpoint = ConstEndpoints.creatingCommunity;

    await APIManager().multiPartRequestForProfile(
      model.avatar,
      model.banner,
      null,
      model.gallery,
      null,
      null,
      endpoint,
      body,
      headers,
      (response) {
        if (response != null) {
          completion(response);
        } else {
          completion(null);
        }
      },
    );
  }

  void editCommunityRequest(
      int communityId,
      EditCommunityRequestModel model,
      ValueSetter<StreamedResponse?> completion,
      ) async {
    final storage = await SharedPreferences.getInstance();
    final token = storage.getString(ConstantsKeys.userTOKEN);

    Map<String, String> headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    Map<String, String> body = {
      'title': model.title,
      'subtitle': model.subtitle,
      'description': model.description,
      'email': model.email,
      'phone': model.phone,
      'website': model.website ?? '',
      'address': model.address,
      '_method': 'PUT',
    };

    String endpoint = 'communities/$communityId';

    APIManager().multiPartRequestForEditCommunity(
      model,
      endpoint,
      body,
      headers,
      (response) {
        if (response != null) {
          completion(response);
        } else {
          completion(null);
        }
      },
    );
  }

  Future searchCemeteryForHumanRequest(
      String name,
      ValueSetter<Response?> completion,
      ) async {
    final storage = await SharedPreferences.getInstance();
    final token = storage.getString(ConstantsKeys.userTOKEN);

    Map<String, String> headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    String endpoint = 'profiles/cemeteries/search?name=$name';

    APIManager().getRequest(
      endpoint,
      headers,
      (response) {
        if (response != null) {
          completion(response);
        } else {
          completion(null);
        }
      },
    );
  }

  Future searchRegionsCemeteryRequest(
      String region,
      ValueSetter<Response?> completion,
      ) async {
    final storage = await SharedPreferences.getInstance();
    final token = storage.getString(ConstantsKeys.userTOKEN);

    Map<String, String> headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    String endpoint = 'profiles/cemeteries/regions?region=$region';

    APIManager().getRequest(
      endpoint,
      headers,
      (response) {
        if (response != null) {
          completion(response);
        } else {
          completion(null);
        }
      },
    );
  }

  Future getDistrictsCemeteryRequest(
      String region,
      ValueSetter<Response?> completion,
      ) async {
    final storage = await SharedPreferences.getInstance();
    final token = storage.getString(ConstantsKeys.userTOKEN);

    Map<String, String> headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    Map<String, dynamic> body = {
      'region': region,
    };

    String endpoint = ConstEndpoints.getDistrictsCemetery;

    APIManager().getRequestEncodedBody(
      endpoint,
      body,
      headers,
      (response) {
        if (response != null) {
          completion(response);
        } else {
          completion(null);
        }
      },
    );
  }

  void updatingUserInformationRequest(
      File? file,
      UpdatingUserInformationRequestModel model,
      ValueSetter<StreamedResponse?> completion,
      ) async {
    final storage = await SharedPreferences.getInstance();
    final token = storage.getString(ConstantsKeys.userTOKEN);

    Map<String, String> headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    Map<String, String> body = {
      'username': model.username,
      'email': model.email,
      'password': model.password ?? '',
      'password_confirmation': model.passwordConfirmation ?? '',
      '_method': 'PUT',
    };

    String endpoint = ConstEndpoints.userInfoEndPoint;

    APIManager().multiPartRequest(
      file,
      endpoint,
      body,
      headers, (response) {
        if (response != null) {
          completion(response);
        } else {
          completion(null);
        }
      },
    );
  }
}