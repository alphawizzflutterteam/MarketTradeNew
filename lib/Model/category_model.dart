/// message : "Category retrieved successfully"
/// error : false
/// total : 8
/// data : [{"id":"1","name":"Credit Card","parent_id":"0","slug":"credit-card","image":"https://developmentalphawizz.com/referral_management/uploads/media/2023/thumb-sm/credit-cards-4-steps-1440x864.jpg","banner":"https://developmentalphawizz.com/referral_management/","row_order":"0","status":"1","clicks":"0","children":[{"id":"7","name":"SBI Credit Card","parent_id":"1","slug":"sbi-credit-card","image":"https://developmentalphawizz.com/referral_management/uploads/media/2023/download.jpg","banner":"https://developmentalphawizz.com/referral_management/","row_order":"0","status":"1","clicks":"0","children":[],"text":"SBI Credit Card","state":{"opened":true},"level":1},{"id":"8","name":"HDFC Credit Card","parent_id":"1","slug":"hdfc-credit-card","image":"https://developmentalphawizz.com/referral_management/uploads/media/2023/thumb-md/credit-cards-4-steps-1440x864.jpg","banner":"https://developmentalphawizz.com/referral_management/","row_order":"0","status":"1","clicks":"0","children":[],"text":"HDFC Credit Card","state":{"opened":true},"level":1}],"text":"Credit Card","state":{"opened":true},"icon":"jstree-folder","level":0,"total":8},{"id":"2","name":"Personal Loan","parent_id":"0","slug":"personal-loan","image":"https://developmentalphawizz.com/referral_management/uploads/media/2023/thumb-sm/Personal-loan.jpg","banner":"https://developmentalphawizz.com/referral_management/","row_order":"0","status":"1","clicks":"2","children":[],"text":"Personal Loan","state":{"opened":true},"icon":"jstree-folder","level":0},{"id":"3","name":"Home Loan & LAP","parent_id":"0","slug":"home-loan-lap","image":"https://developmentalphawizz.com/referral_management/uploads/media/2023/thumb-sm/Top-5-banks-to-take-loan-against-property-LAP-FB-1200x700-compressed.jpg","banner":"https://developmentalphawizz.com/referral_management/","row_order":"0","status":"1","clicks":"0","children":[],"text":"Home Loan & LAP","state":{"opened":true},"icon":"jstree-folder","level":0},{"id":"4","name":"Secure Card","parent_id":"0","slug":"secure-card","image":"https://developmentalphawizz.com/referral_management/uploads/media/2023/thumb-sm/Best-Secured-Credit-Cards-in-India.jpg","banner":"https://developmentalphawizz.com/referral_management/","row_order":"0","status":"1","clicks":"0","children":[],"text":"Secure Card","state":{"opened":true},"icon":"jstree-folder","level":0},{"id":"5","name":"Credit Line Card","parent_id":"0","slug":"credit-line-card","image":"https://developmentalphawizz.com/referral_management/uploads/media/2023/download.jpg","banner":"https://developmentalphawizz.com/referral_management/","row_order":"0","status":"1","clicks":"0","children":[],"text":"Credit Line Card","state":{"opened":true},"icon":"jstree-folder","level":0},{"id":"6","name":"Demat Account","parent_id":"0","slug":"demat-account","image":"https://developmentalphawizz.com/referral_management/uploads/media/2023/thumb-sm/demat-account-mobile.jpg","banner":"https://developmentalphawizz.com/referral_management/","row_order":"0","status":"1","clicks":"0","children":[],"text":"Demat Account","state":{"opened":true},"icon":"jstree-folder","level":0}]
/// popular_categories : [{"id":"2","name":"Personal Loan","parent_id":"0","slug":"personal-loan","image":"https://developmentalphawizz.com/referral_management/uploads/media/2023/thumb-sm/Personal-loan.jpg","banner":"https://developmentalphawizz.com/referral_management/","row_order":"0","status":"1","clicks":"2","children":[],"text":"Personal Loan","state":{"opened":true},"icon":"jstree-folder","level":0,"total":8},{"id":"1","name":"Credit Card","parent_id":"0","slug":"credit-card","image":"https://developmentalphawizz.com/referral_management/uploads/media/2023/thumb-sm/credit-cards-4-steps-1440x864.jpg","banner":"https://developmentalphawizz.com/referral_management/","row_order":"0","status":"1","clicks":"0","children":[{"id":"7","name":"SBI Credit Card","parent_id":"1","slug":"sbi-credit-card","image":"https://developmentalphawizz.com/referral_management/uploads/media/2023/download.jpg","banner":"https://developmentalphawizz.com/referral_management/","row_order":"0","status":"1","clicks":"0","children":[],"text":"SBI Credit Card","state":{"opened":true},"level":1},{"id":"8","name":"HDFC Credit Card","parent_id":"1","slug":"hdfc-credit-card","image":"https://developmentalphawizz.com/referral_management/uploads/media/2023/thumb-md/credit-cards-4-steps-1440x864.jpg","banner":"https://developmentalphawizz.com/referral_management/","row_order":"0","status":"1","clicks":"0","children":[],"text":"HDFC Credit Card","state":{"opened":true},"level":1}],"text":"Credit Card","state":{"opened":true},"icon":"jstree-folder","level":0}]

