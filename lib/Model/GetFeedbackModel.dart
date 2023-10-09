// To parse this JSON data, do
//
//     final getdata = getdataFromJson(jsonString);

import 'dart:convert';

Getdata getdataFromJson(String str) => Getdata.fromJson(json.decode(str));

String getdataToJson(Getdata data) => json.encode(data.toJson());

class Getdata {
  bool error;
  List<Datum> data;
  String message;

  Getdata({
    required this.error,
    required this.data,
    required this.message,
  });

  factory Getdata.fromJson(Map<String, dynamic> json) => Getdata(
    error: json["error"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "error": error,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "message": message,
  };
}

class Datum {
  String id;
  String userId;
  DateTime date;
  String time;
  String lat;
  String lng;
  String nameOfFirm;
  BasicDetail basicDetail;
  List<CustomerDealingIn> customerDealingIn;
  List<Survey> survey;
  String photo;
  String remarks;
  String totalMonthlySale;
  String totalCurrentStock;
  DateTime createdAt;
  DateTime updatedAt;

  Datum({
    required this.id,
    required this.userId,
    required this.date,
    required this.time,
    required this.lat,
    required this.lng,
    required this.nameOfFirm,
    required this.basicDetail,
    required this.customerDealingIn,
    required this.survey,
    required this.photo,
    required this.remarks,
    required this.totalMonthlySale,
    required this.totalCurrentStock,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    userId: json["user_id"],
    date: DateTime.parse(json["date"]),
    time: json["time"],
    lat: json["lat"],
    lng: json["lng"],
    nameOfFirm: json["name_of_firm"],
    basicDetail: BasicDetail.fromJson(json["basic_detail"]),
    customerDealingIn: List<CustomerDealingIn>.from(json["customer_dealing_in"].map((x) => CustomerDealingIn.fromJson(x))),
    survey: List<Survey>.from(json["survey"].map((x) => Survey.fromJson(x))),
    photo: json["photo"],
    remarks: json["remarks"],
    totalMonthlySale: json["total_monthly_sale"],
    totalCurrentStock: json["total_current_stock"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "date": "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
    "time": time,
    "lat": lat,
    "lng": lng,
    "name_of_firm": nameOfFirm,
    "basic_detail": basicDetail.toJson(),
    "customer_dealing_in": List<dynamic>.from(customerDealingIn.map((x) => x.toJson())),
    "survey": List<dynamic>.from(survey.map((x) => x.toJson())),
    "photo": photo,
    "remarks": remarks,
    "total_monthly_sale": totalMonthlySale,
    "total_current_stock": totalCurrentStock,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}

class BasicDetail {
  String name;
  String mobile;
  String email;
  String address;
  String customerType;
  String creditLimit;

  BasicDetail({
    required this.name,
    required this.mobile,
    required this.email,
    required this.address,
    required this.customerType,
    required this.creditLimit,
  });

  factory BasicDetail.fromJson(Map<String, dynamic> json) => BasicDetail(
    name: json["name"],
    mobile: json["mobile"],
    email: json["email"],
    address: json["address"],
    customerType: json["customer_type"],
    creditLimit: json["credit_limit"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "mobile": mobile,
    "email": email,
    "address": address,
    "customer_type": customerType,
    "credit_limit": creditLimit,
  };
}

class CustomerDealingIn {
  String id;
  String name;

  CustomerDealingIn({
    required this.id,
    required this.name,
  });

  factory CustomerDealingIn.fromJson(Map<String, dynamic> json) => CustomerDealingIn(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}

class Survey {
  String brandName;
  String monthlySale;
  String currentStock;
  String wps;
  String rsp;
  String purchasingFrom;

  Survey({
    required this.brandName,
    required this.monthlySale,
    required this.currentStock,
    required this.wps,
    required this.rsp,
    required this.purchasingFrom,
  });

  factory Survey.fromJson(Map<String, dynamic> json) => Survey(
    brandName: json["brand_name"],
    monthlySale: json["monthly_sale"],
    currentStock: json["current_stock"],
    wps: json["wps"],
    rsp: json["rsp"],
    purchasingFrom: json["purchasing_from"],
  );

  Map<String, dynamic> toJson() => {
    "brand_name": brandName,
    "monthly_sale": monthlySale,
    "current_stock": currentStock,
    "wps": wps,
    "rsp": rsp,
    "purchasing_from": purchasingFrom,
  };
}
