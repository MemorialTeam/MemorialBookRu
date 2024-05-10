import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_geocoder/geocoder.dart';
import 'package:flutter_svprogresshud/flutter_svprogresshud.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:memorial_book/models/common/community_edit_model.dart';
import 'package:memorial_book/models/common/coords_request.dart';
import 'package:memorial_book/models/communitites/request/edit_community_request_model.dart';
import 'package:memorial_book/models/create_profile/request/creating_community_profile_request_model.dart';
import 'package:memorial_book/models/create_profile/response/get_religions_response_model.dart';
import 'package:memorial_book/provider/account_provider.dart';
import 'package:memorial_book/provider/message_dialogs_provider.dart';
import 'package:memorial_book/test_data.dart';
import 'package:memorial_book/widgets/element_selection/element_selection_widget.dart';
import 'package:memorial_book/widgets/element_selection/generate_element.dart';
import 'package:memorial_book/widgets/element_selection/spinning_cylinder_widget.dart';
import 'package:provider/provider.dart';
import '../data_handler/mapper.dart';
import '../data_handler/service.dart';
import '../helpers/constants.dart';
import '../models/catalog/request/edit_post_request_model.dart';
import '../models/cemetery/request/creating_cemetery_request_model.dart';
import '../models/cemetery/response/search_cemetery_for_human_response_model.dart';
import '../models/common/determining_changes_post_data_model.dart';
import '../models/common/map_response_model.dart';
import '../models/common/status_response_model.dart';
import '../models/communitites/response/get_community_info_response_model.dart';
import '../models/create_profile/request/create_post_request_model.dart';
import '../models/create_profile/response/get_hobbies_response_model.dart';
import '../models/people/request/creating_persons_profile_request_model.dart';
import '../models/people/response/related_profiles_response_model.dart';
import '../models/pet/request/creating_pet_request_model.dart';
import 'package:http/http.dart';
import 'package:path_provider/path_provider.dart';

import 'auth_provider.dart';
import 'catalog_provider.dart';

class ProfileCreationProvider extends ChangeNotifier {

  final service = Service();
  final mapper = Mapper();

  PageController pageController = PageController();

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController middleNameController = TextEditingController();
  TextEditingController birthDateNameController = TextEditingController();
  TextEditingController deathDateNameController = TextEditingController();
  TextEditingController profileEmailController = TextEditingController();
  TextEditingController profileDeathCauseController = TextEditingController();
  TextEditingController profileBirthPlaceController = TextEditingController();
  TextEditingController profileDescriptionController = TextEditingController();
  TextEditingController profileHobbiesController = TextEditingController();
  ///
  TextEditingController placesNameController = TextEditingController();
  TextEditingController placesNameInLatinController = TextEditingController();
  TextEditingController placesSignatureController = TextEditingController();
  TextEditingController placesEmailController = TextEditingController();
  TextEditingController placesPhoneNumberController = TextEditingController();
  TextEditingController placesDescriptionController = TextEditingController();
  ///
  TextEditingController communitiesNameController = TextEditingController();
  TextEditingController communitiesNameInLatinController = TextEditingController();
  TextEditingController communitiesSignatureController = TextEditingController();
  TextEditingController communitiesEmailController = TextEditingController();
  TextEditingController communitiesLocationController = TextEditingController();
  TextEditingController communitiesPhoneNumberController = TextEditingController();
  TextEditingController websiteController = TextEditingController();
  TextEditingController communitiesDescriptionController = TextEditingController();

  TextEditingController petNameController = TextEditingController();
  TextEditingController petBreedController = TextEditingController();
  TextEditingController petBirthDateController = TextEditingController();
  TextEditingController petDeathDateController = TextEditingController();
  TextEditingController petBirthPlaceController = TextEditingController();
  TextEditingController petBurialPlaceController = TextEditingController();
  TextEditingController petDeathCauseController = TextEditingController();
  TextEditingController petDescriptionController = TextEditingController();

  TextEditingController searchCemeteryController = TextEditingController();

  FocusNode searchCemeteryFocusNode = FocusNode();

  SearchCemeteryForHumanResponseModel? searchedCemeteryModel;
  bool searchedCemeteryBool = false;

  int? selectedCemeteryId;

  void clearSelectedCemetery() {
    selectedCemeteryId = null;
    selectedCemetery = '';
    notifyListeners();
  }

  Future setSearchedCemetery(String cemeteryName, String cemeteryAddress, int id) async {
    String name = '$cemeteryName $cemeteryAddress';
    selectedCemetery = name;
    selectedCemeteryId = id;
    searchCemeteryController.value = TextEditingValue(
      text: name,
    );
    await searchCemeteryForHuman(cemeteryName);
    notifyListeners();
  }

  void clearSearchedCemeteryData() {
    searchedCemeteryModel = null;
    searchedCemeteryBool = false;
    searchCemeteryController.clear();
    notifyListeners();
  }

  Future searchCemeteryForHuman(String name) async {
    searchedCemeteryBool = true;
    notifyListeners();
    await service.searchCemeteryForHumanRequest(name, (response) {
      SVProgressHUD.dismiss();
      mapper.searchCemeteryForHumanResponse(response, (model) {
        searchedCemeteryBool = false;
        notifyListeners();
        if(model != null) {
          if(model.status == true) {
            searchedCemeteryModel = model;
            notifyListeners();
          }
        }
      });
    });

  }

  void disposePetCreate() {
    petNameController.clear();
    petBreedController.clear();
    petBirthDateController.clear();
    petDeathDateController.clear();
    petBirthPlaceController.clear();
    petBurialPlaceController.clear();
    petDeathCauseController.clear();
    petDescriptionController.clear();
    petImagesAndMoves = [];
    petAvatarImage = null;
    petBackgroundImage = null;
    selectedItem = 0;
    selectedAccess = 'Public';
    notifyListeners();
  }

