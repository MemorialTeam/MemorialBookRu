import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svprogresshud/flutter_svprogresshud.dart';
import 'package:image_picker/image_picker.dart';
import 'package:memorial_book/models/pet/response/getting_created_pets_profiles_response_model.dart';
import 'package:memorial_book/provider/auth_provider.dart';
import 'package:memorial_book/provider/tab_bar_provider.dart';
import 'package:provider/provider.dart';
import '../data_handler/mapper.dart';
import '../data_handler/service.dart';
import '../helpers/constants.dart';
import '../helpers/enums.dart';
import '../models/people/response/get_people_info_response_model.dart';
import '../models/people/response/getting_created_humans_profiles_response_model.dart';
import '../models/pet/response/get_pet_info_response_model.dart';
import '../models/user/request/updating_user_information_request_model.dart';
import '../models/user/response/user_info_response_model.dart';
import '../screens/main_flow/quick_links_screens/family_tree_screen.dart';

class AccountProvider extends ChangeNotifier {
  final service = Service();
  final mapper = Mapper();

  final ValueNotifier<UserInfoResponseModel?> user = ValueNotifier(null);

  ImagePicker picker = ImagePicker();

  File? avatar;

  void pickAvatar() async {
    XFile? image = await picker.pickImage(source: ImageSource.gallery);
    avatar = File(image!.path);
    notifyListeners();
  }

  LoadingState loadingState = LoadingState.loading;

  void setLoading() {
    loadingState = LoadingState.loading;
    notifyListeners();
  }

  Future getUserInfo(BuildContext context) async {
    try {
      service.getUserInfoRequest((response) {
        mapper.getUserInfoResponse(response, (model) {
          if(model != null) {
            if(model.status == true) {
              loadingState = LoadingState.active;
            }
            else {
              final tabBarProvider = Provider.of<TabBarProvider>(context,listen: false);
              final authProvider = Provider.of<AuthProvider>(context, listen: false);
              if(model.message == 'Unauthenticated.') {
                authProvider.logoutAuthorized(tabBarProvider.mainContext);
              }
              loadingState = LoadingState.error;
            }

            user.value = model;
            notifyListeners();
          }
          else {
            loadingState = LoadingState.error;
            user.value = UserInfoResponseModel(
              message: 'Something went wrong...',
            );
            notifyListeners();
          }
        });
      });
    } catch(error) {
      loadingState = LoadingState.error;
      user.value = UserInfoResponseModel(
        message: '$error',
      );
      notifyListeners();
    }
  }