class CategoryModel {
  CategoryModel({
      String? message, 
      bool? error, 
      num? total, 
      List<Categories>? data,
      List<PopularCategories>? popularCategories,}){
    _message = message;
    _error = error;
    _total = total;
    _data = data;
    _popularCategories = popularCategories;
}

  CategoryModel.fromJson(dynamic json) {
    _message = json['message'];
    _error = json['error'];
    _total = json['total'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Categories.fromJson(v));
      });
    }
    if (json['popular_categories'] != null) {
      _popularCategories = [];
      json['popular_categories'].forEach((v) {
        _popularCategories?.add(PopularCategories.fromJson(v));
      });
    }
  }
  String? _message;
  bool? _error;
  num? _total;
  List<Categories>? _data;
  List<PopularCategories>? _popularCategories;
CategoryModel copyWith({  String? message,
  bool? error,
  num? total,
  List<Categories>? data,
  List<PopularCategories>? popularCategories,
}) => CategoryModel(  message: message ?? _message,
  error: error ?? _error,
  total: total ?? _total,
  data: data ?? _data,
  popularCategories: popularCategories ?? _popularCategories,
);
  String? get message => _message;
  bool? get error => _error;
  num? get total => _total;
  List<Categories>? get data => _data;
  List<PopularCategories>? get popularCategories => _popularCategories;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = _message;
    map['error'] = _error;
    map['total'] = _total;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    if (_popularCategories != null) {
      map['popular_categories'] = _popularCategories?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : "2"
/// name : "Personal Loan"
/// parent_id : "0"
/// slug : "personal-loan"
/// image : "https://developmentalphawizz.com/referral_management/uploads/media/2023/thumb-sm/Personal-loan.jpg"
/// banner : "https://developmentalphawizz.com/referral_management/"
/// row_order : "0"
/// status : "1"
/// clicks : "2"
/// children : []
/// text : "Personal Loan"
/// state : {"opened":true}
/// icon : "jstree-folder"
/// level : 0
/// total : 8

class PopularCategories {
  PopularCategories({
      String? id, 
      String? name, 
      String? parentId, 
      String? slug, 
      String? image, 
      String? banner, 
      String? rowOrder, 
      String? status, 
      String? clicks, 
      List<dynamic>? children, 
      String? text, 
      State1? state,
      String? icon, 
      num? level, 
      num? total,}){
    _id = id;
    _name = name;
    _parentId = parentId;
    _slug = slug;
    _image = image;
    _banner = banner;
    _rowOrder = rowOrder;
    _status = status;
    _clicks = clicks;
    _children = children;
    _text = text;
    _state = state;
    _icon = icon;
    _level = level;
    _total = total;
}

  PopularCategories.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _parentId = json['parent_id'];
    _slug = json['slug'];
    _image = json['image'];
    _banner = json['banner'];
    _rowOrder = json['row_order'];
    _status = json['status'];
    _clicks = json['clicks'];
    if (json['children'] != null) {
      _children = [];
      json['children'].forEach((v) {
        _children?.add(v.fromJson(v));
      });
    }
    _text = json['text'];
    _state = json['state'] != null ? State1.fromJson(json['state']) : null;
    _icon = json['icon'];
    _level = json['level'];
    _total = json['total'];
  }
  String? _id;
  String? _name;
  String? _parentId;
  String? _slug;
  String? _image;
  String? _banner;
  String? _rowOrder;
  String? _status;
  String? _clicks;
  List<dynamic>? _children;
  String? _text;
  State1? _state;
  String? _icon;
  num? _level;
  num? _total;
PopularCategories copyWith({  String? id,
  String? name,
  String? parentId,
  String? slug,
  String? image,
  String? banner,
  String? rowOrder,
  String? status,
  String? clicks,
  List<dynamic>? children,
  String? text,
  State1? state,
  String? icon,
  num? level,
  num? total,
}) => PopularCategories(  id: id ?? _id,
  name: name ?? _name,
  parentId: parentId ?? _parentId,
  slug: slug ?? _slug,
  image: image ?? _image,
  banner: banner ?? _banner,
  rowOrder: rowOrder ?? _rowOrder,
  status: status ?? _status,
  clicks: clicks ?? _clicks,
  children: children ?? _children,
  text: text ?? _text,
  state: state ?? _state,
  icon: icon ?? _icon,
  level: level ?? _level,
  total: total ?? _total,
);
  String? get id => _id;
  String? get name => _name;
  String? get parentId => _parentId;
  String? get slug => _slug;
  String? get image => _image;
  String? get banner => _banner;
  String? get rowOrder => _rowOrder;
  String? get status => _status;
  String? get clicks => _clicks;
  List<dynamic>? get children => _children;
  String? get text => _text;
  State1? get state => _state;
  String? get icon => _icon;
  num? get level => _level;
  num? get total => _total;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['parent_id'] = _parentId;
    map['slug'] = _slug;
    map['image'] = _image;
    map['banner'] = _banner;
    map['row_order'] = _rowOrder;
    map['status'] = _status;
    map['clicks'] = _clicks;
    if (_children != null) {
      map['children'] = _children?.map((v) => v.toJson()).toList();
    }
    map['text'] = _text;
    if (_state != null) {
      map['state'] = _state?.toJson();
    }
    map['icon'] = _icon;
    map['level'] = _level;
    map['total'] = _total;
    return map;
  }

}

