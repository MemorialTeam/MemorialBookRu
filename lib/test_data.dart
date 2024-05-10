import 'package:memorial_book/models/common/onboarding_part_model.dart';
import 'package:sizer/sizer.dart';

class TestData {

  List<OnboardingPartModel> onboardingsDataList = [
    OnboardingPartModel(
      title: 'Create profiles',
      description: 'Creating a profile is easy and fast. To do this, you need to follow a few simple steps',
      paddingTop: 9.9.h,
      paddingBottom: 0,
      descriptionFrameSize: 20.9.h,
    ),
    OnboardingPartModel(
      title: 'Page for the cemetery',
      description: 'You can find the burial places of famous personalities and create a new burial place. To do this, you need to enter the name and surname of the person whose burial place you want to find, and click the "Find" button.',
      paddingTop: 0,
      paddingBottom: 4.h,
      descriptionFrameSize: 30.h,
    ),
    OnboardingPartModel(
      title: 'Catalog of goods and services',
      description: 'In our application, you can order a product or service. Select the desired product or service from the list of available ones. Then fill out the order form, specifying your contact details.',
      paddingTop: 0,
      paddingBottom: 4.h,
      descriptionFrameSize: 30.h,
    ),
    OnboardingPartModel(
      title: 'Page for the community',
      description: 'In our app, you can create your own community, invite friends and events, and share photos and videos.',
      paddingTop: 9.9.h,
      paddingBottom: 0,
      descriptionFrameSize: 24.h,
    ),
    OnboardingPartModel(
      title: 'Personal account',
      description: 'A personal account is a place where you can manage your accounts and access your data. In your personal account you will find information about your orders, delivery status, purchase history and much more',
      paddingTop: 9.9.h,
      paddingBottom: 0,
      descriptionFrameSize: 31.h,
    ),
  ];

  final List menuOfCommunity = [
    'Memorial wall',
    'Memorials',
    'Social',
  ];

  final List menuOfCemetery = [
    'About the cemetery',
    'Memorials',
    'Contacts',
  ];

  final List listTiles = [
    {
      'image': 'https://ic.wampi.ru/2023/08/12/Emoji.png',
      'title': 'Sports walking',
    },
    {
      'image': 'https://ic.wampi.ru/2023/08/12/Emoji.png',
      'title': 'Sports walking',
    },
    {
      'image': 'https://ic.wampi.ru/2023/08/12/Emoji.png',
      'title': 'Сooking',
    },
    {
      'image': 'https://ic.wampi.ru/2023/08/12/Emoji.png',
      'title': 'IT',
    },
  ];

  List listPictures = [
    {
      'image': 'https://cdn4.whatculture.com/images/2022/03/73ed89c225dbd73b-1200x675.jpg',
    },
    {
      'image': 'https://immcare.com/wp-content/uploads/2019/02/communityheader.jpg',
    },
    {
      'image': 'https://avante.biz/wp-content/uploads/Community-Tv-Show-Wallpapers/Community-Tv-Show-Wallpapers-003.jpg',
    },
    {
      'image': 'https://www.nme.com/wp-content/uploads/2020/06/PMAX89.jpg',
    },
    {
      'image': 'https://w.forfun.com/fetch/56/56876f861329b7acb38cc20a9b544b20.jpeg',
    },
  ];

  List tagsList = [
    {
      'tag': 'multi_images',
      'creator_information': {
        'name': 'John Norris Bahcall',
        'avatar_image': 'http://cdn1.flamp.ru/8ec3745f2832f41c0b97623ba91fc080.jpg',
      },
      'images': [
        {
          'image': 'https://nevsepic.com.ua/uploads/posts/2012-07/1343406767-1481666-danradcliffe_ca612012_19.jpg',
        },
        {
          'image': 'http://i1.wp.com/psihter.ru/wp-content/uploads/2017/12/best-fear-quotes-main.jpg',
        },
        {
          'image': 'https://images.wallpapersden.com/image/download/heath-ledger-actor-male_amhpbG6UmZqaraWkpJRnZ2ltrWdnaW0.jpg',
        },
        {
          'image': 'https://images.wallpapersden.com/image/download/heath-ledger-actor-male_amhpbG6UmZqaraWkpJRnZ2ltrWdnaW0.jpg',
        },
        {
          'image': 'http://cdn1.flamp.ru/bc57c2126b20646180c92643db78d9f0.jpg',
        },
      ],
    },
    {
      'tag': 'added_profiles',
      'creator_information': {
        'name': 'Ivan Mercel Warrys',
        'avatar_image': 'http://v1.popcornnews.ru/k2/news/1200/upload/wcTTcx.jpg',
      },
      'added_profiles': [
        {
          'profile_image': 'https://get.pxhere.com/photo/man-person-people-photography-male-portrait-child-human-hat-facial-expression-smile-senior-citizen-face-head-caricature-troll-comic-emotion-portrait-photography-720074.jpg',
          'profile_name': 'Hans Albrecht Bethe',
          'year_from': '1906',
          'year_to': '2005',
        },
        {
          'profile_image': 'https://get.pxhere.com/photo/person-people-portrait-facial-expression-hairstyle-smile-emotion-portrait-photography-134689.jpg',
          'profile_name': 'John Norris Bahcall',
          'year_from': '1936',
          'year_to': '2010',
        },
      ],
    },
  ];

  final List<String> religionList = const [
    'Baháʼí Faith',
    'Freemasonry',
    'Buddhism',
    'Christianity',
    'Orthodoxy',
    'Confucianism',
    'Hinduism',
    'Islam',
    'Jainism',
    'Judaism',
    'Sikhism',
    'Shinto',
    'Taoism',
    'Zoroastrianism',
    'Unaffiliated',
  ];

  final List formatList = [
    'PM',
    'AM',
  ];

  List<String> dayList() {
    List<String> day = [];
    for (int i = 1; true; i++) {
      day.add(i.toString());
      if(i == 31) break;
    }
    return day;
  }
  List<String> monthList() {
    List<String> month = [];
    for (int i = 1; true; i++) {
      month.add(i.toString());
      if(i == 12) break;
    }
    return month;
  }
  List<String> hourList() {
    List<String> month = [];
    for (int i = 1; true; i++) {
      month.add(i.toString());
      if(i == 23) break;
    }
    return month;
  }
  List<String> minuteList() {
    List<String> month = [];
    for (int i = 1; true; i++) {
      month.add(i.toString());
      if(i == 59) break;
    }
    return month;
  }
  List yearList() {
    int currentYear = DateTime.now().year + 1;
    int startingYear = 1800;
    List year = List.generate((currentYear-startingYear)+1, (index) => startingYear+index);

    return year;
  }
}