  void updatingUserInformation(
      BuildContext context,
      String username,
      String email,
      String? password,
      String? passwordConfirmation,
      File? selectedAvatar,
      ) async {
    try {
      SVProgressHUD.show();
      final requestModel = UpdatingUserInformationRequestModel(
        username: username,
        email: email,
        password: password,
        passwordConfirmation: passwordConfirmation,
      );
      service.updatingUserInformationRequest(selectedAvatar, requestModel, (response) {
        mapper.statusMultiPartResponse(response, (model) async {
          SVProgressHUD.dismiss();
          if(model?.status == true) {
            await getUserInfo(context);
            await Navigator.maybePop(context).whenComplete(() {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                    'Changes saved',
                  ),
                ),
              );
            });
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  model?.message ?? 'Error',
                ),
              ),
            );
          }
        });
      });
    } catch (error) {
      print('the following error occurred (sign up request) ---> $error');
    }

  }

  bool getPetProfileState = false;
  GetPetInfoResponseModel? petProfileModel;

  Future gettingPetProfile(BuildContext context, int id) async {
    getPetProfileState = true;
    try {
      service.gettingPetProfileRequest(id, (response) {
        getPetProfileState = false;
        notifyListeners();
        mapper.gettingPetProfileResponse(response, (model) {
          if(model != null) {
            if(model.status == true) {
              petProfileModel = model;
              notifyListeners();
            }
          }
        });
      });
    } catch (error) {
      SVProgressHUD.dismiss();
      print('the following error occurred (sign up request) ---> $error');
    }
  }

  Future getUserEvents() async {
    await service.getUserEventsRequest((response) {
      print(response?.body);
    });
  }

  String religionIcon(String religionName) {
    switch(religionName) {
      case 'Baháʼí Faith':
        return ConstantsAssets.bahaiFaithImage;
      case 'Freemasonry':
        return ConstantsAssets.freemasonryImage;
      case 'Buddhism':
        return ConstantsAssets.buddhismImage;
      case 'Christianity':
        return ConstantsAssets.christianityImage;
      case 'Orthodoxy':
        return ConstantsAssets.orthodoxyImage;
      case 'Confucianism':
        return ConstantsAssets.confucianismImage;
      case 'Hinduism':
        return ConstantsAssets.hinduismImage;
      case 'Islam':
        return ConstantsAssets.islamImage;
      case 'Jainism':
        return ConstantsAssets.jainismImage;
      case 'Judaism':
        return ConstantsAssets.judaismImage;
      case 'Sikhism':
        return ConstantsAssets.sikhismImage;
      case 'Shinto':
        return ConstantsAssets.shintoImage;
      case 'Taoism':
        return ConstantsAssets.taoismImage;
      case 'Zoroastrianism':
        return ConstantsAssets.zoroastrianismImage;
      case 'None':
        return '';
      default:
        return '';
    }
  }

  CreatedHumansDataResponseModel? createdHumanModel;
  String? createdHumanPageNumber = 'user/profiles/humans?page=1';
  bool createdHumanPaginationLoading = false;
  bool humanLoading = false;

  Future gettingCreatedHumansProfiles(ValueSetter<GettingCreatedHumansProfilesResponseModel?> completion) async {
    humanLoading = true;
    createdHumanPageNumber = 'user/profiles/humans?page=1';
    createdHumanModel = null;
    notifyListeners();
    try {
      await service.gettingCreatedHumansProfilesRequest(createdHumanPageNumber, (response) {
        humanLoading = false;
        notifyListeners();
        mapper.gettingCreatedHumansProfilesResponse(response, (model) {
          if(model != null) {
            if(model.status == true) {
              createdHumanModel = model.humans;
              createdHumanPageNumber = model.humans?.links?.nextPageUrl?.replaceAll('https://memorialbook.site/api/v1/', '');
              notifyListeners();
            }
            completion(model);
          } else {
            completion(null);
          }
        });
      });
    } catch(error) {
      SVProgressHUD.dismiss();
      print('$error');
    }
  }
  Future paginationCreatedHumans() async {
    createdHumanPaginationLoading = true;
    service.gettingCreatedHumansProfilesRequest(createdHumanPageNumber, (response) {
      createdHumanPaginationLoading = false;
      notifyListeners();
      mapper.gettingCreatedHumansProfilesResponse(response, (model) {
        if(model != null) {
          if (model.status == true) {
            if (model.humans?.data != null) {
              createdHumanPageNumber = model.humans?.links?.nextPageUrl?.replaceAll('https://memorialbook.site/api/v1/', '');
              createdHumanModel!.data!.addAll(model.humans!.data!);
              notifyListeners();
            }
          }
        }
      });
    });
  }

  CreatedPetsDataResponseModel? createdPetsModel;
  bool createdPetPaginationLoading = false;
  String? createdPetPageNumber = 'user/profiles/pets?page=1';
  bool petLoading = false;

  Future gettingCreatedPetsProfiles(ValueSetter<GettingCreatedPetsProfilesResponseModel?> completion) async {
    petLoading = true;
    createdPetPageNumber = 'user/profiles/pets?page=1';
    createdPetsModel = null;
    try {
    await service.gettingCreatedPetsProfilesRequest(createdPetPageNumber, (response) {
      petLoading = false;
      notifyListeners();
      mapper.gettingCreatedPetsProfilesResponse(response, (model) {
        if(model != null) {
          if(model.status == true) {
            createdPetsModel = model.pets;
            createdPetPageNumber = model.pets?.links?.nextPageUrl;
            notifyListeners();
          }
          completion(model);
        } else {
          completion(null);
        }
      });
    });
    } catch(error) {
      SVProgressHUD.dismiss();
      print('$error');
    }
  }
  Future paginationCreatedPets() async {
    createdHumanPaginationLoading = true;
    service.gettingCreatedPetsProfilesRequest(createdPetPageNumber, (response) {
      mapper.gettingCreatedPetsProfilesResponse(response, (model) {
        createdHumanPaginationLoading = false;
        notifyListeners();
        if(model != null) {
          if (model.status == true) {
            if (model.pets?.data != null) {
              createdPetPageNumber = model.pets?.links?.nextPageUrl;
              createdPetsModel!.data!.addAll(model.pets!.data!);
              notifyListeners();
            }
          }
        }
      });
    });
  }

  bool usersProfileButtonState = true;

  void switchProfileButtonButtonState() {
    usersProfileButtonState = !usersProfileButtonState;
    notifyListeners();
  }

  void setProfileButtonState(BuildContext context, bool setState) {
    usersProfileButtonState = setState;
    notifyListeners();
    Navigator.push(
      context,
      CupertinoDialogRoute(
        builder: (context) => const FamilyTreeScreen(),
        context: context,
      ),
    );
  }


  bool getPeopleProfileState = false;
  GetPeopleInfoResponseModel? peopleProfileModel;

  Future gettingPeopleProfile(
      BuildContext context,
      int id,
      ) async {
    getPeopleProfileState = true;
    peopleProfileModel = null;
    try {
      await service.gettingPeopleProfileRequest(id, (response) {
        getPeopleProfileState = false;
        notifyListeners();
        mapper.gettingPeopleProfileResponse(response, (model) {
          if(model != null) {
            if(model.status == true) {
              peopleProfileModel = model;
              notifyListeners();
            }
          }
        });
      });
    } catch (error) {
      SVProgressHUD.dismiss();
      print('the following error occurred (sign up request) ---> $error');
    }
  }
}