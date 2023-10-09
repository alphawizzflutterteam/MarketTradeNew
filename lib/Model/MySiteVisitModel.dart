/// data : [{"id":"4","user_id":"3","date":"2023-10-09","time":"01:47:58","lat":"null","lng":"null","name":"","mobile":"8523658980","address":"indore","state":"0","district":"0","pincode":"452010","contractor_id":"10","contractor_mobile":"2147483647","engineer_id":"9","engineer_mobile":"2147483647","artitech_id":"10","artitech_mobile":"2147483647","massion_id":"12","massion_mobile":"2147483647","site_size":"45","current_status":"45","product_being_used":"33","survey":[{"brand_name":"Cement","total_consumption":"100","further_consumption":"100","purchase_price":"25","purchasing_from":"25","last_purchase_date":"2023-10-10"},{"brand_name":"Cement","total_consumption":"100","further_consumption":"200","purchase_price":"5","purchasing_from":"25","last_purchase_date":"2023-10-10"}],"expected_orders":"2023-10-09","photo":[],"remarks":"hcchhchfhg","created_at":"2023-10-09 17:44:33"}]
/// error : false
/// message : "Form Submitted success"

class MySiteVisitModel {
  MySiteVisitModel({
      List<SiteVisitData>? data,
      bool? error, 
      String? message,}){
    _data = data;
    _error = error;
    _message = message;
}

  MySiteVisitModel.fromJson(dynamic json) {
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(SiteVisitData.fromJson(v));
      });
    }
    _error = json['error'];
    _message = json['message'];
  }
  List<SiteVisitData>? _data;
  bool? _error;
  String? _message;
MySiteVisitModel copyWith({  List<SiteVisitData>? data,
  bool? error,
  String? message,
}) => MySiteVisitModel(  data: data ?? _data,
  error: error ?? _error,
  message: message ?? _message,
);
  List<SiteVisitData>? get data => _data;
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

/// id : "4"
/// user_id : "3"
/// date : "2023-10-09"
/// time : "01:47:58"
/// lat : "null"
/// lng : "null"
/// name : ""
/// mobile : "8523658980"
/// address : "indore"
/// state : "0"
/// district : "0"
/// pincode : "452010"
/// contractor_id : "10"
/// contractor_mobile : "2147483647"
/// engineer_id : "9"
/// engineer_mobile : "2147483647"
/// artitech_id : "10"
/// artitech_mobile : "2147483647"
/// massion_id : "12"
/// massion_mobile : "2147483647"
/// site_size : "45"
/// current_status : "45"
/// product_being_used : "33"
/// survey : [{"brand_name":"Cement","total_consumption":"100","further_consumption":"100","purchase_price":"25","purchasing_from":"25","last_purchase_date":"2023-10-10"},{"brand_name":"Cement","total_consumption":"100","further_consumption":"200","purchase_price":"5","purchasing_from":"25","last_purchase_date":"2023-10-10"}]
/// expected_orders : "2023-10-09"
/// photo : []
/// remarks : "hcchhchfhg"
/// created_at : "2023-10-09 17:44:33"

class SiteVisitData {
  SiteVisitData({
      String? id, 
      String? userId, 
      String? date, 
      String? time, 
      String? lat, 
      String? lng, 
      String? name, 
      String? mobile, 
      String? address, 
      String? state, 
      String? district, 
      String? pincode, 
      String? contractorId, 
      String? contractorMobile, 
      String? engineerId, 
      String? engineerMobile, 
      String? artitechId, 
      String? artitechMobile, 
      String? massionId, 
      String? massionMobile, 
      String? siteSize, 
      String? currentStatus, 
      String? productBeingUsed, 
      List<Survey>? survey, 
      String? expectedOrders, 
      List<dynamic>? photo, 
      String? remarks, 
      String? createdAt,}){
    _id = id;
    _userId = userId;
    _date = date;
    _time = time;
    _lat = lat;
    _lng = lng;
    _name = name;
    _mobile = mobile;
    _address = address;
    _state = state;
    _district = district;
    _pincode = pincode;
    _contractorId = contractorId;
    _contractorMobile = contractorMobile;
    _engineerId = engineerId;
    _engineerMobile = engineerMobile;
    _artitechId = artitechId;
    _artitechMobile = artitechMobile;
    _massionId = massionId;
    _massionMobile = massionMobile;
    _siteSize = siteSize;
    _currentStatus = currentStatus;
    _productBeingUsed = productBeingUsed;
    _survey = survey;
    _expectedOrders = expectedOrders;
    _photo = photo;
    _remarks = remarks;
    _createdAt = createdAt;
}