/// opened : true

class State1 {
  State1({
      bool? opened,}){
    _opened = opened;
}

  State1.fromJson(dynamic json) {
    _opened = json['opened'];
  }
  bool? _opened;
State1 copyWith({  bool? opened,
}) => State1(  opened: opened ?? _opened,
);
  bool? get opened => _opened;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['opened'] = _opened;
    return map;
  }

}

/// id : "1"
/// name : "Credit Card"
/// parent_id : "0"
/// slug : "credit-card"
/// image : "https://developmentalphawizz.com/referral_management/uploads/media/2023/thumb-sm/credit-cards-4-steps-1440x864.jpg"
/// banner : "https://developmentalphawizz.com/referral_management/"
/// row_order : "0"
/// status : "1"
/// clicks : "0"
/// children : [{"id":"7","name":"SBI Credit Card","parent_id":"1","slug":"sbi-credit-card","image":"https://developmentalphawizz.com/referral_management/uploads/media/2023/download.jpg","banner":"https://developmentalphawizz.com/referral_management/","row_order":"0","status":"1","clicks":"0","children":[],"text":"SBI Credit Card","state":{"opened":true},"level":1},{"id":"8","name":"HDFC Credit Card","parent_id":"1","slug":"hdfc-credit-card","image":"https://developmentalphawizz.com/referral_management/uploads/media/2023/thumb-md/credit-cards-4-steps-1440x864.jpg","banner":"https://developmentalphawizz.com/referral_management/","row_order":"0","status":"1","clicks":"0","children":[],"text":"HDFC Credit Card","state":{"opened":true},"level":1}]
/// text : "Credit Card"
/// state : {"opened":true}
/// icon : "jstree-folder"
/// level : 0
/// total : 8

