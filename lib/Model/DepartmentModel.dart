/// error : false
/// message : "Account Sucessfully Delete !"
/// data : [{"id":"71","ip_address":null,"username":"Track","department":"1,3","location_time":"1","from_time":"11:42","to_time":"14:42","password":"$2y$10$RiAUYGR8Ygmk.y9r9JOReuYH3oe7EcM4L.duuBjv7kXiojv4XMCPa","email":"track@gmail.com","mobile":"9879098909","image":"17253595586651.jpg","balance":"0","activation_selector":null,"activation_code":null,"forgotten_password_selector":null,"forgotten_password_code":null,"forgotten_password_time":null,"remember_selector":null,"remember_code":null,"created_on":"0","last_login":null,"active":"1","company":null,"address":"indore vijay nagar","bonus":null,"cash_received":"0.00","dob":null,"country_code":null,"otp":"7023","city":null,"area":null,"street":null,"pincode":null,"serviceable_zipcodes":null,"apikey":null,"referral_code":null,"friends_code":null,"fcm_id":"clw5m74cS1KAfPPPmlhfJW:APA91bHbtEDmVyxDyTMLOUUEHLWAc6aKBiqmwtQoiIE8XGHOigP4x-GKPoBtauDm7WDLnK95YskLYo22gTjCbS-UdAcZAtcJ9aqurtc2M9qs_bBiPqtPIzchaDIpNbPxmZds_VFef1TO","device_token":null,"latitude":null,"longitude":null,"created_at":"2024-09-09 11:42:18","commission":null,"permissions":"{\"clients\":{\"add\":\"on\",\"edit\":\"on\",\"view\":\"on\",\"gio_tag\":\"on\",\"photo\":\"on\"},\"feedback\":{\"add\":\"on\",\"view\":\"on\"},\"survey_form\":{\"add\":\"on\",\"view\":\"on\"}}","admin_email":"admin@gmail.com","form":null,"modal_number":"909069099","emi_number":"8923802842qweqe","remarks":"new one is added","name":""}]

class DepartmentModel {
  DepartmentModel({
    bool? error,
    String? message,
    List<DepartmentData>? data,
  }) {
    _error = error;
    _message = message;
    _data = data;
  }

  DepartmentModel.fromJson(dynamic json) {
    _error = json['error'];
    _message = json['message'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(DepartmentData.fromJson(v));
      });
    }
  }
  bool? _error;
  String? _message;
  List<DepartmentData>? _data;
  DepartmentModel copyWith({
    bool? error,
    String? message,
    List<DepartmentData>? data,
  }) =>
      DepartmentModel(
        error: error ?? _error,
        message: message ?? _message,
        data: data ?? _data,
      );
  bool? get error => _error;
  String? get message => _message;
  List<DepartmentData>? get data => _data;

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

/// id : "71"
/// ip_address : null
/// username : "Track"
/// department : "1,3"
/// location_time : "1"
/// from_time : "11:42"
/// to_time : "14:42"
/// password : "$2y$10$RiAUYGR8Ygmk.y9r9JOReuYH3oe7EcM4L.duuBjv7kXiojv4XMCPa"
/// email : "track@gmail.com"
/// mobile : "9879098909"
/// image : "17253595586651.jpg"
/// balance : "0"
/// activation_selector : null
/// activation_code : null
/// forgotten_password_selector : null
/// forgotten_password_code : null
/// forgotten_password_time : null
/// remember_selector : null
/// remember_code : null
/// created_on : "0"
/// last_login : null
/// active : "1"
/// company : null
/// address : "indore vijay nagar"
/// bonus : null
/// cash_received : "0.00"
/// dob : null
/// country_code : null
/// otp : "7023"
/// city : null
/// area : null
/// street : null
/// pincode : null
/// serviceable_zipcodes : null
/// apikey : null
/// referral_code : null
/// friends_code : null
/// fcm_id : "clw5m74cS1KAfPPPmlhfJW:APA91bHbtEDmVyxDyTMLOUUEHLWAc6aKBiqmwtQoiIE8XGHOigP4x-GKPoBtauDm7WDLnK95YskLYo22gTjCbS-UdAcZAtcJ9aqurtc2M9qs_bBiPqtPIzchaDIpNbPxmZds_VFef1TO"
/// device_token : null
/// latitude : null
/// longitude : null
/// created_at : "2024-09-09 11:42:18"
/// commission : null
/// permissions : "{\"clients\":{\"add\":\"on\",\"edit\":\"on\",\"view\":\"on\",\"gio_tag\":\"on\",\"photo\":\"on\"},\"feedback\":{\"add\":\"on\",\"view\":\"on\"},\"survey_form\":{\"add\":\"on\",\"view\":\"on\"}}"
/// admin_email : "admin@gmail.com"
/// form : null
/// modal_number : "909069099"
/// emi_number : "8923802842qweqe"
/// remarks : "new one is added"
/// name : ""

