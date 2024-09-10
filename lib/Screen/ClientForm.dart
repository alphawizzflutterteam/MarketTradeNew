//
// import 'dart:convert';
// import 'dart:io';
//
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:http/http.dart'as http;
// import 'package:omega_employee_management/Screen/Dashboard.dart';
// import '../Model/ClientModel.dart';
// import '../Model/GetListModel.dart';
//
//
//
// class Client_form extends StatefulWidget {
//   final ClientsData? model;
//   Client_form({Key? key, this.model}) : super(key: key);
//
//   @override
//   State<Client_form> createState() => _Client_formState();
// }
//
// class _Client_formState extends State<Client_form> {
//
//   final picker=ImagePicker();
//   File? _imageFile;
//
//   _getFromGallery() async {
//     PickedFile? pickedFile = await ImagePicker().getImage(
//       source: ImageSource.gallery,
//     );
//     if (pickedFile != null) {
//       setState(() {
//         _imageFile = File(pickedFile.path);
//       });
//       Navigator.pop(context);
//     }
//   }
//
//   _getFromCamera() async {
//     PickedFile? pickedFile = await ImagePicker().getImage(
//       source: ImageSource.camera,
//     );
//     if (pickedFile != null) {
//       setState(() {
//         _imageFile = File(pickedFile.path);
//       });
//       Navigator.pop(context);
//     }
//   }
//
//
//   void _showImagePicker(BuildContext context) {
//     showModalBottomSheet(
//       context: context,
//       builder: (BuildContext context) {
//         return SafeArea(
//           child: Wrap(
//             children: <Widget>[
//               ListTile(
//                 leading: Icon(Icons.photo_library),
//                 title: Text('Gallery'),
//                 onTap: () {
//                   _getFromGallery();
//                   // _pickImage(ImageSource.gallery);
//                   Navigator.of(context).pop();
//                 },
//               ),
//               ListTile(
//                 leading: Icon(Icons.photo_camera),
//                 title: Text('Camera'),
//                 onTap: () {
//                   _getFromCamera();
//                   // _pickImage(ImageSource.camera);
//                   Navigator.of(context).pop();
//                 },
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
//   TextEditingController namecn = TextEditingController();
//   TextEditingController emailcn = TextEditingController();
//   TextEditingController mobile1cn= TextEditingController();
//   TextEditingController mobile2cn= TextEditingController();
//   TextEditingController whatsappcn= TextEditingController();
//   TextEditingController  department= TextEditingController();
//   TextEditingController  ownernamecn= TextEditingController();
//   TextEditingController addresscn= TextEditingController();
//   TextEditingController pincodecn= TextEditingController();
//   TextEditingController pancn= TextEditingController();
//   TextEditingController gstcn= TextEditingController();
//   TextEditingController aadharcn= TextEditingController();
//   TextEditingController creditcn= TextEditingController();
//   TextEditingController staffcn= TextEditingController();
//
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//   String? selected_Status;
//   String? selected_Staff;
//   String? selected_State;
//   String? selected_District;
//   String? selected_Customer;
//   // List<String> Staff=['Atul Gautam','Pretty Tomer','Sunil','yash',];
//   List<String> District=['Indore','Bhopal','Gwalior','Ujjain',];
//
//   void initState(){
//     super.initState();
//     fetchState();
//     namecn.text='${widget.model?.nameOfFirm}';
//     ownernamecn.text='${widget.model?.ownerName}';
//     addresscn.text='${widget.model?.address}';
//     pincodecn.text='${widget.model?.pinCode}';
//     emailcn.text='${widget.model?.email}';
//     mobile1cn.text='${widget.model?.mobileOne}';
//     mobile2cn.text='${widget.model?.mobileTwo}';
//     whatsappcn.text='${widget.model?.whatsappNumber}';
//     pancn.text='${widget.model?.pan}';
//     gstcn.text='${widget.model?.gst}';
//     aadharcn.text='${widget.model?.aadhar}';
//     creditcn.text='${widget.model?.creditLimit}';
//     selected_State='${widget.model?.state}';
//     selected_Status='${widget.model?.status}';
//     selected_Customer='${widget.model?.customerType}';
//     //selected_District='${widget.model?.district}';
//     // staffcn.text='${widget.model?.}';
//
//
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//     return  Scaffold(
//       appBar: AppBar(
//         title: Center(child: Text("Add Client")),
//       ),
//
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.only(left: 15,right: 15,top: 20),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//
//             children: [
//
//               Form(
//                   key:_formKey,
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text("Name Of Firm",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
//                       SizedBox(height: MediaQuery.of(context).size.height*.03,),
//                       Card(elevation: 6,
//                         shape: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
//                         child: TextFormField(
//                             keyboardType: TextInputType.text,
//                             controller: namecn,
//                             validator: (value) {
//                               if (value!.isEmpty) {
//                                 // return null;
//                               }
//
//                             },
//
//                             decoration: InputDecoration(
//                                 hintText: 'hfg',
//
//                                 border: OutlineInputBorder(
//                                     borderRadius:  BorderRadius.circular(15)))),
//                       ),
//                       SizedBox(height: MediaQuery.of(context).size.height*.03,),
//                       Text("Status",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
//                       SizedBox(height: MediaQuery.of(context).size.height*.03,),
//                       Card(elevation: 6,
//                         shape: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
//
//                         child: DropdownButtonFormField<String>(
//
//
//                           value: selected_Status,
//                           validator: (value) {
//                             if (value == null || value.isEmpty) {
//                             } else {
//                               return null;
//                             }
//                           },
//
//                           onChanged: (newValue) {
//                             setState(() {
//                               selected_Status= newValue;
//
//                             });
//                           },
//                           items:getList?.data?.clientStatus?.map((items) {
//                             return DropdownMenuItem(
//                               value: items.id,
//                               child: Text(items.name.toString()),
//                             );
//                           }).toList(),
//                           decoration: InputDecoration(
//                             border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
//                             hintText:
//                             'Select Status',
//                           ),
//                         ),
//                       ),
//                       SizedBox(height: MediaQuery.of(context).size.height*.03,),
//                       Text("Staff",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
//                       SizedBox(height: MediaQuery.of(context).size.height*.03,),
//                       Card(elevation: 6,
//                         shape: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
//                         child: TextFormField(
//                             keyboardType: TextInputType.text,
//                             controller: staffcn,
//                             validator: (value) {
//                               if (value!.isEmpty) {
//                                 // return null;
//                               }
//                             },
//                             decoration: InputDecoration(
//                                 hintText: 'hfg',
//                                 border: OutlineInputBorder(
//                                     borderRadius:  BorderRadius.circular(15)))),
//                       ),
//                       SizedBox(height: MediaQuery.of(context).size.height*.03,),
//                       Text("Owner Name",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
//                       SizedBox(height: MediaQuery.of(context).size.height*.03,),
//                       Card(elevation: 6,
//                         shape: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
//                         child: TextFormField(
//                             keyboardType: TextInputType.text,
//                             controller: ownernamecn,
//                             validator: (value) {
//                               if (value!.isEmpty) {
//                               }
//                               return null;
//                             },
//
//                             decoration: InputDecoration(
//                                 hintText: 'fhhhd',
//
//                                 border: OutlineInputBorder(
//                                     borderRadius:  BorderRadius.circular(15)))),
//                       ),
//                       SizedBox(height: MediaQuery.of(context).size.height*.03,),
//                       Text("Address",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
//                       SizedBox(height: MediaQuery.of(context).size.height*.03,),
//                       Card(elevation: 6,
//                         shape: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
//                         child: TextFormField(
//                             keyboardType: TextInputType.text,
//                             controller: addresscn,
//                             validator: (value) {
//                               if (value!.isEmpty) {
//                               }
//                               return null;
//                             },
//                             decoration: InputDecoration(
//                                 hintText: 'fhhhd',
//
//                                 border: OutlineInputBorder(
//                                     borderRadius:  BorderRadius.circular(15)))),
//                       ),
//                       SizedBox(height: MediaQuery.of(context).size.height*.03,),
//                       Text("State",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
//                       SizedBox(height: MediaQuery.of(context).size.height*.03,),
//                       // Card(elevation: 6,
//                       //   shape: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
//                       //   child: DropdownButtonFormField<String>(
//                       //     value: selected_State,
//                       //     validator: (value) {
//                       //       if (value == null || value.isEmpty) {
//                       //       } else {
//                       //         return null;
//                       //       }
//                       //     },
//                       //     onChanged: (newValue) {
//                       //       setState(() {
//                       //         selected_State= newValue;
//                       //         selected_State=getList?.data?.states?[0].countryId;
//                       //       });
//                       //     },
//                       //     items:getList?.data?.states?.map((items) {
//                       //       return DropdownMenuItem(
//                       //         value: items.id,
//                       //         child: Text(items.name.toString()),
//                       //       );
//                       //     }).toList(),
//                       //     decoration: InputDecoration(
//                       //       border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
//                       //       hintText:
//                       //       '  Select State',
//                       //
//                       //     ),
//                       //   ),
//                       // ),
//                       SizedBox(height: MediaQuery.of(context).size.height*.03,),
//                       Text("District",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
//                       SizedBox(height: MediaQuery.of(context).size.height*.03,),
//                       Card(elevation: 6,
//                         shape: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
//                         child: DropdownButtonFormField<String>(
//                           value: selected_District,
//                           validator: (value) {
//                             if (value == null || value.isEmpty) {
//                             } else {
//                               return null;
//                             }
//                           },
//                           onChanged: (newValue) {
//                             setState(() {
//                               selected_District= newValue;
//                             });
//                           },
//                           items:District.map((item) {
//                             return DropdownMenuItem(
//                               value: item,
//                               child: Text(item),
//                             );
//                           }).toList(),
//                           decoration: InputDecoration(
//                             border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
//                             hintText:
//                             '  Select District',
//
//                           ),
//                         ),
//                       ),
//                       SizedBox(height: MediaQuery.of(context).size.height*.03,),
//                       Text("Pincode",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
//                       SizedBox(height: MediaQuery.of(context).size.height*.03,),
//                       Card(elevation: 6,
//                         shape: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
//                         child: TextFormField(
//                             keyboardType: TextInputType.number,
//                             controller: pincodecn,
//                             validator: (value) {
//                               if (value!.isEmpty) {
//                               }
//                               return null;
//                             },
//
//                             decoration: InputDecoration(
//                                 hintText: '452011',
//
//                                 border: OutlineInputBorder(
//                                     borderRadius:  BorderRadius.circular(15)))),
//                       ),
//                       SizedBox(height: MediaQuery.of(context).size.height*.03,),
//                       Text("Email",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
//                       SizedBox(height: MediaQuery.of(context).size.height*.03,),
//                       Card(elevation: 6,
//                         shape: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
//                         child: TextFormField(
//                             keyboardType: TextInputType.emailAddress,
//                             controller: emailcn,
//                             validator: (value) {
//                               if (value!.isEmpty) {
//                               }
//                               return null;
//                             },
//
//                             decoration: InputDecoration(
//                                 hintText: 'hfg@gmail.com',
//
//                                 border: OutlineInputBorder(
//                                     borderRadius:  BorderRadius.circular(15)))),
//                       ),
//                       SizedBox(height: MediaQuery.of(context).size.height*.03,),
//                       Text("Mobile 1",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
//                       SizedBox(height: MediaQuery.of(context).size.height*.03,),
//                       Card(elevation: 6,
//                         shape: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
//                         child: TextFormField(
//                             keyboardType: TextInputType.number,
//                             maxLength: 10,
//                             controller: mobile1cn,
//                             validator: (value) {
//                               if (value!.isEmpty||value.length<10) {
//                               }
//                               return null;
//                             },
//
//                             decoration: InputDecoration(
//                                 hintText: '9854648544',
//
//                                 counterText: "",
//                                 border: OutlineInputBorder(
//                                     borderRadius:  BorderRadius.circular(15)))),
//                       ),
//                       SizedBox(height: MediaQuery.of(context).size.height*.03,),
//                       Text("Mobile 2",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
//                       SizedBox(height: MediaQuery.of(context).size.height*.03,),
//                       Card(elevation: 6,
//                         shape: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
//                         child: TextFormField(
//                             keyboardType: TextInputType.number,
//                             maxLength: 10,
//                             controller: mobile2cn,
//                             validator: (value) {
//                               if (value!.isEmpty||value.length<10) {
//                               }
//                               return null;
//                             },
//
//                             decoration: InputDecoration(
//                                 hintText: '9854648544',
//
//                                 counterText: "",
//                                 border: OutlineInputBorder(
//                                     borderRadius:  BorderRadius.circular(15)))),
//                       ),
//                       SizedBox(height: MediaQuery.of(context).size.height*.03,),
//                       Text("Whatsapp Number",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
//                       SizedBox(height: MediaQuery.of(context).size.height*.03,),
//                       Card(elevation: 6,
//                         shape: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
//                         child: TextFormField(
//                             keyboardType: TextInputType.number,
//                             maxLength: 10,
//                             controller: whatsappcn,
//                             validator: (value) {
//                               if (value!.isEmpty||value.length<10) {
//                               }
//                               return null;
//                             },
//
//                             decoration: InputDecoration(
//                                 hintText: '9854648544',
//
//                                 counterText: "",
//                                 border: OutlineInputBorder(
//                                     borderRadius:  BorderRadius.circular(15)))),
//                       ),
//                       SizedBox(height: MediaQuery.of(context).size.height*.03,),
//                       Text("Pan",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
//                       SizedBox(height: MediaQuery.of(context).size.height*.03,),
//                       Card(elevation: 6,
//                         shape: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
//                         child: TextFormField(
//                             keyboardType: TextInputType.text,
//
//                             controller: pancn,
//                             validator: (value) {
//                               if (value!.isEmpty) {
//                               }
//                               return null;
//                             },
//                             decoration: InputDecoration(
//                                 hintText: '4545385838',
//                                 counterText: "",
//                                 border: OutlineInputBorder(
//                                     borderRadius:  BorderRadius.circular(15)))),
//                       ),
//                       SizedBox(height: MediaQuery.of(context).size.height*.03,),
//                       Text("GST",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
//                       SizedBox(height: MediaQuery.of(context).size.height*.03),
//                       Card(elevation: 6,
//                         shape: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
//                         child: TextFormField(
//                             keyboardType: TextInputType.text,
//
//                             controller: gstcn,
//                             validator: (value) {
//                               if (value!.isEmpty) {
//                               }
//                               return null;
//                             },
//
//                             decoration: InputDecoration(
//                                 hintText: '6565',
//
//                                 counterText: "",
//                                 border: OutlineInputBorder(
//                                     borderRadius:  BorderRadius.circular(15)))),
//                       ),
//                       SizedBox(height: MediaQuery.of(context).size.height*.03,),
//                       Text("Aadhaar",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
//                       SizedBox(height: MediaQuery.of(context).size.height*.03,),
//                       Card(elevation: 6,
//                         shape: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
//                         child: TextFormField(
//                             keyboardType: TextInputType.number,
//                             maxLength: 12,
//                             controller: aadharcn,
//                             validator: (value) {
//                               if (value!.isEmpty||value.length<12) {
//                               }
//                               return null;
//                             },
//
//                             decoration: InputDecoration(
//                                 hintText: '57687375747567',
//
//                                 counterText: "",
//                                 border: OutlineInputBorder(
//                                     borderRadius:  BorderRadius.circular(15)))),
//                       ),
//                       SizedBox(height: MediaQuery.of(context).size.height*.03,),
//                       Text("Customer Type",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
//                       SizedBox(height: MediaQuery.of(context).size.height*.03,),
//                       Card(elevation: 6,
//                         shape: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
//                         child: DropdownButtonFormField<String>(
//                           value: selected_Customer,
//                           validator: (value) {
//                             if (value == null || value.isEmpty) {
//                             } else {
//                               return null;
//                             }
//                           },
//                           onChanged: (newValue) {
//                             setState(() {
//                               selected_Customer= newValue;
//                             });
//                           },
//                           items:getList?.data?.customerType?.map((items) {
//                             return DropdownMenuItem(
//                               value: items.id,
//                               child: Text(items.name.toString()),
//                             );
//                           }).toList(),
//                           decoration: InputDecoration(
//                             border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
//                             hintText:
//                             'Select Customer Type',
//                           ),
//                         ),
//                       ),
//                       SizedBox(height: MediaQuery.of(context).size.height*.03,),
//                       Text("Credit limit",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
//                       SizedBox(height: MediaQuery.of(context).size.height*.03,),
//                       Card(elevation: 6,
//                         shape: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
//                         child: TextFormField(
//                             keyboardType: TextInputType.text,
//                             controller: creditcn,
//                             validator: (value) {
//                               if (value!.isEmpty) {
//                               }
//                               return null;
//                             },
//                             decoration: InputDecoration(
//                                 hintText: '999999999.99',
//                                 border: OutlineInputBorder(
//                                     borderRadius:  BorderRadius.circular(15)))),
//                       ),
//                       SizedBox(height: MediaQuery.of(context).size.height*.03,),
//                       ElevatedButton(onPressed: (){
//                         _showImagePicker(context);
//                       }, child: Text("Select Image")),
//                       Center(
//                         child: Container(
//                             height: 150,
//                             width: 150,
//                             decoration: BoxDecoration(border: Border.all(color: Colors.black)),
//                             child:_imageFile!=null? Image.file(_imageFile!.absolute,fit: BoxFit.fill,):
//                             //    Center(child: Image.asset('assets/img.png')),),
//                             Image.network('${widget.model?.customerType}')
//                         ),
//                       )
//                     ],
//                   )
//               ),
//               SizedBox(height: MediaQuery.of(context).size.height*.03,),
//               Row(
//                 children: [
//                   SizedBox(width: MediaQuery.of(context).size.width*.02,),
//                   ElevatedButton(style: ElevatedButton.styleFrom(primary: Colors.green),
//                       onPressed: (){
//                         if(_formKey.currentState!.validate()){
//                           update();
//                         }
//                       }, child: Text("Update"))
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   GetListModel? getList;
//   Future<void> fetchState() async {
//     var headers = {
//       'Cookie': 'ci_session=87296a4980f29999f28fd3ac8756e4f69277cda7'
//     };
//     var request = http.MultipartRequest('POST', Uri.parse('https://developmentalphawizz.com/rename_market_track/app/v1/api/get_lists'));
//
//     request.headers.addAll(headers);
//
//     http.StreamedResponse response = await request.send();
//     if (response.statusCode == 200) {
//       var result=await response.stream.bytesToString();
//       var finalresult = GetListModel.fromJson(json.decode(result));
//       setState(() {
//         getList=finalresult;
//       });
//     }
//     else {
//       print(response.reasonPhrase);
//     }
//   }
//
//
//   Future<void> update() async {
//     var headers = {
//       'Cookie': 'ci_session=7e079301704afa2c89541d74dff4365aadc746ac'
//     };
//     var request = http.MultipartRequest('POST', Uri.parse('https://developmentalphawizz.com/rename_market_track/app/v1/api/add_new_client'));
//     request.fields.addAll({
//       'user_id': '2',
//       'name_of_firm': namecn.text,
//       'status':selected_Status.toString() ,
//       'owner_name': ownernamecn.text,
//       'address': addresscn.text,
//       'district': '2',
//       'pin_code': pincodecn.text,
//       'state': selected_State.toString(),
//       'mobile_one': mobile1cn.text,
//       'mobile_two': mobile2cn.text,
//       'whatsapp_number': whatsappcn.text,
//       'email': emailcn.text,
//       'pan': pancn.text,
//       'gst': gstcn.text,
//       'aadhar': aadharcn.text,
//       'customer_type': selected_Customer.toString(),
//       'credit_limit': creditcn.text,
//       'lat': '22.76975',
//       'lng': '76.57556',
//       // "id": "${getLi}"
//     });
//
//     request.headers.addAll(headers);
//
//     http.StreamedResponse response = await request.send();
//
//     if (response.statusCode == 200) {
//       var result=await response.stream.bytesToString();
//       var finalresult=jsonDecode(result);
//       if(finalresult['error']==false){
//         Fluttertoast.showToast(msg: finalresult['message']);
//         Navigator.push(context, MaterialPageRoute(builder: (context) => Dashboard(),));
//       }
//       else{
//         Fluttertoast.showToast(msg: finalresult['message']);
//       }
//     }
//     else {
//       print(response.reasonPhrase);
//     }
//
//   }
// }
//

import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:omega_employee_management/Helper/String.dart';
import 'package:omega_employee_management/Screen/Dashboard.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Helper/Color.dart';
import '../Model/ClientModel.dart';
import '../Model/GetListModel.dart';
import 'Add_Address.dart';

class Client_form extends StatefulWidget {
  final ClientsData? model;
  const Client_form({Key? key, this.model}) : super(key: key);

  @override
  State<Client_form> createState() => _Client_formState();
}

int count = 0;

class _Client_formState extends State<Client_form> {
  final picker = ImagePicker();
  File? _imageFile;

  Future<void> _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(
        source: source, maxHeight: 400, maxWidth: 400, imageQuality: 50);
    if (pickedImage != null) {
      setState(() {
        _imageFile = File(pickedImage.path);
        imagePathList.add(_imageFile?.path ?? "");
      });
    }
  }

  // void _showImagePicker(BuildContext context) {
  //   showModalBottomSheet(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return SafeArea(
  //         child: Wrap(
  //           children: <Widget>[
  //             ListTile(
  //               leading: const Icon(Icons.photo_library),
  //               title: const Text('Gallery'),
  //               onTap: () {
  //                 _pickImage(ImageSource.gallery);
  //                 Navigator.of(context).pop();
  //               },
  //             ),
  //             ListTile(
  //               leading: const Icon(Icons.photo_camera),
  //               title: const Text('Camera'),
  //               onTap: () {
  //                 _pickImage(ImageSource.camera);
  //                 Navigator.of(context).pop();
  //               },
  //             ),
  //           ],
  //         ),
  //       );
  //     },
  //   );
  // }

  TextEditingController namecn = TextEditingController();
  TextEditingController emailcn = TextEditingController();
  TextEditingController mobile1cn = TextEditingController();
  TextEditingController mobile2cn = TextEditingController();
  TextEditingController whatsappcn = TextEditingController();
  TextEditingController department = TextEditingController();
  TextEditingController ownernamecn = TextEditingController();
  TextEditingController addresscn = TextEditingController();
  TextEditingController pincodecn = TextEditingController();
  TextEditingController pancn = TextEditingController();
  TextEditingController gstcn = TextEditingController();
  TextEditingController aadharcn = TextEditingController();
  TextEditingController voterCtr = TextEditingController();
  TextEditingController creditcn = TextEditingController();
  TextEditingController staffcn = TextEditingController();
  TextEditingController udyogIdCtr = TextEditingController();
  TextEditingController doBCtr = TextEditingController();
  TextEditingController doACtr = TextEditingController();
  TextEditingController routeCtr = TextEditingController();
  TextEditingController marketCtr = TextEditingController();
  TextEditingController landmarkCtr = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? selected_Status;
  String? selected_Staff;
  String? selected_State;
  String? selected_District;
  String? selected_Customer;
  var stateId;
  int nwIndex = 0;
  var cityId;
  int stateindex = 0;
  String? selectedState;
  String? selectedDistrict;

  // List<String> Staff=['Atul Gautam','Pretty Tomer','Sunil','yash',];
  List<String> District = [
    'Indore',
    'Bhopal',
    'Gwalior',
    'Ujjain',
  ];

  @override
  void initState() {
    super.initState();
    getState();
    fetchState();
    getCurrentLoc();
    convertDateTimeDispla();
    print(
        "statusss=====${widget.model?.status} id is${widget.model?.id}===========");
    namecn.text = '${widget.model?.nameOfFirm}';
    ownernamecn.text = '${widget.model?.ownerName}';
    addresscn.text = '${widget.model?.address}';
    pincodecn.text = '${widget.model?.pinCode}';
    emailcn.text = '${widget.model?.email}';
    mobile1cn.text = '${widget.model?.mobileOne}';
    mobile2cn.text = '${widget.model?.mobileTwo}';
    whatsappcn.text = '${widget.model?.whatsappNumber}';
    pancn.text = '${widget.model?.pan}';
    gstcn.text = '${widget.model?.gst}';
    aadharcn.text = '${widget.model?.aadhar}';
    creditcn.text = '${widget.model?.creditLimit}';
    doBCtr.text = '${widget.model?.dateOfBirth}';
    doACtr.text = '${widget.model?.dateOfAnniversary}';
    routeCtr.text = '${widget.model?.route}';
    marketCtr.text = '${widget.model?.market}';
    landmarkCtr.text = '${widget.model?.landmark}';
    udyogIdCtr.text = '${widget.model?.udyogidNumber}';
    selected_Status = '${widget.model?.status}';
    selected_Customer = '${widget.model?.customerType}';
    selected_State = '${widget.model?.state}';
    // panImage!.path =  "${widget.model?.panImg}" ?? "";
    selected_District = '${widget.model?.district}';
    voterCtr.text = '${widget.model?.voterNumber}';
    // staffcn.text='${widget.model?.}';
    // stateId='${widget.model?.state}';
    getImages();
  }

  getImages() {
    int? length1 = widget.model?.photo?.length;
    for (int i = 0; i < length1!; i++)
      apiImages.add(widget.model?.photo![i] ?? "");
  }

  File? panImage;
  File? gstImage;
  File? aadharImage;
  File? aadharBack;
  File? gstOne;
  File? gstTwo;
  File? voterIdImage;
  File? voterIdBackImage;

  void pickImageDialog(BuildContext context, int i) async {
    return await showDialog<void>(
      context: context,
      // barrierDismissible: barrierDismissible, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(6),
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              // InkWell(
              //   onTap: () async {
              //     _getFromGallery();
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
                  _getFromCamera();
                },
                child: Container(
                  child: ListTile(
                      title: Text("Camera"),
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

  void pickImageDialogPan(BuildContext context, int i) async {
    return await showDialog<void>(
      context: context,
      // barrierDismissible: barrierDismissible, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(6),
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
                      title: Text("Camera"),
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

  void pickImageDialogGst(BuildContext context, int i) async {
    return await showDialog<void>(
      context: context,
      // barrierDismissible: barrierDismissible, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(6),
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              // InkWell(
              //   onTap: () async {
              //     _getFromGalleryGst();
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
                  _getFromCameraGst();
                },
                child: Container(
                  child: ListTile(
                      title: Text("Camera"),
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

  void pickImageDialogGstOne(BuildContext context, int i) async {
    return await showDialog<void>(
      context: context,
      // barrierDismissible: barrierDismissible, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(6),
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              // InkWell(
              //   onTap: () async {
              //     _getFromGalleryGst();
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
                  _getFromCameraGstOne();
                },
                child: Container(
                  child: ListTile(
                      title: Text("Camera"),
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

  void pickImageDialogGstTwo(BuildContext context, int i) async {
    return await showDialog<void>(
      context: context,
      // barrierDismissible: barrierDismissible, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(6),
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              // InkWell(
              //   onTap: () async {
              //     _getFromGalleryGst();
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
                  _getFromCameraGstTwo();
                },
                child: Container(
                  child: ListTile(
                      title: Text("Camera"),
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

  void pickImageDialogAdhar(BuildContext context, int i) async {
    return await showDialog<void>(
      context: context,
      // barrierDismissible: barrierDismissible, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(6),
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
                      title: Text("Camera"),
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

  void pickImageDialogAdharBack(BuildContext context, int i) async {
    return await showDialog<void>(
      context: context,
      // barrierDismissible: barrierDismissible, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(6),
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
                  getFromCameraAdharBack();
                },
                child: Container(
                  child: ListTile(
                      title: Text("Camera"),
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
      //  Navigator.pop(context);
    }
  }

  _getFromCamera() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
        source: ImageSource.camera,
        maxHeight: 400,
        maxWidth: 400,
        imageQuality: 50);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
      //   Navigator.pop(context);
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
      //  Navigator.pop(context);
    }
  }

  _getFromCameraPan() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
        source: ImageSource.camera,
        maxHeight: 400,
        maxWidth: 400,
        imageQuality: 50);
    if (pickedFile != null) {
      setState(() {
        panImage = File(pickedFile.path);
      });
      //Navigator.pop(context);
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
      //   Navigator.pop(context);
    }
  }

  _getFromCameraGst() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
        source: ImageSource.camera,
        maxHeight: 640,
        maxWidth: 400,
        imageQuality: 80);
    if (pickedFile != null) {
      setState(() {
        gstImage = File(pickedFile.path);
      });
      // Navigator.pop(context);
    }
  }

  _getFromCameraGstOne() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
        source: ImageSource.camera,
        maxHeight: 640,
        maxWidth: 400,
        imageQuality: 80);
    if (pickedFile != null) {
      setState(() {
        gstOne = File(pickedFile.path);
      });
      // Navigator.pop(context);
    }
  }

  _getFromCameraGstTwo() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
        source: ImageSource.camera,
        maxHeight: 640,
        maxWidth: 400,
        imageQuality: 80);
    if (pickedFile != null) {
      setState(() {
        gstTwo = File(pickedFile.path);
      });
      //  Navigator.pop(context);
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
      // Navigator.pop(context);
    }
  }

  _getFromCameraAdhar() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
        source: ImageSource.camera,
        maxHeight: 640,
        maxWidth: 400,
        imageQuality: 80);
    if (pickedFile != null) {
      setState(() {
        aadharImage = File(pickedFile.path);
      });
      //  Navigator.pop(context);
    }
  }

  getFromCameraAdharBack() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
        source: ImageSource.camera,
        maxHeight: 640,
        maxWidth: 400,
        imageQuality: 80);
    if (pickedFile != null) {
      setState(() {
        aadharBack = File(pickedFile.path);
      });
      //  Navigator.pop(context);
    }
  }

  _getFromCameraVoteIdFront() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
        source: ImageSource.camera,
        maxHeight: 640,
        maxWidth: 400,
        imageQuality: 80);
    if (pickedFile != null) {
      setState(() {
        voterIdImage = File(pickedFile.path);
      });
      // Navigator.pop(context);
    }
  }

  _getFromCameraVoterIdBack() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
        source: ImageSource.camera,
        maxHeight: 640,
        maxWidth: 400,
        imageQuality: 80);
    if (pickedFile != null) {
      setState(() {
        voterIdBackImage = File(pickedFile.path);
      });
      // Navigator.pop(context);
    }
  }

  _showBirthDatePicker() async {
    var selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1970),
      lastDate: DateTime.now(),
    );
    if (selectedDate != null) {
      setState(() {
        doBCtr.text =
            "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}";
      });
    }
  }

  _showAnniversaryDatePicker() async {
    var selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1970),
      lastDate: DateTime.now(),
    );
    if (selectedDate != null) {
      setState(() {
        doACtr.text =
            "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}";
      });
    }
  }

  GetListModel? getListModel;
  getState() async {
    var headers = {
      'Cookie': 'ci_session=81cd74eabcb3683af924161dd1dcd833b8da1ff6'
    };
    var request =
        http.MultipartRequest('GET', Uri.parse(getListsApi.toString()));
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      String str = await response.stream.bytesToString();
      var result = json.decode(str);
      var finalResponse = GetListModel.fromJson(result);
      setState(() {
        getListModel = finalResponse;
      });
      // if(stateId != null){
      //   for(var state in getListModel!.data!.states!){
      //     if(state.id == stateId){
      //       this.selected_State = state.name;
      //     }
      //   }
      // }
    } else {
      print(response.reasonPhrase);
    }
  }

  List imagePathList = [];
  List apiImages = [];
  bool isImages = false;

  Widget buildGridView() {
    return Container(
      height: 170,
      child: GridView.builder(
        itemCount: apiImages.length,
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (BuildContext context, int index) {
          return Stack(
            children: [
              InkWell(
                onTap: () {
                  if (apiImages[index] != null) {
                    final imageProvider =
                        Image.network(apiImages[index] ?? '').image;
                    showImageViewer(context, imageProvider,
                        onViewerDismissed: () {
                      print("dismissed");
                    });
                  }
                },
                onLongPress: () {
                  // if (voterIdBackImage != null)
                  // Fluttertoast.showToast(
                  // msg: 'Already saved in gallery');
                  if (apiImages[index] != null)
                    showDilaogBox(apiImages[index] ?? "");
                },
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: colors.primary)),
                  width: MediaQuery.of(context).size.width / 2.8,
                  height: 170,
                  child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      child: Image.network(
                        '${apiImages[index]}',
                        fit: BoxFit.cover,
                      )),
                ),
              ),
              // Positioned(
              //   bottom: 0,
              //   child: Container(
              //     decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
              //       border: Border.all(color: colors.primary),),
              //     width:MediaQuery.of(context).size.width/2.8,
              //     height: 65,
              //     child: Padding(
              //       padding: const EdgeInsets.all(3.0),
              //       child: Column(
              //         crossAxisAlignment: CrossAxisAlignment.start,
              //         mainAxisAlignment: MainAxisAlignment.center,
              //         children: [
              //           Text("Date: ${formattedDate}", style: TextStyle(fontSize: 10, color: Colors.white),),
              //           Text("Time: ${timeData}", style: TextStyle(fontSize: 10, color: Colors.white),),
              //           Text("Location: ${currentAddress.text}", style: TextStyle(fontSize: 10, color: Colors.white),overflow: TextOverflow.ellipsis,maxLines: 2,)
              //         ],
              //       ),
              //     ),
              //   ),
              // ),
              Positioned(
                top: 0,
                right: 25,
                child: InkWell(
                  onTap: () {
                    setState(() {
                      apiImages.remove(apiImages[index]);
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
        elevation: 0,
        backgroundColor: colors.primary,
        centerTitle: true,
        title: Text(
          "Edit Client Form",
          style: TextStyle(fontSize: 15),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 15, right: 15, top: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Name Of Firm",
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .02,
                    ),
                    Card(
                      elevation: 6,
                      shape: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      child: TextFormField(
                          keyboardType: TextInputType.text,
                          controller: namecn,
                          validator: (value) {
                            if (value!.isEmpty) {
                              // return null;
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              hintText: 'name',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)))),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .02,
                    ),
                    const Text(
                      "Status",
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .02,
                    ),
                    Card(
                      elevation: 6,
                      shape: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      child: DropdownButtonFormField<String?>(
                        value: selected_Status,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                          } else {
                            return null;
                          }
                          return null;
                        },
                        onChanged: (newValue) {
                          setState(() {
                            selected_Status = newValue;
                          });
                        },
                        items: getList?.data?.clientStatus?.map((items) {
                          return DropdownMenuItem(
                            value: items.id,
                            child: Text(items.name.toString()),
                          );
                        }).toList(),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          hintText: 'Select Status',
                        ),
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * .02),
                    // const Text("Staff",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
                    // SizedBox(height: MediaQuery.of(context).size.height*.02,),
                    // Card(elevation: 6,
                    //   shape: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                    //   child: TextFormField(
                    //       keyboardType: TextInputType.text,
                    //       controller: staffcn,
                    //       validator: (value) {
                    //         if (value!.isEmpty) {
                    //           // return null;
                    //         }
                    //         return null;
                    //       },
                    //       decoration: InputDecoration(
                    //           hintText: 'hfg',
                    //           border: OutlineInputBorder(
                    //               borderRadius:  BorderRadius.circular(10)))),
                    // ),
                    // SizedBox(height: MediaQuery.of(context).size.height*.02,),
                    const Text(
                      "Owner Name",
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * .02),
                    Card(
                      elevation: 6,
                      shape: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      child: TextFormField(
                        keyboardType: TextInputType.text,
                        controller: ownernamecn,
                        validator: (value) {
                          if (value!.isEmpty) {}
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: 'name',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * .02),
                    // const Text("Departments",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
                    // SizedBox(height: MediaQuery.of(context).size.height*.02,),
                    // Card(
                    //   elevation: 3,
                    //   shape: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                    //   child: Container(
                    //     // decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: Colors.white, border: Border.all(color: Colors.black)),
                    //     height: 56,
                    //     width: MediaQuery.of(context).size.width/1.1,
                    //     child: Padding(
                    //       padding: const EdgeInsets.only(top: 0, left: 10, bottom: 2, right: 10),
                    //       child: SingleChildScrollView(
                    //         scrollDirection: Axis.horizontal,
                    //         child: Align(
                    //           alignment: Alignment.centerLeft,
                    //           child: Row (
                    //             crossAxisAlignment: CrossAxisAlignment.start,
                    //             children: results!.map((e) {
                    //               return Container(
                    //                 margin: const EdgeInsets.symmetric(horizontal: 2),
                    //                 padding: const EdgeInsets.symmetric(horizontal: 10),
                    //                 height: 30,
                    //                 decoration: BoxDecoration(
                    //                     borderRadius: BorderRadius.circular(10),
                    //                     color: colors.primary),
                    //                 child: Center(
                    //                   child: Text(
                    //                     e,
                    //                     style: TextStyle(color: Colors.white),
                    //                   ),
                    //                 ),
                    //               );
                    //             }).toList(),
                    //           ),
                    //         ),
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    // SizedBox(height: MediaQuery.of(context).size.height*.02,),
                    const Text(
                      "Address",
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .02,
                    ),
                    Card(
                      elevation: 6,
                      shape: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      child: TextFormField(
                        keyboardType: TextInputType.text,
                        controller: addresscn,
                        validator: (value) {
                          if (value!.isEmpty) {}
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: 'Address',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .02,
                    ),
                    Text(
                      "State",
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                    Card(
                      elevation: 3,
                      shape: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      child: DropdownButtonFormField<String>(
                        value: selected_State,
                        onChanged: (newValue) {
                          setState(() {
                            selected_State = newValue;
                            stateindex = getListModel!.data!.states!.indexWhere(
                                (element) => element.id == selected_State);
                            // getListModel?.data?.states?.map((items) {
                            //   if(items.id == newValue) {
                            //     cities = items.cities;
                            //   }
                            // });
                            var name = print("aaaaa ${selected_State}");
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
                    // SizedBox(height: MediaQuery.of(context).size.height*.02,),
                    // Text("District",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
                    // Card(elevation: 3,
                    //   shape: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                    //   child: DropdownButtonFormField<String>(
                    //     value: selected_District,
                    //     onChanged: (newValue) {
                    //       setState(() {
                    //         selected_District = newValue;
                    //         nwIndex = getListModel!.data!.states![stateindex].cities!.indexWhere((element) => element.id == selectedDistrict);
                    //         // print("current indexxx ${selected}");
                    //         // nwIndex = getListModel!.data!.states![stateindex].cities!.indexWhere((element) => element.id == selectedDistrict)!;
                    //         // currentIndex = selected;
                    //         // showTextField = true;
                    //       });
                    //     },
                    //     items: getListModel?.data?.states?[stateindex].cities?.map((items) {
                    //       return DropdownMenuItem(
                    //         value: items.id,
                    //         child: Text(items.city.toString()),
                    //       );
                    //     }).toList(),
                    //     decoration: InputDecoration(
                    //       contentPadding: EdgeInsets.only(top: 5, left: 10),
                    //       border: InputBorder.none,
                    //       hintText: 'Select District',
                    //     ),
                    //   ),
                    // ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .02,
                    ),
                    const Text(
                      "Pincode",
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .02,
                    ),
                    Card(
                      elevation: 6,
                      shape: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      child: TextFormField(
                          keyboardType: TextInputType.number,
                          controller: pincodecn,
                          validator: (value) {
                            if (value!.isEmpty) {}
                            return null;
                          },
                          decoration: InputDecoration(
                              hintText: '452011',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)))),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .02,
                    ),
                    const Text(
                      "Email",
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .02,
                    ),
                    Card(
                      elevation: 6,
                      shape: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15)),
                      child: TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        controller: emailcn,
                        validator: (value) {
                          if (value!.isEmpty) {}
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: 'hfg@gmail.com',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .02,
                    ),
                    const Text(
                      "Mobile 1",
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .02,
                    ),
                    Card(
                      elevation: 6,
                      shape: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        maxLength: 10,
                        controller: mobile1cn,
                        validator: (value) {
                          if (value!.isEmpty || value.length < 10) {}
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: '9854648544',
                          counterText: "",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .02,
                    ),
                    const Text(
                      "Mobile 2",
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .02,
                    ),
                    Card(
                      elevation: 6,
                      shape: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        maxLength: 10,
                        controller: mobile2cn,
                        // validator: (value) {
                        //   if (value!.isEmpty||value.length<10) {
                        //   }
                        //   return null;
                        // },

                        decoration: InputDecoration(
                          hintText: '9854648544',
                          counterText: "",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .02,
                    ),
                    const Text(
                      "Whatsapp Number",
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .02,
                    ),
                    Card(
                      elevation: 6,
                      shape: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        maxLength: 10,
                        controller: whatsappcn,
                        // validator: (value) {
                        //   if (value!.isEmpty||value.length<10) {
                        //     return "please enter whatsapp number";
                        //   }
                        //   return null;
                        // },
                        decoration: InputDecoration(
                          hintText: '9854648544',
                          counterText: "",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .02,
                    ),
                    const Text(
                      "Date of Birth",
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .02,
                    ),
                    Card(
                      elevation: 6,
                      shape: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      child: TextFormField(
                          onTap: _showBirthDatePicker,
                          keyboardType: TextInputType.none,
                          // maxLength: 10,
                          controller: doBCtr,
                          // validator: (value) {
                          //   if (value!.isEmpty) {
                          //     return "please select date of birth";
                          //   }
                          //   return null;
                          // },

                          decoration: InputDecoration(
                              hintText: '',
                              counterText: "",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)))),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .02,
                    ),
                    const Text(
                      "Date of Anniversary",
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .02,
                    ),
                    Card(
                      elevation: 6,
                      shape: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      child: TextFormField(
                          onTap: _showAnniversaryDatePicker,
                          keyboardType: TextInputType.none,
                          // maxLength: 10,
                          controller: doACtr,
                          // validator: (value) {
                          //   if (value!.isEmpty) {
                          //     return "please select date of anniversary";
                          //   }
                          //   return null;
                          // },

                          decoration: InputDecoration(
                              hintText: '',
                              counterText: "",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)))),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .02,
                    ),
                    const Text(
                      "Route",
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .02,
                    ),
                    Card(
                      elevation: 6,
                      shape: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      child: TextFormField(
                          keyboardType: TextInputType.text,
                          // maxLength: 10,
                          controller: routeCtr,
                          // validator: (value) {
                          //   if (value!.isEmpty) {
                          //     return "please enter route";
                          //   }
                          //   return null;
                          // },

                          decoration: InputDecoration(
                              hintText: '',
                              counterText: "",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)))),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .02,
                    ),
                    const Text(
                      "Market",
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .02,
                    ),
                    Card(
                      elevation: 6,
                      shape: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      child: TextFormField(
                          keyboardType: TextInputType.text,
                          // maxLength: 10,
                          controller: marketCtr,
                          decoration: InputDecoration(
                              hintText: '',
                              counterText: "",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)))),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .02,
                    ),
                    const Text(
                      "landmark",
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .02,
                    ),
                    Card(
                      elevation: 6,
                      shape: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      child: TextFormField(
                          keyboardType: TextInputType.text,
                          // maxLength: 10,
                          controller: landmarkCtr,
                          // validator: (value) {
                          //   if (value!.isEmpty) {
                          //     return "please enter landmark";
                          //   }
                          //   return null;
                          // },

                          decoration: InputDecoration(
                              hintText: '',
                              counterText: "",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)))),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .02,
                    ),
                    const Text(
                      "Udyog Id Number",
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .02,
                    ),
                    Card(
                      elevation: 6,
                      shape: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      child: TextFormField(
                          keyboardType: TextInputType.text,
                          maxLength: 19,
                          controller: udyogIdCtr,
                          // validator: (value) {
                          //   if (value!.isEmpty) {
                          //     return "please enter udyog Id ";
                          //   }
                          //   return null;
                          // },

                          decoration: InputDecoration(
                              hintText: '',
                              counterText: "",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)))),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .02,
                    ),
                    const Text(
                      "Pan",
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .02,
                    ),
                    Card(
                      elevation: 6,
                      shape: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      child: TextFormField(
                          keyboardType: TextInputType.text,
                          controller: pancn,
                          decoration: InputDecoration(
                              hintText: '4545385838',
                              counterText: "",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)))),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .02,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        // pickImageDialogPan(context, 1);
                        _getFromCameraPan();
                      },
                      child: Text("Select Pan"),
                    ),
                    Center(
                      child: Stack(children: [
                        InkWell(
                            child: Container(
                                height: 150,
                                width: 150,
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black)),
                                child: panImage != null
                                    ? Image.file(
                                        panImage!.absolute,
                                        fit: BoxFit.fill,
                                      )
                                    :
                                    //    Center(child: Image.asset('assets/img.png')),),
                                    Image.network(
                                        '${widget.model?.panImg}',
                                      )),
                            onTap: () {
                              if (panImage != null) {
                                final imageProvider =
                                    Image.file(panImage!).image;
                                showImageViewer(context, imageProvider,
                                    onViewerDismissed: () {
                                  print("dismissed");
                                });
                              } else if (widget.model?.panImg != null) {
                                final imageProvider =
                                    Image.network(widget.model?.panImg ?? '')
                                        .image;
                                showImageViewer(context, imageProvider,
                                    onViewerDismissed: () {
                                  print("dismissed");
                                });
                              }
                            },
                            onLongPress: () {
                              if (panImage != null)
                                Fluttertoast.showToast(
                                    msg: 'Already saved in gallery');
                              else if (widget.model?.panImg != null)
                                showDilaogBox(widget.model?.panImg ?? "");
                            }),
                        panImage != null
                            ? Positioned(
                                right: 2,
                                child: InkWell(
                                  onTap: () {
                                    panImage = null;
                                    setState(() {});
                                  },
                                  child: Icon(
                                    Icons.cancel,
                                    size: 30,
                                    color: Colors.red.withOpacity(0.7),
                                  ),
                                ),
                              )
                            : SizedBox()
                      ]),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .02,
                    ),
                    const Text(
                      "GST",
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .02,
                    ),
                    Card(
                      elevation: 6,
                      shape: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      child: TextFormField(
                          keyboardType: TextInputType.text,
                          controller: gstcn,
                          // validator: (value) {
                          //   if (value!.isEmpty) {
                          //   }
                          //   return null;
                          // },

                          decoration: InputDecoration(
                              hintText: '6565',
                              counterText: "",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)))),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * .01),
                    ElevatedButton(
                      onPressed: () {
                        // pickImageDialogGst(context, 1);
                        _getFromCameraGst();
                      },
                      child: Text("Select GST"),
                    ),
                    Center(
                      child: Stack(children: [
                        InkWell(
                            child: Container(
                                height: 150,
                                width: 150,
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black)),
                                child: gstImage != null
                                    ? Image.file(
                                        gstImage!.absolute,
                                        fit: BoxFit.fill,
                                      )
                                    :
                                    //    Center(child: Image.asset('assets/img.png')),),
                                    Image.network(
                                        '${widget.model?.gstImg}',
                                      )),
                            onTap: () {
                              if (gstImage != null) {
                                final imageProvider =
                                    Image.file(gstImage!).image;
                                showImageViewer(context, imageProvider,
                                    onViewerDismissed: () {
                                  print("dismissed");
                                });
                              } else if (widget.model?.gstImg != null) {
                                final imageProvider =
                                    Image.network(widget.model?.gstImg ?? '')
                                        .image;
                                showImageViewer(context, imageProvider,
                                    onViewerDismissed: () {
                                  print("dismissed");
                                });
                              }
                            },
                            onLongPress: () {
                              if (gstImage != null)
                                Fluttertoast.showToast(
                                    msg: 'Already saved in gallery');
                              else if (widget.model?.gstImg != null)
                                showDilaogBox(widget.model?.gstImg ?? "");
                            }),
                        gstImage != null
                            ? Positioned(
                                right: 2,
                                child: InkWell(
                                  onTap: () {
                                    gstImage = null;
                                    setState(() {});
                                  },
                                  child: Icon(
                                    Icons.cancel,
                                    size: 30,
                                    color: Colors.red.withOpacity(0.7),
                                  ),
                                ),
                              )
                            : SizedBox()
                      ]),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * .01),
                    ElevatedButton(
                      onPressed: () {
                        // pickImageDialogGstOne(context, 1);
                        _getFromCameraGstOne();
                      },
                      child: Text("Select GST One"),
                    ),
                    Center(
                      child: Stack(children: [
                        InkWell(
                            child: Container(
                                height: 150,
                                width: 150,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black),
                                ),
                                child: gstOne != null
                                    ? Image.file(gstOne!.absolute,
                                        fit: BoxFit.fill)
                                    : Image.network(
                                        '${widget.model?.gstImgTwo}',
                                      )),
                            onTap: () {
                              if (gstOne != null) {
                                final imageProvider = Image.file(gstOne!).image;
                                showImageViewer(context, imageProvider,
                                    onViewerDismissed: () {
                                  print("dismissed");
                                });
                              } else if (widget.model?.gstImgTwo != null) {
                                final imageProvider =
                                    Image.network(widget.model?.gstImgTwo ?? '')
                                        .image;
                                showImageViewer(context, imageProvider,
                                    onViewerDismissed: () {
                                  print("dismissed");
                                });
                              }
                            },
                            onLongPress: () {
                              if (gstOne != null)
                                Fluttertoast.showToast(
                                    msg: 'Already saved in gallery');
                              else if (widget.model?.gstImgTwo != null)
                                showDilaogBox(widget.model?.gstImgTwo ?? "");
                            }),
                        gstOne != null
                            ? Positioned(
                                right: 2,
                                child: InkWell(
                                  onTap: () {
                                    gstOne = null;
                                    setState(() {});
                                  },
                                  child: Icon(
                                    Icons.cancel,
                                    size: 30,
                                    color: Colors.red.withOpacity(0.7),
                                  ),
                                ),
                              )
                            : SizedBox()
                      ]),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * .01),
                    ElevatedButton(
                      onPressed: () {
                        // pickImageDialogGstTwo(context, 1);
                        _getFromCameraGstTwo();
                      },
                      child: Text("Select GST Two"),
                    ),
                    Center(
                      child: Stack(children: [
                        InkWell(
                            child: Container(
                                height: 150,
                                width: 150,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black),
                                ),
                                child: gstTwo != null
                                    ? Image.file(gstTwo!.absolute,
                                        fit: BoxFit.fill)
                                    : Image.network(
                                        '${widget.model?.gstImgThree}',
                                      )),
                            onTap: () {
                              if (gstTwo != null) {
                                final imageProvider = Image.file(gstTwo!).image;
                                showImageViewer(context, imageProvider,
                                    onViewerDismissed: () {
                                  print("dismissed");
                                });
                              } else if (widget.model?.gstImgThree != null) {
                                final imageProvider = Image.network(
                                        widget.model?.gstImgThree ?? '')
                                    .image;
                                showImageViewer(context, imageProvider,
                                    onViewerDismissed: () {
                                  print("dismissed");
                                });
                              }
                            },
                            onLongPress: () {
                              if (gstTwo != null)
                                Fluttertoast.showToast(
                                    msg: 'Already saved in gallery');
                              else if (widget.model?.gstImgThree != null)
                                showDilaogBox(widget.model?.gstImgThree ?? "");
                            }),
                        gstTwo != null
                            ? Positioned(
                                right: 2,
                                child: InkWell(
                                  onTap: () {
                                    gstTwo = null;
                                    setState(() {});
                                  },
                                  child: Icon(
                                    Icons.cancel,
                                    size: 30,
                                    color: Colors.red.withOpacity(0.7),
                                  ),
                                ),
                              )
                            : SizedBox()
                      ]),
                    ),
                    const Text(
                      "Aadhaar",
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .02,
                    ),
                    Card(
                      elevation: 6,
                      shape: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15)),
                      child: TextFormField(
                          keyboardType: TextInputType.number,
                          maxLength: 12,
                          controller: aadharcn,
                          // validator: (value) {
                          //   if (value!.isEmpty||value.length<12) {
                          //   }
                          //   return null;
                          // },
                          decoration: InputDecoration(
                              hintText: '57687375747567',
                              counterText: "",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)))),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * .01),
                    ElevatedButton(
                      onPressed: () {
                        // pickImageDialogAdhar(context, 1);
                        _getFromCameraAdhar();
                      },
                      child: Text("Select Aadhaar Front"),
                    ),
                    Center(
                      child: Stack(children: [
                        InkWell(
                            child: Container(
                                height: 150,
                                width: 150,
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black)),
                                child: aadharImage != null
                                    ? Image.file(
                                        aadharImage!.absolute,
                                        fit: BoxFit.fill,
                                      )
                                    :
                                    //    Center(child: Image.asset('assets/img.png')),),
                                    Image.network(
                                        '${widget.model?.aadharImg}',
                                      )),
                            onTap: () {
                              if (aadharImage != null) {
                                final imageProvider =
                                    Image.file(aadharImage!).image;
                                showImageViewer(context, imageProvider,
                                    onViewerDismissed: () {
                                  print("dismissed");
                                });
                              } else if (widget.model?.aadharImg != null) {
                                final imageProvider =
                                    Image.network(widget.model?.aadharImg ?? '')
                                        .image;
                                showImageViewer(context, imageProvider,
                                    onViewerDismissed: () {
                                  print("dismissed");
                                });
                              }
                            },
                            onLongPress: () {
                              if (aadharImage != null)
                                Fluttertoast.showToast(
                                    msg: 'Already saved in gallery');
                              else if (widget.model?.aadharImg != null)
                                showDilaogBox(widget.model?.aadharImg ?? "");
                            }),
                        aadharImage != null
                            ? Positioned(
                                right: 2,
                                child: InkWell(
                                  onTap: () {
                                    aadharImage = null;
                                    setState(() {});
                                  },
                                  child: Icon(
                                    Icons.cancel,
                                    size: 30,
                                    color: Colors.red.withOpacity(0.7),
                                  ),
                                ),
                              )
                            : SizedBox()
                      ]),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * .01),
                    ElevatedButton(
                      onPressed: () {
                        // pickImageDialogAdharBack(context, 1);
                        getFromCameraAdharBack();
                      },
                      child: Text("Select Aadhaar Back"),
                    ),

                    Center(
                      child: Stack(children: [
                        InkWell(
                            child: Container(
                                height: 150,
                                width: 150,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black),
                                ),
                                child: aadharBack != null
                                    ? Image.file(aadharBack!.absolute,
                                        fit: BoxFit.fill)
                                    : Image.network(
                                        '${widget.model?.aadharBack}',
                                      )),
                            onTap: () {
                              if (aadharBack != null) {
                                final imageProvider =
                                    Image.file(aadharBack!).image;
                                showImageViewer(context, imageProvider,
                                    onViewerDismissed: () {
                                  print("dismissed");
                                });
                              } else if (widget.model?.aadharBack != null) {
                                final imageProvider = Image.network(
                                        widget.model?.aadharBack ?? '')
                                    .image;
                                showImageViewer(context, imageProvider,
                                    onViewerDismissed: () {
                                  print("dismissed");
                                });
                              }
                            },
                            onLongPress: () {
                              if (aadharBack != null)
                                Fluttertoast.showToast(
                                    msg: 'Already saved in gallery');
                              else if (widget.model?.aadharBack != null)
                                showDilaogBox(widget.model?.aadharBack ?? "");
                            }),
                        aadharBack != null
                            ? Positioned(
                                right: 2,
                                child: InkWell(
                                  onTap: () {
                                    aadharBack = null;
                                    setState(() {});
                                  },
                                  child: Icon(
                                    Icons.cancel,
                                    size: 30,
                                    color: Colors.red.withOpacity(0.7),
                                  ),
                                ),
                              )
                            : SizedBox()
                      ]),
                    ),
                    Text(
                      "Voter Id",
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .02,
                    ),
                    Card(
                      elevation: 6,
                      shape: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      child: TextFormField(
                          keyboardType: TextInputType.number,
                          maxLength: 12,
                          controller: voterCtr,
                          // validator: (value) {
                          //   if (value!.isEmpty) {
                          //     return 'Please Enter Your VoterId No';
                          //   }
                          //   return null;
                          // },
                          decoration: InputDecoration(
                              hintText: '',
                              counterText: "",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)))),
                    ),

                    SizedBox(height: MediaQuery.of(context).size.height * .01),
                    ElevatedButton(
                      onPressed: () {
                        // pickImageDialogAdhar(context, 1);
                        _getFromCameraVoteIdFront();
                      },
                      child: Text("Select Voter Id Front"),
                    ),
                    Center(
                      child: Stack(children: [
                        InkWell(
                            child: Container(
                                height: 150,
                                width: 150,
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black)),
                                child: voterIdImage != null
                                    ? Image.file(
                                        voterIdImage!.absolute,
                                        fit: BoxFit.fill,
                                      )
                                    :
                                    //    Center(child: Image.asset('assets/img.png')),),
                                    Image.network(
                                        '${widget.model?.voterIdFrontImage}',
                                      )),
                            onTap: () {
                              if (voterIdImage != null) {
                                final imageProvider =
                                    Image.file(voterIdImage!).image;
                                showImageViewer(context, imageProvider,
                                    onViewerDismissed: () {
                                  print("dismissed");
                                });
                              } else if (widget.model?.voterIdFrontImage !=
                                  null) {
                                final imageProvider = Image.network(
                                        widget.model?.voterIdFrontImage ?? '')
                                    .image;
                                showImageViewer(context, imageProvider,
                                    onViewerDismissed: () {
                                  print("dismissed");
                                });
                              }
                            },
                            onLongPress: () {
                              if (voterIdImage != null)
                                Fluttertoast.showToast(
                                    msg: 'Already saved in gallery');
                              else if (widget.model?.voterIdFrontImage != null)
                                showDilaogBox(
                                    widget.model?.voterIdFrontImage ?? "");
                            }),
                        voterIdImage != null
                            ? Positioned(
                                right: 2,
                                child: InkWell(
                                  onTap: () {
                                    voterIdImage = null;
                                    setState(() {});
                                  },
                                  child: Icon(
                                    Icons.cancel,
                                    size: 30,
                                    color: Colors.red.withOpacity(0.7),
                                  ),
                                ),
                              )
                            : SizedBox()
                      ]),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * .01),
                    ElevatedButton(
                      onPressed: () {
                        // pickImageDialogAdharBack(context, 1);
                        _getFromCameraVoterIdBack();
                      },
                      child: Text("Select Voter Id Back"),
                    ),
                    Center(
                      child: Stack(children: [
                        InkWell(
                            child: Container(
                                height: 150,
                                width: 150,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black),
                                ),
                                child: voterIdBackImage != null
                                    ? Image.file(voterIdBackImage!.absolute,
                                        fit: BoxFit.fill)
                                    : Image.network(
                                        '${widget.model?.voterIdBackImage}',
                                      )),
                            onTap: () {
                              if (voterIdBackImage != null) {
                                final imageProvider =
                                    Image.file(voterIdBackImage!).image;
                                showImageViewer(context, imageProvider,
                                    onViewerDismissed: () {
                                  print("dismissed");
                                });
                              } else if (widget.model?.voterIdBackImage !=
                                  null) {
                                final imageProvider = Image.network(
                                        widget.model?.voterIdBackImage ?? '')
                                    .image;
                                showImageViewer(context, imageProvider,
                                    onViewerDismissed: () {
                                  print("dismissed");
                                });
                              }
                            },
                            onLongPress: () {
                              if (voterIdBackImage != null)
                                Fluttertoast.showToast(
                                    msg: 'Already saved in gallery');
                              else if (widget.model?.voterIdBackImage != null)
                                showDilaogBox(
                                    widget.model?.voterIdBackImage ?? "");
                            }),
                        voterIdBackImage != null
                            ? Positioned(
                                right: 2,
                                child: InkWell(
                                  onTap: () {
                                    voterIdBackImage = null;
                                    setState(() {});
                                  },
                                  child: Icon(
                                    Icons.cancel,
                                    size: 30,
                                    color: Colors.red.withOpacity(0.7),
                                  ),
                                ),
                              )
                            : SizedBox()
                      ]),
                    ),
                    const Text(
                      "Customer Type",
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .02,
                    ),
                    Card(
                      elevation: 6,
                      shape: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: DropdownButtonFormField<String>(
                        value: selected_Customer,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                          } else {
                            return null;
                          }
                          return null;
                        },
                        onChanged: (newValue) {
                          setState(() {
                            selected_Customer = newValue;
                          });
                        },
                        items: getList?.data?.customerType?.map((items) {
                          return DropdownMenuItem(
                            value: items.id,
                            child: Text(items.name.toString()),
                          );
                        }).toList(),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          hintText: 'Select Customer Type',
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .02,
                    ),
                    const Text(
                      "Credit limit",
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .02,
                    ),
                    Card(
                      elevation: 6,
                      shape: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      child: TextFormField(
                          keyboardType: TextInputType.text,
                          controller: creditcn,
                          // validator: (value) {
                          //   if (value!.isEmpty) {
                          //   }
                          //   return null;
                          // },

                          decoration: InputDecoration(
                              hintText: '9999',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)))),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .02,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          // _showImagePicker(context);
                          _pickImage(ImageSource.camera);
                        },
                        child: const Text("Select Image")),
                    apiImages.length > 0 ? buildGridView() : SizedBox(),
                    imagePathList.length > 0 ? buildGridView1() : SizedBox(),
                    // Center(
                    //   child: Container(
                    //       height: 150,
                    //       width: 150,
                    //       decoration: BoxDecoration(border: Border.all(color: Colors.black)),
                    //       child: _imageFile!=null? Image.file(_imageFile!.absolute,fit: BoxFit.fill,):
                    //       //    Center(child: Image.asset('assets/img.png')),),
                    //       Image.network('${widget.model?.photo}',)
                    //   ),
                    // )
                  ],
                ),
              ),
              // SizedBox(height: MediaQuery.of(context).size.height*.03,),
              // Row(
              //   children: [
              //     SizedBox(width: MediaQuery.of(context).size.width*.02,),
              //     ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
              //         onPressed: (){
              //           if(_formKey.currentState!.validate()){
              //             update();
              //           }
              //         }, child: const Text("Update"))
              //
              //   ],
              // ),
              SizedBox(height: MediaQuery.of(context).size.height * .02),
              Container(
                height: 60,
                // width: MediaQuery.of(context).size.width/2,
                child: Center(
                  child: Column(
                    children: [
                      // SizedBox(width: MediaQuery.of(context).size.width*.02,),
                      Container(
                        width: MediaQuery.of(context).size.width / 2,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: colors.primary),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              // Fluttertoast.showToast(msg: "Please Fill All Fields");
                              update();
                            }
                          },
                          child: Text(
                            "Update",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 40,
              )
            ],
          ),
        ),
      ),
    );
  }

  GetListModel? getList;
  Future<void> fetchState() async {
    var headers = {
      'Cookie': 'ci_session=87296a4980f29999f28fd3ac8756e4f69277cda7'
    };
    var request = http.MultipartRequest(
        'POST',
        Uri.parse(
            'https://developmentalphawizz.com/rename_market_track/app/v1/api/get_lists'));
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var result = await response.stream.bytesToString();
      var finalresult = GetListModel.fromJson(json.decode(result));
      setState(() {
        getList = finalresult;
      });
    } else {
      print(response.reasonPhrase);
    }
  }

  Future<void> update() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? department_id = pref.getString('department');
    var headers = {
      'Cookie': 'ci_session=7e079301704afa2c89541d74dff4365aadc746ac'
    };
    var request = http.MultipartRequest(
        'POST',
        Uri.parse(
            'https://developmentalphawizz.com/rename_market_track/app/v1/api/add_new_client'));
    request.fields.addAll({
      'user_id': '${CUR_USERID}',
      'name_of_firm': namecn.text,
      "date_of_birth": doBCtr.text,
      "date_of_anniversary": doACtr.text,
      "udyogid_number": udyogIdCtr.text,
      "route": routeCtr.text,
      "market": marketCtr.text,
      "landmark": landmarkCtr.text,
      'status': selected_Status.toString(),
      'owner_name': ownernamecn.text,
      'address': addresscn.text,
      'district': selected_District.toString(),
      'pin_code': pincodecn.text,
      'state': selected_State.toString(),
      'mobile_one': mobile1cn.text,
      'mobile_two': mobile2cn.text,
      'whatsapp_number': whatsappcn.text,
      'email': emailcn.text,
      'pan': pancn.text,
      'gst': gstcn.text,
      'aadhar': aadharcn.text,
      'customer_type': selected_Customer.toString(),
      'credit_limit': creditcn.text,
      'lat': latitude.toString(),
      'lng': longitude.toString(),
      'id': '${widget.model?.id}',
      'department': '${department_id.toString()}',
      // 'gst_img': '${gstImage.toString()}',
      // 'pan_img': '${panImage.toString()}',
      // 'aadhar_img': '${aadharImage.toString()}',
      // 'aadhar_back': '${aadharBack.toString()}',
      // 'gst_img_two': '${gstOne.toString()}',
      // 'gst_img_three': '${gstTwo.toString()}',
      'create_by': '${CUR_USERID}',
      'voter_number': '${voterCtr.text}',
      for (var i = 0; i < imagePathList.length; i++)
        'photo[]': imagePathList[i],
      for (var i = 0; i < apiImages.length; i++) 'photos[]': apiImages[i],
    });
    print("update parara ${request.fields}");
    gstImage != null
        ? request.files.add(
            await http.MultipartFile.fromPath('gst_img', gstImage?.path ?? ""))
        : true;
    panImage != null
        ? request.files.add(
            await http.MultipartFile.fromPath('pan_img', panImage?.path ?? ""))
        : true;
    aadharImage != null
        ? request.files.add(await http.MultipartFile.fromPath(
            'aadhar_img', aadharImage?.path ?? ""))
        : true;
    aadharBack != null
        ? request.files.add(await http.MultipartFile.fromPath(
            'aadhar_back', aadharBack?.path ?? ""))
        : true;
    gstOne != null
        ? request.files.add(await http.MultipartFile.fromPath(
            'gst_img_two', gstOne?.path ?? ""))
        : true;
    gstTwo != null
        ? request.files.add(
            await http.MultipartFile.fromPath(
                'gst_img_three', gstTwo?.path ?? ""),
          )
        : true;
    voterIdImage != null
        ? request.files.add(
            await http.MultipartFile.fromPath(
                'voter_id_front_image', voterIdImage?.path ?? ""),
          )
        : true;
    voterIdBackImage != null
        ? request.files.add(
            await http.MultipartFile.fromPath(
                'voter_id_back_image', voterIdBackImage?.path ?? ""),
          )
        : true;
    // for (var i = 0; i < imagePathList.length; i++) {
    //   print('Imageeee $imagePathList');
    //   imagePathList.isEmpty
    //       ? null
    //       : request.files.add(
    //           await http.MultipartFile.fromPath('photos[]', imagePathList[i]),
    //         );
    // }
    // for (var i = 0; i < apiImages.length; i++) {
    //   print('apii Imageeee $apiImages');
    //   apiImages.isEmpty
    //       ? null
    //       : request.files.add(
    //           await http.MultipartFile.fromPath('photos[]', apiImages[i]),
    //         );
    // }
    print('----${widget.model?.id}');
    print("parameter  ${request.fields}");
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var result = await response.stream.bytesToString();
      var finalresult = jsonDecode(result);
      if (finalresult['error'] == false) {
        Fluttertoast.showToast(msg: finalresult['message']);
        await Navigator.push(
            context, MaterialPageRoute(builder: (context) => Dashboard()));
      } else {
        Fluttertoast.showToast(msg: finalresult['message']);
      }
    } else {
      print(response.reasonPhrase);
    }
  }

  String? formattedDate;
  String? timeData;
  convertDateTimeDispla() {
    var now = new DateTime.now();
    var formatter = new DateFormat('dd-MM-yyyy');
    formattedDate = formatter.format(now);
    print("datedetet$formattedDate"); // 2016-01-25
    timeData = DateFormat("hh:mm:ss a").format(DateTime.now());
    print("timeeeeeeeeee$timeData");
  }

  Widget buildGridView1() {
    return Container(
      height: 170,
      child: GridView.builder(
        itemCount: imagePathList.length,
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (BuildContext context, int index) {
          return Stack(
            children: [
              InkWell(
                onTap: () {
                  if (imagePathList[index] != null) {
                    final imageProvider =
                        Image.file(imagePathList[index]!).image;
                    showImageViewer(context, imageProvider,
                        onViewerDismissed: () {
                      print("dismissed");
                    });
                  }
                },
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: colors.primary)),
                  width: MediaQuery.of(context).size.width / 2.8,
                  height: 170,
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    child: Image.file(File(imagePathList[index]),
                        fit: BoxFit.cover),
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: colors.primary),
                  ),
                  width: MediaQuery.of(context).size.width / 2.8,
                  height: 65,
                  child: Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Date: ${formattedDate}",
                          style: TextStyle(fontSize: 10, color: Colors.white),
                        ),
                        Text(
                          "Time: ${timeData}",
                          style: TextStyle(fontSize: 10, color: Colors.white),
                        ),
                        Text(
                          "Location: ${currentAddress.text}",
                          style: TextStyle(fontSize: 10, color: Colors.white),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        )
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

  var pinController = TextEditingController();
  var currentAddress = TextEditingController();
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
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    // var loc = Provider.of<LocationProvider>(context, listen: false);
    latitude = position.latitude.toString();
    longitude = position.longitude.toString();
    setState(() {
      longitude_Global = latitude;
      lattitudee_Global = longitude;
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
          currentlocation_Global = currentAddress.text.toString();
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

  Future<void> downloadImage(String imageUrl) async {
    print("mmmmmmmm");
    var response = await http.get(Uri.parse(imageUrl));

    if (response.statusCode == 200) {
      final result = await ImageGallerySaver.saveImage(
          Uint8List.fromList(response.bodyBytes));
      Fluttertoast.showToast(msg: "Image saved to gallery");
      print('Image saved to gallery: $result');
    } else {
      print('Failed to download image: ${response.statusCode}');
    }
  }

  showDilaogBox(String imageUrl) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Are you want to download Image?'),
          content: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                child: Container(
                  //  padding: EdgeInsets.all(16),
                  height: 30,
                  width: 80,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: colors.primary),
                  child: Center(
                      child: Text(
                    "Yes",
                    style: TextStyle(color: colors.whiteTemp),
                  )),
                ),
                onTap: () {
                  downloadImage(imageUrl);
                  Navigator.of(context).pop(); // Close the AlertDialog
                  // getImageFromGallery();
                },
              ),
              InkWell(
                child: Container(
                  height: 30,
                  width: 80,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: colors.primary),
                  child: Center(
                      child: Text(
                    "No",
                    style: TextStyle(color: colors.whiteTemp),
                  )),
                ),
                onTap: () {
                  Navigator.of(context).pop(); // Close the AlertDialog
                  //getImageFromCamera();
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
