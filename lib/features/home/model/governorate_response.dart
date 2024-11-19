import 'dart:convert';

class GovernorateResponse {
  final int status;
  final String message;
  final Data data;

  GovernorateResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory GovernorateResponse.fromRawJson(String str) =>
      GovernorateResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GovernorateResponse.fromJson(Map<String, dynamic> json) =>
      GovernorateResponse(
        status: json["status"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data.toJson(),
      };
}

class Data {
  final List<Governorate> governorates;

  Data({
    required this.governorates,
  });

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        governorates: List<Governorate>.from(
            json["governates"].map((x) => Governorate.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "governates": List<dynamic>.from(governorates.map((x) => x.toJson())),
      };
}

class Governorate {
  final String governorateId;
  final String latlng;
  final String name;

  Governorate({
    required this.governorateId,
    required this.latlng,
    required this.name,
  });

  factory Governorate.fromRawJson(String str) =>
      Governorate.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Governorate.fromJson(Map<String, dynamic> json) => Governorate(
        governorateId: json["governate_id"],
        latlng: json["latlng"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "governate_id": governorateId,
        "latlng": latlng,
        "name": name,
      };
}
