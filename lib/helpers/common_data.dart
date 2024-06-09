import '../models/market/product_model.dart';

class CommonData {
  static final listOfThreeAccesses = [
    {
      'title': 'Публичный',
      'subtitle': 'Информация профиля видна всем пользователям',
    },
    {
      'title': 'Доступный',
      'subtitle': 'Часть информации в профиле скрыта: места захоронения, родственники',
    },
    {
      'title': 'Приватный',
      'subtitle': 'Информацию профиля могу видеть только я',
    },
  ];
  static final listOfTwoAccesses = [
    {
      'title': 'Публичный',
      'subtitle': 'Информация профиля видна всем пользователям',
    },
    {
      'title': 'Приватный',
      'subtitle': 'Информацию профиля могу видеть только я',
    },
  ];

  List<ProductModel> historyList = [
    ProductModel(
      status: 'Новый',
      productName: 'Уборка',
      price: '29,99',
      doneAt: '28.02.2021',
      image: 'https://kcson33.uszn032.ru/upload/iblock/6f9/v2ab1vx6rqdl3ybp5dit7lcyf1xg66ke/EYhljOWXQAEt-pH.jpg',
    ),
    ProductModel(
      status: 'В работе',
      productName: 'Облагораживание',
      price: '29,99',
      doneAt: '28.02.2021',
      image: 'https://i.simpalsmedia.com/999.md/BoardImages/900x900/3e454fe7436faad5f4c8d2c07c890ca9.jpg',
    ),
    ProductModel(
      status: 'Выполнен',
      productName: 'Цветы',
      price: '29,99',
      doneAt: '30.02.2021',
      image: 'https://mykaleidoscope.ru/uploads/posts/2022-06/1655993610_42-mykaleidoscope-ru-p-deshevie-buketi-tsvetov-krasivo-foto-45.jpg',
      cashback: '+\$7,99 (Exaltation on the grave)',
    ),
    ProductModel(
      status: 'Отменен',
      productName: 'Уборка',
      price: '29,99',
      doneAt: '28.02.2021',
      image: 'https://blagodel32.ru/upload/iblock/7c8/7c8bb62c877e480c519be840f04daeab.jpg',
    ),
    ProductModel(
      status: 'Выполнен',
      productName: 'Installing QR-code...',
      price: '29,99',
      doneAt: '28.02.2021',
      image: 'https://www.thesun.co.uk/wp-content/uploads/2018/09/NINTCHDBPICT000436982054.jpg',
      cashback: '+\$7,99 (Exaltation on the grave)',
    ),
    ProductModel(
      status: 'Выполнен',
      productName: 'Installing QR-code...',
      price: '29,99',
      doneAt: '28.02.2021',
      image: 'https://www.thesun.co.uk/wp-content/uploads/2018/09/NINTCHDBPICT000436982054.jpg',
      cashback: '+\$7,99 (Exaltation on the grave)',
    ),
  ];
}