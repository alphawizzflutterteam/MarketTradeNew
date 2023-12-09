/// error : false
/// message : "All Clients Lists"
/// data : [{"id":"1","user_id":"2","staff_id":"0","name_of_firm":"BCC Cement","status":"1","owner_name":"Mahendra Singh","address":"Indore Vijay Nagar","email":"sawan@mailinator.com","district":"2","state":"2","pin_code":"452003","mobile_one":"7896543211","mobile_two":"7897897899","whatsapp_number":"7897897891","pan":"AAAAA1234R","gst":"ABCFHRUGKGH","aadhar":"123445679877","customer_type":"1","lat":"25.789456","lng":"75.654789","photo":"https://developmentalphawizz.com/market_track/uploads/user_image/jblogo3.png","credit_limit":"10000.00","created_at":"2023-09-27 16:18:23","updated_at":"2023-09-27 16:11:43"},{"id":"2","user_id":"2","staff_id":"0","name_of_firm":"Birla Cement","status":"1","owner_name":"Mahendra Singh","address":"Indore Vijay Nagar","email":"sawan@mailinator.com","district":"2","state":"2","pin_code":"452003","mobile_one":"7896543211","mobile_two":"7897897899","whatsapp_number":"7897897891","pan":"AAAAA1234R","gst":"ABCFHRUGKGH","aadhar":"123445679877","customer_type":"1","lat":"25.789456","lng":"75.654789","photo":"https://developmentalphawizz.com/market_track/uploads/user_image/jblogo4.png","credit_limit":"10000.00","created_at":"2023-09-27 16:18:34","updated_at":"2023-09-27 16:18:34"},{"id":"6","user_id":"0","staff_id":"1","name_of_firm":"fdfdf","status":"1","owner_name":"dfdf","address":"fdf","email":"test@gmail.com","district":"12","state":"10","pin_code":"465656","mobile_one":"5555555555","mobile_two":"66666666666","whatsapp_number":"77777777777","pan":"45455454554","gst":"6565","aadhar":"54545454545545","customer_type":"2","lat":"","lng":"","photo":"https://developmentalphawizz.com/market_track/uploads/user_image/","credit_limit":"343443.00","created_at":"2023-10-04 17:09:28","updated_at":"2023-10-03 17:39:04"},{"id":"7","user_id":"1","staff_id":"0","name_of_firm":"qwe","status":"1","owner_name":"fdfdf","address":"fdfdfdfd","email":"dfds111@gmail.com","district":"13","state":"10","pin_code":"332323","mobile_one":"3232323233","mobile_two":"32323233232","whatsapp_number":"2323232323","pan":"45455454554","gst":"6565","aadhar":"54545454545545","customer_type":"1","lat":"","lng":"","photo":"https://developmentalphawizz.com/market_track/uploads/user_image/","credit_limit":"99999999.99","created_at":"2023-10-04 17:09:15","updated_at":"2023-10-03 17:53:09"}]

class DelearRetailerModel {
  DelearRetailerModel({
      bool? error,
      String? message,
      List<DealerListData>? data,}){
    _error = error;
    _message = message;
    _data = data;
}

  DelearRetailerModel.fromJson(dynamic json) {
    _error = json['error'];
    _message = json['message'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(DealerListData.fromJson(v));
      });
    }
  }
  bool? _error;
  String? _message;
  List<DealerListData>? _data;
DelearRetailerModel copyWith({  bool? error,
  String? message,
  List<DealerListData>? data,
}) => DelearRetailerModel(  error: error ?? _error,
  message: message ?? _message,
  data: data ?? _data,
);
  bool? get error => _error;
  String? get message => _message;
  List<DealerListData>? get data => _data;

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
/// user_id : "2"
/// staff_id : "0"
/// name_of_firm : "BCC Cement"
/// status : "1"
/// owner_name : "Mahendra Singh"
/// address : "Indore Vijay Nagar"
/// email : "sawan@mailinator.com"
/// district : "2"
/// state : "2"
/// pin_code : "452003"
/// mobile_one : "7896543211"
/// mobile_two : "7897897899"
/// whatsapp_number : "7897897891"
/// pan : "AAAAA1234R"
/// gst : "ABCFHRUGKGH"
/// aadhar : "123445679877"
/// customer_type : "1"
/// lat : "25.789456"
/// lng : "75.654789"
/// photo : "https://developmentalphawizz.com/market_track/uploads/user_image/jblogo3.png"
/// credit_limit : "10000.00"
/// created_at : "2023-09-27 16:18:23"
/// updated_at : "2023-09-27 16:11:43"

