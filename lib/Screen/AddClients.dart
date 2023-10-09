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
  String? selected_District;
  int nwIndex = 0;
  String? selectedDistrict;
  int stateindex = 0;
  List<String> Staff=['Atul Gautam','Pretty Tomer','Sunil','yash',];
  // List<String> District=['Indore','Bhopal','Gwalior','Ujjain',];
  // List<String> State=['MP','Gujrat','Rajasthan','Utter pradesh',];


  final picker=ImagePicker();
  File? _imageFile;

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
                child:  Container(
                  child: ListTile(
                    title:  Text("Gallery"),
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
   print("parameter ${request.fields}");
  request.files.add(await http.MultipartFile.fromPath('photo', _imageFile?.path ?? ""));
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
                      child:  DropdownButtonFormField<String>(
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
                    SizedBox(height: MediaQuery.of(context).size.height*.02,),
                    Text("Staff",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
                    Card(elevation: 3,
                      shape: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                      child: DropdownButtonFormField<String>(
                        value: selected_stuff,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please Enter Staff';
                          } else {
                            return null;
                          }
                        },
                        onChanged: (newValue) {
                          setState(() {
                            selected_stuff= newValue;
                          });
                        },
                        items:Staff.map((item) {
                          return DropdownMenuItem(
                            value: item,
                            child: Text(item),
                          );
                        }).toList(),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                          hintText:
                          'Select Status',
                        ),
                      ),
                    ),
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
                            nwIndex = getListModel!.data!.states![stateindex].cities!.indexWhere((element) => element.id == selectedDistrict)!;
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
                    SizedBox(height: MediaQuery.of(context).size.height*.02,),
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
                              hintText: '',
                              border: OutlineInputBorder(borderRadius:  BorderRadius.circular(10),
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
                                  borderRadius:  BorderRadius.circular(15)))),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height*.02,),
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
                    SizedBox(height: MediaQuery.of(context).size.height*.02,),
                    Text("Customer Type",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
                    SizedBox(height: MediaQuery.of(context).size.height*.02,),
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
                              borderRadius:  BorderRadius.circular(10)),),
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height*.01,),
                    // Text("Deparment",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
                    // SizedBox(height: MediaQuery.of(context).size.height*.03,),
                    // Card(elevation: 6,
                    //   shape: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                    //   child: TextFormField(
                    //       keyboardType: TextInputType.text,
                    //       controller: department,
                    //       validator: (value) {
                    //         if (value!.isEmpty) {
                    //           return 'Please Enter Your Department';
                    //         }
                    //         return null;
                    //       },
                    //       decoration: InputDecoration(
                    //           hintText: '${widget.model?.}',
                    //           border: OutlineInputBorder(
                    //               borderRadius:  BorderRadius.circular(15)))),
                    // ),
                    // SizedBox(height: MediaQuery.of(context).size.height*.03,),
                    ElevatedButton(
                        onPressed: () {
                          pickImageDialog(context, 1);
                        }, child: Text("Select Image"),
                    ),
                    Center(
                      child: Container(
                        height: 150,
                        width: 150,
                        decoration: BoxDecoration(border: Border.all(color: Colors.black)),
                        child:_imageFile!=null? Image.file(_imageFile!.absolute,fit: BoxFit.fill,):
                        Center(child: Image.asset('assets/img.png'),
                        ),
                      ),
                    ),
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
