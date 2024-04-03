import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:omega_employee_management/Screen/Dashboard.dart';
import 'package:omega_employee_management/Screen/MultiSelect.dart';
import '../Helper/Color.dart';
import '../Helper/String.dart';
import '../Model/GetListModel.dart';
import 'Add_Address.dart';

class AddClients extends StatefulWidget {
  const AddClients({Key? key}) : super(key: key);

  @override
  State<AddClients> createState() => _AddClientsState();
}

int count = 0;

class _AddClientsState extends State<AddClients> {


  void initState() {
    super.initState();
    getCurrentLoc();
    getState();
    convertDateTimeDispla();
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
  TextEditingController voterIdCtr= TextEditingController();
  TextEditingController udyogIdCtr= TextEditingController();
  TextEditingController doBCtr= TextEditingController();
  TextEditingController doACtr= TextEditingController();
  TextEditingController routeCtr= TextEditingController();
  TextEditingController marketCtr= TextEditingController();
  TextEditingController landmarkCtr= TextEditingController();

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
  List<String> results = [];
  GetListModel? getListModel;
  getState() async {
    var headers = {
      'Cookie': 'ci_session=81cd74eabcb3683af924161dd1dcd833b8da1ff6'
    };
    var request = http.MultipartRequest(
        'GET', Uri.parse(getListsApi.toString()));
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      String str = await response.stream.bytesToString();
      var result = json.decode(str);
      var finalResponse = GetListModel.fromJson(result);
      setState(() {
        getListModel = finalResponse;
      });
    } else {
      print(response.reasonPhrase);
    }
  }
  // DealingProductModel? dealingProductModel;
  // dealingProduct() async {
  //   var headers = {
  //     'Cookie': 'ci_session=4f8360fd4e4e40e498783ef6638c6f55e6bc9fca'
  //   };
  //   var request = http.MultipartRequest('POST', Uri.parse(GetDealingProduct.toString()));
  //   request.headers.addAll(headers);
  //   http.StreamedResponse response = await request.send();
  //   if (response.statusCode == 200) {
  //     var result=await response.stream.bytesToString();
  //     var finalresult = DealingProductModel.fromJson(json.decode(result));
  //     setState(() {
  //       dealingProductModel = finalresult;
  //     });
  //   }
  //   else {
  //     print(response.reasonPhrase);
  //   }
  // }
  Widget select() {
    return InkWell(
      onTap: (){
        setState(() {
          _showMultiSelect();
        });
      },
      child:
      Container(
        height: 50,
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.only(left: 10),
        decoration: BoxDecoration(
            color: colors.white70,),
            // border: Border(
            //     // bottom: BorderSide(color: colors.blackTemp.withOpacity(0.5),
            //     ))),
        child: results.isEmpty ? const Padding(
          padding: EdgeInsets.only(left: 10, top: 10, bottom: 10),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Select Department',
              style: TextStyle(
                fontSize: 15,
                color: colors.blackTemp,
                fontWeight: FontWeight.normal,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ):SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Align(
            alignment: Alignment.centerLeft,
            child: Row (
              crossAxisAlignment: CrossAxisAlignment.start,
              children: results.map((e) {
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 2),
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  height: 30,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: colors.primary),
                  child: Center(
                    child: Text(
                      e,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }

  void _showMultiSelect() async {
    var departments = ["seller","user","flutter"];
    results = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (context, setState) {
          return
            MultiSelect(
              departments:  departments,
              // dealingData: dealingProductModel?.data,
              // name:delearRetailerModel?.data?[nwIndex].ownerName,
              // email:delearRetailerModel?.data?[nwIndex].email,
              // contact: delearRetailerModel?.data?[nwIndex].mobileOne,
              // creditLimit: delearRetailerModel?.data?[nwIndex].creditLimit,
              // customerType: delearRetailerModel?.data?[nwIndex].customerType,
              // date: dateCtr.text,time: timeCtr.text,image: _imageFile?.path,remark: remarkCtr.text,clientId: selected,
            );
        });
      },
    );
    setState(() {});
  }

  final picker= ImagePicker();
  File? _imageFile;
  File? panImage;
  File? gstImage;
  File? aadharImage;
  File? aadharBack;
  File? voterIdImage;
  File? voterIdBackImage;
  File? udyogIdImage;
  File? gstOne;
  File? gstTwo;


  String _dateValue = '';
  var dateFormate;

  String convertDateTimeDisplay(String date) {
    final DateFormat displayFormater = DateFormat('yyyy-MM-dd HH:mm:ss.SSS');
    final DateFormat serverFormater = DateFormat('yyyy-MM-dd');
    final DateTime displayDate = displayFormater.parse(date);
    final String formatted = serverFormater.format(displayDate);
    return formatted;
  }

  Future _selectDate1() async {
    DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1950),
        lastDate: DateTime.now(),
        builder: (BuildContext context, Widget? child) {
          return Theme(
            data: ThemeData.light().copyWith(
                primaryColor: colors.primary,
                // accentColor: Colors.black,
                colorScheme: ColorScheme.light(primary: colors.primary),
                buttonTheme:
                ButtonThemeData(textTheme: ButtonTextTheme.accent)),
            child: child!,
          );
        });
    if (picked != null)
      setState(() {
        String yourDate = picked.toString();
        _dateValue = convertDateTimeDisplay(yourDate);
        dateFormate = DateFormat("dd/MM/yyyy").format(DateTime.parse(_dateValue ?? ""));
      });
    setState(() {
      doBCtr = TextEditingController(text: _dateValue);
    });
  }

  _showAnniversaryDatePicker() async {
    DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1960),
        lastDate: DateTime.now(),
        builder: (BuildContext context, Widget? child) {
          return Theme(
            data: ThemeData.light().copyWith(
                primaryColor: colors.primary,
                // accentColor: Colors.black,
                colorScheme: ColorScheme.light(primary: colors.primary),
                buttonTheme:
                ButtonThemeData(textTheme: ButtonTextTheme.accent)),
            child: child!,
          );
        });
    if (picked != null)
      setState(() {
        String yourDate = picked.toString();
        _dateValue = convertDateTimeDisplay(yourDate);
        dateFormate = DateFormat("dd/MM/yyyy").format(DateTime.parse(_dateValue ?? ""));
      });
    setState(() {
      doACtr = TextEditingController(text: _dateValue);
    });
  }


