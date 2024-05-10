class DeviceInfoModel {
  final String id;
  final String name;
  final String type;
  final String version;

  DeviceInfoModel({
    required this.id,
    required this.name,
    required this.type,
    required this.version,
  });

  factory DeviceInfoModel.fromJson(Map<String, dynamic> parsedJson) {
    return DeviceInfoModel(
      id: parsedJson['id'] ?? '',
      name: parsedJson['name'] ?? '',
      type: parsedJson['type'] ?? '',
      version: parsedJson['version'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'type': type,
      'version': version,
    };
  }
}