class Categories {
  Categories({
      String? id, 
      String? name, 
      String? parentId, 
      String? slug, 
      String? image, 
      String? banner, 
      String? rowOrder, 
      String? status, 
      String? clicks, 
      List<Children>? children, 
      String? text, 
      State1? state,
      String? icon, 
      num? level, 
      num? total,}){
    _id = id;
    _name = name;
    _parentId = parentId;
    _slug = slug;
    _image = image;
    _banner = banner;
    _rowOrder = rowOrder;
    _status = status;
    _clicks = clicks;
    _children = children;
    _text = text;
    _state = state;
    _icon = icon;
    _level = level;
    _total = total;
}

  Categories.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _parentId = json['parent_id'];
    _slug = json['slug'];
    _image = json['image'];
    _banner = json['banner'];
    _rowOrder = json['row_order'];
    _status = json['status'];
    _clicks = json['clicks'];
    if (json['children'] != null) {
      _children = [];
      json['children'].forEach((v) {
        _children?.add(Children.fromJson(v));
      });
    }
    _text = json['text'];
    _state = json['state'] != null ? State1.fromJson(json['state']) : null;
    _icon = json['icon'];
    _level = json['level'];
    _total = json['total'];
  }
  String? _id;
  String? _name;
  String? _parentId;
  String? _slug;
  String? _image;
  String? _banner;
  String? _rowOrder;
  String? _status;
  String? _clicks;
  List<Children>? _children;
  String? _text;
  State1? _state;
  String? _icon;
  num? _level;
  num? _total;
Categories copyWith({  String? id,
  String? name,
  String? parentId,
  String? slug,
  String? image,
  String? banner,
  String? rowOrder,
  String? status,
  String? clicks,
  List<Children>? children,
  String? text,
  State1? state,
  String? icon,
  num? level,
  num? total,
}) => Categories(  id: id ?? _id,
  name: name ?? _name,
  parentId: parentId ?? _parentId,
  slug: slug ?? _slug,
  image: image ?? _image,
  banner: banner ?? _banner,
  rowOrder: rowOrder ?? _rowOrder,
  status: status ?? _status,
  clicks: clicks ?? _clicks,
  children: children ?? _children,
  text: text ?? _text,
  state: state ?? _state,
  icon: icon ?? _icon,
  level: level ?? _level,
  total: total ?? _total,
);
  String? get id => _id;
  String? get name => _name;
  String? get parentId => _parentId;
  String? get slug => _slug;
  String? get image => _image;
  String? get banner => _banner;
  String? get rowOrder => _rowOrder;
  String? get status => _status;
  String? get clicks => _clicks;
  List<Children>? get children => _children;
  String? get text => _text;
  State1? get state => _state;
  String? get icon => _icon;
  num? get level => _level;
  num? get total => _total;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['parent_id'] = _parentId;
    map['slug'] = _slug;
    map['image'] = _image;
    map['banner'] = _banner;
    map['row_order'] = _rowOrder;
    map['status'] = _status;
    map['clicks'] = _clicks;
    if (_children != null) {
      map['children'] = _children?.map((v) => v.toJson()).toList();
    }
    map['text'] = _text;
    if (_state != null) {
      map['state'] = _state?.toJson();
    }
    map['icon'] = _icon;
    map['level'] = _level;
    map['total'] = _total;
    return map;
  }

}

/// opened : true

// class State {
//   State({
//       bool? opened,}){
//     _opened = opened;
// }
//
//   State.fromJson(dynamic json) {
//     _opened = json['opened'];
//   }
//   bool? _opened;
// State copyWith({  bool? opened,
// }) => State(  opened: opened ?? _opened,
// );
//   bool? get opened => _opened;
//
//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['opened'] = _opened;
//     return map;
//   }
//
// }