   getImageFromCamera(src) async {
    var pickedFile = await ImagePicker().pickImage(source: ImageSource.camera,maxHeight: 100,maxWidth: 100,imageQuality: 40);
    switch (src){
      case "aadhar": if(pickedFile != null){
        setState(() {
          aadharImage = File(pickedFile.path);
        });
      }
       break;
      case "aadhar_back": if(pickedFile != null){
        setState(() {
          aadharBack = File(pickedFile.path);
        });
      }
      break;
      case "voter_id": if(pickedFile != null){
        setState(() {
          voterIdImage = File(pickedFile.path);
        });
      }
      break;
      case "voter_id_back": if(pickedFile != null){
        setState(() {
          voterIdBackImage = File(pickedFile.path);
        });
      }
      break;
      case "pan": if(pickedFile != null){
        setState(() {
          panImage = File(pickedFile.path);
        });
      }
      break;
      case "gst_one": if(pickedFile != null){
        setState(() {
          gstImage = File(pickedFile.path);
        });
      }
      break;
      case "gst_two": if(pickedFile != null){
        setState(() {
          gstOne = File(pickedFile.path);
        });
      }
      break;
      case "gst_three": if(pickedFile != null){
        setState(() {
          gstTwo = File(pickedFile.path);
        });
      }
      break;
      default : if(pickedFile != null){
        setState(() {
          count++;
          _imageFile = File(pickedFile.path);
          imagePathList.add(_imageFile?.path ?? "");
          isImages = true;
               });
             }
           break;
       }
   }

