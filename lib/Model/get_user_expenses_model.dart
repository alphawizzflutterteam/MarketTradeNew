// To parse this JSON data, do
//
//     final getUserExpensesModel = getUserExpensesModelFromJson(jsonString);

import 'dart:convert';

GetUserExpensesModel getUserExpensesModelFromJson(String str) => GetUserExpensesModel.fromJson(json.decode(str));

String getUserExpensesModelToJson(GetUserExpensesModel data) => json.encode(data.toJson());

class GetUserExpensesModel {
  List<UserExpenses> data;
  bool error;
  String message;

  GetUserExpensesModel({
    required this.data,
    required this.error,
    required this.message,
  });

  factory GetUserExpensesModel.fromJson(Map<String, dynamic> json) => GetUserExpensesModel(
    data: List<UserExpenses>.from(json["data"].map((x) => UserExpenses.fromJson(x))),
    error: json["error"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "error": error,
    "message": message,
  };
}

class UserExpenses {
  String id;
  String userId;
  List<String> images;
  String spentType;
  String subSpentType;
  String? from;
  String? to;
  String amount;
  String status;
  dynamic remark;
  String isPaid;
  String latitude;
  String? longitude;
  String address;
  String description;
  DateTime createAt;
  String updateAt;
  String name;
  String st;
  String sst;

  UserExpenses({
    required this.id,
    required this.userId,
    required this.images,
    required this.spentType,
    required this.subSpentType,
    this.from,
    this.to,
    required this.amount,
    required this.status,
    this.remark,
    required this.isPaid,
    required this.latitude,
    this.longitude,
    required this.address,
    required this.description,
    required this.createAt,
    required this.updateAt,
    required this.name,
    required this.st,
    required this.sst,
  });

  factory UserExpenses.fromJson(Map<String, dynamic> json) => UserExpenses(
    id: json["id"],
    userId: json["user_id"],
    images: List<String>.from(json["images"].map((x) => x)),
    spentType: json["spent_type"],
    subSpentType: json["sub_spent_type"],
    from: json["from"],
    to: json["to"],
    amount: json["amount"],
    status: json["status"],
    remark: json["remark"],
    isPaid: json["is_paid"],
    latitude: json["latitude"],
    longitude: json["longitude"],
    address: json["address"],
    description: json["description"],
    createAt: DateTime.parse(json["create_at"]),
    updateAt: json["update_at"],
    name: json["name"],
    st: json["st"],
    sst: json["sst"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "images": List<dynamic>.from(images.map((x) => x)),
    "spent_type": spentType,
    "sub_spent_type": subSpentType,
    "from": from,
    "to": to,
    "amount": amount,
    "status": status,
    "remark": remark,
    "is_paid": isPaid,
    "latitude": latitude,
    "longitude": longitude,
    "address": address,
    "description": description,
    "create_at": "${createAt.year.toString().padLeft(4, '0')}-${createAt.month.toString().padLeft(2, '0')}-${createAt.day.toString().padLeft(2, '0')}",
    "update_at": updateAt,
    "name": name,
    "st": st,
    "sst": sst,
  };
}
