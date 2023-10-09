/// message : "Category retrieved successfully"
/// error : false
/// data : [{"id":"18","name":"Travel","parent_id":"0","slug":"travel","image":"https://alphawizzserver.com/employee_management/uploads/media/2023/thumb-sm/travel-category-mob.jpg","banner":"https://alphawizzserver.com/employee_management/","row_order":"0","status":"1","clicks":"0","children":[{"id":"22","name":"Train","parent_id":"18","slug":"train","image":"https://alphawizzserver.com/employee_management/uploads/media/2023/Train-free-to-use-clip-art.png","banner":"https://alphawizzserver.com/employee_management/","row_order":"0","status":"1","clicks":"0","children":[],"text":"Train","state":{"opened":true},"level":1},{"id":"23","name":"Bus","parent_id":"18","slug":"bus","image":"https://alphawizzserver.com/employee_management/uploads/media/2023/istockphoto-492620954-612x612.jpg","banner":"https://alphawizzserver.com/employee_management/","row_order":"0","status":"1","clicks":"0","children":[],"text":"Bus","state":{"opened":true},"level":1},{"id":"24","name":"Auto","parent_id":"18","slug":"auto","image":"https://alphawizzserver.com/employee_management/uploads/media/2023/thumb-md/auto.jpeg","banner":"https://alphawizzserver.com/employee_management/","row_order":"0","status":"1","clicks":"0","children":[],"text":"Auto","state":{"opened":true},"level":1},{"id":"25","name":"Cab","parent_id":"18","slug":"cab","image":"https://alphawizzserver.com/employee_management/uploads/media/2023/download_(11).jpg","banner":"https://alphawizzserver.com/employee_management/","row_order":"0","status":"1","clicks":"0","children":[],"text":"Cab","state":{"opened":true},"level":1}],"text":"Travel","state":{"opened":true},"icon":"jstree-folder","level":0,"total":29},{"id":"19","name":"Food","parent_id":"0","slug":"food","image":"https://alphawizzserver.com/employee_management/uploads/media/2023/download_(1).png","banner":"https://alphawizzserver.com/employee_management/","row_order":"0","status":"1","clicks":"0","children":[{"id":"26","name":"Lunch","parent_id":"19","slug":"lunch","image":"https://alphawizzserver.com/employee_management/uploads/media/2023/pexels-robin-stickel-70497.jpg","banner":"https://alphawizzserver.com/employee_management/","row_order":"0","status":"1","clicks":"0","children":[],"text":"Lunch","state":{"opened":true},"level":1},{"id":"27","name":"Dinner","parent_id":"19","slug":"dinner","image":"https://alphawizzserver.com/employee_management/uploads/media/2023/download_(12).jpg","banner":"https://alphawizzserver.com/employee_management/","row_order":"0","status":"1","clicks":"0","children":[],"text":"Dinner","state":{"opened":true},"level":1},{"id":"28","name":"Breakfast","parent_id":"19","slug":"breakfast","image":"https://alphawizzserver.com/employee_management/uploads/media/2023/download_(13).jpg","banner":"https://alphawizzserver.com/employee_management/","row_order":"0","status":"1","clicks":"0","children":[],"text":"Breakfast","state":{"opened":true},"level":1}],"text":"Food","state":{"opened":true},"icon":"jstree-folder","level":0},{"id":"20","name":"Stay","parent_id":"0","slug":"stay","image":"https://alphawizzserver.com/employee_management/uploads/media/2023/images_(5).jpg","banner":"https://alphawizzserver.com/employee_management/","row_order":"0","status":"1","clicks":"0","children":[{"id":"29","name":"Hotel","parent_id":"20","slug":"hotel","image":"https://alphawizzserver.com/employee_management/uploads/media/2023/thumb-md/453472437.jpg","banner":"https://alphawizzserver.com/employee_management/","row_order":"0","status":"1","clicks":"0","children":[],"text":"Hotel","state":{"opened":true},"level":1}],"text":"Stay","state":{"opened":true},"icon":"jstree-folder","level":0},{"id":"21","name":"Other","parent_id":"0","slug":"other","image":"https://alphawizzserver.com/employee_management/uploads/media/2023/download_(2).png","banner":"https://alphawizzserver.com/employee_management/","row_order":"0","status":"1","clicks":"0","children":[],"text":"Other","state":{"opened":true},"icon":"jstree-folder","level":0}]

