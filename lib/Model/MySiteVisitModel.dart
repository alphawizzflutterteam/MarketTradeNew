/// data : [{"id":"55","user_id":"71","date":"2024-09-20","time":"06:19:06","lat":"22.7469017","lng":"75.8980159","name":"sawan","mobile":"8042427272","address":"indore ","state":"MADHYA PRADESH","district":"Damoh","pincode":"451808","contractor_id":"7","contractor_mobile":"7485963215","engineer_id":"10","engineer_mobile":"7485963215","artitech_id":"900","artitech_mobile":"null","massion_id":"904","massion_mobile":"9852147588","site_size":"80","current_status":"80","product_being_used":"36","survey":[{"cid":"RB","brand_name":"RCB Testing","total_consumption":"100","further_consumption":"200","purchase_price":"80","purchasing_from":"chbc","last_purchase_date":"11-09-2024"},{"cid":"RB","brand_name":"Atul","total_consumption":"800","further_consumption":"600","purchase_price":"80","purchasing_from":"fhhchc","last_purchase_date":"13-09-2024"},{"cid":"RB","brand_name":"hrhtteyt","total_consumption":"","further_consumption":"","purchase_price":"","purchasing_from":"","last_purchase_date":""}],"expected_orders":"2024-09-20","photo":["https://developmentalphawizz.com/rename_market_track/uploads/user_image/4fcf42b6f9496fd47d9d87071fd208d4.jpg","https://developmentalphawizz.com/rename_market_track/uploads/user_image/d81024340ba1e08c492ed13ea6156f74.jpg"],"remarks":"gdchhc","massion_name":"gghfh","massion_address":"","architect_address":"","architect_name":"","engineer_address":"","engineer_name":"","contractor_address":"","contractor_name":"","created_at":"2024-09-09 18:24:06","final_total":[{"title":"rb","total_consumption":900,"further_consumption":800}]}]
/// error : false
/// message : "Form Submitted success"

