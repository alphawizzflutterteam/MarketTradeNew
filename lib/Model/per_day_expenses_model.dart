/// data : [{"id":"12","status":"0","date":"2023-06-22","total_amount":"200","name":"Karan S Tomar","images":["https://alphawizzserver.com/employee_management/uploads/spent_images/"]},{"id":"13","status":"0","date":"2023-06-23","total_amount":"15200","name":"Karan S Tomar","images":["https://alphawizzserver.com/employee_management/uploads/spent_images/"]}]
/// error : false
/// message : "All spents"

class PerDayExpensesModel {
  PerDayExpensesModel({
      List<PerDayCharges>? data,
      bool? error, 
      String? message,}){
    _data = data;
    _error = error;
    _message = message;
}

  PerDayExpensesModel.fromJson(dynamic json) {
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(PerDayCharges.fromJson(v));
      });
    }
    _error = json['error'];
    _message = json['message'];
  }
  List<PerDayCharges>? _data;
  bool? _error;
  String? _message;
PerDayExpensesModel copyWith({  List<PerDayCharges>? data,
  bool? error,
  String? message,
}) => PerDayExpensesModel(  data: data ?? _data,
  error: error ?? _error,
  message: message ?? _message,
);
  List<PerDayCharges>? get data => _data;
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

/// id : "12"
/// status : "0"
/// date : "2023-06-22"
/// total_amount : "200"
/// name : "Karan S Tomar"
/// images : ["https://alphawizzserver.com/employee_management/uploads/spent_images/"]

class PerDayCharges {
  PerDayCharges({
      String? id, 
      String? status, 
      String? isPaid,
      String? date,
      String? totalAmount, 
      String? name, 
      List<String>? images,}){
    _id = id;
    _status = status;
    _isPaid = isPaid;
    _date = date;
    _totalAmount = totalAmount;
    _name = name;
    _images = images;
}

  PerDayCharges.fromJson(dynamic json) {
    _id = json['id'];
    _status = json['status'];
    _isPaid = json['is_paid'];
    _date = json['date'];
    _totalAmount = json['total_amount'];
    _name = json['name'];
    _images = json['images'] != null ? json['images'].cast<String>() : [];
  }
  String? _id;
  String? _status;
  String? _isPaid;
  String? _date;
  String? _totalAmount;
  String? _name;
  List<String>? _images;
PerDayCharges copyWith({  String? id,
  String? status,
  String? isPaid,
  String? date,
  String? totalAmount,
  String? name,
  List<String>? images,
}) => PerDayCharges(  id: id ?? _id,
  status: status ?? _status,
  isPaid: isPaid ?? _isPaid,
  date: date ?? _date,
  totalAmount: totalAmount ?? _totalAmount,
  name: name ?? _name,
  images: images ?? _images,
);
  String? get id => _id;
  String? get status => _status;
  String? get isPaid => _isPaid;
  String? get date => _date;
  String? get totalAmount => _totalAmount;
  String? get name => _name;
  List<String>? get images => _images;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['status'] = _status;
    map['is_paid'] = _isPaid;
    map['date'] = _date;
    map['total_amount'] = _totalAmount;
    map['name'] = _name;
    map['images'] = _images;
    return map;
  }

}