  _getFromCameraPan() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera,maxHeight:100,maxWidth: 100,imageQuality: 40
    );
    if (pickedFile != null) {
      setState(() {
        panImage = File(pickedFile.path);
      });
      // Navigator.pop(context);
    }
  }

  _getFromCameraGst() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera,maxHeight: 100,maxWidth: 100,imageQuality: 40
    );
    if (pickedFile != null) {
      setState(() {
        gstImage = File(pickedFile.path);
      });
      // Navigator.pop(context);
    }
  }

  _getFromCameraGstOne() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera,maxHeight: 100,maxWidth: 100,imageQuality: 40
    );
    if (pickedFile != null) {
      setState(() {
        gstOne = File(pickedFile.path);
      });
      // Navigator.pop(context);
    }
  }

  _getFromCameraGstTwo() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera,maxHeight: 100,maxWidth: 100,imageQuality: 40
    );
    if (pickedFile != null) {
      setState(() {
        gstTwo = File(pickedFile.path);
      });
      // Navigator.pop(context);
    }
  }

  Future<void> getCurrentLoc() async {
    print("workingggg===========");
    LocationPermission permission;
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      print("checking permission here ${permission}");
      if (permission == LocationPermission.deniedForever) {
        return Future.error('Location Not Available');
      }
    }
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    // var loc = Provider.of<LocationProvider>(context, listen: false);
    latitude = position.latitude.toString();
    longitude = position.longitude.toString();
    setState(() {
      longitude_Global=latitude;
      lattitudee_Global=longitude;
    });

    List<Placemark> placemark = await placemarkFromCoordinates(
        double.parse(latitude!), double.parse(longitude!),
        localeIdentifier: "en");
    pinController.text = placemark[0].postalCode!;
    if (mounted) {
      setState(() {
        pinController.text = placemark[0].postalCode!;
        currentAddress.text =
        "${placemark[0].street}, ${placemark[0].subLocality}, ${placemark[0].locality}";
        latitude = position.latitude.toString();
        longitude = position.longitude.toString();
        // loc.lng = position.longitude.toString();
        //loc.lat = position.latitude.toString();
        setState(() {
          currentlocation_Global=currentAddress.text.toString();
        });
      });
      if (currentAddress.text == "" || currentAddress.text == null) {
      } else {
        setState(() {
          // navigateToPage();
        });
      }
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
     "date_of_birth" : doBCtr.text,
     "date_of_anniversary" : doACtr.text,
     "udyogid_number":udyogIdCtr.text,
     "route":routeCtr.text,
     "market":marketCtr.text,
     "landmark":landmarkCtr.text,
     'status':selected_Status.toString() ,
     'owner_name': ownernamecn.text,
     // 'departments': results.toString(),
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
     'create_by': '${CUR_USERID}',
     'voter_number': '${voterIdCtr.text}',
     'current_address': "${currentAddress.text}",
   });
   // print( aadharImage!.path.toString());
   // print("path" + _imageFile!.path.toString());
   // print("path" + gstImage!.path.toString());
   // print("path" + aadharBack!.path.toString());
   // print("path" + panImage!.path.toString());
   // print("path" + gstOne!.path.toString());
   // print("path" + gstTwo!.path.toString());
   // print("path" + voterIdImage!.path.toString());
   // print("path" + voterIdBackImage!.path.toString());
   print("parameter addd clientss${request.fields} ${request.files}");
   for (var i = 0; i < imagePathList.length; i++) {
     print('Imageeee $imagePathList');
     imagePathList.isEmpty
         ? null
         : request.files.add(await http.MultipartFile.fromPath(
         'photos[]', imagePathList[i]));
   }
  // request.files.add(await http.MultipartFile.fromPath('gst_img', gstImage?.path ?? ""));
  // request.files.add(await http.MultipartFile.fromPath('pan_img', panImage?.path ?? ""));
  // request.files.add(await http.MultipartFile.fromPath('aadhar_img', aadharImage?.path ?? ""));
  // request.files.add(await http.MultipartFile.fromPath('aadhar_back', aadharBack?.path ?? ""));
  // request.files.add(await http.MultipartFile.fromPath('gst_img_two', gstOne?.path ?? ""));
  // request.files.add(await http.MultipartFile.fromPath('gst_img_three', gstTwo?.path ?? ""));
  // request.files.add(await http.MultipartFile.fromPath('voter_id_front_image', voterIdImage?.path ?? ""));
  // request.files.add(await http.MultipartFile.fromPath('voter_id_back_image', voterIdBackImage?.path ?? ""));
  request.headers.addAll(headers);
   print("reaquestPAth" + request.files.toString());
  http.StreamedResponse response = await request.send();
  if (response.statusCode == 200) {
    var finalResponse = await response.stream.bytesToString();
    final jsonresponse = json.decode(finalResponse);
    Fluttertoast.showToast(msg: '${jsonresponse['message']}');
    Navigator.push(context, MaterialPageRoute(builder: (context) => Dashboard()));
  }
  else {
    print("reason" + response.reasonPhrase.toString());
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
            getImageFromCamera("image");
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

  String? formattedDate;
  String? timeData;

  convertDateTimeDispla() {
    var now = new DateTime.now();
    var formatter = new DateFormat('yyyy-MM-dd');
    formattedDate = formatter.format(now);
    print("datedetet$formattedDate"); // 2016-01-25
    timeData = DateFormat("hh:mm:ss a").format(DateTime.now());
    print("timeeeeeeeeee$timeData");
  }

  var pinController = TextEditingController();
  var currentAddress = TextEditingController();

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
              Positioned(
                bottom: 0,
                child: Container(
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: colors.primary),),
                  width:MediaQuery.of(context).size.width/2.8,
                  height: 65,
                  child: Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Date: ${formattedDate}", style: TextStyle(fontSize: 10, color: Colors.white),),
                        Text("Time: ${timeData}", style: TextStyle(fontSize: 10, color: Colors.white),),
                        Text("Location: ${currentAddress.text}", style: TextStyle(fontSize: 10, color: Colors.white),overflow: TextOverflow.ellipsis,maxLines: 2,)
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 0,
                right: 25,
                child: InkWell(
                  onTap: () {
                    setState(() {
                      imagePathList.remove(imagePathList[index]);
                      count--;
                    });
                  },
                  child: Icon(
                    Icons.cancel,
                    size: 30,
                    color: Colors.red.withOpacity(0.7),
                  ),
                ),
              )
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
                      shape: OutlineInputBorder(borderRadius: BorderRadius.circular(10),
                      ),
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
                    // Text("Department",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
                    // SizedBox(height: MediaQuery.of(context).size.height*.02,),
                    // Card(
                    //   elevation: 3,
                    //
                    //   shape: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                    //   child: Container(
                    //     // decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: Colors.white, border: Border.all(color: Colors.black)),
                    //     height: 56,
                    //     width: MediaQuery.of(context).size.width/1.1,
                    //     child: Padding(
                    //       padding: const EdgeInsets.only(top: 0, left: 10, bottom: 2, right: 10),
                    //       child: select(),
                    //     ),
                    //   ),
                    // ),
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
                            stateindex = getListModel!.data!.states!.indexWhere((element) => element.id == selected_State);
                            // getListModel?.data?.states?.map((items) {
                            //   if(items.id == newValue) {
                            //     cities = items.cities;
                            //   }
                            // });
                            var name = print("aaaaaaaaaaaaaaaaaaaaaaa${selected_State}");
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
                            nwIndex = getListModel!.data!.states![stateindex].cities!.indexWhere((element) => element.id == selectedDistrict);
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
                        maxLength: 6,
                          keyboardType: TextInputType.number,
                          controller: pincodecn,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please Enter pin code';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            counterText: "",
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
                          // validator: (value) {
                          //   if (value!.isEmpty||value.length<10) {
                          //     return 'Please Enter Your Mobile No';
                          //   }
                          //   return null;
                          // },
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
                          // validator: (value) {
                          //   if (value!.isEmpty||value.length<10) {
                          //     return 'Please Enter Your Whatsapp No';
                          //   }
                          //   return null;
                          // },
                          decoration: InputDecoration(
                              hintText: '',
                              counterText: "",
                              border: OutlineInputBorder(
                                  borderRadius:  BorderRadius.circular(10)))),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height*.02,),
                    Text("Date of Birth",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
                    SizedBox(height: MediaQuery.of(context).size.height*.02,),
                    Card(
                      elevation: 6,
                      shape: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                      child: TextFormField(
                        onTap: (){
                          _selectDate1();
                        },
                          keyboardType: TextInputType.none,
                          maxLength: 10,
                          controller: doBCtr,
                          // validator: (value) {
                          //   if (value!.isEmpty) {
                          //     return 'Please select Your Date of Birth';
                          //   }
                          //   return null;
                          // },
                          decoration: InputDecoration(
                              hintText: '',
                              counterText: "",
                              border: OutlineInputBorder(
                                  borderRadius:  BorderRadius.circular(10)))),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height*.02,),
                    Text("Date of Anniversary",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
                    SizedBox(height: MediaQuery.of(context).size.height*.02,),
                    Card(
                      elevation: 6,
                      shape: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                      child: TextFormField(
                        onTap: (){
                          _showAnniversaryDatePicker();
                        },
                          keyboardType: TextInputType.none,
                          maxLength: 10,
                          controller: doACtr,
                          // validator: (value) {
                          //   if (value!.isEmpty) {
                          //     return 'Please select Your Date of Anniversary';
                          //   }
                          //   return null;
                          // },
                          decoration: InputDecoration(
                              hintText: '',
                              counterText: "",
                              border: OutlineInputBorder(
                                  borderRadius:  BorderRadius.circular(10)))),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height*.02,),
                    Text("Route",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
                    SizedBox(height: MediaQuery.of(context).size.height*.02,),
                    Card(
                      elevation: 6,
                      shape: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                      child: TextFormField(
                          keyboardType: TextInputType.text,
                          // maxLength: 10,
                          controller: routeCtr,
                          // validator: (value) {
                          //   if (value!.isEmpty) {
                          //     return 'Please Enter Route';
                          //   }
                          //   return null;
                          // },
                          decoration: InputDecoration(
                              hintText: '',
                              counterText: "",
                              border: OutlineInputBorder(
                                  borderRadius:  BorderRadius.circular(10)))),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height*.02,),
                    Text("Market",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
                    SizedBox(height: MediaQuery.of(context).size.height*.02,),
                    Card(
                      elevation: 6,
                      shape: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                      child: TextFormField(
                          keyboardType: TextInputType.text,
                          // maxLength: 10,
                          controller: marketCtr,
                          // validator: (value) {
                          //   if (value!.isEmpty) {
                          //     return 'Please Enter market';
                          //   }
                          //   return null;
                          // },
                          decoration: InputDecoration(
                              hintText: '',
                              counterText: "",
                              border: OutlineInputBorder(
                                  borderRadius:  BorderRadius.circular(10)))),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height*.02,),
                    Text("Landmark",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
                    SizedBox(height: MediaQuery.of(context).size.height*.02,),
                    Card(
                      elevation: 6,
                      shape: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                      child: TextFormField(
                          keyboardType: TextInputType.text,
                          // maxLength: 10,
                          controller: landmarkCtr,
                          // validator: (value) {
                          //   if (value!.isEmpty) {
                          //     return 'Please Enter Landmark';
                          //   }
                          //   return null;
                          // },
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
                        // maxLength: 10,
                          keyboardType: TextInputType.text,
                          controller: panCtr,
                          // validator: (value) {
                          //   if (value!.isEmpty) {
                          //     return 'Please Enter Your Pan No';
                          //   }
                          //   return null;
                          // },
                          decoration: InputDecoration(
                              hintText: '',
                              counterText: "",
                              border: OutlineInputBorder(
                                  borderRadius:  BorderRadius.circular(10)))),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height*.02,),
                    ElevatedButton(
                      onPressed: () {
                        // pickImageDialogPan(context, 1);
                        _getFromCameraPan();
                       // getImageFromCamera("pan");
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
                          maxLength: 15,
                          controller: gstCtr,
                          // validator: (value) {
                          //   if (value!.isEmpty) {
                          //     return 'Please Enter Your Gst No';
                          //   }
                          //   return null;
                          // },
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
                         //pickImageDialogGst(context, 1);
                        _getFromCameraGst();
                        //getImageFromCamera("gst_one");
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
                        // pickImageDialogGstOne(context, 1);
                        _getFromCameraGstOne();
                       // getImageFromCamera("gst_two");
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
                        // pickImageDialogGstTwo(context, 1);
                       _getFromCameraGstTwo();
                      //  getImageFromCamera("gst_three");
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
                          // validator: (value) {
                          //   if (value!.isEmpty||value.length<12) {
                          //     return 'Please Enter Your Aadhaar No';
                          //   }
                          //   return null;
                          // },
                          decoration: InputDecoration(
                              hintText: '',
                              counterText: "",
                              border: OutlineInputBorder(borderRadius:  BorderRadius.circular(10)))),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height*.01),
                    ElevatedButton(
                      onPressed: () {
                        // pickImageDialogAdhar(context, 1);
                        // _getFromCameraAdhar();
                        getImageFromCamera("aadhar");
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
                        // pickImageDialogAdharBack(context, 1);
                        // _getFromCameraAdharBack();
                        getImageFromCamera("aadhar_back");
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
                    Text("Voter Id",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
                    SizedBox(height: MediaQuery.of(context).size.height*.02,),
                    Card(elevation: 6,
                      shape: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                      child: TextFormField(
                          keyboardType: TextInputType.number,
                          maxLength: 12,
                          controller: voterIdCtr,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please Enter Your VoterId No';
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
                        // pickImageDialogVoter(context, 1);
                        // _getFromCameraVoterId();
                        getImageFromCamera("voter_id");
                      }, child: Text("Add Voter Id Front"),
                    ),
                    Center(
                      child: Container(
                        height: 150,
                        width: 150,
                        decoration: BoxDecoration(border: Border.all(color: Colors.black),
                        ),
                        child:voterIdImage!=null? Image.file(voterIdImage!.absolute,fit: BoxFit.fill):
                        Center(child: Image.asset('assets/images/homelogo.png'),
                        ),
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height*.01),
                    ElevatedButton(
                      onPressed: () {
                        // pickImageDialogVoterBack(context, 1);
                        // _getFromCameraVoterIdBack();
                        getImageFromCamera("voter_id_back");
                      }, child: Text("Add Voter Id Back"),
                    ),
                    Center(
                      child: Container(
                        height: 150,
                        width: 150,
                        decoration: BoxDecoration(border: Border.all(color: Colors.black),
                        ),
                        child: voterIdBackImage !=null? Image.file(voterIdBackImage!.absolute,fit: BoxFit.fill):
                        Center(child: Image.asset('assets/images/homelogo.png'),
                        ),
                      ),
                    ),
                    Text("Udyog Id",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
                    SizedBox(height: MediaQuery.of(context).size.height*.02,),
                    Card(elevation: 6,
                      shape: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                      child: TextFormField(
                          keyboardType: TextInputType.text,
                          maxLength: 12,
                          controller: udyogIdCtr,
                          // validator: (value) {
                          //   if (value!.isEmpty) {
                          //     return 'Please Enter Your Udyog Id No';
                          //   }
                          //   return null;
                          // },
                          decoration: InputDecoration(
                              hintText: '',
                              counterText: "",
                              border: OutlineInputBorder(borderRadius:  BorderRadius.circular(10)))),
                    ),
                    // SizedBox(height: MediaQuery.of(context).size.height*.01),
                    // ElevatedButton(
                    //   onPressed: () {
                    //     // pickImageDialogUdyogId(context, 1);
                    //     _getFromCameraUdyogId();
                    //   }, child: Text("Add Udyog Id"),
                    // ),
                    // Center(
                    //   child: Container(
                    //     height: 150,
                    //     width: 150,
                    //     decoration: BoxDecoration(border: Border.all(color: Colors.black),
                    //     ),
                    //     child:udyogIdImage!=null? Image.file(udyogIdImage!.absolute,fit: BoxFit.fill):
                    //     Center(child: Image.asset('assets/images/homelogo.png'),
                    //     ),
                    //   ),
                    // ),
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
                        // validator: (value) {
                        //   if (value!.isEmpty) {
                        //     return 'Please Enter Credit limit';
                        //   }
                        //   return null;
                        // },
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
                          // print("hhhhhhhhhhhhhhhhhh");
                          // addClinets();
                               if(imagePathList.isEmpty || imagePathList.length == "" || imagePathList.length == null){
                                Fluttertoast.showToast(msg: "Please Select Image");
                              } else if(selected_Status == null || selected_District == null || selected_State == null ){
                                Fluttertoast.showToast(msg: "Please select Droup Down filleds");
                              } else if(_formKey.currentState!.validate()){
                                 // Fluttertoast.showToast(msg: "Please Fill All Fields");
                                 addClinets();
                               }
                            }, child: Text("Add", style: TextStyle(fontWeight: FontWeight.bold))),
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
