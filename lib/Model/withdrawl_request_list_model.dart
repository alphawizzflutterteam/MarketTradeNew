/// data : [{"id":"2","user_id":"236","bank_details":"{\"ac_no\": \"918225917493\", \"bank_name\": \"Paytm payment Bank \", \"ifsc_code\": \"PYTM0123456\", \"account_type\": \"Savings\", \"ac_holder_name\": \"arpit sharma \"}","amount":"2.00","remarks":null,"status":"2","created_at":"2023-06-02 21:14:09","updated_at":"2023-06-06 08:28:35"}]
/// error : false
/// message : "All spents"

class WithdrawlRequestListModel {
  WithdrawlRequestListModel({
      List<WithdrawlList>? data,
      bool? error, 
      String? message,}){
    _data = data;
    _error = error;
    _message = message;
}

  WithdrawlRequestListModel.fromJson(dynamic json) {
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(WithdrawlList.fromJson(v));
      });
    }
    _error = json['error'];
    _message = json['message'];
  }
  List<WithdrawlList>? _data;
  bool? _error;
  String? _message;
WithdrawlRequestListModel copyWith({  List<WithdrawlList>? data,
  bool? error,
  String? message,
}) => WithdrawlRequestListModel(  data: data ?? _data,
  error: error ?? _error,
  message: message ?? _message,
);
  List<WithdrawlList>? get data => _data;
  bool? get error => _error;
  String? get message => _message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    map['error'] = _error;
    map['message'] = _message;
    return map;
  }

}

/// id : "2"
/// user_id : "236"
/// bank_details : "{\"ac_no\": \"918225917493\", \"bank_name\": \"Paytm payment Bank \", \"ifsc_code\": \"PYTM0123456\", \"account_type\": \"Savings\", \"ac_holder_name\": \"arpit sharma \"}"
/// amount : "2.00"
/// remarks : null
/// status : "2"
/// created_at : "2023-06-02 21:14:09"
/// updated_at : "2023-06-06 08:28:35"

class WithdrawlList {
  WithdrawlList({
      String? id, 
      String? userId, 
      String? bankDetails, 
      String? amount, 
      dynamic remarks, 
      String? status, 
      String? createdAt, 
      String? updatedAt,}){
    _id = id;
    _userId = userId;
    _bankDetails = bankDetails;
    _amount = amount;
    _remarks = remarks;
    _status = status;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
}

  WithdrawlList.fromJson(dynamic json) {
    _id = json['id'];
    _userId = json['user_id'];
    _bankDetails = json['bank_details'];
    _amount = json['amount'];
    _remarks = json['remarks'];
    _status = json['status'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }
  String? _id;
  String? _userId;
  String? _bankDetails;
  String? _amount;
  dynamic _remarks;
  String? _status;
  String? _createdAt;
  String? _updatedAt;
WithdrawlList copyWith({  String? id,
  String? userId,
  String? bankDetails,
  String? amount,
  dynamic remarks,
  String? status,
  String? createdAt,
  String? updatedAt,
}) => WithdrawlList(  id: id ?? _id,
  userId: userId ?? _userId,
  bankDetails: bankDetails ?? _bankDetails,
  amount: amount ?? _amount,
  remarks: remarks ?? _remarks,
  status: status ?? _status,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
);
  String? get id => _id;
  String? get userId => _userId;
  String? get bankDetails => _bankDetails;
  String? get amount => _amount;
  dynamic get remarks => _remarks;
  String? get status => _status;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['user_id'] = _userId;
    map['bank_details'] = _bankDetails;
    map['amount'] = _amount;
    map['remarks'] = _remarks;
    map['status'] = _status;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }

}