  SiteVisitData.fromJson(dynamic json) {
    _id = json['id'];
    _userId = json['user_id'];
    _date = json['date'];
    _time = json['time'];
    _lat = json['lat'];
    _lng = json['lng'];
    _name = json['name'];
    _mobile = json['mobile'];
    _address = json['address'];
    _state = json['state'];
    _district = json['district'];
    _pincode = json['pincode'];
    _contractorId = json['contractor_id'];
    _contractorMobile = json['contractor_mobile'];
    _engineerId = json['engineer_id'];
    _engineerMobile = json['engineer_mobile'];
    _artitechId = json['artitech_id'];
    _artitechMobile = json['artitech_mobile'];
    _massionId = json['massion_id'];
    _massionMobile = json['massion_mobile'];
    _siteSize = json['site_size'];
    _currentStatus = json['current_status'];
    _productBeingUsed = json['product_being_used'];
    if (json['survey'] != null) {
      _survey = [];
      json['survey'].forEach((v) {
        _survey?.add(Survey.fromJson(v));
      });
    }
    _expectedOrders = json['expected_orders'];
    if (json['photo'] != null) {
      _photo = [];
      json['photo'].forEach((v) {
        _photo?.add(v.fromJson(v));
      });
    }
    _remarks = json['remarks'];
    _createdAt = json['created_at'];
  }
  String? _id;
  String? _userId;
  String? _date;
  String? _time;
  String? _lat;
  String? _lng;
  String? _name;
  String? _mobile;
  String? _address;
  String? _state;
  String? _district;
  String? _pincode;
  String? _contractorId;
  String? _contractorMobile;
  String? _engineerId;
  String? _engineerMobile;
  String? _artitechId;
  String? _artitechMobile;
  String? _massionId;
  String? _massionMobile;
  String? _siteSize;
  String? _currentStatus;
  String? _productBeingUsed;
  List<Survey>? _survey;
  String? _expectedOrders;
  List<dynamic>? _photo;
  String? _remarks;
  String? _createdAt;
  SiteVisitData copyWith({  String? id,
  String? userId,
  String? date,
  String? time,
  String? lat,
  String? lng,
  String? name,
  String? mobile,
  String? address,
  String? state,
  String? district,
  String? pincode,
  String? contractorId,
  String? contractorMobile,
  String? engineerId,
  String? engineerMobile,
  String? artitechId,
  String? artitechMobile,
  String? massionId,
  String? massionMobile,
  String? siteSize,
  String? currentStatus,
  String? productBeingUsed,
  List<Survey>? survey,
  String? expectedOrders,
  List<dynamic>? photo,
  String? remarks,
  String? createdAt,
}) => SiteVisitData(  id: id ?? _id,
  userId: userId ?? _userId,
  date: date ?? _date,
  time: time ?? _time,
  lat: lat ?? _lat,
  lng: lng ?? _lng,
  name: name ?? _name,
  mobile: mobile ?? _mobile,
  address: address ?? _address,
  state: state ?? _state,
  district: district ?? _district,
  pincode: pincode ?? _pincode,
  contractorId: contractorId ?? _contractorId,
  contractorMobile: contractorMobile ?? _contractorMobile,
  engineerId: engineerId ?? _engineerId,
  engineerMobile: engineerMobile ?? _engineerMobile,
  artitechId: artitechId ?? _artitechId,
  artitechMobile: artitechMobile ?? _artitechMobile,
  massionId: massionId ?? _massionId,
  massionMobile: massionMobile ?? _massionMobile,
  siteSize: siteSize ?? _siteSize,
  currentStatus: currentStatus ?? _currentStatus,
  productBeingUsed: productBeingUsed ?? _productBeingUsed,
  survey: survey ?? _survey,
  expectedOrders: expectedOrders ?? _expectedOrders,
  photo: photo ?? _photo,
  remarks: remarks ?? _remarks,
  createdAt: createdAt ?? _createdAt,
);
  String? get id => _id;
  String? get userId => _userId;
  String? get date => _date;
  String? get time => _time;
  String? get lat => _lat;
  String? get lng => _lng;
  String? get name => _name;
  String? get mobile => _mobile;
  String? get address => _address;
  String? get state => _state;
  String? get district => _district;
  String? get pincode => _pincode;
  String? get contractorId => _contractorId;
  String? get contractorMobile => _contractorMobile;
  String? get engineerId => _engineerId;
  String? get engineerMobile => _engineerMobile;
  String? get artitechId => _artitechId;
  String? get artitechMobile => _artitechMobile;
  String? get massionId => _massionId;
  String? get massionMobile => _massionMobile;
  String? get siteSize => _siteSize;
  String? get currentStatus => _currentStatus;
  String? get productBeingUsed => _productBeingUsed;
  List<Survey>? get survey => _survey;
  String? get expectedOrders => _expectedOrders;
  List<dynamic>? get photo => _photo;
  String? get remarks => _remarks;
  String? get createdAt => _createdAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['user_id'] = _userId;
    map['date'] = _date;
    map['time'] = _time;
    map['lat'] = _lat;
    map['lng'] = _lng;
    map['name'] = _name;
    map['mobile'] = _mobile;
    map['address'] = _address;
    map['state'] = _state;
    map['district'] = _district;
    map['pincode'] = _pincode;
    map['contractor_id'] = _contractorId;
    map['contractor_mobile'] = _contractorMobile;
    map['engineer_id'] = _engineerId;
    map['engineer_mobile'] = _engineerMobile;
    map['artitech_id'] = _artitechId;
    map['artitech_mobile'] = _artitechMobile;
    map['massion_id'] = _massionId;
    map['massion_mobile'] = _massionMobile;
    map['site_size'] = _siteSize;
    map['current_status'] = _currentStatus;
    map['product_being_used'] = _productBeingUsed;
    if (_survey != null) {
      map['survey'] = _survey?.map((v) => v.toJson()).toList();
    }
    map['expected_orders'] = _expectedOrders;
    if (_photo != null) {
      map['photo'] = _photo?.map((v) => v.toJson()).toList();
    }
    map['remarks'] = _remarks;
    map['created_at'] = _createdAt;
    return map;
  }

}

