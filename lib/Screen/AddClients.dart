import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:omega_employee_management/Screen/Dashboard.dart';
import '../Helper/Color.dart';
import '../Helper/String.dart';
import '../Model/GetListModel.dart';
import 'Add_Address.dart';

class AddClients extends StatefulWidget {
  const AddClients({Key? key}) : super(key: key);

  @override
  State<AddClients> createState() => _AddClientsState();
}

class _AddClientsState extends State<AddClients> {


  void initState() {
    super.initState();
    getState();
    print("latitute and longtitute ${latitude} ${longitude}");
  }

  TextEditingController namecn = TextEditingController();
  TextEditingController emailcn = TextEditingController();
  TextEditingController mobilecnOne= TextEditingController();
  TextEditingController mobilecnTwo= TextEditingController();
  TextEditingController whatsUpCTr= TextEditingController();
  TextEditingController department= TextEditingController();
  TextEditingController ownernamecn= TextEditingController();
  TextEditingController addresscn= TextEditingController();
  TextEditingController pincodecn= TextEditingController();
  TextEditingController gstCtr= TextEditingController();
  TextEditingController panNumberCtr = TextEditingController();
  TextEditingController adharCtr= TextEditingController();
  TextEditingController creditCTr= TextEditingController();
  TextEditingController panCtr= TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? selected_Status;
  String? selected_stuff;
  String? selected_State;
  List<Cities>?cities = [];
  String? selected_District;
  int nwIndex = 0;
  String? selectedDistrict;
  int stateindex = 0;
  List<String> Staff=['Atul Gautam','Pretty Tomer','Sunil','yash',];
  // List<String> District=['Indore','Bhopal','Gwalior','Ujjain',];
  // List<String> State=['MP','Gujrat','Rajasthan','Utter pradesh',];

