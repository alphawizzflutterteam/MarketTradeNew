class MySiteVisitModel {
  List<SiteVisitData>? data;
  bool? error;
  String? message;

  MySiteVisitModel({this.data, this.error, this.message});

  MySiteVisitModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <SiteVisitData>[];
      json['data'].forEach((v) {
        data!.add(new SiteVisitData.fromJson(v));
      });
    }
    error = json['error'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['error'] = this.error;
    data['message'] = this.message;
    return data;
  }
}

class SiteVisitData {
  String? id;
  String? userId;
  String? date;
  String? time;
  String? lat;
  String? lng;
  String? name;
  String? mobile;
  String? address;
  String? state;
  String? district;
  String? pincode;
  String? contractorId;
  String? contractorMobile;
  String? engineerId;
  String? engineerMobile;
  String? artitechId;
  String? artitechMobile;
  String? massionId;
  String? massionMobile;
  String? siteSize;
  String? currentStatus;
  String? productBeingUsed;
  List<Survey>? survey;
  String? expectedOrders;
  List<String>? photo;
  String? remarks;
  String? massionName;
  String? massionAddress;
  String? architectAddress;
  String? architectName;
  String? engineerAddress;
  String? engineerName;
  String? contractorAddress;
  String? contractorName;
  String? createdAt;
  String? staffId;
  String? nameOfFirm;
  String? status;
  String? ownerName;
  String? email;
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
  String? creditLimit;
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

  SiteVisitData(
      {this.id,
      this.userId,
      this.date,
      this.time,
      this.lat,
      this.lng,
      this.name,
      this.mobile,
      this.address,
      this.state,
      this.district,
      this.pincode,
      this.contractorId,
      this.contractorMobile,
      this.engineerId,
      this.engineerMobile,
      this.artitechId,
      this.artitechMobile,
      this.massionId,
      this.massionMobile,
      this.siteSize,
      this.currentStatus,
      this.productBeingUsed,
      this.survey,
      this.expectedOrders,
      this.photo,
      this.remarks,
      this.massionName,
      this.massionAddress,
      this.architectAddress,
      this.architectName,
      this.engineerAddress,
      this.engineerName,
      this.contractorAddress,
      this.contractorName,
      this.createdAt,
      this.staffId,
      this.nameOfFirm,
      this.status,
      this.ownerName,
      this.email,
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
      this.creditLimit,
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
      this.currentAddress});

  SiteVisitData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    date = json['date'];
    time = json['time'];
    lat = json['lat'];
    lng = json['lng'];
    name = json['name'];
    mobile = json['mobile'];
    address = json['address'];
    state = json['state'];
    district = json['district'];
    pincode = json['pincode'];
    contractorId = json['contractor_id'];
    contractorMobile = json['contractor_mobile'];
    engineerId = json['engineer_id'];
    engineerMobile = json['engineer_mobile'];
    artitechId = json['artitech_id'];
    artitechMobile = json['artitech_mobile'];
    massionId = json['massion_id'];
    massionMobile = json['massion_mobile'];
    siteSize = json['site_size'];
    currentStatus = json['current_status'];
    productBeingUsed = json['product_being_used'];
    if (json['survey'] != null) {
      survey = <Survey>[];
      json['survey'].forEach((v) {
        survey!.add(new Survey.fromJson(v));
      });
    }
    expectedOrders = json['expected_orders'];
    photo = json['photo'].cast<String>();
    remarks = json['remarks'];
    massionName = json['massion_name'];
    massionAddress = json['massion_address'];
    architectAddress = json['architect_address'];
    architectName = json['architect_name'];
    engineerAddress = json['engineer_address'];
    engineerName = json['engineer_name'];
    contractorAddress = json['contractor_address'];
    contractorName = json['contractor_name'];
    createdAt = json['created_at'];
    staffId = json['staff_id'];
    nameOfFirm = json['name_of_firm'];
    status = json['status'];
    ownerName = json['owner_name'];
    email = json['email'];
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
    creditLimit = json['credit_limit'];
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
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['date'] = this.date;
    data['time'] = this.time;
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    data['name'] = this.name;
    data['mobile'] = this.mobile;
    data['address'] = this.address;
    data['state'] = this.state;
    data['district'] = this.district;
    data['pincode'] = this.pincode;
    data['contractor_id'] = this.contractorId;
    data['contractor_mobile'] = this.contractorMobile;
    data['engineer_id'] = this.engineerId;
    data['engineer_mobile'] = this.engineerMobile;
    data['artitech_id'] = this.artitechId;
    data['artitech_mobile'] = this.artitechMobile;
    data['massion_id'] = this.massionId;
    data['massion_mobile'] = this.massionMobile;
    data['site_size'] = this.siteSize;
    data['current_status'] = this.currentStatus;
    data['product_being_used'] = this.productBeingUsed;
    if (this.survey != null) {
      data['survey'] = this.survey!.map((v) => v.toJson()).toList();
    }
    data['expected_orders'] = this.expectedOrders;
    data['photo'] = this.photo;
    data['remarks'] = this.remarks;
    data['massion_name'] = this.massionName;
    data['massion_address'] = this.massionAddress;
    data['architect_address'] = this.architectAddress;
    data['architect_name'] = this.architectName;
    data['engineer_address'] = this.engineerAddress;
    data['engineer_name'] = this.engineerName;
    data['contractor_address'] = this.contractorAddress;
    data['contractor_name'] = this.contractorName;
    data['created_at'] = this.createdAt;
    data['staff_id'] = this.staffId;
    data['name_of_firm'] = this.nameOfFirm;
    data['status'] = this.status;
    data['owner_name'] = this.ownerName;
    data['email'] = this.email;
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
    data['credit_limit'] = this.creditLimit;
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
    return data;
  }
}

class Survey {
  String? brandName;
  String? totalConsumption;
  String? furtherConsumption;
  String? purchasePrice;
  String? purchasingFrom;
  String? lastPurchaseDate;

  Survey(
      {this.brandName,
      this.totalConsumption,
      this.furtherConsumption,
      this.purchasePrice,
      this.purchasingFrom,
      this.lastPurchaseDate});

  Survey.fromJson(Map<String, dynamic> json) {
    brandName = json['brand_name'];
    totalConsumption = json['total_consumption'];
    furtherConsumption = json['further_consumption'];
    purchasePrice = json['purchase_price'];
    purchasingFrom = json['purchasing_from'];
    lastPurchaseDate = json['last_purchase_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['brand_name'] = this.brandName;
    data['total_consumption'] = this.totalConsumption;
    data['further_consumption'] = this.furtherConsumption;
    data['purchase_price'] = this.purchasePrice;
    data['purchasing_from'] = this.purchasingFrom;
    data['last_purchase_date'] = this.lastPurchaseDate;
    return data;
  }
}
