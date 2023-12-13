/// error : false
/// message : "Data Get Sucessfully !"
/// data : [{"id":"1","title":"Received","created_at":"2023-12-12 13:27:01"},{"id":"2","title":"Ledger Not Recievd","created_at":"2023-12-12 13:27:12"},{"id":"3","title":"Rate Diffrence","created_at":"2023-12-12 13:27:25"},{"id":"4","title":"Bill not Received","created_at":"2023-12-12 13:27:33"}]

class GravanceModel {
  GravanceModel({
      bool? error, 
      String? message, 
      List<GravanceData>? data,}){
    _error = error;
    _message = message;
    _data = data;
}

  GravanceModel.fromJson(dynamic json) {
    _error = json['error'];
    _message = json['message'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(GravanceData.fromJson(v));
      });
    }
  }
  bool? _error;
  String? _message;
  List<GravanceData>? _data;
GravanceModel copyWith({  bool? error,
  String? message,
  List<GravanceData>? data,
}) => GravanceModel(  error: error ?? _error,
  message: message ?? _message,
  data: data ?? _data,
);
  bool? get error => _error;
  String? get message => _message;
  List<GravanceData>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['error'] = _error;
    map['message'] = _message;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : "1"
/// title : "Received"
/// created_at : "2023-12-12 13:27:01"

class GravanceData {
  GravanceData({
      String? id, 
      String? title, 
      String? createdAt,}){
    _id = id;
    _title = title;
    _createdAt = createdAt;
}

  GravanceData.fromJson(dynamic json) {
    _id = json['id'];
    _title = json['title'];
    _createdAt = json['created_at'];
  }
  String? _id;
  String? _title;
  String? _createdAt;
  GravanceData copyWith({  String? id,
  String? title,
  String? createdAt,
}) => GravanceData(  id: id ?? _id,
  title: title ?? _title,
  createdAt: createdAt ?? _createdAt,
);
  String? get id => _id;
  String? get title => _title;
  String? get createdAt => _createdAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['title'] = _title;
    map['created_at'] = _createdAt;
    return map;
  }

}