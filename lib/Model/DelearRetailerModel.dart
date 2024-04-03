class DelearRetailerModel {
  bool? error;
  String? message;
  List<Data>? data;

  DelearRetailerModel({this.error, this.message, this.data});

  DelearRetailerModel.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['error'] = this.error;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
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
  String? panImg;
  String? gst;
  String? gstImg;
  String? gstImgTwo;
  String? gstImgThree;
  String? aadhar;
  String? aadharImg;
  String? aadharBack;
  String? customerType;
  String? lat;
  String? lng;
  String? photo;
  String? creditLimit;
  String? createdAt;
  String? updatedAt;
  String? udyogidNumber;
  String? dateOfBirth;
  String? dateOfAnniversary;
  String? route;
  String? market;
  String? landmark;
  String? voterIdBackImage;
  String? voterIdFrontImage;
  String? createBy;
  String? active;
  String? department;
  String? currentAddress;
  String? city;
  String? statename;

  Data(
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
        this.panImg,
        this.gst,
        this.gstImg,
        this.gstImgTwo,
        this.gstImgThree,
        this.aadhar,
        this.aadharImg,
        this.aadharBack,
        this.customerType,
        this.lat,
        this.lng,
        this.photo,
        this.creditLimit,
        this.createdAt,
        this.updatedAt,
        this.udyogidNumber,
        this.dateOfBirth,
        this.dateOfAnniversary,
        this.route,
        this.market,
        this.landmark,
        this.voterIdBackImage,
        this.voterIdFrontImage,
        this.createBy,
        this.active,
        this.department,
        this.currentAddress,
        this.city,
        this.statename});

  Data.fromJson(Map<String, dynamic> json) {
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
    panImg = json['pan_img'];
    gst = json['gst'];
    gstImg = json['gst_img'];
    gstImgTwo = json['gst_img_two'];
    gstImgThree = json['gst_img_three'];
    aadhar = json['aadhar'];
    aadharImg = json['aadhar_img'];
    aadharBack = json['aadhar_back'];
    customerType = json['customer_type'];
    lat = json['lat'];
    lng = json['lng'];
    photo = json['photo'];
    creditLimit = json['credit_limit'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    udyogidNumber = json['udyogid_number'];
    dateOfBirth = json['date_of_birth'];
    dateOfAnniversary = json['date_of_anniversary'];
    route = json['route'];
    market = json['market'];
    landmark = json['landmark'];
    voterIdBackImage = json['voter_id_back_image'];
    voterIdFrontImage = json['voter_id_front_image'];
    createBy = json['create_by'];
    active = json['active'];
    department = json['department'];
    currentAddress = json['current_address'];
    city = json['city'];
    statename = json['statename'];
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
    data['pan_img'] = this.panImg;
    data['gst'] = this.gst;
    data['gst_img'] = this.gstImg;
    data['gst_img_two'] = this.gstImgTwo;
    data['gst_img_three'] = this.gstImgThree;
    data['aadhar'] = this.aadhar;
    data['aadhar_img'] = this.aadharImg;
    data['aadhar_back'] = this.aadharBack;
    data['customer_type'] = this.customerType;
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    data['photo'] = this.photo;
    data['credit_limit'] = this.creditLimit;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['udyogid_number'] = this.udyogidNumber;
    data['date_of_birth'] = this.dateOfBirth;
    data['date_of_anniversary'] = this.dateOfAnniversary;
    data['route'] = this.route;
    data['market'] = this.market;
    data['landmark'] = this.landmark;
    data['voter_id_back_image'] = this.voterIdBackImage;
    data['voter_id_front_image'] = this.voterIdFrontImage;
    data['create_by'] = this.createBy;
    data['active'] = this.active;
    data['department'] = this.department;
    data['current_address'] = this.currentAddress;
    data['city'] = this.city;
    data['statename'] = this.statename;
    return data;
  }
}