  void disposeHumanCreate() {
    profileCertificate = null;
    firstNameController.clear();
    lastNameController.clear();
    middleNameController.clear();
    profileBirthPlaceController.clear();
    humanDeathDate = null;
    humanBirthDate = null;
    profileDeathCauseController.clear();
    profileDescriptionController.clear();
    selectedCemetery = '';
    selectedCemeteryId = null;
    searchCemeteryController.clear();
    searchedCemeteryBool = false;
    searchedCemeteryModel = null;
    gender = '';
    father = '';
    husbandWife = '';
    mother = '';
    fatherID = '';
    motherID = '';
    husbandWifeID = '';
    fatherList = [];
    husbandWifeList = [];
    profileImagesAndMoves = [];
    motherList = [];
    hobbiesList = [];
    selectedHobbiesList = [];
    religionsList = [];
    profileAvatarImage = null;
    profileBackgroundImage = null;
    religionID = null;
    religion = '';
    selectedItem = 0;
    selectedAccess = 'Public';
    notifyListeners();
  }

  TextEditingController titleOfCreatePostController = TextEditingController();
  TextEditingController descriptionOfCreatePostController = TextEditingController();
  TextEditingController dateOfCreatePostController = TextEditingController();
  TextEditingController timeOfCreatePostController = TextEditingController();

  TextEditingController editCommunityNameController = TextEditingController();
  TextEditingController editCommunitySignatureController = TextEditingController();
  TextEditingController editCommunityEmailController = TextEditingController();
  TextEditingController editCommunityLocationController = TextEditingController();
  TextEditingController editCommunityPhoneNumberController = TextEditingController();
  TextEditingController editWebsiteCommunityController = TextEditingController();
  TextEditingController editCommunityDescriptionController = TextEditingController();



  Future<File?> toFile(String url) async {
    try {
      final Random rng = Random();
      final Directory tempDir = await getTemporaryDirectory();
      final String tempPath = tempDir.path;
      final File file = File(tempPath + (rng.nextInt(100)).toString() + '.png');
      final Response response = await get(Uri.parse(url));
      await file.writeAsBytes(response.bodyBytes);
      return file;
    } catch(error) {
      return null;
    }
  }

  void editCommunity(BuildContext context, ValueSetter<StatusResponseModel?> completion) async {
    try {
      SVProgressHUD.show();
      final EditCommunityRequestModel model = EditCommunityRequestModel(
        title: editCommunityNameController.text.isEmpty ?
        communityEditModel.title :
        editCommunityNameController.text,
        subtitle: editCommunitySignatureController.text.isEmpty ?
        communityEditModel.subtitle :
        editCommunitySignatureController.text,
        description: editCommunityDescriptionController.text.isEmpty ?
        communityEditModel.description :
        editCommunityDescriptionController.text,
        email: editCommunityEmailController.text.isEmpty ?
        communityEditModel.email :
        editCommunityEmailController.text,
        phone: editCommunityPhoneNumberController.text.isEmpty ?
        communityEditModel.phone :
        editCommunityPhoneNumberController.text,
        website: editWebsiteCommunityController.text,
        address: editCommunityLocationController.text.isEmpty ?
        communityEditModel.address :
        editCommunityLocationController.text,
        avatar: editCommunitiesAvatarImage,
        banner: editCommunitiesBackgroundImage,
        gallery: editCommunitiesImagesAndMoves,
        mediaRemovedIds: removedIndexUrlsCommunityList,
      );

      service.editCommunityRequest(communityEditModel.id, model, (response) {
        SVProgressHUD.dismiss();
        mapper.statusMultiPartResponse(response, (model) {
          if(model != null) {
            completion(model);
          } else {
            completion(null);
          }
        });
      });
    } catch (error) {
      SVProgressHUD.dismiss();
      print('$error');
    }
  }

  late CommunityEditModel communityEditModel;

  void uploadingDataToControllers(CommunityEditModel model) async {
    communityEditModel = model;
    editCommunityNameController.value = TextEditingValue(
      text: model.title,
    );
    editCommunitySignatureController.value = TextEditingValue(
      text: model.subtitle,
    );
    editCommunityEmailController.value = TextEditingValue(
      text: model.email,
    );
    editCommunityLocationController.value = TextEditingValue(
      text: model.address,
    );
    editCommunityPhoneNumberController.value = TextEditingValue(
      text: model.phone,
    );
    editWebsiteCommunityController.value = TextEditingValue(
      text: model.website ?? '',
    );
    editCommunityDescriptionController.value = TextEditingValue(
      text: model.description,
    );
    print(model.avatar);
    print(model.banner);
    if(model.avatar != null && model.avatar != '') {
      try {
        editCommunitiesAvatarImage = await toFile(model.avatar!);
      } catch(error) {
        print('---------$error');
      }
    }
    if(model.banner != null && model.banner != '') {
      try {
      editCommunitiesBackgroundImage = await toFile(model.banner!);
      } catch(error) {
        print('---------$error');
      }
    }
    notifyListeners();
  }

  bool isPinned = false;

  void switchPinned() {
    isPinned = !isPinned;
    notifyListeners();
  }

  TextEditingController validateDescriptionController(CheckFlow check) {
    switch(check) {
      case CheckFlow.profile:
        return profileDescriptionController;
      case CheckFlow.cemetery:
        return placesDescriptionController;
      case CheckFlow.community:
        return communitiesDescriptionController;
      case CheckFlow.pet:
        return petDescriptionController;
      case CheckFlow.editCommunity:
        return editCommunityDescriptionController;
      default:
        return TextEditingController();
    }
  }

  String titleCard(CheckFlow checkFlow) {
    switch(checkFlow) {
      case CheckFlow.profile:
        return '${firstNameController.text}${lastNameController.text.isNotEmpty ? ' ${lastNameController.text}' : ''}${middleNameController.text.isNotEmpty ? ' ${middleNameController.text}' : ''}';
      case CheckFlow.cemetery:
        break;
      case CheckFlow.community:
        return communitiesNameController.text;
      case CheckFlow.pet:
        return petNameController.text;
      case CheckFlow.editCommunity:
        return editCommunityNameController.text;
    }
    return '';
  }

