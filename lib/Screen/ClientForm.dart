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
//     var request = http.MultipartRequest('POST', Uri.parse('https://developmentalphawizz.com/market_track/app/v1/api/get_lists'));
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
//     var request = http.MultipartRequest('POST', Uri.parse('https://developmentalphawizz.com/market_track/app/v1/api/add_new_client'));
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

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart'as http;
import 'package:omega_employee_management/Helper/String.dart';
import 'package:omega_employee_management/Screen/Dashboard.dart';
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

class _Client_formState extends State<Client_form> {

  final picker = ImagePicker();
  File? _imageFile;

  Future<void> _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: source,maxHeight: 640,maxWidth: 400,imageQuality: 80);
    if (pickedImage != null) {
      setState(() {
        _imageFile = File(pickedImage.path);
      });
    }
  }


  void _showImagePicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Gallery'),
                onTap: () {
                  _pickImage(ImageSource.gallery);
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_camera),
                title: const Text('Camera'),
                onTap: () {
                  _pickImage(ImageSource.camera);
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }


  TextEditingController namecn = TextEditingController();
  TextEditingController emailcn = TextEditingController();
  TextEditingController mobile1cn= TextEditingController();
  TextEditingController mobile2cn= TextEditingController();
  TextEditingController whatsappcn= TextEditingController();
  TextEditingController department= TextEditingController();
  TextEditingController ownernamecn= TextEditingController();
  TextEditingController addresscn= TextEditingController();
  TextEditingController pincodecn= TextEditingController();
  TextEditingController pancn= TextEditingController();
  TextEditingController gstcn= TextEditingController();
  TextEditingController aadharcn= TextEditingController();
  TextEditingController creditcn= TextEditingController();
  TextEditingController staffcn= TextEditingController();
  TextEditingController udyogIdCtr= TextEditingController();
  TextEditingController doBCtr= TextEditingController();
  TextEditingController doACtr= TextEditingController();
  TextEditingController routeCtr= TextEditingController();
  TextEditingController marketCtr= TextEditingController();
  TextEditingController landmarkCtr= TextEditingController();


  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? selected_Status;
  String? selected_Staff;
  String? selected_State;
  String? selected_District;
  String? selected_Customer;
  List<String>? results = ["seller", 'user', "flutter"];
  var stateId;
  var cityId;
  int stateindex = 0;
  String? selectedState;

  // List<String> Staff=['Atul Gautam','Pretty Tomer','Sunil','yash',];
  List<String> District= ['Indore','Bhopal','Gwalior','Ujjain',];

  @override
  void initState(){
    super.initState();
    fetchState();
    namecn.text='${widget.model?.nameOfFirm}';
    ownernamecn.text='${widget.model?.ownerName}';
    addresscn.text='${widget.model?.address}';
    pincodecn.text='${widget.model?.pinCode}';
    emailcn.text='${widget.model?.email}';
    mobile1cn.text='${widget.model?.mobileOne}';
    mobile2cn.text='${widget.model?.mobileTwo}';
    whatsappcn.text='${widget.model?.whatsappNumber}';
    pancn.text='${widget.model?.pan}';
    gstcn.text='${widget.model?.gst}';
    aadharcn.text='${widget.model?.aadhar}';
    creditcn.text='${widget.model?.creditLimit}';
    doBCtr.text ='${widget.model?.dateOfBirth}';
    doACtr.text ='${widget.model?.dateOfAnniversary}';
    routeCtr.text ='${widget.model?.route}';
    marketCtr.text ='${widget.model?.market}';
    landmarkCtr.text ='${widget.model?.landmark}';
    udyogIdCtr.text ='${widget.model?.udyogIdNumber}';
    selected_Status='${widget.model?.status}';
    selected_Customer='${widget.model?.customerType}';
    // panImage!.path =  "${widget.model?.panImg}" ?? "";
    // selected_District='${widget.model?.district}';
    // staffcn.text='${widget.model?.}';
    // stateId='${widget.model?.state}';
  }


  File? panImage;
  File? gstImage;
  File? aadharImage;
  File? aadharBack;
  File? gstOne;
  File? gstTwo;
  File? voterIdImage;
  File? voterIdBackImage;

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

  void pickImageDialogPan(BuildContext context,int i) async {
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

  void pickImageDialogAdharBack(BuildContext context,int i) async{
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
                  getFromCameraAdharBack();
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
      source: ImageSource.camera,maxHeight: 640,maxWidth: 400,imageQuality: 80
    );
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
      Navigator.pop(context);
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
      source: ImageSource.camera,maxHeight: 640,maxWidth: 400,imageQuality: 80
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
      source: ImageSource.camera,maxHeight: 640,maxWidth: 400,imageQuality: 80
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
      source: ImageSource.camera,maxHeight: 640,maxWidth: 400,imageQuality: 80
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
      source: ImageSource.camera,maxHeight: 640,maxWidth: 400,imageQuality: 80
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
      source: ImageSource.camera,maxHeight: 640,maxWidth: 400,imageQuality: 80
    );
    if (pickedFile != null) {
      setState(() {
        aadharImage = File(pickedFile.path);
      });
      Navigator.pop(context);
    }
  }


  getFromCameraAdharBack() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera,maxHeight: 640,maxWidth: 400,imageQuality: 80
    );
    if (pickedFile != null) {
      setState(() {
        aadharBack = File(pickedFile.path);
      });
      Navigator.pop(context);
    }
  }
  _getFromCameraVoteIdFront() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera,maxHeight: 640,maxWidth: 400,imageQuality: 80
    );
    if (pickedFile != null) {
      setState(() {
        voterIdImage = File(pickedFile.path);
      });
      // Navigator.pop(context);
    }
  }
  _getFromCameraVoterIdBack() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera,maxHeight: 640,maxWidth: 400,imageQuality: 80
    );
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
      firstDate:DateTime(1970),
      lastDate: DateTime.now(),
    );
    if (selectedDate != null){
      setState(() {
        doBCtr.text = "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}";
      });
    }
  }
  _showAnniversaryDatePicker() async {
    var selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate:DateTime(1970),
      lastDate: DateTime.now(),
    );
    if (selectedDate != null){
      setState(() {
        doACtr.text = "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
    backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: colors.primary,
        centerTitle: true,
        title: Text("Client"),
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
                      const Text("Name Of Firm",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
                      SizedBox(height: MediaQuery.of(context).size.height*.02,),
                      Card(elevation: 6,
                        shape: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
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
                                    borderRadius:  BorderRadius.circular(10)))),
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height*.02,),
                      const Text("Status",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
                      SizedBox(height: MediaQuery.of(context).size.height*.02,),
                      Card(elevation: 6,
                        shape: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                        child: DropdownButtonFormField<String>(
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
                              selected_Status= newValue;
                            });
                          },
                          items: getList?.data?.clientStatus?.map((items) {
                            return DropdownMenuItem(
                              value: items.id,
                              child: Text(items.name.toString()),
                            );
                          }).toList(),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                            hintText: 'Select Status',
                          ),
                        ),
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height*.02,),
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
                      const Text("Owner Name",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
                      SizedBox(height: MediaQuery.of(context).size.height*.02,),
                      Card(
                        elevation: 6,
                        shape: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                        child: TextFormField(
                            keyboardType: TextInputType.text,
                            controller: ownernamecn,
                            validator: (value) {
                              if (value!.isEmpty) {
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                hintText: 'name',
                                border: OutlineInputBorder(
                                    borderRadius:  BorderRadius.circular(15),
                                ),
                            ),
                        ),
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height*.02,),
                      const Text("Departments",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
                      SizedBox(height: MediaQuery.of(context).size.height*.02,),
                      Card(
                        elevation: 3,

                        shape: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                        child: Container(
                          // decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: Colors.white, border: Border.all(color: Colors.black)),
                          height: 56,
                          width: MediaQuery.of(context).size.width/1.1,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 0, left: 10, bottom: 2, right: 10),
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Row (
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: results!.map((e) {
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
                        ),
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height*.02,),
                      const Text("Address",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
                      SizedBox(height: MediaQuery.of(context).size.height*.02,),
                      Card(elevation: 6,
                        shape: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                        child: TextFormField(
                            keyboardType: TextInputType.text,
                            controller: addresscn,
                            validator: (value) {
                              if (value!.isEmpty) {
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                hintText: 'Address',
                                border: OutlineInputBorder(
                                    borderRadius:  BorderRadius.circular(10),
                                ),
                            ),
                        ),
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height*.02,),
                      const Text("State",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
                      SizedBox(height: MediaQuery.of(context).size.height*.02,),
                      Card(elevation: 6,
                        shape: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                        child: DropdownButtonFormField<String>(
                          value: stateId,
                          onChanged: (newValue) {
                            setState(() {
                              stateId = newValue;
                              // print("current indexxx ${selected}");
                              // stateindex = getList!.data!.states!.indexWhere((element) => element.id == selectedState);
                              // currentIndex = selected;
                              // showTextField = true;
                            });
                          },
                          items: getList?.data?.states?.map((items) {
                            return DropdownMenuItem(
                              value: items.id,
                              child: Text(items.name.toString()),
                            );
                          }).toList(),
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(top: 5, left: 10),
                            border: InputBorder.none,
                            hintText: '${widget.model?.state}',
                          ),
                        ),
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height*.02,),
                      const Text("District",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
                      SizedBox(height: MediaQuery.of(context).size.height*.02,),
                      Card(elevation: 6,
                        shape: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                        child: DropdownButtonFormField<String>(
                          value: selected_District,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                            } else {
                            }
                            return null;
                          },
                          onChanged: (newValue) {
                            setState(() {
                              selected_District= newValue;
                            });
                          },
                          items:getList?.data?.states?[0].cities?.map((items) {
                            return DropdownMenuItem(
                              value: items.id,
                              child: Text(items.city.toString()),
                            );
                          }).toList(),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                            hintText:
                            '${widget.model?.district}',
                          ),
                        ),
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height*.02,),
                      const Text("Pincode",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
                      SizedBox(height: MediaQuery.of(context).size.height*.02,),
                      Card(elevation: 6,
                        shape: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                        child: TextFormField(
                            keyboardType: TextInputType.number,
                            controller: pincodecn,
                            validator: (value) {
                              if (value!.isEmpty) {
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                hintText: '452011',
                                border: OutlineInputBorder(
                                    borderRadius:  BorderRadius.circular(10)))),
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height*.02,),
                      const Text("Email",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
                      SizedBox(height: MediaQuery.of(context).size.height*.02,),
                      Card(elevation: 6,
                        shape: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                        child: TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            controller: emailcn,
                            validator: (value) {
                              if (value!.isEmpty) {
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                hintText: 'hfg@gmail.com',
                                border: OutlineInputBorder(
                                    borderRadius:  BorderRadius.circular(10)))),
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height*.02,),
                      const Text("Mobile 1",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
                      SizedBox(height: MediaQuery.of(context).size.height*.02,),
                      Card(elevation: 6,
                        shape: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                        child: TextFormField(
                            keyboardType: TextInputType.number,
                            maxLength: 10,
                            controller: mobile1cn,
                            validator: (value) {
                              if (value!.isEmpty||value.length<10) {
                              }
                              return null;
                            },

                            decoration: InputDecoration(
                                hintText: '9854648544',
                                counterText: "",
                                border: OutlineInputBorder(
                                    borderRadius:  BorderRadius.circular(10)))),
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height*.02,),
                      const Text("Mobile 2",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
                      SizedBox(height: MediaQuery.of(context).size.height*.02,),
                      Card(elevation: 6,
                        shape: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                        child: TextFormField(
                            keyboardType: TextInputType.number,
                            maxLength: 10,
                            controller: mobile2cn,
                            validator: (value) {
                              if (value!.isEmpty||value.length<10) {
                              }
                              return null;
                            },

                            decoration: InputDecoration(
                                hintText: '9854648544',

                                counterText: "",
                                border: OutlineInputBorder(
                                    borderRadius:  BorderRadius.circular(10)))),
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height*.02,),
                      const Text("Whatsapp Number",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
                      SizedBox(height: MediaQuery.of(context).size.height*.02,),
                      Card(elevation: 6,
                        shape: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                        child: TextFormField(
                            keyboardType: TextInputType.number,
                            maxLength: 10,
                            controller: whatsappcn,
                            validator: (value) {
                              if (value!.isEmpty||value.length<10) {
                                return "please enter whatsapp number";
                              }
                              return null;
                            },

                            decoration: InputDecoration(
                                hintText: '9854648544',

                                counterText: "",
                                border: OutlineInputBorder(
                                    borderRadius:  BorderRadius.circular(10)))),
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height*.02,),
                      const Text("Date of Birth",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
                      SizedBox(height: MediaQuery.of(context).size.height*.02,),
                      Card(elevation: 6,
                        shape: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                        child: TextFormField(
                          onTap: _showBirthDatePicker,
                            keyboardType: TextInputType.none,
                            // maxLength: 10,
                            controller: doBCtr,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "please select date of birth";
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
                      const Text("Date of Anniversary",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
                      SizedBox(height: MediaQuery.of(context).size.height*.02,),
                      Card(elevation: 6,
                        shape: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                        child: TextFormField(
                          onTap: _showAnniversaryDatePicker,
                            keyboardType: TextInputType.none,
                            // maxLength: 10,
                            controller: doACtr,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "please select date of anniversary";
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
                      const Text("Route",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
                      SizedBox(height: MediaQuery.of(context).size.height*.02,),
                      Card(elevation: 6,
                        shape: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                        child: TextFormField(
                            keyboardType: TextInputType.text,
                            // maxLength: 10,
                            controller: routeCtr,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "please enter route";
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
                      const Text("Market",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
                      SizedBox(height: MediaQuery.of(context).size.height*.02,),
                      Card(elevation: 6,
                        shape: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                        child: TextFormField(
                            keyboardType: TextInputType.text,
                            // maxLength: 10,
                            controller: marketCtr,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return"please enter market";
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
                      const Text("landmark",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
                      SizedBox(height: MediaQuery.of(context).size.height*.02,),
                      Card(elevation: 6,
                        shape: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                        child: TextFormField(
                            keyboardType: TextInputType.text,
                            // maxLength: 10,
                            controller: landmarkCtr,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "please enter landmark";
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
                      const Text("Udyog Id Number",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
                      SizedBox(height: MediaQuery.of(context).size.height*.02,),
                      Card(elevation: 6,
                        shape: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                        child: TextFormField(
                            keyboardType: TextInputType.text,
                            // maxLength: 10,
                            controller: udyogIdCtr,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "please enter udyog Id ";
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
                      const Text("Pan",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
                      SizedBox(height: MediaQuery.of(context).size.height*.02,),
                      Card(elevation: 6,
                        shape: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                        child: TextFormField(
                            keyboardType: TextInputType.text,
                            controller: pancn,
                            validator: (value) {
                              if (value!.isEmpty) {
                              }
                              return null;
                            },

                            decoration: InputDecoration(
                                hintText: '4545385838',
                                counterText: "",
                                border: OutlineInputBorder(
                                    borderRadius:  BorderRadius.circular(10)))),
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height*.02,),
                      ElevatedButton(
                        onPressed: () {
                          // pickImageDialogPan(context, 1);
                          _getFromCameraPan();
                        }, child: Text("Select Pan"),
                      ),
                      Center(
                        child: Container(
                            height: 150,
                            width: 150,
                            decoration: BoxDecoration(border: Border.all(color: Colors.black)),
                            child: panImage!=null? Image.file(panImage!.absolute,fit: BoxFit.fill,):
                            //    Center(child: Image.asset('assets/img.png')),),
                            Image.network('${widget.model?.panImg}',)
                        ),
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height*.02,),
                      const Text("GST",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
                      SizedBox(height: MediaQuery.of(context).size.height*.02,),
                      Card(elevation: 6,
                        shape: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                        child: TextFormField(
                            keyboardType: TextInputType.text,
                            controller: gstcn,
                            validator: (value) {
                              if (value!.isEmpty) {
                              }
                              return null;
                            },

                            decoration: InputDecoration(
                                hintText: '6565',

                                counterText: "",
                                border: OutlineInputBorder(
                                    borderRadius:  BorderRadius.circular(10)))),
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height*.01),
                      ElevatedButton(
                        onPressed: () {
                          // pickImageDialogGst(context, 1);
                          _getFromCameraGst();
                        }, child: Text("Select GST"),
                      ),
                      Center(
                        child: Container(
                            height: 150,
                            width: 150,
                            decoration: BoxDecoration(border: Border.all(color: Colors.black)),
                            child: gstImage!=null? Image.file(gstImage!.absolute,fit: BoxFit.fill,):
                            //    Center(child: Image.asset('assets/img.png')),),
                            Image.network('${widget.model?.gstImg}',)
                        ),
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height*.01),
                      ElevatedButton(
                        onPressed: () {
                          // pickImageDialogGstOne(context, 1);
                          _getFromCameraGstOne();
                        }, child: Text("Select GST One"),
                      ),
                      Center(
                        child: Container(
                          height: 150,
                          width: 150,
                          decoration: BoxDecoration(border: Border.all(color: Colors.black),
                          ),
                          child:gstOne!=null? Image.file(gstOne!.absolute,fit: BoxFit.fill):
                          Image.network('${widget.model?.gstTwoImg}',)
                        ),
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height*.01),
                      ElevatedButton(
                        onPressed: () {
                          // pickImageDialogGstTwo(context, 1);
                          _getFromCameraGstTwo();
                        }, child: Text("Select GST Two"),
                      ),
                      Center(
                        child: Container(
                          height: 150,
                          width: 150,
                          decoration: BoxDecoration(border: Border.all(color: Colors.black),
                          ),
                          child:gstTwo!=null? Image.file(gstTwo!.absolute,fit: BoxFit.fill):
                          Image.network('${widget.model?.gstThreeImg}',)
                        ),
                      ),
                      const Text("Aadhaar",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
                      SizedBox(height: MediaQuery.of(context).size.height*.02,),
                      Card(elevation: 6,
                        shape: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                        child: TextFormField(
                            keyboardType: TextInputType.number,
                            maxLength: 12,
                            controller: aadharcn,
                            validator: (value) {
                              if (value!.isEmpty||value.length<12) {
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                hintText: '57687375747567',
                                counterText: "",
                                border: OutlineInputBorder(
                                    borderRadius:  BorderRadius.circular(10)))),
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height*.01),
                      ElevatedButton(
                        onPressed: () {
                          // pickImageDialogAdhar(context, 1);
                          _getFromCameraAdhar();
                        }, child: Text("Select Aadhaar Front"),
                      ),
                      Center(
                        child: Container(
                            height: 150,
                            width: 150,
                            decoration: BoxDecoration(border: Border.all(color: Colors.black)),
                            child: aadharImage!=null? Image.file(aadharImage!.absolute,fit: BoxFit.fill,):
                            //    Center(child: Image.asset('assets/img.png')),),
                            Image.network('${widget.model?.aadharImg}',)
                        ),
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height*.01),
                      ElevatedButton(
                        onPressed: () {
                          // pickImageDialogAdharBack(context, 1);
                          getFromCameraAdharBack();
                        }, child: Text("Select Aadhaar Back"),
                      ),
                      Center(
                        child: Container(
                          height: 150,
                          width: 150,
                          decoration: BoxDecoration(border: Border.all(color: Colors.black),
                          ),
                          child: aadharBack!=null? Image.file(aadharBack!.absolute,fit: BoxFit.fill):
                          Image.network('${widget.model?.aadharBackImg}',)
                        ),
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height*.01),
                      ElevatedButton(
                        onPressed: () {
                          // pickImageDialogAdhar(context, 1);
                          _getFromCameraVoteIdFront();
                        }, child: Text("Select Voter Id Front"),
                      ),
                      Center(
                        child: Container(
                            height: 150,
                            width: 150,
                            decoration: BoxDecoration(border: Border.all(color: Colors.black)),
                            child: voterIdImage!=null? Image.file(voterIdImage!.absolute,fit: BoxFit.fill,):
                            //    Center(child: Image.asset('assets/img.png')),),
                            Image.network('${widget.model?.voterIdImg}',)
                        ),
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height*.01),
                      ElevatedButton(
                        onPressed: () {
                          // pickImageDialogAdharBack(context, 1);
                          _getFromCameraVoterIdBack();
                        }, child: Text("Select Voter Id Back"),
                      ),
                      Center(
                        child: Container(
                            height: 150,
                            width: 150,
                            decoration: BoxDecoration(border: Border.all(color: Colors.black),
                            ),
                            child: voterIdBackImage!=null? Image.file(voterIdBackImage!.absolute,fit: BoxFit.fill):
                            Image.network('${widget.model?.voterIdBackImg}',)
                        ),
                      ),
                      const Text("Customer Type",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
                      SizedBox(height: MediaQuery.of(context).size.height*.02,),
                      Card(elevation: 6,
                        shape: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
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
                              selected_Customer= newValue;
                            });
                          },
                          items:getList?.data?.customerType?.map((items) {
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
                      const Text("Credit limit",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
                      SizedBox(height: MediaQuery.of(context).size.height*.02,),
                      Card(elevation: 6,
                        shape: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                        child: TextFormField(
                            keyboardType: TextInputType.text,
                            controller: creditcn,
                            validator: (value) {
                              if (value!.isEmpty) {
                              }
                              return null;
                            },

                            decoration: InputDecoration(
                                hintText: '9999',
                                border: OutlineInputBorder(
                                    borderRadius:  BorderRadius.circular(10)))),
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height*.02,),
                      ElevatedButton(onPressed: (){
                        // _showImagePicker(context);
                        _pickImage(ImageSource.camera);
                      }, child: const Text("Select Image")),
                      Center(
                        child: Container(
                            height: 150,
                            width: 150,
                            decoration: BoxDecoration(border: Border.all(color: Colors.black)),
                            child: _imageFile!=null? Image.file(_imageFile!.absolute,fit: BoxFit.fill,):
                            //    Center(child: Image.asset('assets/img.png')),),
                            Image.network('${widget.model?.photo}',)
                        ),
                      )
                    ],
                  )
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
                            update();
                          }
                        }, child: Text("Update", style: TextStyle(fontWeight: FontWeight.bold)
                            )
                        ),
                      ),
                    ],
                  ),
                ),
              ),
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
    var request = http.MultipartRequest('POST', Uri.parse('https://developmentalphawizz.com/market_track/app/v1/api/get_lists'));
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var result=await response.stream.bytesToString();
      var finalresult = GetListModel.fromJson(json.decode(result));
      setState(() {
        getList=finalresult;
      });
    }
    else {
      print(response.reasonPhrase);
    }
  }


  Future<void> update() async {
    var headers = {
      'Cookie': 'ci_session=7e079301704afa2c89541d74dff4365aadc746ac'
    };
    var request = http.MultipartRequest('POST', Uri.parse('https://developmentalphawizz.com/market_track/app/v1/api/add_new_client'));
    request.fields.addAll({
      'user_id': '${CUR_USERID}',
      'name_of_firm': namecn.text,
      'status': selected_Status.toString() ,
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
      'photo': '${_imageFile.toString()}',
      'gst_img': '${gstImage.toString()}',
      'pan_img': '${panImage.toString()}',
      'aadhar_img': '${aadharImage.toString()}',
      'aadhar_back': '${aadharBack.toString()}',
      'gst_img_two': '${gstOne.toString()}',
      'gst_img_three': '${gstTwo.toString()}'
    });
    print('----${widget.model?.id}');
    print("parameter  ${request.fields}");
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var result=await response.stream.bytesToString();
      var finalresult=jsonDecode(result);
      if(finalresult['error'] == false){
        Fluttertoast.showToast(msg: finalresult['message']);
        await Navigator.push(context, MaterialPageRoute(builder: (context) => Dashboard()));
      }
      else{
        Fluttertoast.showToast(msg: finalresult['message']);
      }
    }
    else {
      print(response.reasonPhrase);
    }
  }
}
