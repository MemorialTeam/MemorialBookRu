class ItemModel {
  int id;
  late int numberOfAdded;
  String productName;
  String price;
  String description;
  String doneAt;
  String avatar;
  List<String> gallery;
  String? cashback;

  ItemModel({
    required this.id,
    this.numberOfAdded = 0,
    required this.productName,
    required this.price,
    required this.description,
    required this.doneAt,
    required this.avatar,
    required this.gallery,
    this.cashback,
  });
}