/// id : "7"
/// name : "SBI Credit Card"
/// parent_id : "1"
/// slug : "sbi-credit-card"
/// image : "https://developmentalphawizz.com/referral_management/uploads/media/2023/download.jpg"
/// banner : "https://developmentalphawizz.com/referral_management/"
/// row_order : "0"
/// status : "1"
/// clicks : "0"
/// children : []
/// text : "SBI Credit Card"
/// state : {"opened":true}
/// level : 1

class Children {
  Children({
      String? id, 
      String? name, 
      String? parentId, 
      String? slug, 
      String? image, 
      String? banner, 
      String? rowOrder, 
      String? status, 
      String? clicks, 
      List<dynamic>? children, 
      String? text, 
      State1? state,
      num? level,}){
    _id = id;
    _name = name;
    _parentId = parentId;
    _slug = slug;
    _image = image;
    _banner = banner;
    _rowOrder = rowOrder;
    _status = status;
    _clicks = clicks;
    _children = children;
    _text = text;
    _state = state;
    _level = level;
}

  Children.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _parentId = json['parent_id'];
    _slug = json['slug'];
    _image = json['image'];
    _banner = json['banner'];
    _rowOrder = json['row_order'];
    _status = json['status'];
    _clicks = json['clicks'];
    if (json['children'] != null) {
      _children = [];
      json['children'].forEach((v) {
        _children?.add(v.fromJson(v));
      });
    }
    _text = json['text'];
    _state = json['state'] != null ? State1.fromJson(json['state']) : null;
    _level = json['level'];
  }
  String? _id;
  String? _name;
  String? _parentId;
  String? _slug;
  String? _image;
  String? _banner;
  String? _rowOrder;
  String? _status;
  String? _clicks;
  List<dynamic>? _children;
  String? _text;
  State1? _state;
  num? _level;
Children copyWith({  String? id,
  String? name,
  String? parentId,
  String? slug,
  String? image,
  String? banner,
  String? rowOrder,
  String? status,
  String? clicks,
  List<dynamic>? children,
  String? text,
  State1? state,
  num? level,
}) => Children(  id: id ?? _id,
  name: name ?? _name,
  parentId: parentId ?? _parentId,
  slug: slug ?? _slug,
  image: image ?? _image,
  banner: banner ?? _banner,
  rowOrder: rowOrder ?? _rowOrder,
  status: status ?? _status,
  clicks: clicks ?? _clicks,
  children: children ?? _children,
  text: text ?? _text,
  state: state ?? _state,
  level: level ?? _level,
);
  String? get id => _id;
  String? get name => _name;
  String? get parentId => _parentId;
  String? get slug => _slug;
  String? get image => _image;
  String? get banner => _banner;
  String? get rowOrder => _rowOrder;
  String? get status => _status;
  String? get clicks => _clicks;
  List<dynamic>? get children => _children;
  String? get text => _text;
  State1? get state => _state;
  num? get level => _level;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['parent_id'] = _parentId;
    map['slug'] = _slug;
    map['image'] = _image;
    map['banner'] = _banner;
    map['row_order'] = _rowOrder;
    map['status'] = _status;
    map['clicks'] = _clicks;
    if (_children != null) {
      map['children'] = _children?.map((v) => v.toJson()).toList();
    }
    map['text'] = _text;
    if (_state != null) {
      map['state'] = _state?.toJson();
    }
    map['level'] = _level;
    return map;
  }

}

/// opened : true

// class State {
//   State({
//       bool? opened,}){
//     _opened = opened;
// }
//
//   State.fromJson(dynamic json) {
//     _opened = json['opened'];
//   }
//   bool? _opened;
// State copyWith({  bool? opened,
// }) => State(  opened: opened ?? _opened,
// );
//   bool? get opened => _opened;
//
//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['opened'] = _opened;
//     return map;
//   }
//
// }