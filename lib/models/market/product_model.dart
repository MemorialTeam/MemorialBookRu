class ProductModel {
  String status;
  String productName;
  String price;
  String doneAt;
  String image;
  String? cashback;

  ProductModel({
    required this.status,
    required this.productName,
    required this.price,
    required this.doneAt,
    required this.image,
    this.cashback,
  });
}