class DepartmentData {
  DepartmentData({
    String? id,
    dynamic ipAddress,
    String? username,
    String? department,
    String? locationTime,
    String? fromTime,
    String? toTime,
    String? password,
    String? email,
    String? mobile,
    String? image,
    String? balance,
    dynamic activationSelector,
    dynamic activationCode,
    dynamic forgottenPasswordSelector,
    dynamic forgottenPasswordCode,
    dynamic forgottenPasswordTime,
    dynamic rememberSelector,
    dynamic rememberCode,
    String? createdOn,
    dynamic lastLogin,
    String? active,
    dynamic company,
    String? address,
    dynamic bonus,
    String? cashReceived,
    dynamic dob,
    dynamic countryCode,
    String? otp,
    dynamic city,
    dynamic area,
    dynamic street,
    dynamic pincode,
    dynamic serviceableZipcodes,
    dynamic apikey,
    dynamic referralCode,
    dynamic friendsCode,
    String? fcmId,
    dynamic deviceToken,
    dynamic latitude,
    dynamic longitude,
    String? createdAt,
    dynamic commission,
    String? permissions,
    String? adminEmail,
    dynamic form,
    String? modalNumber,
    String? emiNumber,
    String? remarks,
    String? name,
  }) {
    _id = id;
    _ipAddress = ipAddress;
    _username = username;
    _department = department;
    _locationTime = locationTime;
    _fromTime = fromTime;
    _toTime = toTime;
    _password = password;
    _email = email;
    _mobile = mobile;
    _image = image;
    _balance = balance;
    _activationSelector = activationSelector;
    _activationCode = activationCode;
    _forgottenPasswordSelector = forgottenPasswordSelector;
    _forgottenPasswordCode = forgottenPasswordCode;
    _forgottenPasswordTime = forgottenPasswordTime;
    _rememberSelector = rememberSelector;
    _rememberCode = rememberCode;
    _createdOn = createdOn;
    _lastLogin = lastLogin;
    _active = active;
    _company = company;
    _address = address;
    _bonus = bonus;
    _cashReceived = cashReceived;
    _dob = dob;
    _countryCode = countryCode;
    _otp = otp;
    _city = city;
    _area = area;
    _street = street;
    _pincode = pincode;
    _serviceableZipcodes = serviceableZipcodes;
    _apikey = apikey;
    _referralCode = referralCode;
    _friendsCode = friendsCode;
    _fcmId = fcmId;
    _deviceToken = deviceToken;
    _latitude = latitude;
    _longitude = longitude;
    _createdAt = createdAt;
    _commission = commission;
    _permissions = permissions;
    _adminEmail = adminEmail;
    _form = form;
    _modalNumber = modalNumber;
    _emiNumber = emiNumber;
    _remarks = remarks;
    _name = name;
  }

