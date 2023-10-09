/// error : false
/// message : "All Clients Lists"
/// data : [{"id":"1","user_id":"2","name_of_firm":"BCC Cement","status":"1","owner_name":"Mahendra Singh","address":"Indore Vijay Nagar","email":"sawan@mailinator.com","district":"2","state":"2","pin_code":"452003","mobile_one":"7896543211","mobile_two":"7897897899","whatsapp_number":"7897897891","pan":"AAAAA1234R","gst":"ABCFHRUGKGH","aadhar":"123445679877","customer_type":"1","lat":"25.789456","lng":"75.654789","photo":"jblogo3.png","credit_limit":"10000.00","created_at":"2023-09-27 16:18:23","updated_at":"2023-09-27 16:11:43"},{"id":"2","user_id":"2","name_of_firm":"Birla Cement","status":"1","owner_name":"Mahendra Singh","address":"Indore Vijay Nagar","email":"sawan@mailinator.com","district":"2","state":"2","pin_code":"452003","mobile_one":"7896543211","mobile_two":"7897897899","whatsapp_number":"7897897891","pan":"AAAAA1234R","gst":"ABCFHRUGKGH","aadhar":"123445679877","customer_type":"1","lat":"25.789456","lng":"75.654789","photo":"jblogo4.png","credit_limit":"10000.00","created_at":"2023-09-27 16:18:34","updated_at":"2023-09-27 16:18:34"},{"id":"4","user_id":"2","name_of_firm":"Harish choudhary","status":"2","owner_name":"HArish","address":"vijay nagar indore ","email":"","district":"283","state":"11","pin_code":"452010","mobile_one":"7855777774","mobile_two":"7888555558","whatsapp_number":"74555888855","pan":"CBUPC8788G","gst":"GSTNI0867","aadhar":"788855555588","customer_type":"5","lat":"","lng":"","photo":"","credit_limit":"10.00","created_at":"2023-10-03 13:12:59","updated_at":"2023-09-27 18:01:35"}]

class ClientModel {
  ClientModel({
      bool? error, 
      String? message, 
      List<ClientsData>? data,}){
    _error = error;
    _message = message;
    _data = data;
}

  ClientModel.fromJson(dynamic json) {
    _error = json['error'];
    _message = json['message'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(ClientsData.fromJson(v));
      });
    }
  }
  bool? _error;
  String? _message;
  List<ClientsData>? _data;
ClientModel copyWith({  bool? error,
  String? message,
  List<ClientsData>? data,
}) => ClientModel(  error: error ?? _error,
  message: message ?? _message,
  data: data ?? _data,
);
  bool? get error => _error;
  String? get message => _message;
  List<ClientsData>? get data => _data;

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
/// photo : "jblogo3.png"
/// credit_limit : "10000.00"
/// created_at : "2023-09-27 16:18:23"
/// updated_at : "2023-09-27 16:11:43"

class ClientsData {
  ClientsData({
      String? id, 
      String? userId, 
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

  ClientsData.fromJson(dynamic json) {
    _id = json['id'];
    _userId = json['user_id'];
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
  ClientsData copyWith({  String? id,
  String? userId,
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
}) => ClientsData(  id: id ?? _id,
  userId: userId ?? _userId,
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