  GetListModel? getListModel;
  getState() async {
    var headers = {
      'Cookie': 'ci_session=81cd74eabcb3683af924161dd1dcd833b8da1ff6'
    };
    var request = http.MultipartRequest('GET', Uri.parse(getListsApi.toString()));
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      String str = await response.stream.bytesToString();
      var result = json.decode(str);
      var finalResponse = GetListModel.fromJson(result);
      setState(() {
        getListModel = finalResponse;
      });
    }
    else {
      print(response.reasonPhrase);
    }
  }

  void pickImageDialog(BuildContext context,int i) async{
    return await showDialog<void>(
      context: context,
      // barrierDismissible: barrierDismissible, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(6),
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              InkWell(
                onTap: () async {
                  _getFromGallery();
                },
                child: Container(
                  child: ListTile(
                    title: Text("Gallery"),
                    leading: Icon(
                      Icons.image,
                      color: colors.primary,
                    ),
                  ),
                ),
              ),
              Container(
                width: 200,
                height: 1,
                color: Colors.black12,
              ),
              InkWell(
                onTap: () async {
                  _getFromCamera();
                },
                child: Container(
                  child: ListTile(
                      title: Text("Camera"),
                      leading: Icon(
                        Icons.camera,
                        color: colors.primary,
                      ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void pickImageDialogPan(BuildContext context,int i) async{
    return await showDialog<void>(
      context: context,
      // barrierDismissible: barrierDismissible, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(6),
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              // InkWell(
              //   onTap: () async {
              //     _getFromGalleryPan();
              //   },
              //   child:  Container(
              //     child: ListTile(
              //       title:  Text("Gallery"),
              //       leading: Icon(
              //         Icons.image,
              //         color: colors.primary,
              //       ),
              //     ),
              //   ),
              // ),
              Container(
                width: 200,
                height: 1,
                color: Colors.black12,
              ),
              InkWell(
                onTap: () async {
                  _getFromCameraPan();
                },
                child: Container(
                  child: ListTile(
                      title:  Text("Camera"),
                      leading: Icon(
                        Icons.camera,
                        color: colors.primary,
                      )),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void pickImageDialogGst(BuildContext context,int i) async{
    return await showDialog<void>(
      context: context,
      // barrierDismissible: barrierDismissible, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(6),
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              // InkWell(
              //   onTap: () async {
              //     _getFromGalleryGst();
              //   },
              //   child: Container(
              //     child: ListTile(
              //       title: Text("Gallery"),
              //       leading: Icon(
              //         Icons.image,
              //         color: colors.primary,
              //       ),
              //     ),
              //   ),
              // ),
              Container(
                width: 200,
                height: 1,
                color: Colors.black12,
              ),
              InkWell(
                onTap: () async {
                  _getFromCameraGst();
                },
                child: Container(
                  child: ListTile(
                      title:  Text("Camera"),
                      leading: Icon(
                        Icons.camera,
                        color: colors.primary,
                      ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }


  void pickImageDialogGstOne(BuildContext context,int i) async{
    return await showDialog<void>(
      context: context,
      // barrierDismissible: barrierDismissible, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(6),
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              // InkWell(
              //   onTap: () async {
              //     _getFromGalleryGst();
              //   },
              //   child: Container(
              //     child: ListTile(
              //       title: Text("Gallery"),
              //       leading: Icon(
              //         Icons.image,
              //         color: colors.primary,
              //       ),
              //     ),
              //   ),
              // ),
              Container(
                width: 200,
                height: 1,
                color: Colors.black12,
              ),
              InkWell(
                onTap: () async {
                  _getFromCameraGstOne();
                },
                child: Container(
                  child: ListTile(
                    title:  Text("Camera"),
                    leading: Icon(
                      Icons.camera,
                      color: colors.primary,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void pickImageDialogGstTwo(BuildContext context,int i) async{
    return await showDialog<void>(
      context: context,
      // barrierDismissible: barrierDismissible, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(6),
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              // InkWell(
              //   onTap: () async {
              //     _getFromGalleryGst();
              //   },
              //   child: Container(
              //     child: ListTile(
              //       title: Text("Gallery"),
              //       leading: Icon(
              //         Icons.image,
              //         color: colors.primary,
              //       ),
              //     ),
              //   ),
              // ),
              Container(
                width: 200,
                height: 1,
                color: Colors.black12,
              ),
              InkWell(
                onTap: () async {
                  _getFromCameraGstTwo();
                },
                child: Container(
                  child: ListTile(
                    title:  Text("Camera"),
                    leading: Icon(
                      Icons.camera,
                      color: colors.primary,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void pickImageDialogAdhar(BuildContext context,int i) async{
    return await showDialog<void>(
      context: context,
      // barrierDismissible: barrierDismissible, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(6),
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              // InkWell(
              //   onTap: () async {
              //     _getFromGalleryAdhar();
              //   },
              //   child:  Container(
              //     child: ListTile(
              //       title:  Text("Gallery"),
              //       leading: Icon(
              //         Icons.image,
              //         color: colors.primary,
              //       ),
              //     ),
              //   ),
              // ),
              Container(
                width: 200,
                height: 1,
                color: Colors.black12,
              ),
              InkWell(
                onTap: () async {
                  _getFromCameraAdhar();
                },
                child: Container(
                  child: ListTile(
                      title:  Text("Camera"),
                      leading: Icon(
                        Icons.camera,
                        color: colors.primary,
                      )),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void pickImageDialogAdharBack(BuildContext context,int i) async {
    return await showDialog<void>(
      context: context,
      // barrierDismissible: barrierDismissible, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(6),
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              // InkWell(
              //   onTap: () async {
              //     _getFromGalleryAdhar();
              //   },
              //   child:  Container(
              //     child: ListTile(
              //       title:  Text("Gallery"),
              //       leading: Icon(
              //         Icons.image,
              //         color: colors.primary,
              //       ),
              //     ),
              //   ),
              // ),
              Container(
                width: 200,
                height: 1,
                color: Colors.black12,
              ),
              InkWell(
                onTap: () async {
                  _getFromCameraAdharBack();
                },
                child: Container(
                  child: ListTile(
                      title:  Text("Camera"),
                      leading: Icon(
                        Icons.camera,
                        color: colors.primary,
                      )),
                ),
              ),
            ],
          ),
        );
      },
    );
  }


  final picker= ImagePicker();
  File? _imageFile;
  File? panImage;
  File? gstImage;
  File? aadharImage;
  File? aadharBack;
  File? gstOne;
  File? gstTwo;

  _getFromGallery() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
      Navigator.pop(context);
    }
  }


  _getFromCamera() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera,
    );
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
        imagePathList.add(_imageFile?.path ?? "");
        isImages = true;
      });
      //Navigator.pop(context);
    }
  }

  _getFromGalleryPan() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      setState(() {
        panImage = File(pickedFile.path);
      });
      Navigator.pop(context);
    }
  }

  _getFromCameraPan() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera,
    );
    if (pickedFile != null) {
      setState(() {
        panImage = File(pickedFile.path);
      });
      Navigator.pop(context);
    }
  }

  _getFromGalleryGst() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      setState(() {
        gstImage = File(pickedFile.path);
      });
      Navigator.pop(context);
    }
  }

  _getFromCameraGst() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera,
    );
    if (pickedFile != null) {
      setState(() {
        gstImage = File(pickedFile.path);
      });
      Navigator.pop(context);
    }
  }

  _getFromCameraGstOne() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera,
    );
    if (pickedFile != null) {
      setState(() {
        gstOne = File(pickedFile.path);
      });
      Navigator.pop(context);
    }
  }

  _getFromCameraGstTwo() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera,
    );
    if (pickedFile != null) {
      setState(() {
        gstTwo = File(pickedFile.path);
      });
      Navigator.pop(context);
    }
  }

  _getFromGalleryAdhar() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      setState(() {
        aadharImage = File(pickedFile.path);
      });
      Navigator.pop(context);
    }
  }

  _getFromCameraAdhar() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera,
    );
    if (pickedFile != null) {
      setState(() {
        aadharImage = File(pickedFile.path);
      });
      Navigator.pop(context);
    }
  }

  _getFromCameraAdharBack() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera,
    );
    if (pickedFile != null) {
      setState(() {
        aadharBack = File(pickedFile.path);
      });
      Navigator.pop(context);
    }
  }

  addClinets() async {
   var headers = {
    'Cookie': 'ci_session=3350434c72c5fbc8f5a7e422a38423adace3eaf8'
   };
   var request = http.MultipartRequest('POST', Uri.parse(addNewClient.toString()));
   request.fields.addAll({
     'user_id': '${CUR_USERID}',
     'name_of_firm': namecn.text,
     'status':selected_Status.toString() ,
     'owner_name': ownernamecn.text,
     'address': addresscn.text,
     'district': selected_District.toString(),
     'pin_code': pincodecn.text,
     'state': selected_State.toString(),
     'mobile_one': mobilecnOne.text,
     'mobile_two': mobilecnTwo.text,
     'whatsapp_number': whatsUpCTr.text,
     'email': emailcn.text,
     'pan': panCtr.text,
     'gst': gstCtr.text,
     'aadhar': adharCtr.text,
     'customer_type': selected_Customer.toString(),
     'credit_limit': creditCTr.text,
     'lat': latitude.toString(),
     'lng': longitude.toString(),
   });
   print("parameter addd clientss${request.fields} ${request.files}");
  request.files.add(await http.MultipartFile.fromPath('photo', _imageFile?.path ?? ""));
  request.files.add(await http.MultipartFile.fromPath('gst_img', gstImage?.path ?? ""));
  request.files.add(await http.MultipartFile.fromPath('pan_img', panImage?.path ?? ""));
  request.files.add(await http.MultipartFile.fromPath('aadhar_img', aadharImage?.path ?? ""));
  request.files.add(await http.MultipartFile.fromPath('aadhar_back', aadharBack?.path ?? ""));
  request.files.add(await http.MultipartFile.fromPath('gst_img_two', gstOne?.path ?? ""));
  request.files.add(await http.MultipartFile.fromPath('gst_img_three', gstTwo?.path ?? ""));
  request.headers.addAll(headers);
  http.StreamedResponse response = await request.send();
  if (response.statusCode == 200) {
    var finalResponse = await response.stream.bytesToString();
    final jsonresponse = json.decode(finalResponse);
    Fluttertoast.showToast(msg: '${jsonresponse['message']}');
    Navigator.push(context, MaterialPageRoute(builder: (context) => Dashboard()));
  }
  else {
    print(response.reasonPhrase);
  }
}

  String? selected_Customer;
  List imagePathList = [];
  bool isImages = false;

  Widget uploadMultiImmage() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(
          height: 10,
        ),
        InkWell(
          onTap: () async {
            _getFromCamera();
            // pickImageDialog(context, 1);
            // await pickImages();
          },
          child: Container(
            height: 40,
            width: 125,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: colors.primary),
            child: Center(
              child: Text(
                "Upload Images",
                style: TextStyle(color: colors.whiteTemp, fontWeight: FontWeight.bold, fontSize: 12),
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),
        Visibility(
            visible: isImages,
            child:  buildGridView()),
      ],
    );
  }

  Widget buildGridView() {
    return Container(
      height: 170,
      child: GridView.builder(
        itemCount: imagePathList.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (BuildContext context, int index) {
          return Stack(
            children: [
              Container(
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: colors.primary)
                ),
                width: MediaQuery.of(context).size.width/2.8,
                height: 170,
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  child: Image.file(
                      File(imagePathList[index]), fit: BoxFit.cover),
                ),
              ),
            ],
          );
        },
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: colors.primary,
        elevation: 0,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child:  Icon(Icons.arrow_back_ios, color: Colors.white),
        ),
        centerTitle: true,
        // backgroundColor: Colors.white,
        title: Text("Add Client", style: TextStyle(fontSize: 15, color: Colors.white),),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 15,right: 15,top: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Form(
                key:_formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Name Of Firm",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
                    SizedBox(height: MediaQuery.of(context).size.height*.02,),
                    Card(elevation: 3,
                      shape: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                      child: TextFormField(
                          keyboardType: TextInputType.text,
                          controller: namecn,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please Enter Your Name';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              hintText: '',
                              border: OutlineInputBorder(borderRadius:  BorderRadius.circular(10)))),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height*.02),
                    Text("Status",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
                    SizedBox(height: MediaQuery.of(context).size.height*.02),
                    Card(
                      elevation: 3,
                      shape: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                      child: DropdownButtonFormField<String>(
                        value: selected_Status,
                        onChanged: (newValue) {
                          setState(() {
                            selected_Status = newValue;
                          });
                        },
                        items: getListModel?.data?.clientStatus?.map((items) {
                          return DropdownMenuItem(
                            value: items.id,
                            child: Text(items.name.toString()),
                          );
                        }).toList(),
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(top: 5, left: 10),
                          border: InputBorder.none,
                          hintText: 'Select Status',
                        ),
                      ),
                    ),
                    // SizedBox(height: MediaQuery.of(context).size.height*.02,),
                    // Text("Staff",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
                    // Card(elevation: 3,
                    //   shape: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                    //   child: DropdownButtonFormField<String>(
                    //     value: selected_stuff,
                    //     validator: (value) {
                    //       if (value == null || value.isEmpty) {
                    //         return 'Please Enter Staff';
                    //       } else {
                    //         return null;
                    //       }
                    //     },
                    //     onChanged: (newValue) {
                    //       setState(() {
                    //         selected_stuff= newValue;
                    //       });
                    //     },
                    //     items:Staff.map((item) {
                    //       return DropdownMenuItem(
                    //         value: item,
                    //         child: Text(item),
                    //       );
                    //     }).toList(),
                    //     decoration: InputDecoration(
                    //       border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                    //       hintText:
                    //       'Select Status',
                    //     ),
                    //   ),
                    // ),
                    SizedBox(height: MediaQuery.of(context).size.height*.02,),
                    Text("Owner Name",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
                    SizedBox(height: MediaQuery.of(context).size.height*.02,),
                    Card(elevation: 3,
                      shape: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                      child: TextFormField(
                          keyboardType: TextInputType.text,
                          controller: ownernamecn,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please Enter owner name';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              hintText: '',
                              border: OutlineInputBorder(
                                  borderRadius:  BorderRadius.circular(10)))),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height*.02,),
                    Text("Address",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
                    SizedBox(height: MediaQuery.of(context).size.height*.02,),
                    Card(elevation: 3,
                      shape: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                      child: TextFormField(
                          keyboardType: TextInputType.text,
                          controller: addresscn,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please Enter address';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              hintText: '',
                              border: OutlineInputBorder(
                                  borderRadius:  BorderRadius.circular(10)))),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height*.02,),
                    Text("State",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
                    Card(elevation: 3,
                      shape: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                      child: DropdownButtonFormField<String>(
                        value: selected_State,
                        onChanged: (newValue) {
                          setState(() {
                            selected_State = newValue;
                            getListModel?.data?.states?.map((items) {
                              if(items.id == newValue) {
                                cities = items.cities;
                              }
                            });
                            var name =
                            print("aaaaaaaaaaaaaaaaaaaaaaa${selected_State}");
                            // print("current indexxx ${selected}");
                            // stateindex = getListModel!.data!.states!.indexWhere((element) => element.id == selectedState);
                            // currentIndex = selected;
                            // showTextField = true;
                          });
                        },
                        items: getListModel?.data?.states?.map((items) {
                          return DropdownMenuItem(
                            value: items.id,

                            child: Text(items.name.toString()),



                          );
                        }).toList(),
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(top: 5, left: 10),
                          border: InputBorder.none,
                          hintText: 'Select State',
                        ),
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height*.02,),
                    Text("District",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
                    Card(elevation: 3,
                      shape: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                      child: DropdownButtonFormField<String>(
                        value: selected_District,
                        onChanged: (newValue) {
                          setState(() {
                            selected_District = newValue;
                            // print("current indexxx ${selected}");
                            // nwIndex = getListModel!.data!.states![stateindex].cities!.indexWhere((element) => element.id == selectedDistrict)!;
                            // currentIndex = selected;
                            // showTextField = true;
                          });
                        },
                        items: getListModel?.data?.states?[stateindex].cities?.map((items) {
                          return DropdownMenuItem(
                            value: items.id,
                            child: Text(items.city.toString()),
                          );
                        }).toList(),
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(top: 5, left: 10),
                          border: InputBorder.none,
                          hintText: 'Select District',
                        ),
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height*.02),
                    Text("Pincode",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
                    SizedBox(height: MediaQuery.of(context).size.height*.02,),
                    Card(elevation: 3,
                      shape: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                      child: TextFormField(
                          keyboardType: TextInputType.number,
                          controller: pincodecn,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please Enter pin code';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              hintText: '', border: OutlineInputBorder(borderRadius:  BorderRadius.circular(10),
                              ),
                          ),
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height*.02,),
                    Text("Email",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
                    SizedBox(height: MediaQuery.of(context).size.height*.02,),
                    Card(elevation: 3,
                      shape: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                      child: TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          controller: emailcn,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please Enter Your Email';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              hintText: '',
                              border: OutlineInputBorder(borderRadius:  BorderRadius.circular(10)))),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height*.02,),
                    Text("Mobile 1",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
                    SizedBox(height: MediaQuery.of(context).size.height*.02,),
                    Card(elevation: 3,
                      shape: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                      child: TextFormField(
                          keyboardType: TextInputType.number,
                          maxLength: 10,
                          controller: mobilecnOne,
                          validator: (value) {
                            if (value!.isEmpty||value.length<10) {
                              return 'Please Enter Your Mobile No';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              hintText: '',
                              counterText: "",
                              border: OutlineInputBorder(borderRadius:  BorderRadius.circular(10)))),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height*.02,),
                    Text("Mobile 2",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
                    SizedBox(height: MediaQuery.of(context).size.height*.02,),
                    Card(elevation: 3,
                      shape: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                      child: TextFormField(
                          keyboardType: TextInputType.number,
                          maxLength: 10,
                          controller: mobilecnTwo,
                          validator: (value) {
                            if (value!.isEmpty||value.length<10) {
                              return 'Please Enter Your Mobile No';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              hintText: '',
                              counterText: "",
                              border: OutlineInputBorder(
                                  borderRadius:  BorderRadius.circular(10)))),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height*.02,),
                    Text("Whatsapp Number",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
                    SizedBox(height: MediaQuery.of(context).size.height*.02,),
                    Card(
                      elevation: 6,
                      shape: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                      child: TextFormField(
                          keyboardType: TextInputType.number,
                          maxLength: 10,
                          controller: whatsUpCTr,
                          validator: (value) {
                            if (value!.isEmpty||value.length<10) {
                              return 'Please Enter Your Whatsapp No';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              hintText: '',
                              counterText: "",
                              border: OutlineInputBorder(
                                  borderRadius:  BorderRadius.circular(10)))),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height*.02,),
                    Text("Pan",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
                    SizedBox(height: MediaQuery.of(context).size.height*.02,),
                    Card(elevation: 6,
                      shape: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                      child: TextFormField(
                          keyboardType: TextInputType.text,
                          controller: panCtr,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please Enter Your Pan No';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              hintText: '',
                              counterText: "",
                              border: OutlineInputBorder(
                                  borderRadius:  BorderRadius.circular(10)))),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height*.02,),
                    ElevatedButton(
                      onPressed: () {
                        pickImageDialogPan(context, 1);
                      }, child: Text("Add Pan"),
                    ),
                    Center(
                      child: Container(
                        height: 150,
                        width: 150,
                        decoration: BoxDecoration(border: Border.all(color: Colors.black),
                        ),
                        child:panImage!=null? Image.file(panImage!.absolute,fit: BoxFit.fill):
                        Center(child: Image.asset('assets/images/homelogo.png'),
                        ),
                      ),
                    ),
                    Text("GST",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
                    SizedBox(height: MediaQuery.of(context).size.height*.02,),
                    Card(elevation: 6,
                      shape: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                      child: TextFormField(
                          keyboardType: TextInputType.text,
                          controller: gstCtr,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please Enter Your Gst No';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              hintText: '',
                              counterText: "",
                              border: OutlineInputBorder(
                                  borderRadius:  BorderRadius.circular(15),
                              )
                          )
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height*.01),
                    ElevatedButton(
                      onPressed: () {
                        pickImageDialogGst(context, 1);
                      }, child: Text("Add GST Image1"),
                    ),
                    Center(
                      child: Container(
                        height: 150,
                        width: 150,
                        decoration: BoxDecoration(border: Border.all(color: Colors.black),
                        ),
                        child:gstImage!=null? Image.file(gstImage!.absolute,fit: BoxFit.fill):
                        Center(child: Image.asset('assets/images/homelogo.png'),
                        ),
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height*.01),
                    ElevatedButton(
                      onPressed: () {
                        pickImageDialogGstOne(context, 1);
                      }, child: Text("Add GST Image2"),
                    ),
                    Center(
                      child: Container(
                        height: 150,
                        width: 150,
                        decoration: BoxDecoration(border: Border.all(color: Colors.black),
                        ),
                        child:gstOne!=null? Image.file(gstOne!.absolute,fit: BoxFit.fill):
                        Center(child: Image.asset('assets/images/homelogo.png'),
                        ),
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height*.01),
                    ElevatedButton(
                      onPressed: () {
                        pickImageDialogGstTwo(context, 1);
                      }, child: Text("Add GST Image3"),
                    ),
                    Center(
                      child: Container(
                        height: 150,
                        width: 150,
                        decoration: BoxDecoration(border: Border.all(color: Colors.black),
                        ),
                        child:gstTwo!=null? Image.file(gstTwo!.absolute,fit: BoxFit.fill):
                        Center(child: Image.asset('assets/images/homelogo.png'),
                        ),
                      ),
                    ),
                    Text("Aadhaar",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
                    SizedBox(height: MediaQuery.of(context).size.height*.02,),
                    Card(elevation: 6,
                      shape: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                      child: TextFormField(
                          keyboardType: TextInputType.number,
                          maxLength: 12,
                          controller: adharCtr,
                          validator: (value) {
                            if (value!.isEmpty||value.length<12) {
                              return 'Please Enter Your Aadhaar No';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              hintText: '',
                              counterText: "",
                              border: OutlineInputBorder(borderRadius:  BorderRadius.circular(10)))),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height*.01),
                    ElevatedButton(
                      onPressed: () {
                        pickImageDialogAdhar(context, 1);
                      }, child: Text("Add Aadhaar Front"),
                    ),
                    Center(
                      child: Container(
                        height: 150,
                        width: 150,
                        decoration: BoxDecoration(border: Border.all(color: Colors.black),
                        ),
                        child:aadharImage!=null? Image.file(aadharImage!.absolute,fit: BoxFit.fill):
                        Center(child: Image.asset('assets/images/homelogo.png'),
                        ),
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height*.01),
                    ElevatedButton(
                      onPressed: () {
                        pickImageDialogAdharBack(context, 1);
                      }, child: Text("Add Aadhaar Back"),
                    ),
                    Center(
                      child: Container(
                        height: 150,
                        width: 150,
                        decoration: BoxDecoration(border: Border.all(color: Colors.black),
                        ),
                        child: aadharBack!=null? Image.file(aadharBack!.absolute,fit: BoxFit.fill):
                        Center(child: Image.asset('assets/images/homelogo.png'),
                        ),
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height*.01),
                    Text("Customer Type",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
                    SizedBox(height: MediaQuery.of(context).size.height*.02),
                    Card(
                      elevation: 6,
                      shape: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                      child: DropdownButtonFormField<String>(
                        value: selected_Customer,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please Enter Customer Type';
                          } else {
                            return null;
                          }
                        },
                        onChanged: (newValue) {
                          setState(() {
                            selected_Customer= newValue;
                          });
                        },
                        items: getListModel?.data?.customerType?.map((items) {
                          return DropdownMenuItem(
                            value: items.id,
                            child: Text(items.name.toString()),
                          );
                        }).toList(),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                          hintText:
                          'Select Customer Type',
                        ),
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height*.02,),
                    Text("Credit limit",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
                    SizedBox(height: MediaQuery.of(context).size.height*.02,),
                    Card(elevation: 6,
                      shape: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                      child: TextFormField(
                        keyboardType: TextInputType.text,
                        controller: creditCTr,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please Enter Credit limit';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: '',
                          border: OutlineInputBorder(
                              borderRadius:  BorderRadius.circular(10))),
                      ),
                    ),
                    SizedBox(height: 15),
                    uploadMultiImmage(),
                  ],
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height*.02),
              Container(
                height: 60,
                // width: MediaQuery.of(context).size.width/2,
                child: Center(
                  child: Column(
                    children: [
                      // SizedBox(width: MediaQuery.of(context).size.width*.02,),
                      Container(
                        width: MediaQuery.of(context).size.width/2,
                        child: ElevatedButton(style: ElevatedButton.styleFrom(primary: colors.primary),
                            onPressed: () {
                              if(_formKey.currentState!.validate()){
                                addClinets();
                              }
                            }, child: Text("Add", style: TextStyle(fontWeight: FontWeight.bold, ),)),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
