// To parse this JSON data, do
//
//     final checkInOutModel = checkInOutModelFromJson(jsonString);

import 'dart:convert';

CheckInModel checkInOutModelFromJson(String str) => CheckInModel.fromJson(json.decode(str));

String checkInOutModelToJson(CheckInModel data) => json.encode(data.toJson());

class CheckInModel {
  String data;

  CheckInModel({
    required this.data,
  });

  factory CheckInModel.fromJson(Map<String, dynamic> json) => CheckInModel(
    data: json["data"],
  );

  Map<String, dynamic> toJson() => {
    "data": data,
  };
}
