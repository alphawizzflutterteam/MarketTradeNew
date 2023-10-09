// To parse this JSON data, do
//
//     final workallotmentModel = workallotmentModelFromJson(jsonString);

import 'dart:convert';

WorkallotmentModel workallotmentModelFromJson(String str) => WorkallotmentModel.fromJson(json.decode(str));

String workallotmentModelToJson(WorkallotmentModel data) => json.encode(data.toJson());

class WorkallotmentModel {
  List<WorkAllotmentData> data;
  bool error;
  String message;

  WorkallotmentModel({
    required this.data,
    required this.error,
    required this.message,
  });

  factory WorkallotmentModel.fromJson(Map<String, dynamic> json) => WorkallotmentModel(
    data: List<WorkAllotmentData>.from(json["data"].map((x) => WorkAllotmentData.fromJson(x))),
    error: json["error"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "error": error,
    "message": message,
  };
}

class WorkAllotmentData {
  String id;
  String userId;
  String title;
  String description;
  String image;
  dynamic latitude;
  dynamic longitude;
  String address;
  String status;
  String createdAt;
  String updateAt;

  WorkAllotmentData({
    required this.id,
    required this.userId,
    required this.title,
    required this.description,
    required this.image,
    this.latitude,
    this.longitude,
    required this.address,
    required this.status,
    required this.createdAt,
    required this.updateAt,
  });

  factory WorkAllotmentData.fromJson(Map<String, dynamic> json) => WorkAllotmentData(
    id: json["id"],
    userId: json["user_id"],
    title: json["title"],
    description: json["description"],
    image: json["image"],
    latitude: json["latitude"],
    longitude: json["longitude"],
    address: json["address"],
    status: json["status"],
    createdAt: json["created_at"],
    updateAt: json["update_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "title": title,
    "description": description,
    "image": image,
    "latitude": latitude,
    "longitude": longitude,
    "address": address,
    "status": status,
    "created_at": createdAt,
    "update_at": updateAt,
  };
}