class DealerListData {
  DealerListData({
      String? id,
      String? userId,
      String? staffId,
      String? nameOfFirm,
      String? status,
      String? ownerName,
      String? address,
      String? email,
      String? district,
      String? state,
      String? pinCode,
      String? mobileOne,
      String? mobileTwo,
      String? whatsappNumber,
      String? pan,
      String? gst,
      String? aadhar,
      String? customerType,
      String? lat,
      String? lng,
      String? photo,
      String? creditLimit,
      String? createdAt,
      String? updatedAt,}){
    _id = id;
    _userId = userId;
    _staffId = staffId;
    _nameOfFirm = nameOfFirm;
    _status = status;
    _ownerName = ownerName;
    _address = address;
    _email = email;
    _district = district;
    _state = state;
    _pinCode = pinCode;
    _mobileOne = mobileOne;
    _mobileTwo = mobileTwo;
    _whatsappNumber = whatsappNumber;
    _pan = pan;
    _gst = gst;
    _aadhar = aadhar;
    _customerType = customerType;
    _lat = lat;
    _lng = lng;
    _photo = photo;
    _creditLimit = creditLimit;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
}

  DealerListData.fromJson(dynamic json) {
    _id = json['id'];
    _userId = json['user_id'];
    _staffId = json['staff_id'];
    _nameOfFirm = json['name_of_firm'];
    _status = json['status'];
    _ownerName = json['owner_name'];
    _address = json['address'];
    _email = json['email'];
    _district = json['district'];
    _state = json['state'];
    _pinCode = json['pin_code'];
    _mobileOne = json['mobile_one'];
    _mobileTwo = json['mobile_two'];
    _whatsappNumber = json['whatsapp_number'];
    _pan = json['pan'];
    _gst = json['gst'];
    _aadhar = json['aadhar'];
    _customerType = json['customer_type'];
    _lat = json['lat'];
    _lng = json['lng'];
    _photo = json['photo'];
    _creditLimit = json['credit_limit'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }
  String? _id;
  String? _userId;
  String? _staffId;
  String? _nameOfFirm;
  String? _status;
  String? _ownerName;
  String? _address;
  String? _email;
  String? _district;
  String? _state;
  String? _pinCode;
  String? _mobileOne;
  String? _mobileTwo;
  String? _whatsappNumber;
  String? _pan;
  String? _gst;
  String? _aadhar;
  String? _customerType;
  String? _lat;
  String? _lng;
  String? _photo;
  String? _creditLimit;
  String? _createdAt;
  String? _updatedAt;
  DealerListData copyWith({  String? id,
  String? userId,
  String? staffId,
  String? nameOfFirm,
  String? status,
  String? ownerName,
  String? address,
  String? email,
  String? district,
  String? state,
  String? pinCode,
  String? mobileOne,
  String? mobileTwo,
  String? whatsappNumber,
  String? pan,
  String? gst,
  String? aadhar,
  String? customerType,
  String? lat,
  String? lng,
  String? photo,
  String? creditLimit,
  String? createdAt,
  String? updatedAt,
}) => DealerListData(  id: id ?? _id,
  userId: userId ?? _userId,
  staffId: staffId ?? _staffId,
  nameOfFirm: nameOfFirm ?? _nameOfFirm,
  status: status ?? _status,
  ownerName: ownerName ?? _ownerName,
  address: address ?? _address,
  email: email ?? _email,
  district: district ?? _district,
  state: state ?? _state,
  pinCode: pinCode ?? _pinCode,
  mobileOne: mobileOne ?? _mobileOne,
  mobileTwo: mobileTwo ?? _mobileTwo,
  whatsappNumber: whatsappNumber ?? _whatsappNumber,
  pan: pan ?? _pan,
  gst: gst ?? _gst,
  aadhar: aadhar ?? _aadhar,
  customerType: customerType ?? _customerType,
  lat: lat ?? _lat,
  lng: lng ?? _lng,
  photo: photo ?? _photo,
  creditLimit: creditLimit ?? _creditLimit,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
);
  String? get id => _id;
  String? get userId => _userId;
  String? get staffId => _staffId;
  String? get nameOfFirm => _nameOfFirm;
  String? get status => _status;
  String? get ownerName => _ownerName;
  String? get address => _address;
  String? get email => _email;
  String? get district => _district;
  String? get state => _state;
  String? get pinCode => _pinCode;
  String? get mobileOne => _mobileOne;
  String? get mobileTwo => _mobileTwo;
  String? get whatsappNumber => _whatsappNumber;
  String? get pan => _pan;
  String? get gst => _gst;
  String? get aadhar => _aadhar;
  String? get customerType => _customerType;
  String? get lat => _lat;
  String? get lng => _lng;
  String? get photo => _photo;
  String? get creditLimit => _creditLimit;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['user_id'] = _userId;
    map['staff_id'] = _staffId;
    map['name_of_firm'] = _nameOfFirm;
    map['status'] = _status;
    map['owner_name'] = _ownerName;
    map['address'] = _address;
    map['email'] = _email;
    map['district'] = _district;
    map['state'] = _state;
    map['pin_code'] = _pinCode;
    map['mobile_one'] = _mobileOne;
    map['mobile_two'] = _mobileTwo;
    map['whatsapp_number'] = _whatsappNumber;
    map['pan'] = _pan;
    map['gst'] = _gst;
    map['aadhar'] = _aadhar;
    map['customer_type'] = _customerType;
    map['lat'] = _lat;
    map['lng'] = _lng;
    map['photo'] = _photo;
    map['credit_limit'] = _creditLimit;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }

}