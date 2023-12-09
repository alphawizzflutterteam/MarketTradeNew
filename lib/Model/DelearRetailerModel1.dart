class DelearRetailerModel1 {
  bool? error;
  String? message;
  ContractorData? data;

  DelearRetailerModel1({this.error, this.message, this.data});

  DelearRetailerModel1.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    message = json['message'];
    data = json['data'] != null ? new ContractorData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['error'] = this.error;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class ContractorData {
  List<Dealers1>? dealers;
  List<Dealers1>? retailers;
  List<Dealers1>? contractor;
  List<Dealers1>? builder;
  List<Dealers1>? engineer;
  List<Dealers1>? artitech;
  List<Dealers1>? massion;

  ContractorData(
      {
        this.dealers,
        this.retailers,
        this.contractor,
        this.builder,
        this.engineer,
        this.artitech,
        this.massion
      }
      );

  ContractorData.fromJson(Map<String, dynamic> json) {
    if (json['dealers'] != null) {
      dealers = <Dealers1>[];
      json['dealers'].forEach((v) {
        dealers!.add(new Dealers1.fromJson(v));
      });
    }
    if (json['retailers'] != null) {
      retailers = <Dealers1>[];
      json['retailers'].forEach((v) {
        retailers!.add(new Dealers1.fromJson(v));
      });
    }
    if (json['contractor'] != null) {
      contractor = <Dealers1>[];
      json['contractor'].forEach((v) {
        contractor!.add(new Dealers1.fromJson(v));
      });
    }
    if (json['builder'] != null) {
      builder = <Dealers1>[];
      json['builder'].forEach((v) {
        builder!.add(new Dealers1.fromJson(v));
      });
    }
    if (json['engineer'] != null) {
      engineer = <Dealers1>[];
      json['engineer'].forEach((v) {
        engineer!.add(new Dealers1.fromJson(v));
      });
    }
    if (json['artitech'] != null) {
      artitech = <Dealers1>[];
      json['artitech'].forEach((v) {
        artitech!.add(new Dealers1.fromJson(v));
      });
    }
    if (json['massion'] != null) {
      massion = <Dealers1>[];
      json['massion'].forEach((v) {
        massion!.add(new Dealers1.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.dealers != null) {
      data['dealers'] = this.dealers!.map((v) => v.toJson()).toList();
    }
    if (this.retailers != null) {
      data['retailers'] = this.retailers!.map((v) => v.toJson()).toList();
    }
    if (this.contractor != null) {
      data['contractor'] = this.contractor!.map((v) => v.toJson()).toList();
    }
    if (this.builder != null) {
      data['builder'] = this.builder!.map((v) => v.toJson()).toList();
    }
    if (this.engineer != null) {
      data['engineer'] = this.engineer!.map((v) => v.toJson()).toList();
    }
    if (this.artitech != null) {
      data['artitech'] = this.artitech!.map((v) => v.toJson()).toList();
    }
    if (this.massion != null) {
      data['massion'] = this.massion!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Dealers1 {
  String? id;
  String? userId;
  String? staffId;
  String? nameOfFirm;
  String? status;
  String? ownerName;
  String? address;
  String? email;
  String? district;
  String? state;
  String? pinCode;
  String? mobileOne;
  String? mobileTwo;
  String? whatsappNumber;
  String? pan;
  String? gst;
  String? aadhar;
  String? customerType;
  String? lat;
  String? lng;
  String? photo;
  String? creditLimit;
  String? createdAt;
  String? updatedAt;

  Dealers1(
      {this.id,
        this.userId,
        this.staffId,
        this.nameOfFirm,
        this.status,
        this.ownerName,
        this.address,
        this.email,
        this.district,
        this.state,
        this.pinCode,
        this.mobileOne,
        this.mobileTwo,
        this.whatsappNumber,
        this.pan,
        this.gst,
        this.aadhar,
        this.customerType,
        this.lat,
        this.lng,
        this.photo,
        this.creditLimit,
        this.createdAt,
        this.updatedAt});

  Dealers1.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    staffId = json['staff_id'];
    nameOfFirm = json['name_of_firm'];
    status = json['status'];
    ownerName = json['owner_name'];
    address = json['address'];
    email = json['email'];
    district = json['district'];
    state = json['state'];
    pinCode = json['pin_code'];
    mobileOne = json['mobile_one'];
    mobileTwo = json['mobile_two'];
    whatsappNumber = json['whatsapp_number'];
    pan = json['pan'];
    gst = json['gst'];
    aadhar = json['aadhar'];
    customerType = json['customer_type'];
    lat = json['lat'];
    lng = json['lng'];
    photo = json['photo'];
    creditLimit = json['credit_limit'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['staff_id'] = this.staffId;
    data['name_of_firm'] = this.nameOfFirm;
    data['status'] = this.status;
    data['owner_name'] = this.ownerName;
    data['address'] = this.address;
    data['email'] = this.email;
    data['district'] = this.district;
    data['state'] = this.state;
    data['pin_code'] = this.pinCode;
    data['mobile_one'] = this.mobileOne;
    data['mobile_two'] = this.mobileTwo;
    data['whatsapp_number'] = this.whatsappNumber;
    data['pan'] = this.pan;
    data['gst'] = this.gst;
    data['aadhar'] = this.aadhar;
    data['customer_type'] = this.customerType;
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    data['photo'] = this.photo;
    data['credit_limit'] = this.creditLimit;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