  int animationDispose() {
    return indexPage = 0;
  }

  late int indexPage;

  int dayPublicationDate = 0;
  int monthPublicationDate = 0;
  int yearPublicationDate = 0;

  int dayBirthDate = 0;
  int monthBirthDate = 0;
  int yearBirthDate = 0;

  int dayDeathDate = 0;
  int monthDeathDate = 0;
  int yearDeathDate = 0;

  String dayBirthDateText = '';
  String monthBirthDateText = '';
  String yearBirthDateText = '';

  String dayPublicationDateText = '';
  String monthPublicationDateText = '';
  String yearPublicationDateText = '';

  String dayDeathDateText = '';
  String monthDeathDateText = '';
  String yearDeathDateText = '';

  int hourPublicationDate = 0;
  String hourPublicationDateText = '';

  int minutePublicationDate = 0;
  String minutePublicationDateText = '';

  int formatPublicationDate = 0;
  String formatPublicationDateText = '';

  String gender = '';
  String father = '';
  String husbandWife = '';
  String petOwner = '';
  String religion = '';
  String mother = '';

  String fatherID = '';
  String motherID = '';
  String ownerID = '';
  String husbandWifeID = '';

  List<ReligionResponseModel> religionsList = [];

  int? religionID;

  ImagePicker picker = ImagePicker();

  File? profileBackgroundImage;
  File? profileAvatarImage;

  File? placesBackgroundImage;
  File? placesAvatarImage;

  File? communitiesBackgroundImage;
  File? communitiesAvatarImage;

  File? editCommunitiesBackgroundImage;
  File? editCommunitiesAvatarImage;

  File? petBackgroundImage;
  File? petAvatarImage;

  File? profileCertificate;

  File? generateBackgroundImage(CheckFlow checkFlow) {
    switch(checkFlow) {
      case CheckFlow.profile:
        return profileBackgroundImage;
      case CheckFlow.cemetery:
        return placesBackgroundImage;
      case CheckFlow.community:
        return communitiesBackgroundImage;
      case CheckFlow.pet:
        return petBackgroundImage;
      case CheckFlow.editCommunity:
        return editCommunitiesBackgroundImage;
    }
  }
  File? generateAvatarImage(CheckFlow checkFlow) {
    switch(checkFlow) {
      case CheckFlow.profile:
        return profileAvatarImage;
      case CheckFlow.cemetery:
        return placesAvatarImage;
      case CheckFlow.community:
        return communitiesAvatarImage;
      case CheckFlow.pet:
        return petAvatarImage;
      case CheckFlow.editCommunity:
        return editCommunitiesAvatarImage;
    }
  }
  String generateTitle(CheckFlow checkFlow) {
    switch(checkFlow) {
      case CheckFlow.profile:
        return 'Profile creation';
      case CheckFlow.pet:
        return 'Profile pets creation';
      case CheckFlow.cemetery:
        return 'New cemetery';
      case CheckFlow.community:
        return 'New community';
      case CheckFlow.editCommunity:
        return 'Edit community';
    }
  }

  List<HobbiesResponseModel> hobbiesList = [];
  List<String> selectedHobbiesList = [];

  List<HumansResponseModel> fatherList = [];
  List<HumansResponseModel> motherList = [];
  List<HumansResponseModel> husbandWifeList = [];



  void setGender(String sex) {
    gender = sex;
    notifyListeners();
  }

  void removeGender() {
    gender = '';
    notifyListeners();
  }

  void setFather(String fatherText, String fatherId) {
    father = fatherText;
    fatherID = fatherId;
    notifyListeners();
  }

  void removeFather() {
    father = '';
    fatherID = '';
    notifyListeners();
  }

  void setHusband(String husbandWifeText, String husbandWifeId) {
    husbandWife = husbandWifeText;
    husbandWifeID = husbandWifeId;
    notifyListeners();
  }

  void removeHusband() {
    husbandWife = '';
    husbandWifeID = '';
    notifyListeners();
  }

  void setMother(String motherText, String motherId) {
    mother = motherText;
    motherID = motherId;
    notifyListeners();
  }

  void removeMother() {
    mother = '';
    motherID = '';
    notifyListeners();
  }

  void setOwner(String motherText, String motherId) {
    petOwner = motherText;
    ownerID = motherId;
    notifyListeners();
  }

  void removeOwner() {
    petOwner = '';
    ownerID = '';
    notifyListeners();
  }

  void setReligion(String sex, int relig) {
    religion = sex;
    religionID = relig;
    notifyListeners();
  }

  void removeReligion() {
    religion = '';
    religionID = null;
    notifyListeners();
  }

  List<TextEditingController> communitiesSocialLinks = [];
  List<File> profileImagesAndMoves = [];
  List<File> petImagesAndMoves = [];
  List<File> placesImagesAndMoves = [];
  List<File> communitiesImagesAndMoves = [];
  List<dynamic> editCommunitiesImagesAndMoves = [];
  List<dynamic> createPostImagesAndMoves = [];
  List<File> validatePicturesAndMoves(CheckFlow check) {
    switch(check) {
      case CheckFlow.profile:
        return profileImagesAndMoves;
      case CheckFlow.cemetery:
        return placesImagesAndMoves;
      case CheckFlow.community:
        return communitiesImagesAndMoves;
      case CheckFlow.pet:
        return petImagesAndMoves;
      case CheckFlow.editCommunity:

      default:
        return [];
    }
  }

