/// data : [{"id":"33","name":"Cement","parent_id":"0","slug":"test","image":"","banner":null,"row_order":"0","status":"1","clicks":"0","products":[{"id":"34","name":"Ultra Tech Cement","parent_id":"33","slug":"test-tt","image":"","banner":"","row_order":"0","status":"1","clicks":"0"},{"id":"35","name":"ACC Cement","parent_id":"33","slug":"new-product","image":"","banner":"","row_order":"0","status":"1","clicks":"0"}]},{"id":"36","name":"RB","parent_id":"0","slug":"test","image":"","banner":null,"row_order":"0","status":"1","clicks":"0","products":[]}]
/// error : false
/// message : "All Category Product"

class DealingProductModel {
  DealingProductModel({
      List<DealingData>? data,
      bool? error, 
      String? message,}){
    _data = data;
    _error = error;
    _message = message;
}

  DealingProductModel.fromJson(dynamic json) {
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(DealingData.fromJson(v));
      });
    }
    _error = json['error'];
    _message = json['message'];
  }
  List<DealingData>? _data;
  bool? _error;
  String? _message;
DealingProductModel copyWith({  List<DealingData>? data,
  bool? error,
  String? message,
}) => DealingProductModel(  data: data ?? _data,
  error: error ?? _error,
  message: message ?? _message,
);
  List<DealingData>? get data => _data;
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

/// id : "33"
/// name : "Cement"
/// parent_id : "0"
/// slug : "test"
/// image : ""
/// banner : null
/// row_order : "0"
/// status : "1"
/// clicks : "0"
/// products : [{"id":"34","name":"Ultra Tech Cement","parent_id":"33","slug":"test-tt","image":"","banner":"","row_order":"0","status":"1","clicks":"0"},{"id":"35","name":"ACC Cement","parent_id":"33","slug":"new-product","image":"","banner":"","row_order":"0","status":"1","clicks":"0"}]

class DealingData {
  DealingData({
      String? id, 
      String? name, 
      String? parentId, 
      String? slug, 
      String? image, 
      dynamic banner, 
      String? rowOrder, 
      String? status, 
      String? clicks, 
      List<Products>? products,}){
    _id = id;
    _name = name;
    _parentId = parentId;
    _slug = slug;
    _image = image;
    _banner = banner;
    _rowOrder = rowOrder;
    _status = status;
    _clicks = clicks;
    _products = products;
}

  DealingData.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _parentId = json['parent_id'];
    _slug = json['slug'];
    _image = json['image'];
    _banner = json['banner'];
    _rowOrder = json['row_order'];
    _status = json['status'];
    _clicks = json['clicks'];
    if (json['products'] != null) {
      _products = [];
      json['products'].forEach((v) {
        _products?.add(Products.fromJson(v));
      });
    }
  }
  String? _id;
  String? _name;
  String? _parentId;
  String? _slug;
  String? _image;
  dynamic _banner;
  String? _rowOrder;
  String? _status;
  String? _clicks;
  List<Products>? _products;
  DealingData copyWith({  String? id,
  String? name,
  String? parentId,
  String? slug,
  String? image,
  dynamic banner,
  String? rowOrder,
  String? status,
  String? clicks,
  List<Products>? products,
}) => DealingData(  id: id ?? _id,
  name: name ?? _name,
  parentId: parentId ?? _parentId,
  slug: slug ?? _slug,
  image: image ?? _image,
  banner: banner ?? _banner,
  rowOrder: rowOrder ?? _rowOrder,
  status: status ?? _status,
  clicks: clicks ?? _clicks,
  products: products ?? _products,
);
  String? get id => _id;
  String? get name => _name;
  String? get parentId => _parentId;
  String? get slug => _slug;
  String? get image => _image;
  dynamic get banner => _banner;
  String? get rowOrder => _rowOrder;
  String? get status => _status;
  String? get clicks => _clicks;
  List<Products>? get products => _products;

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
    if (_products != null) {
      map['products'] = _products?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : "34"
/// name : "Ultra Tech Cement"
/// parent_id : "33"
/// slug : "test-tt"
/// image : ""
/// banner : ""
/// row_order : "0"
/// status : "1"
/// clicks : "0"

class Products {
  Products({
      String? id, 
      String? name, 
      String? parentId, 
      String? slug, 
      String? image, 
      String? banner, 
      String? rowOrder, 
      String? status, 
      String? clicks,}){
    _id = id;
    _name = name;
    _parentId = parentId;
    _slug = slug;
    _image = image;
    _banner = banner;
    _rowOrder = rowOrder;
    _status = status;
    _clicks = clicks;
}

  Products.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _parentId = json['parent_id'];
    _slug = json['slug'];
    _image = json['image'];
    _banner = json['banner'];
    _rowOrder = json['row_order'];
    _status = json['status'];
    _clicks = json['clicks'];
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
Products copyWith({  String? id,
  String? name,
  String? parentId,
  String? slug,
  String? image,
  String? banner,
  String? rowOrder,
  String? status,
  String? clicks,
}) => Products(  id: id ?? _id,
  name: name ?? _name,
  parentId: parentId ?? _parentId,
  slug: slug ?? _slug,
  image: image ?? _image,
  banner: banner ?? _banner,
  rowOrder: rowOrder ?? _rowOrder,
  status: status ?? _status,
  clicks: clicks ?? _clicks,
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
    return map;
  }
}