class MySiteVisitModel {
  MySiteVisitModel({
    List<SiteVisitData>? data,
    bool? error,
    String? message,
  }) {
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
  MySiteVisitModel copyWith({
    List<SiteVisitData>? data,
    bool? error,
    String? message,
  }) =>
      MySiteVisitModel(
        data: data ?? _data,
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

/// id : "55"
/// user_id : "71"
/// date : "2024-09-20"
/// time : "06:19:06"
/// lat : "22.7469017"
/// lng : "75.8980159"
/// name : "sawan"
/// mobile : "8042427272"
/// address : "indore "
/// state : "MADHYA PRADESH"
/// district : "Damoh"
/// pincode : "451808"
/// contractor_id : "7"
/// contractor_mobile : "7485963215"
/// engineer_id : "10"
/// engineer_mobile : "7485963215"
/// artitech_id : "900"
/// artitech_mobile : "null"
/// massion_id : "904"
/// massion_mobile : "9852147588"
/// site_size : "80"
/// current_status : "80"
/// product_being_used : "36"
/// survey : [{"cid":"RB","brand_name":"RCB Testing","total_consumption":"100","further_consumption":"200","purchase_price":"80","purchasing_from":"chbc","last_purchase_date":"11-09-2024"},{"cid":"RB","brand_name":"Atul","total_consumption":"800","further_consumption":"600","purchase_price":"80","purchasing_from":"fhhchc","last_purchase_date":"13-09-2024"},{"cid":"RB","brand_name":"hrhtteyt","total_consumption":"","further_consumption":"","purchase_price":"","purchasing_from":"","last_purchase_date":""}]
/// expected_orders : "2024-09-20"
/// photo : ["https://developmentalphawizz.com/rename_market_track/uploads/user_image/4fcf42b6f9496fd47d9d87071fd208d4.jpg","https://developmentalphawizz.com/rename_market_track/uploads/user_image/d81024340ba1e08c492ed13ea6156f74.jpg"]
/// remarks : "gdchhc"
/// massion_name : "gghfh"
/// massion_address : ""
/// architect_address : ""
/// architect_name : ""
/// engineer_address : ""
/// engineer_name : ""
/// contractor_address : ""
/// contractor_name : ""
/// created_at : "2024-09-09 18:24:06"
/// final_total : [{"title":"rb","total_consumption":900,"further_consumption":800}]

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
    List<String>? photo,
    String? remarks,
    String? massionName,
    String? massionAddress,
    String? architectAddress,
    String? architectName,
    String? engineerAddress,
    String? engineerName,
    String? contractorAddress,
    String? contractorName,
    String? createdAt,
    List<FinalTotal>? finalTotal,
  }) {
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
    _massionName = massionName;
    _massionAddress = massionAddress;
    _architectAddress = architectAddress;
    _architectName = architectName;
    _engineerAddress = engineerAddress;
    _engineerName = engineerName;
    _contractorAddress = contractorAddress;
    _contractorName = contractorName;
    _createdAt = createdAt;
    _finalTotal = finalTotal;
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
    _photo = json['photo'] != null ? json['photo'].cast<String>() : [];
    _remarks = json['remarks'];
    _massionName = json['massion_name'];
    _massionAddress = json['massion_address'];
    _architectAddress = json['architect_address'];
    _architectName = json['architect_name'];
    _engineerAddress = json['engineer_address'];
    _engineerName = json['engineer_name'];
    _contractorAddress = json['contractor_address'];
    _contractorName = json['contractor_name'];
    _createdAt = json['created_at'];
    if (json['final_total'] != null) {
      _finalTotal = [];
      json['final_total'].forEach((v) {
        _finalTotal?.add(FinalTotal.fromJson(v));
      });
    }
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
  List<String>? _photo;
  String? _remarks;
  String? _massionName;
  String? _massionAddress;
  String? _architectAddress;
  String? _architectName;
  String? _engineerAddress;
  String? _engineerName;
  String? _contractorAddress;
  String? _contractorName;
  String? _createdAt;
  List<FinalTotal>? _finalTotal;
  SiteVisitData copyWith({
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
    List<String>? photo,
    String? remarks,
    String? massionName,
    String? massionAddress,
    String? architectAddress,
    String? architectName,
    String? engineerAddress,
    String? engineerName,
    String? contractorAddress,
    String? contractorName,
    String? createdAt,
    List<FinalTotal>? finalTotal,
  }) =>
      SiteVisitData(
        id: id ?? _id,
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
        massionName: massionName ?? _massionName,
        massionAddress: massionAddress ?? _massionAddress,
        architectAddress: architectAddress ?? _architectAddress,
        architectName: architectName ?? _architectName,
        engineerAddress: engineerAddress ?? _engineerAddress,
        engineerName: engineerName ?? _engineerName,
        contractorAddress: contractorAddress ?? _contractorAddress,
        contractorName: contractorName ?? _contractorName,
        createdAt: createdAt ?? _createdAt,
        finalTotal: finalTotal ?? _finalTotal,
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
  List<String>? get photo => _photo;
  String? get remarks => _remarks;
  String? get massionName => _massionName;
  String? get massionAddress => _massionAddress;
  String? get architectAddress => _architectAddress;
  String? get architectName => _architectName;
  String? get engineerAddress => _engineerAddress;
  String? get engineerName => _engineerName;
  String? get contractorAddress => _contractorAddress;
  String? get contractorName => _contractorName;
  String? get createdAt => _createdAt;
  List<FinalTotal>? get finalTotal => _finalTotal;

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
    map['photo'] = _photo;
    map['remarks'] = _remarks;
    map['massion_name'] = _massionName;
    map['massion_address'] = _massionAddress;
    map['architect_address'] = _architectAddress;
    map['architect_name'] = _architectName;
    map['engineer_address'] = _engineerAddress;
    map['engineer_name'] = _engineerName;
    map['contractor_address'] = _contractorAddress;
    map['contractor_name'] = _contractorName;
    map['created_at'] = _createdAt;
    if (_finalTotal != null) {
      map['final_total'] = _finalTotal?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// title : "rb"
/// total_consumption : 900
/// further_consumption : 800

class FinalTotal {
  FinalTotal({
    String? title,
    num? totalConsumption,
    num? furtherConsumption,
  }) {
    _title = title;
    _totalConsumption = totalConsumption;
    _furtherConsumption = furtherConsumption;
  }

  FinalTotal.fromJson(dynamic json) {
    _title = json['title'];
    _totalConsumption = json['total_consumption'];
    _furtherConsumption = json['further_consumption'];
  }
  String? _title;
  num? _totalConsumption;
  num? _furtherConsumption;
  FinalTotal copyWith({
    String? title,
    num? totalConsumption,
    num? furtherConsumption,
  }) =>
      FinalTotal(
        title: title ?? _title,
        totalConsumption: totalConsumption ?? _totalConsumption,
        furtherConsumption: furtherConsumption ?? _furtherConsumption,
      );
  String? get title => _title;
  num? get totalConsumption => _totalConsumption;
  num? get furtherConsumption => _furtherConsumption;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['title'] = _title;
    map['total_consumption'] = _totalConsumption;
    map['further_consumption'] = _furtherConsumption;
    return map;
  }
}

/// cid : "RB"
/// brand_name : "RCB Testing"
/// total_consumption : "100"
/// further_consumption : "200"
/// purchase_price : "80"
/// purchasing_from : "chbc"
/// last_purchase_date : "11-09-2024"

class Survey {
  Survey({
    String? cid,
    String? brandName,
    String? totalConsumption,
    String? furtherConsumption,
    String? purchasePrice,
    String? purchasingFrom,
    String? lastPurchaseDate,
  }) {
    _cid = cid;
    _brandName = brandName;
    _totalConsumption = totalConsumption;
    _furtherConsumption = furtherConsumption;
    _purchasePrice = purchasePrice;
    _purchasingFrom = purchasingFrom;
    _lastPurchaseDate = lastPurchaseDate;
  }

  Survey.fromJson(dynamic json) {
    _cid = json['cid'];
    _brandName = json['brand_name'];
    _totalConsumption = json['total_consumption'];
    _furtherConsumption = json['further_consumption'];
    _purchasePrice = json['purchase_price'];
    _purchasingFrom = json['purchasing_from'];
    _lastPurchaseDate = json['last_purchase_date'];
  }
  String? _cid;
  String? _brandName;
  String? _totalConsumption;
  String? _furtherConsumption;
  String? _purchasePrice;
  String? _purchasingFrom;
  String? _lastPurchaseDate;
  Survey copyWith({
    String? cid,
    String? brandName,
    String? totalConsumption,
    String? furtherConsumption,
    String? purchasePrice,
    String? purchasingFrom,
    String? lastPurchaseDate,
  }) =>
      Survey(
        cid: cid ?? _cid,
        brandName: brandName ?? _brandName,
        totalConsumption: totalConsumption ?? _totalConsumption,
        furtherConsumption: furtherConsumption ?? _furtherConsumption,
        purchasePrice: purchasePrice ?? _purchasePrice,
        purchasingFrom: purchasingFrom ?? _purchasingFrom,
        lastPurchaseDate: lastPurchaseDate ?? _lastPurchaseDate,
      );
  String? get cid => _cid;
  String? get brandName => _brandName;
  String? get totalConsumption => _totalConsumption;
  String? get furtherConsumption => _furtherConsumption;
  String? get purchasePrice => _purchasePrice;
  String? get purchasingFrom => _purchasingFrom;
  String? get lastPurchaseDate => _lastPurchaseDate;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['cid'] = _cid;
    map['brand_name'] = _brandName;
    map['total_consumption'] = _totalConsumption;
    map['further_consumption'] = _furtherConsumption;
    map['purchase_price'] = _purchasePrice;
    map['purchasing_from'] = _purchasingFrom;
    map['last_purchase_date'] = _lastPurchaseDate;
    return map;
  }
}