/// brand_name : "Cement"
/// total_consumption : "100"
/// further_consumption : "100"
/// purchase_price : "25"
/// purchasing_from : "25"
/// last_purchase_date : "2023-10-10"

class Survey {
  Survey({
      String? brandName, 
      String? totalConsumption, 
      String? furtherConsumption, 
      String? purchasePrice, 
      String? purchasingFrom, 
      String? lastPurchaseDate,}){
    _brandName = brandName;
    _totalConsumption = totalConsumption;
    _furtherConsumption = furtherConsumption;
    _purchasePrice = purchasePrice;
    _purchasingFrom = purchasingFrom;
    _lastPurchaseDate = lastPurchaseDate;
}

  Survey.fromJson(dynamic json) {
    _brandName = json['brand_name'];
    _totalConsumption = json['total_consumption'];
    _furtherConsumption = json['further_consumption'];
    _purchasePrice = json['purchase_price'];
    _purchasingFrom = json['purchasing_from'];
    _lastPurchaseDate = json['last_purchase_date'];
  }
  String? _brandName;
  String? _totalConsumption;
  String? _furtherConsumption;
  String? _purchasePrice;
  String? _purchasingFrom;
  String? _lastPurchaseDate;
Survey copyWith({  String? brandName,
  String? totalConsumption,
  String? furtherConsumption,
  String? purchasePrice,
  String? purchasingFrom,
  String? lastPurchaseDate,
}) => Survey(  brandName: brandName ?? _brandName,
  totalConsumption: totalConsumption ?? _totalConsumption,
  furtherConsumption: furtherConsumption ?? _furtherConsumption,
  purchasePrice: purchasePrice ?? _purchasePrice,
  purchasingFrom: purchasingFrom ?? _purchasingFrom,
  lastPurchaseDate: lastPurchaseDate ?? _lastPurchaseDate,
);
  String? get brandName => _brandName;
  String? get totalConsumption => _totalConsumption;
  String? get furtherConsumption => _furtherConsumption;
  String? get purchasePrice => _purchasePrice;
  String? get purchasingFrom => _purchasingFrom;
  String? get lastPurchaseDate => _lastPurchaseDate;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['brand_name'] = _brandName;
    map['total_consumption'] = _totalConsumption;
    map['further_consumption'] = _furtherConsumption;
    map['purchase_price'] = _purchasePrice;
    map['purchasing_from'] = _purchasingFrom;
    map['last_purchase_date'] = _lastPurchaseDate;
    return map;
  }

}