  DepartmentData.fromJson(dynamic json) {
    _id = json['id'];
    _ipAddress = json['ip_address'];
    _username = json['username'];
    _department = json['department'];
    _locationTime = json['location_time'];
    _fromTime = json['from_time'];
    _toTime = json['to_time'];
    _password = json['password'];
    _email = json['email'];
    _mobile = json['mobile'];
    _image = json['image'];
    _balance = json['balance'];
    _activationSelector = json['activation_selector'];
    _activationCode = json['activation_code'];
    _forgottenPasswordSelector = json['forgotten_password_selector'];
    _forgottenPasswordCode = json['forgotten_password_code'];
    _forgottenPasswordTime = json['forgotten_password_time'];
    _rememberSelector = json['remember_selector'];
    _rememberCode = json['remember_code'];
    _createdOn = json['created_on'];
    _lastLogin = json['last_login'];
    _active = json['active'];
    _company = json['company'];
    _address = json['address'];
    _bonus = json['bonus'];
    _cashReceived = json['cash_received'];
    _dob = json['dob'];
    _countryCode = json['country_code'];
    _otp = json['otp'];
    _city = json['city'];
    _area = json['area'];
    _street = json['street'];
    _pincode = json['pincode'];
    _serviceableZipcodes = json['serviceable_zipcodes'];
    _apikey = json['apikey'];
    _referralCode = json['referral_code'];
    _friendsCode = json['friends_code'];
    _fcmId = json['fcm_id'];
    _deviceToken = json['device_token'];
    _latitude = json['latitude'];
    _longitude = json['longitude'];
    _createdAt = json['created_at'];
    _commission = json['commission'];
    _permissions = json['permissions'];
    _adminEmail = json['admin_email'];
    _form = json['form'];
    _modalNumber = json['modal_number'];
    _emiNumber = json['emi_number'];
    _remarks = json['remarks'];
    _name = json['name'];
  }
  String? _id;
  dynamic _ipAddress;
  String? _username;
  String? _department;
  String? _locationTime;
  String? _fromTime;
  String? _toTime;
  String? _password;
  String? _email;
  String? _mobile;
  String? _image;
  String? _balance;
  dynamic _activationSelector;
  dynamic _activationCode;
  dynamic _forgottenPasswordSelector;
  dynamic _forgottenPasswordCode;
  dynamic _forgottenPasswordTime;
  dynamic _rememberSelector;
  dynamic _rememberCode;
  String? _createdOn;
  dynamic _lastLogin;
  String? _active;
  dynamic _company;
  String? _address;
  dynamic _bonus;
  String? _cashReceived;
  dynamic _dob;
  dynamic _countryCode;
  String? _otp;
  dynamic _city;
  dynamic _area;
  dynamic _street;
  dynamic _pincode;
  dynamic _serviceableZipcodes;
  dynamic _apikey;
  dynamic _referralCode;
  dynamic _friendsCode;
  String? _fcmId;
  dynamic _deviceToken;
  dynamic _latitude;
  dynamic _longitude;
  String? _createdAt;
  dynamic _commission;
  String? _permissions;
  String? _adminEmail;
  dynamic _form;
  String? _modalNumber;
  String? _emiNumber;
  String? _remarks;
  String? _name;
  DepartmentData copyWith({
    String? id,
    dynamic ipAddress,
    String? username,
    String? department,
    String? locationTime,
    String? fromTime,
    String? toTime,
    String? password,
    String? email,
    String? mobile,
    String? image,
    String? balance,
    dynamic activationSelector,
    dynamic activationCode,
    dynamic forgottenPasswordSelector,
    dynamic forgottenPasswordCode,
    dynamic forgottenPasswordTime,
    dynamic rememberSelector,
    dynamic rememberCode,
    String? createdOn,
    dynamic lastLogin,
    String? active,
    dynamic company,
    String? address,
    dynamic bonus,
    String? cashReceived,
    dynamic dob,
    dynamic countryCode,
    String? otp,
    dynamic city,
    dynamic area,
    dynamic street,
    dynamic pincode,
    dynamic serviceableZipcodes,
    dynamic apikey,
    dynamic referralCode,
    dynamic friendsCode,
    String? fcmId,
    dynamic deviceToken,
    dynamic latitude,
    dynamic longitude,
    String? createdAt,
    dynamic commission,
    String? permissions,
    String? adminEmail,
    dynamic form,
    String? modalNumber,
    String? emiNumber,
    String? remarks,
    String? name,
  }) =>
      DepartmentData(
        id: id ?? _id,
        ipAddress: ipAddress ?? _ipAddress,
        username: username ?? _username,
        department: department ?? _department,
        locationTime: locationTime ?? _locationTime,
        fromTime: fromTime ?? _fromTime,
        toTime: toTime ?? _toTime,
        password: password ?? _password,
        email: email ?? _email,
        mobile: mobile ?? _mobile,
        image: image ?? _image,
        balance: balance ?? _balance,
        activationSelector: activationSelector ?? _activationSelector,
        activationCode: activationCode ?? _activationCode,
        forgottenPasswordSelector:
            forgottenPasswordSelector ?? _forgottenPasswordSelector,
        forgottenPasswordCode: forgottenPasswordCode ?? _forgottenPasswordCode,
        forgottenPasswordTime: forgottenPasswordTime ?? _forgottenPasswordTime,
        rememberSelector: rememberSelector ?? _rememberSelector,
        rememberCode: rememberCode ?? _rememberCode,
        createdOn: createdOn ?? _createdOn,
        lastLogin: lastLogin ?? _lastLogin,
        active: active ?? _active,
        company: company ?? _company,
        address: address ?? _address,
        bonus: bonus ?? _bonus,
        cashReceived: cashReceived ?? _cashReceived,
        dob: dob ?? _dob,
        countryCode: countryCode ?? _countryCode,
        otp: otp ?? _otp,
        city: city ?? _city,
        area: area ?? _area,
        street: street ?? _street,
        pincode: pincode ?? _pincode,
        serviceableZipcodes: serviceableZipcodes ?? _serviceableZipcodes,
        apikey: apikey ?? _apikey,
        referralCode: referralCode ?? _referralCode,
        friendsCode: friendsCode ?? _friendsCode,
        fcmId: fcmId ?? _fcmId,
        deviceToken: deviceToken ?? _deviceToken,
        latitude: latitude ?? _latitude,
        longitude: longitude ?? _longitude,
        createdAt: createdAt ?? _createdAt,
        commission: commission ?? _commission,
        permissions: permissions ?? _permissions,
        adminEmail: adminEmail ?? _adminEmail,
        form: form ?? _form,
        modalNumber: modalNumber ?? _modalNumber,
        emiNumber: emiNumber ?? _emiNumber,
        remarks: remarks ?? _remarks,
        name: name ?? _name,
      );
  String? get id => _id;
  dynamic get ipAddress => _ipAddress;
  String? get username => _username;
  String? get department => _department;
  String? get locationTime => _locationTime;
  String? get fromTime => _fromTime;
  String? get toTime => _toTime;
  String? get password => _password;
  String? get email => _email;
  String? get mobile => _mobile;
  String? get image => _image;
  String? get balance => _balance;
  dynamic get activationSelector => _activationSelector;
  dynamic get activationCode => _activationCode;
  dynamic get forgottenPasswordSelector => _forgottenPasswordSelector;
  dynamic get forgottenPasswordCode => _forgottenPasswordCode;
  dynamic get forgottenPasswordTime => _forgottenPasswordTime;
  dynamic get rememberSelector => _rememberSelector;
  dynamic get rememberCode => _rememberCode;
  String? get createdOn => _createdOn;
  dynamic get lastLogin => _lastLogin;
  String? get active => _active;
  dynamic get company => _company;
  String? get address => _address;
  dynamic get bonus => _bonus;
  String? get cashReceived => _cashReceived;
  dynamic get dob => _dob;
  dynamic get countryCode => _countryCode;
  String? get otp => _otp;
  dynamic get city => _city;
  dynamic get area => _area;
  dynamic get street => _street;
  dynamic get pincode => _pincode;
  dynamic get serviceableZipcodes => _serviceableZipcodes;
  dynamic get apikey => _apikey;
  dynamic get referralCode => _referralCode;
  dynamic get friendsCode => _friendsCode;
  String? get fcmId => _fcmId;
  dynamic get deviceToken => _deviceToken;
  dynamic get latitude => _latitude;
  dynamic get longitude => _longitude;
  String? get createdAt => _createdAt;
  dynamic get commission => _commission;
  String? get permissions => _permissions;
  String? get adminEmail => _adminEmail;
  dynamic get form => _form;
  String? get modalNumber => _modalNumber;
  String? get emiNumber => _emiNumber;
  String? get remarks => _remarks;
  String? get name => _name;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['ip_address'] = _ipAddress;
    map['username'] = _username;
    map['department'] = _department;
    map['location_time'] = _locationTime;
    map['from_time'] = _fromTime;
    map['to_time'] = _toTime;
    map['password'] = _password;
    map['email'] = _email;
    map['mobile'] = _mobile;
    map['image'] = _image;
    map['balance'] = _balance;
    map['activation_selector'] = _activationSelector;
    map['activation_code'] = _activationCode;
    map['forgotten_password_selector'] = _forgottenPasswordSelector;
    map['forgotten_password_code'] = _forgottenPasswordCode;
    map['forgotten_password_time'] = _forgottenPasswordTime;
    map['remember_selector'] = _rememberSelector;
    map['remember_code'] = _rememberCode;
    map['created_on'] = _createdOn;
    map['last_login'] = _lastLogin;
    map['active'] = _active;
    map['company'] = _company;
    map['address'] = _address;
    map['bonus'] = _bonus;
    map['cash_received'] = _cashReceived;
    map['dob'] = _dob;
    map['country_code'] = _countryCode;
    map['otp'] = _otp;
    map['city'] = _city;
    map['area'] = _area;
    map['street'] = _street;
    map['pincode'] = _pincode;
    map['serviceable_zipcodes'] = _serviceableZipcodes;
    map['apikey'] = _apikey;
    map['referral_code'] = _referralCode;
    map['friends_code'] = _friendsCode;
    map['fcm_id'] = _fcmId;
    map['device_token'] = _deviceToken;
    map['latitude'] = _latitude;
    map['longitude'] = _longitude;
    map['created_at'] = _createdAt;
    map['commission'] = _commission;
    map['permissions'] = _permissions;
    map['admin_email'] = _adminEmail;
    map['form'] = _form;
    map['modal_number'] = _modalNumber;
    map['emi_number'] = _emiNumber;
    map['remarks'] = _remarks;
    map['name'] = _name;
    return map;
  }
}
