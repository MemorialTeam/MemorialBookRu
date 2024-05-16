class ManufacturingTimeResponseModel {
  String? unit;
  String? value;

  ManufacturingTimeResponseModel({
    required this.unit,
    required this.value,
  });

  ManufacturingTimeResponseModel.fromJson(Map<String, dynamic> json) {
    unit = json['unit'];
    value = json['value'];
  }
}