  Future getImages(BuildContext context, CheckFlow check) async {
    final pickedFile = await picker.pickMultiImage();
    List<XFile> filePick = pickedFile;

    if (filePick.isNotEmpty) {
      for (var i = 0; i < filePick.length; i++) {
        validatePicturesAndMoves(check).add(
          File(
            filePick[i].path,
          ),
        );
      }
      notifyListeners();
    }
    else {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Nothing is selected',
            ),
          ),
      );
    }
  }

  Future getImagesInCreatePost(BuildContext context) async {
    final pickedFile = await picker.pickMultiImage();
    List<XFile> filePick = pickedFile;

    if (filePick.isNotEmpty) {
      for (var i = 0; i < filePick.length; i++) {
        createPostImagesAndMoves.add(
          File(
            filePick[i].path,
          ),
        );
      }
      notifyListeners();
    }
    else {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Nothing is selected',
            ),
          ),
      );
    }
  }
  Future getImagesInEditCommunity(BuildContext context) async {
    final pickedFile = await picker.pickMultiImage();
    List<XFile> filePick = pickedFile;

    if (filePick.isNotEmpty) {
      for (var i = 0; i < filePick.length; i++) {
        editCommunitiesImagesAndMoves.add(
          File(
            filePick[i].path,
          ),
        );
      }
      notifyListeners();
    }
    else {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Nothing is selected',
            ),
          ),
      );
    }
  }

  Future pdfPick(BuildContext context) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      profileCertificate = File(result.files.single.path!);
      print(profileCertificate);
      notifyListeners();
    }
    else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Nothing is selected',
          ),
        ),
      );
    }
  }

  void removePDF() {
    profileCertificate = null;
    notifyListeners();
  }

  void removeImage(int index, CheckFlow check) {
    validatePicturesAndMoves(check).removeAt(index);
    notifyListeners();
  }

  void removeImageFromCreatePost(int index) {
    createPostImagesAndMoves.removeAt(index);
    notifyListeners();
  }


  ///POST
  List<String> removedIndexUrlsPostList = [];

  void removeUrlFromEditPost(int index, int urlId) {
    createPostImagesAndMoves.removeAt(index);
    removedIndexUrlsPostList.add(urlId.toString());
    notifyListeners();
  }

  ///COMMUNITY
  List<String> removedIndexUrlsCommunityList = [];

  void removeImageFromEditCommunity(int index) {
    editCommunitiesImagesAndMoves.removeAt(index);
    notifyListeners();
  }
  void removeUrlFromEditCommunity(int index, int urlId) {
    editCommunitiesImagesAndMoves.removeAt(index);
    removedIndexUrlsCommunityList.add(urlId.toString());
    notifyListeners();
  }

  final TestData data = TestData();

  void pickBackgroundImage(CheckFlow checkFlow) async {
    XFile? image = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 50,
    );
    switch(checkFlow) {
      case CheckFlow.profile:
        profileBackgroundImage = File(image!.path);
        notifyListeners();
        break;
      case CheckFlow.cemetery:
        placesBackgroundImage = File(image!.path);
        notifyListeners();
        break;
      case CheckFlow.community:
        communitiesBackgroundImage = File(image!.path);
        notifyListeners();
        break;
      case CheckFlow.pet:
        petBackgroundImage = File(image!.path);
        notifyListeners();
        break;
      case CheckFlow.editCommunity:
        editCommunitiesBackgroundImage = File(image!.path);
        notifyListeners();
        break;
    }
  }
  void pickAvatarImage(CheckFlow checkFlow) async {
    XFile? image = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 50,
    );
    switch(checkFlow) {
      case CheckFlow.profile:
        profileAvatarImage = File(image!.path);
        notifyListeners();
        break;
      case CheckFlow.cemetery:
        placesAvatarImage = File(image!.path);
        notifyListeners();
        break;
      case CheckFlow.community:
        communitiesAvatarImage = File(image!.path);
        notifyListeners();
        break;
      case CheckFlow.pet:
        petAvatarImage = File(image!.path);
        notifyListeners();
        break;
      case CheckFlow.editCommunity:
        editCommunitiesAvatarImage = File(image!.path);
        notifyListeners();
        break;
    }
    notifyListeners();
  }

  Future showBirthDate(BuildContext context) async {
    return await elementSelectionWidget(
      context: context,
      title: 'Choose birth date',
      textButton: 'Close',
      child: Row(
        children: [
          Expanded(
            child: SpinningCylinderWidget(
              title: 'Day',
              onSelectedItemChanged: (item) {
                Text text = generateElement(
                  array: data.dayList(),
                )[item] as Text;
                dayBirthDate = item;
                dayBirthDateText = text.data?.length == 1 ?
                '0${text.data}' :
                text.data ?? '';
                notifyListeners();
              },
              scrollController: FixedExtentScrollController(
                initialItem: dayBirthDate,
              ),
              children: data.dayList(),
            ),
          ),
          Expanded(
            child: SpinningCylinderWidget(
              title: 'Month',
              onSelectedItemChanged: (item) {
                Text text = generateElement(
                  array: data.monthList(),
                )[item] as Text;
                monthBirthDate = item;
                monthBirthDateText = text.data?.length == 1 ?
                '0${text.data}' :
                text.data ?? '';
                notifyListeners();
              },
              scrollController: FixedExtentScrollController(
                initialItem: monthBirthDate,
              ),
              children: data.monthList(),
            ),
          ),
          Expanded(
            child: SpinningCylinderWidget(
              title: 'Year',
              onSelectedItemChanged: (item) {
                Text text = generateElement(
                  array: data.yearList(),
                )[item] as Text;
                yearBirthDate = item;
                yearBirthDateText = text.data ?? '';
                notifyListeners();
              },
              scrollController: FixedExtentScrollController(
                initialItem: yearBirthDate,
              ),
              children: data.yearList(),
            ),
          ),
        ],
      ),
    );
  }

  Future showPostPublicationDate(BuildContext context) async {
    return await elementSelectionWidget(
      context: context,
      title: 'Select the publication date',
      textButton: 'Close',
      child: Row(
        children: [
          Expanded(
            child: SpinningCylinderWidget(
              title: 'Day',
              onSelectedItemChanged: (item) {
                Text text = generateElement(
                  array: data.dayList(),
                )[item] as Text;
                dayPublicationDate = item;
                dayPublicationDateText = text.data?.length == 1 ?
                '0${text.data}' :
                text.data ?? '';
                notifyListeners();
              },
              scrollController: FixedExtentScrollController(
                initialItem: dayPublicationDate,
              ),
              children: data.dayList(),
            ),
          ),
          Expanded(
            child: SpinningCylinderWidget(
              title: 'Month',
              onSelectedItemChanged: (item) {
                Text text = generateElement(
                  array: data.monthList(),
                )[item] as Text;
                monthPublicationDate = item;
                monthPublicationDateText = text.data?.length == 1 ?
                '0${text.data}' :
                text.data ?? '';
                notifyListeners();
              },
              scrollController: FixedExtentScrollController(
                initialItem: monthPublicationDate,
              ),
              children: data.monthList(),
            ),
          ),
          Expanded(
            child: SpinningCylinderWidget(
              title: 'Year',
              onSelectedItemChanged: (item) {
                Text text = generateElement(
                  array: data.yearList(),
                )[item] as Text;
                yearPublicationDate = item;
                yearPublicationDateText = text.data ?? '';
                notifyListeners();
              },
              scrollController: FixedExtentScrollController(
                initialItem: yearPublicationDate,
              ),
              children: data.yearList(),
            ),
          ),
        ],
      ),
    );
  }

  Future showPostPublicationTime(BuildContext context) async {
    return await elementSelectionWidget(
      context: context,
      title: 'Select the publication time',
      textButton: 'Close',
      child: Row(
        children: [
          Expanded(
            child: SpinningCylinderWidget(
              title: 'Hour',
              onSelectedItemChanged: (item) {
                Text text = generateElement(
                  array: data.hourList(),
                )[item] as Text;
                hourPublicationDate = item;
                hourPublicationDateText = text.data?.length == 1 ?
                '0${text.data}' :
                text.data ?? '';
                notifyListeners();
              },
              scrollController: FixedExtentScrollController(
                initialItem: hourPublicationDate,
              ),
              children: data.hourList(),
            ),
          ),
          Expanded(
            child: SpinningCylinderWidget(
              title: 'Minute',
              onSelectedItemChanged: (item) {
                Text text = generateElement(
                  array: data.minuteList(),
                )[item] as Text;
                minutePublicationDate = item;
                minutePublicationDateText = text.data?.length == 1 ?
                '0${text.data}' :
                text.data ?? '';
                notifyListeners();
              },
              scrollController: FixedExtentScrollController(
                initialItem: minutePublicationDate,
              ),
              children: data.minuteList(),
            ),
          ),
        ],
      ),
    );
  }

  Future showDeathDate(BuildContext context) async {
    return await elementSelectionWidget(
      context: context,
      title: 'Choose death date',
      textButton: 'Close',
      child: Row(
        children: [
          Expanded(
            child: SpinningCylinderWidget(
              title: 'Day',
              onSelectedItemChanged: (item) {
                Text text = generateElement(
                  array: data.dayList(),
                )[item] as Text;
                dayDeathDate = item;
                dayDeathDateText = text.data?.length == 1 ?
                '0${text.data}' :
                text.data ?? '';
                notifyListeners();
              },
              scrollController: FixedExtentScrollController(
                initialItem: dayDeathDate,
              ),
              children: data.dayList(),
            ),
          ),
          Expanded(
            child: SpinningCylinderWidget(
              title: 'Month',
              onSelectedItemChanged: (item) {
                Text text = generateElement(
                  array: data.monthList(),
                )[item] as Text;
                monthDeathDate = item;
                monthDeathDateText = text.data?.length == 1 ?
                '0${text.data}' :
                text.data ?? '';
                notifyListeners();
              },
              scrollController: FixedExtentScrollController(
                initialItem: monthDeathDate,
              ),
              children: data.monthList(),
            ),
          ),
          Expanded(
            child: SpinningCylinderWidget(
              title: 'Year',
              onSelectedItemChanged: (item) {
                Text text = generateElement(
                  array: data.yearList(),
                )[item] as Text;
                yearDeathDate = item;
                yearDeathDateText = text.data ?? '';
                notifyListeners();
              },
              scrollController: FixedExtentScrollController(
                initialItem: yearDeathDate,
              ),
              children: data.yearList(),
            ),
          ),
        ],
      ),
    );
  }

  bool creatingPostValidate() {
    if(dateOfCreatePostController.text.isEmpty && timeOfCreatePostController.text.isEmpty) {
      return true;
    } else {
      if(dateOfCreatePostController.text.isNotEmpty && dateOfCreatePostController.text.length == 10 && timeOfCreatePostController.text.isNotEmpty && timeOfCreatePostController.text.length == 5) {
        return true;
      } else {
        return false;
      }
    }
  }

  int onChangePage(int index) {
    indexPage = index;
    notifyListeners();
    return indexPage;
  }

  int selectedItem = 0;
  String selectedAccess = 'Public';

  void selectAccess(String access, int index) {
    selectedItem = index;
    selectedAccess = access;
    notifyListeners();
  }

  void addHobbies(HobbiesResponseModel hobbies) {
    selectedHobbiesList.add(hobbies.title ?? '');
    notifyListeners();
  }

  void removeFromHobbies(index) {
    selectedHobbiesList.remove(index);
    notifyListeners();
  }

  void generateRequest(BuildContext context, CheckFlow checkFlow, int isDraft) {
    switch(checkFlow) {
      case CheckFlow.profile:
        return creatingProfile(context, isDraft);
      case CheckFlow.pet:
        return creatingPet(context, isDraft);
      case CheckFlow.cemetery:
        return creatingCemetery(context, isDraft);
      case CheckFlow.community:
        return creatingCommunity(context, isDraft);
    }
  }

  DateTime? humanBirthDate;
  DateTime? humanDeathDate;

  Future humanBirthDatePicker(BuildContext context) async {
    humanBirthDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      cancelText: 'Close',
      confirmText: 'Select',
      builder: (BuildContext context, Widget? widget) => Theme(
        data: ThemeData(
          colorScheme: ColorScheme.light(
            primary: const Color.fromRGBO(23, 94, 217, 1),
          ),
          dialogTheme: DialogTheme(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
          ),
        ),
        child: widget!,
      ),
    );
    notifyListeners();
  }
  Future humanDeathDatePicker(BuildContext context) async {
    humanDeathDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      cancelText: 'Close',
      confirmText: 'Select',
      builder: (BuildContext context, Widget? widget) => Theme(
        data: ThemeData(
          colorScheme: ColorScheme.light(
            primary: const Color.fromRGBO(23, 94, 217, 1),
          ),
          dialogTheme: DialogTheme(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
          ),
        ),
        child: widget!,
      ),
    );
    notifyListeners();
  }

  void creatingProfile(BuildContext context, int isDraft) {
    SVProgressHUD.show();
    try {
      CreatingPersonsProfileRequestModel model = CreatingPersonsProfileRequestModel(
        firstName: firstNameController.text,
        lastName: lastNameController.text,
        middleName: middleNameController.text,
        gender: gender,
        dateBirth: '${humanBirthDate!.day.toString().padLeft(2, '0')}.${humanBirthDate!.month.toString().padLeft(2, '0')}.${humanBirthDate!.year}',
        dateDeath: '${humanDeathDate!.day.toString().padLeft(2, '0')}.${humanDeathDate!.month.toString().padLeft(2, '0')}.${humanDeathDate!.year}',
        deathReason: profileDeathCauseController.text,
        birthPlace: profileBirthPlaceController.text,
        fatherID: fatherID,
        motherID: motherID,
        spouseID: husbandWifeID,
        description: profileDescriptionController.text,
        coords: CoordsRequest(
          lat: lat,
          lng: lng,
        ),
        access: selectedAccess,
        religion: religionID,
        asDraft: '$isDraft',
        cemeteryId: selectedCemeteryId,
      );

      service.creatingProfileRequest(profileAvatarImage, profileBackgroundImage, profileCertificate, profileImagesAndMoves, selectedHobbiesList, model, (response) {
        SVProgressHUD.dismiss();
        mapper.statusMultiPartResponse(response, (model) async {
          if(model?.status == true) {
            final _catalogProvider = Provider.of<CatalogProvider>(context, listen: false);
            final _accountProvider = Provider.of<AccountProvider>(context, listen: false);
            await _catalogProvider.gettingAuthorizedMainContent(context, (model) {});
            await _accountProvider.gettingCreatedHumansProfiles(
              ((model) { }),
            );
            await _accountProvider.getUserInfo(context);
            religionID = null;
            Navigator.pop(context);
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
      SVProgressHUD.dismiss();
      print('$error');
    }
  }

  List<CountryResponseModel> countryList = [];

  String selectedCemetery = '';

  Map<MarkerId, Marker> markersAddress = <MarkerId, Marker>{};

  double lat = 0.0;
  double lng = 0.0;

  late Completer<GoogleMapController> addressMapController;

  void onMapCreated(GoogleMapController controller) {
    addressMapController = Completer();
    addressMapController.complete(controller);
  }

  void selectCountry(
      BuildContext context,
      String country,
      TextEditingController controller,
      BitmapDescriptor icon,
      ) async {
    try {
      GoogleMapController _controller = await addressMapController.future;
      FocusScope.of(context).unfocus();
      List<Address> addresses = await Geocoder.local.findAddressesFromQuery(country);
      const String markerIdVal = '1';
      const MarkerId markerId = MarkerId(markerIdVal);
      final Marker marker = Marker(
        markerId: markerId,
        icon: icon,
        position: LatLng(
          addresses.first.coordinates.latitude ?? 0.0,
          addresses.first.coordinates.longitude ?? 0.0,
        ),
      );
      lat = addresses.first.coordinates.latitude ?? 0.0;
      lng = addresses.first.coordinates.longitude ?? 0.0;
      controller.value = TextEditingValue(
        text: country,
        selection: TextSelection.fromPosition(
          TextPosition(
            offset: country.length,
          ),
        ),
      );
      markersAddress[markerId] = marker;
      _controller.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: LatLng(addresses.first.coordinates.latitude ?? 0.0, addresses.first.coordinates.longitude ?? 0.0),
            zoom: 12,
          ),
        ),
      );
      countryList.clear();
    } catch(e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('You cannot go to this address'),
        ),
      );
      print('error caught: $e');
    }

    notifyListeners();
  }

  void saveCountry(String country) {
    selectedCemetery = country;
    notifyListeners();
  }

  void getPlace(
      String input,
      BuildContext context,
      ValueSetter<GetCommunityInfoResponseModel?> completion,
      ) async {
    service.getPlaceRequest(input, (response) {
      mapper.getPlaceResponse(response, (model) async {
        print(response?.body);
        if(model?.status == "OK") {
          if(model!.predictions!.isNotEmpty) {
            countryList = model.predictions ?? [];
            notifyListeners();
          }
        } else {
          countryList.clear();
          notifyListeners();
        }
      });
    });
  }

  void creatingPet(BuildContext context, int isDraft) async {
    try {
      SVProgressHUD.show();
      CreatingPetRequestModel model = CreatingPetRequestModel(
        name: petNameController.text,
        breed: petBreedController.text,
        dateBirth: petBirthDateController.text,
        dateDeath: petDeathDateController.text,
        deathReason: petDeathCauseController.text,
        birthPlace: petBirthPlaceController.text,
        ownerID: ownerID.toString(),
        description: petDescriptionController.text,
        access: selectedAccess,
        asDraft: '$isDraft',
      );

      service.creatingPetRequest(petAvatarImage, petBackgroundImage, petImagesAndMoves, model, (response) {
        mapper.statusMultiPartResponse(response, (model) async {
          SVProgressHUD.dismiss();
          print(model?.message);
          if(model?.status == true) {
            Navigator.pop(context);
            final _catalogProvider = Provider.of<CatalogProvider>(context, listen: false);
            final _accountProvider = Provider.of<AccountProvider>(context, listen: false);
            await _catalogProvider.gettingAuthorizedMainContent(context, (model) {});
            await _accountProvider.gettingCreatedPetsProfiles(
              ((model) { }),
            );
            await _accountProvider.getUserInfo(context);
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
      SVProgressHUD.dismiss();
      print('$error');
    }
  }

  void creatingCemetery(BuildContext context, int isDraft) async {
    try {
      SVProgressHUD.show();
      CreatingCemeteryRequestModel model = CreatingCemeteryRequestModel(
        title: placesNameController.text,
        subtitle: placesNameInLatinController.text,
        address: selectedCemetery,
        addressCoords: CoordsRequest(
          lng: lng,
          lat: lat,
        ),
        email: placesEmailController.text,
        phone: placesPhoneNumberController.text,
        schedule: '',
        description: placesDescriptionController.text,
        access: selectedAccess,
        asDraft: '$isDraft',
      );

      service.creatingCemeteryRequest(petAvatarImage, petBackgroundImage, profileImagesAndMoves, model, (response) {
        mapper.statusMultiPartResponse(response, (model) {
          SVProgressHUD.dismiss();
          print(model?.message);
          if(model?.status == true) {
            Navigator.pop(context);
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
      SVProgressHUD.dismiss();
      print('$error');
    }
  }

  String contentTypeCreatePost(PostContentType type) {
    switch(type) {
      case PostContentType.textContent:
        return 'TEXT_POST';
      case PostContentType.mediaContent:
        return 'MEDIA_POST';
      case PostContentType.textWithMediaContent:
        return 'TEXT_WITH_MEDIA_POST';
      case PostContentType.none:
        return 'NONE';
    }
  }

  void disposeAddPostScreen() {
    createPostImagesAndMoves.clear();
    titleOfCreatePostController.clear();
    descriptionOfCreatePostController.clear();
    yearPublicationDateText = '';
    monthPublicationDateText = '';
    dayPublicationDateText = '';
    hourPublicationDateText = '';
    minutePublicationDateText = '';
    isPinned = false;
    notifyListeners();
  }

  void setEditCommunityState(CommunitiesInfoResponseModel model) {
    print(model.gallery);
    removedIndexUrlsCommunityList.clear();
    editCommunitiesImagesAndMoves.clear();
    if(model.gallery != null && model.gallery!.isNotEmpty) {
      for(String item in model.gallery!) {
        editCommunitiesImagesAndMoves.add(item);
        notifyListeners();
      }
    }
    notifyListeners();
  }

  void setEditPostState(PostContentType? type, DeterminingChangesPostDataModel model) {
    switch(type) {
      case PostContentType.textContent:
        titleOfCreatePostController.value = TextEditingValue(
          text: model.title ?? '',
        );
        descriptionOfCreatePostController.value = TextEditingValue(
          text: model.description ?? '',
        );
        notifyListeners();
        break;
      case PostContentType.mediaContent:
        removedIndexUrlsPostList.clear();
        createPostImagesAndMoves.clear();
        titleOfCreatePostController.clear();
        descriptionOfCreatePostController.clear();
        if(model.media != null && model.media!.isNotEmpty) {
          for(Map item in model.media!) {
            createPostImagesAndMoves.add(item);
            notifyListeners();
          }
        }
        print(createPostImagesAndMoves);
        notifyListeners();
        break;
      case PostContentType.textWithMediaContent:
        removedIndexUrlsPostList.clear();
        createPostImagesAndMoves.clear();
        titleOfCreatePostController.clear();
        descriptionOfCreatePostController.clear();
        titleOfCreatePostController.value = TextEditingValue(
          text: model.title ?? '',
        );
        descriptionOfCreatePostController.value = TextEditingValue(
          text: model.description ?? '',
        );
        if(model.media != null && model.media!.isNotEmpty) {
          for(Map item in model.media!) {
            createPostImagesAndMoves.add(item);
            notifyListeners();
          }
        }
        print(createPostImagesAndMoves);
        notifyListeners();
        break;
      case null:
        break;
    }
  }

  void createPost(BuildContext context, int communityId, ValueSetter<StatusResponseModel?> completion) async {
    try {
      // late final PostContentType switcher;
      //
      // if(createPostImagesAndMoves.isNotEmpty && descriptionOfCreatePostController.text.isEmpty && titleOfCreatePostController.text.isEmpty) {
      //   switcher = PostContentType.mediaContent;
      // }
      // else if(descriptionOfCreatePostController.text.isNotEmpty && titleOfCreatePostController.text.isNotEmpty && createPostImagesAndMoves.isEmpty) {
      //   switcher = PostContentType.textContent;
      // } else if(descriptionOfCreatePostController.text.isNotEmpty && titleOfCreatePostController.text.isNotEmpty && createPostImagesAndMoves.isNotEmpty) {
      //   switcher = PostContentType.textWithMediaContent;
      // }

      String publishedAt = '';

      if(birthDateNameController.text.isNotEmpty && timeOfCreatePostController.text.isNotEmpty) {
        publishedAt = '${birthDateNameController.text.replaceAll('.', '-')} ${timeOfCreatePostController.text}:00';
      }

      CreatePostRequestModel model = CreatePostRequestModel(
        communityId: communityId,
        title: titleOfCreatePostController.text,
        description: descriptionOfCreatePostController.text,
        postMedia: createPostImagesAndMoves,
        isPinned: isPinned,
        publishedAt: publishedAt,
      );

      SVProgressHUD.show();
      await service.createPostRequest(model, (response) {
        mapper.statusMultiPartResponse(response, (model) {
          SVProgressHUD.dismiss();
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

  void editPost(EditPostRequestModel model, ValueSetter<StatusResponseModel?> completion) async {
    SVProgressHUD.show();
    try {
      await service.editPostRequest(model, (response) {
        mapper.statusMultiPartResponse(response, (model) {
          SVProgressHUD.dismiss();
          if(model != null) {
            print(model.status);
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

  Future deletePost(int postId, ValueSetter<StatusResponseModel?> completion) async {
    try {
      SVProgressHUD.show();
      await service.deletePostRequest(postId, (response) {
        mapper.statusResponse(response, (model) {
          SVProgressHUD.dismiss();
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
  Future pinPost(int postId, ValueSetter<StatusResponseModel?> completion) async {
    try {
      SVProgressHUD.show();
      await service.pinPostRequest(postId, (response) {
        mapper.statusResponse(response, (model) {
          SVProgressHUD.dismiss();
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

  void creatingCommunity(BuildContext context, int isDraft) async {
    try {
      SVProgressHUD.show();

      List<String> links = [];

      for (var element in communitiesSocialLinks) {
        links.add(element.text);
      }

      final CreatingCommunityProfileRequestModel model = CreatingCommunityProfileRequestModel(
        title: communitiesNameController.text,
        subtitle: communitiesSignatureController.text,
        description: communitiesDescriptionController.text,
        email: communitiesEmailController.text,
        phone: communitiesPhoneNumberController.text,
        website: websiteController.text,
        socialLinks: links,
        address: communitiesLocationController.text,
        avatar: communitiesAvatarImage,
        banner: communitiesBackgroundImage,
        gallery: communitiesImagesAndMoves,
      );

      service.creatingCommunityRequest(model, (response) {
        mapper.statusMultiPartResponse(response, (model) {
          SVProgressHUD.dismiss();
          if(model?.status == true) {
            final authProvider = Provider.of<AuthProvider>(context, listen: false);
            final catalogProvider = Provider.of<CatalogProvider>(context, listen: false);
            if(authProvider.userRules == 'authorized') {
              catalogProvider.gettingAuthorizedMainContent(context, (model) {});
            } else if(authProvider.userRules == 'guest') {
              catalogProvider.gettingGuestMainContent(context, (model) {});
            }
            catalogProvider.gettingGuestCommunities(
              context,
              ((model) {}),
            );
            Navigator.pop(context);
          } else {
            final messageDialogsProvider = Provider.of<MessageDialogsProvider>(context, listen: false);
            messageDialogsProvider.informationWindow(
              context: context,
              title: model?.message ?? 'Error',
              textButton: 'Retry',
            );
          }
        });
      });
    } catch (error) {
      SVProgressHUD.dismiss();
      print('$error');
    }
  }

  Future gettingReligions() async {
    try {
      await service.gettingReligionsRequest((response) {
        mapper.gettingReligionsResponse(response, (model) {
          if(model != null) {
            if(model.status == true) {
              religionsList = model.religions ?? [];
              print(model.religions);
              print(religionsList);
              notifyListeners();
            }
          }
        });
      });
    } catch (error) {
      SVProgressHUD.dismiss();
      print('$error');
    }
  }

  Future gettingHobbies() async {
    try {
      await service.gettingHobbiesRequest((response) {
        mapper.gettingHobbiesResponse(response, (model) {
          if(model != null) {
            if(model.status == true) {
              hobbiesList = model.hobbies ?? [];
              print(hobbiesList.length);
              notifyListeners();
            }
          }
        });
      });
    } catch (error) {
      SVProgressHUD.dismiss();
      print('$error');
    }
  }

  Future gettingRelatedProfiles({required BuildContext context, String? gender}) async {
    try {
      await service.gettingRelatedProfilesRequest(gender, (response) {
        mapper.gettingRelatedProfilesResponse(response, (model) {
          if(model?.status == true) {
            switch(gender) {
              case 'male':
                fatherList.clear();
                fatherList = model?.humans ?? [];
                notifyListeners();
                break;
              case 'female':
                motherList.clear();
                motherList = model?.humans ?? [];
                notifyListeners();
                break;
              case null:
                husbandWifeList.clear();
                husbandWifeList = model?.humans ?? [];
                notifyListeners();
                break;
            }
          }
        });
      });
    } catch (error) {
      SVProgressHUD.dismiss();
      print('$error');
    }
  }

  bool primaryInfoCheck(CheckFlow checkFlow) {
    switch(checkFlow) {
      case CheckFlow.editCommunity:
        return true;
      case CheckFlow.profile:
        if(firstNameController.text.isNotEmpty &&
            lastNameController.text.isNotEmpty &&
            gender.isNotEmpty &&
            humanDeathDate != null &&
            humanBirthDate != null
        ) {
          return true;
        }
        else {
          return false;
        }
      case CheckFlow.cemetery:
        return false;
      case CheckFlow.community:
        if(communitiesNameController.text.isNotEmpty
            && communitiesSignatureController.text.isNotEmpty
            && communitiesSignatureController.text.isNotEmpty
            && communitiesEmailController.text.isNotEmpty
            && communitiesPhoneNumberController.text.isNotEmpty) {
          return true;
        }
        else {
          return false;
        }
      case CheckFlow.pet:
        if(petNameController.text.isNotEmpty &&
            petBreedController.text.isNotEmpty &&
            petBirthPlaceController.text.isNotEmpty &&
            petDeathCauseController.text.isNotEmpty &&
            petDeathDateController.text.isNotEmpty &&
            petBirthDateController.text.isNotEmpty &&
            petOwner.isNotEmpty
        ) {
          return true;
        } else {
          return false;
        }
      default:
        return false;
    }
  }

  bool descriptionCheck(CheckFlow checkFlow) {
    switch(checkFlow) {
      case CheckFlow.profile:
        if(profileDescriptionController.text.isNotEmpty) {
          return true;
        } else {
          return false;
        }
      case CheckFlow.cemetery:
        if(placesDescriptionController.text.isNotEmpty && profileImagesAndMoves.isNotEmpty) {
          return true;
        } else {
          return false;
        }
      case CheckFlow.community:
        if(communitiesDescriptionController.text.isNotEmpty) {
          return true;
        } else {
          return false;
        }
      case CheckFlow.pet:
        if(petDescriptionController.text.isNotEmpty) {
          return true;
        } else {
          return false;
        }
      case CheckFlow.editCommunity:
        return true;
      default:
        return false;
    }
  }
}