/// message : "Permissions Get Successfully !"
/// data : {"clients":{"add":"on","edit":"on","view":"on","gio_tag":"on","photo":"on"},"feedback":{"add":"on","view":"on"},"survey_form":{"add":"on","view":"on"}}
/// error : false

class PermissionModel {
  PermissionModel({
      String? message, 
      Data? data, 
      bool? error,}){
    _message = message;
    _data = data;
    _error = error;
}

  PermissionModel.fromJson(dynamic json) {
    _message = json['message'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
    _error = json['error'];
  }
  String? _message;
  Data? _data;
  bool? _error;
PermissionModel copyWith({  String? message,
  Data? data,
  bool? error,
}) => PermissionModel(  message: message ?? _message,
  data: data ?? _data,
  error: error ?? _error,
);
  String? get message => _message;
  Data? get data => _data;
  bool? get error => _error;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = _message;
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    map['error'] = _error;
    return map;
  }

}

/// clients : {"add":"on","edit":"on","view":"on","gio_tag":"on","photo":"on"}
/// feedback : {"add":"on","view":"on"}
/// survey_form : {"add":"on","view":"on"}

class Data {
  Data({
      Clients? clients, 
      Feedback? feedback, 
      SurveyForm? surveyForm,}){
    _clients = clients;
    _feedback = feedback;
    _surveyForm = surveyForm;
}

  Data.fromJson(dynamic json) {
    _clients = json['clients'] != null ? Clients.fromJson(json['clients']) : null;
    _feedback = json['feedback'] != null ? Feedback.fromJson(json['feedback']) : null;
    _surveyForm = json['survey_form'] != null ? SurveyForm.fromJson(json['survey_form']) : null;
  }
  Clients? _clients;
  Feedback? _feedback;
  SurveyForm? _surveyForm;
Data copyWith({  Clients? clients,
  Feedback? feedback,
  SurveyForm? surveyForm,
}) => Data(  clients: clients ?? _clients,
  feedback: feedback ?? _feedback,
  surveyForm: surveyForm ?? _surveyForm,
);
  Clients? get clients => _clients;
  Feedback? get feedback => _feedback;
  SurveyForm? get surveyForm => _surveyForm;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_clients != null) {
      map['clients'] = _clients?.toJson();
    }
    if (_feedback != null) {
      map['feedback'] = _feedback?.toJson();
    }
    if (_surveyForm != null) {
      map['survey_form'] = _surveyForm?.toJson();
    }
    return map;
  }

}

/// add : "on"
/// view : "on"

class SurveyForm {
  SurveyForm({
      String? add, 
      String? view,}){
    _add = add;
    _view = view;
}

  SurveyForm.fromJson(dynamic json) {
    _add = json['add'];
    _view = json['view'];
  }
  String? _add;
  String? _view;
SurveyForm copyWith({  String? add,
  String? view,
}) => SurveyForm(  add: add ?? _add,
  view: view ?? _view,
);
  String? get add => _add;
  String? get view => _view;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['add'] = _add;
    map['view'] = _view;
    return map;
  }

}

/// add : "on"
/// view : "on"

class Feedback {
  Feedback({
      String? add, 
      String? view,}){
    _add = add;
    _view = view;
}

  Feedback.fromJson(dynamic json) {
    _add = json['add'];
    _view = json['view'];
  }
  String? _add;
  String? _view;
Feedback copyWith({  String? add,
  String? view,
}) => Feedback(  add: add ?? _add,
  view: view ?? _view,
);
  String? get add => _add;
  String? get view => _view;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['add'] = _add;
    map['view'] = _view;
    return map;
  }

}

/// add : "on"
/// edit : "on"
/// view : "on"
/// gio_tag : "on"
/// photo : "on"

class Clients {
  Clients({
      String? add, 
      String? edit, 
      String? view, 
      String? gioTag, 
      String? photo,}){
    _add = add;
    _edit = edit;
    _view = view;
    _gioTag = gioTag;
    _photo = photo;
}

  Clients.fromJson(dynamic json) {
    _add = json['add'];
    _edit = json['edit'];
    _view = json['view'];
    _gioTag = json['gio_tag'];
    _photo = json['photo'];
  }
  String? _add;
  String? _edit;
  String? _view;
  String? _gioTag;
  String? _photo;
Clients copyWith({  String? add,
  String? edit,
  String? view,
  String? gioTag,
  String? photo,
}) => Clients(  add: add ?? _add,
  edit: edit ?? _edit,
  view: view ?? _view,
  gioTag: gioTag ?? _gioTag,
  photo: photo ?? _photo,
);
  String? get add => _add;
  String? get edit => _edit;
  String? get view => _view;
  String? get gioTag => _gioTag;
  String? get photo => _photo;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['add'] = _add;
    map['edit'] = _edit;
    map['view'] = _view;
    map['gio_tag'] = _gioTag;
    map['photo'] = _photo;
    return map;
  }
}