class NewCategoryModel {
  NewCategoryModel({
      String? message, 
      bool? error, 
      List<Data>? data,}){
    _message = message;
    _error = error;
    _data = data;
}

  NewCategoryModel.fromJson(dynamic json) {
    _message = json['message'];
    _error = json['error'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Data.fromJson(v));
      });
    }
  }
  String? _message;
  bool? _error;
  List<Data>? _data;
NewCategoryModel copyWith({  String? message,
  bool? error,
  List<Data>? data,
}) => NewCategoryModel(  message: message ?? _message,
  error: error ?? _error,
  data: data ?? _data,
);
  String? get message => _message;
  bool? get error => _error;
  List<Data>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = _message;
    map['error'] = _error;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : "18"
/// name : "Travel"
/// parent_id : "0"
/// slug : "travel"
/// image : "https://alphawizzserver.com/employee_management/uploads/media/2023/thumb-sm/travel-category-mob.jpg"
/// banner : "https://alphawizzserver.com/employee_management/"
/// row_order : "0"
/// status : "1"
/// clicks : "0"
/// children : [{"id":"22","name":"Train","parent_id":"18","slug":"train","image":"https://alphawizzserver.com/employee_management/uploads/media/2023/Train-free-to-use-clip-art.png","banner":"https://alphawizzserver.com/employee_management/","row_order":"0","status":"1","clicks":"0","children":[],"text":"Train","state":{"opened":true},"level":1},{"id":"23","name":"Bus","parent_id":"18","slug":"bus","image":"https://alphawizzserver.com/employee_management/uploads/media/2023/istockphoto-492620954-612x612.jpg","banner":"https://alphawizzserver.com/employee_management/","row_order":"0","status":"1","clicks":"0","children":[],"text":"Bus","state":{"opened":true},"level":1},{"id":"24","name":"Auto","parent_id":"18","slug":"auto","image":"https://alphawizzserver.com/employee_management/uploads/media/2023/thumb-md/auto.jpeg","banner":"https://alphawizzserver.com/employee_management/","row_order":"0","status":"1","clicks":"0","children":[],"text":"Auto","state":{"opened":true},"level":1},{"id":"25","name":"Cab","parent_id":"18","slug":"cab","image":"https://alphawizzserver.com/employee_management/uploads/media/2023/download_(11).jpg","banner":"https://alphawizzserver.com/employee_management/","row_order":"0","status":"1","clicks":"0","children":[],"text":"Cab","state":{"opened":true},"level":1}]
/// text : "Travel"
/// state : {"opened":true}
/// icon : "jstree-folder"
/// level : 0
/// total : 29

class Data {
  Data({
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
      State2? state,
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

  Data.fromJson(dynamic json) {
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
    _state = json['state'] != null ? State2.fromJson(json['state']) : null;
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
  State2? _state;
  String? _icon;
  num? _level;
  num? _total;
Data copyWith({  String? id,
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
  State2? state,
  String? icon,
  num? level,
  num? total,
}) => Data(  id: id ?? _id,
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
  State2? get state => _state;
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

class State2 {
  State2({
      bool? opened,}){
    _opened = opened;
}

  State2.fromJson(dynamic json) {
    _opened = json['opened'];
  }
  bool? _opened;
State2 copyWith({  bool? opened,
}) => State2(  opened: opened ?? _opened,
);
  bool? get opened => _opened;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['opened'] = _opened;
    return map;
  }

}

/// id : "22"
/// name : "Train"
/// parent_id : "18"
/// slug : "train"
/// image : "https://alphawizzserver.com/employee_management/uploads/media/2023/Train-free-to-use-clip-art.png"
/// banner : "https://alphawizzserver.com/employee_management/"
/// row_order : "0"
/// status : "1"
/// clicks : "0"
/// children : []
/// text : "Train"
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
      State2? state,
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
    _state = json['state'] != null ? State2.fromJson(json['state']) : null;
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
  State2? _state;
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
  State2? state,
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
  State2? get state => _state;
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