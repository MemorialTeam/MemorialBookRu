class RequisiteResponseModel {
  int? id;
  int? shopId;
  String? fullName;
  String? legalAddress;
  String? postAddress;
  String? inn;
  String? ogrn;
  String? kpp;
  String? bik;
  String? paymentAccount;
  String? correspondentAccount;
  String? bankName;

  RequisiteResponseModel({
    required this.id,
    required this.shopId,
    required this.fullName,
    required this.legalAddress,
    required this.postAddress,
    required this.inn,
    required this.ogrn,
    required this.kpp,
    required this.bik,
    required this.paymentAccount,
    required this.correspondentAccount,
    required this.bankName,
  });

  RequisiteResponseModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    shopId = json['shop_id'];
    fullName = json['full_name'];
    legalAddress = json['legal_address'];
    postAddress = json['post_address'];
    inn = json['INN'];
    ogrn = json['OGRN'];
    kpp = json['KPP'];
    bik = json['BIK'];
    paymentAccount = json['payment_account'];
    correspondentAccount = json['correspondent_account'];
    bankName = json['bank_name'];
  }
}