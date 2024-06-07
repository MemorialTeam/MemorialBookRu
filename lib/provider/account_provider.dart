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

  void gettingPetProfile(
      BuildContext context,
      int id,
      ) async {
    getPetProfileState = true;
    notifyListeners();
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
  bool createdHumanPaginationLoading = false;
  int createdHumanPageNumber = 1;
  int createdHumanLastPageNumber = 1;

  Future gettingCreatedHumansProfiles(ValueSetter<GettingCreatedHumansProfilesResponseModel?> completion) async {
    createdHumanPageNumber = 1;
    createdHumanModel = null;
    notifyListeners();
    SVProgressHUD.show();
    try {
      await service.gettingCreatedHumansProfilesRequest(createdHumanPageNumber, (response) {
        mapper.gettingCreatedHumansProfilesResponse(response, (model) {
          print(response?.body);
          SVProgressHUD.dismiss();
          if(model != null) {
            if(model.status == true) {
              createdHumanModel = model.humans;
              createdHumanLastPageNumber = model.humans?.lastPage ?? 1;
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
    createdHumanPageNumber++;
    createdHumanPaginationLoading = true;
    notifyListeners();
    SVProgressHUD.show();
    service.gettingCreatedHumansProfilesRequest(createdHumanPageNumber, (response) {
      mapper.gettingCreatedHumansProfilesResponse(response, (model) {
        SVProgressHUD.dismiss();
        createdHumanPaginationLoading = false;
        notifyListeners();
        if(model != null) {
          if (model.status == true) {
            if (model.humans?.data != null) {
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
  int createdPetPageNumber = 1;
  int createdPetLastPageNumber = 1;

  Future gettingCreatedPetsProfiles(ValueSetter<GettingCreatedPetsProfilesResponseModel?> completion) async {
    createdPetPageNumber = 1;
    createdPetsModel = null;
    notifyListeners();
    SVProgressHUD.show();
    try {
    await service.gettingCreatedPetsProfilesRequest(createdPetPageNumber, (response) {
      mapper.gettingCreatedPetsProfilesResponse(response, (model) {
        print(response?.body);
        if(model != null) {
          if(model.status == true) {
            createdPetsModel = model.pets;
            createdPetLastPageNumber = model.pets?.lastPage ?? 1;
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
    createdHumanPageNumber++;
    createdHumanPaginationLoading = true;
    notifyListeners();
    SVProgressHUD.show();
    service.gettingCreatedPetsProfilesRequest(createdPetPageNumber, (response) {
      mapper.gettingCreatedPetsProfilesResponse(response, (model) {
        SVProgressHUD.dismiss();
        createdHumanPaginationLoading = false;
        notifyListeners();
        if(model != null) {
          if (model.status == true) {
            if (model.pets?.data != null) {
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

  Future gettingUserProfiles(BuildContext context, bool? setState) async {
    bool humanState = false;
    bool petState = false;

    if(setState != null) {
      usersProfileButtonState = setState;
      notifyListeners();
    }
    await gettingCreatedHumansProfiles((model) {
      if(model != null) {
        if(model.status == true) {
          humanState = true;
          notifyListeners();
        } else {
          humanState = false;
          notifyListeners();
        }
      } else {
        humanState = false;
        notifyListeners();
      }
    });
    await gettingCreatedPetsProfiles((model) {
      if(model != null) {
        if(model.status == true) {
          petState = true;
          notifyListeners();
        } else {
          petState = false;
          notifyListeners();
        }
      } else {
        petState = false;
        notifyListeners();
      }
    });
    if(humanState == true || petState == true) {
      await Navigator.push(
        context,
        CupertinoPageRoute(
          builder: (context) => FamilyTreeScreen(),
        ),
      );
    } else {
      print('error');
    }
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