import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:omega_employee_management/Model/GedClientDataModel.dart';
import '../Helper/Color.dart';
import '../Helper/String.dart';
import '../Model/DealingProductModel.dart';
import '../Model/DelearRetailerModel.dart';
import '../Model/DelearRetailerModel1.dart';
import 'MultiSelect.dart';
import 'Survey.dart';


var latitude;
var longitude;


class FeedbackForm extends StatefulWidget {
  const FeedbackForm({Key? key}) : super(key: key);

  @override
  State<FeedbackForm> createState() => _FeedbackFormState();
}

class _FeedbackFormState extends State<FeedbackForm> {

  void initState() {
    super.initState();
    getCurrentLoc();
    convertDateTimeDispla();
    date();
    getDelearRetaler();
    dealingProduct();
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController namecn = TextEditingController();
  TextEditingController petTypeCtr = TextEditingController();
  TextEditingController mobilecn = TextEditingController();
  TextEditingController timeCtr = TextEditingController();
  TextEditingController dateCtr = TextEditingController();
  TextEditingController remarkCtr = TextEditingController();
  TextEditingController startDateController = TextEditingController();
  TextEditingController dealerMailController = TextEditingController();
  TextEditingController dealerNameController = TextEditingController();
  TextEditingController dealerNumberController = TextEditingController();
  TextEditingController dealercreditlimitController = TextEditingController();

  String _dateValue = '';
  var dateFormate;
  String? formattedDate;
  String? timeData;

  convertDateTimeDispla() {
      var now = new DateTime.now();
      var formatter = new DateFormat('yyyy-MM-dd');
       formattedDate = formatter.format(now);
      print("datedetet${formattedDate}"); // 2016-01-25
       timeData = DateFormat("hh:mm:ss a").format(DateTime.now());
      print("timeeeeeeeeee${timeData}");
  }


  date() async {
    dateCtr.text = formattedDate.toString();
    timeCtr.text = timeData.toString();
  }

  DelearRetailerModel? delearRetailerModel;
  getDelearRetaler() async {
    var headers = {
      'Cookie': 'ci_session=ef29e61acfe01ba495d2b60947f70ae0b26cc807'
    };
    var request = http.MultipartRequest('POST', Uri.parse(clientType.toString()));
    request.fields.addAll({
      'client_type': '1,2'
    });

    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      String str = await response.stream.bytesToString();
      var result = json.decode(str);
      var finalResponse = DelearRetailerModel.fromJson(result);
      setState(() {
        delearRetailerModel = finalResponse;
        // delearRetailerModel?.data?.add(DealerListData(ownerName: "Other", id: "800"));
        // delearRetailerModel?.data?.add(DealerListData(ownerName: "NotApplicable", id: "801"));
      });
    }
    else {
      print(response.reasonPhrase);
    }
  }

  var pinController = TextEditingController();
  var currentAddress = TextEditingController();

  Future<void> getCurrentLoc() async {
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
        print('Latitude=============${latitude}');
        print('Longitude*************${longitude}');

        print('Current Addresssssss${currentAddress.text}');
      });
      if (currentAddress.text == "" || currentAddress.text == null) {
      } else {
        setState(() {
          // navigateToPage();
        });
      }
    }
  }

  String? selected;
  int nwIndex = 0;
  var currentIndex;
  final picker=ImagePicker();
  File? _imageFile;
  bool showTextField = false;

  void pickImageDialog(BuildContext context,int i) async {
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


  DealingProductModel? dealingProductModel;
  dealingProduct() async {
    var headers = {
      'Cookie': 'ci_session=4f8360fd4e4e40e498783ef6638c6f55e6bc9fca'
    };
    var request = http.MultipartRequest('POST', Uri.parse(GetDealingProduct.toString()));
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var result=await response.stream.bytesToString();
      var finalresult = DealingProductModel.fromJson(json.decode(result));
      setState(() {
        dealingProductModel = finalresult;
      });
    }
    else {
      print(response.reasonPhrase);
    }
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
        imagePathList.add(_imageFile?.path ?? "");
        isImages = true ;
      });
      //Navigator.pop(context);
    }
  }

  List<DealingData> results = [];

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
            color: colors.white70,
            border: Border(
                bottom: BorderSide(color: colors.blackTemp.withOpacity(0.5),
                ))),
        child: results.isEmpty ? const Padding(
          padding: EdgeInsets.only(left: 10, top: 10, bottom: 10),
          child: Text(
            'Select',
            style: TextStyle(
              fontSize: 15,
              color: colors.blackTemp,
              fontWeight: FontWeight.normal,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ):SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row (
            crossAxisAlignment: CrossAxisAlignment.start,
            children: results.map((e) {
              return Padding(
                padding: const EdgeInsets.only(top: 10, left: 1, right: 1),
                child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    height: 30,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: colors.primary),
                        child: Center(
                        child: Text(
                          "${e.name}",
                          style: TextStyle(color: Colors.white),
                        ),
                    ),
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }

  void _showMultiSelect() async {
    results = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (context, setState) {
          return
            MultiSelect(
              dealingData: dealingProductModel?.data,
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


  List<String> imagePathList = [];
  bool isImages = false;

  Widget uploadMultiImage() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(
          height: 10,
        ),
        InkWell(
          onTap: () async {
            // pickImageDialog(context, 1);
            // await pickImages();
            _getFromCamera();
          },
          child: Container(
            height: 40,
            width: 165,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10), color: colors.primary),
            child: Center(
              child: Text(
                "Upload Image",
                style: TextStyle(color: colors.whiteTemp),
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Visibility(
            visible: isImages,
            child:  buildGridView()),
      ],
    );
  }

  Widget buildGridView() {
    return Container(
      height: 200,
      child: GridView.builder(
        itemCount: imagePathList.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (BuildContext context, int index) {
          return Stack(
            children: [
              Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15))),
                  child: Container(
                    width: MediaQuery.of(context).size.width / 2,
                    height: MediaQuery.of(context).size.height / 2,
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      child: Image.file(File(imagePathList[index]),
                          fit: BoxFit.cover),
                    ),
                  )),
              Positioned(
                bottom: 10,
                child: Container(
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: colors.primary),),
                  width:MediaQuery.of(context).size.width/2.8,
                  height: 70,
                  child: Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Date: ${formattedDate}", style: TextStyle(fontSize: 10, color: Colors.white)),
                        Text("Time: ${timeData}", style: TextStyle(fontSize: 10, color: Colors.white)),
                        Text("Location: ${currentAddress.text}", style: TextStyle(fontSize: 10, color: Colors.white),overflow: TextOverflow.ellipsis,maxLines: 2,)
                      ],
                    ),
                  ),
                ),
                // InkWell(
                //   onTap: () {
                //     setState(() {
                //       imagePathList.remove(imagePathList[index]);
                //     });
                //   },
                //   child: Icon(
                //     Icons.remove_circle,
                //     size: 30,
                //     color: Colors.red.withOpacity(0.7),
                //   ),
                // ),
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
        elevation: 0,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child:  Icon(Icons.arrow_back_ios, color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: colors.primary,
        title: Text("Counter Visit Form", style: TextStyle(fontSize: 15, color: Colors.white)),
      ),
      body:
      SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 15, right: 15, top: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // const Text(
                    //   "Date",
                    //   style: TextStyle(
                    //       fontSize: 14, fontWeight: FontWeight.bold),
                    // ),
                    // SizedBox(
                    //   height: MediaQuery.of(context).size.height *.01,
                    // ),
                    // Container(
                    //   height: 50,
                    //   child: TextFormField(
                    //       readOnly: true,
                    //       controller: dateCtr,
                    //       decoration: InputDecoration(
                    //         // hintText: '',
                    //           border: OutlineInputBorder(
                    //               borderRadius: BorderRadius.circular(10)))),
                    // ),
                    // SizedBox(
                    //   height: MediaQuery.of(context).size.height * .01,
                    // ),
                    // const Text(
                    //   "Time",
                    //   style: TextStyle(
                    //       fontSize: 14, fontWeight: FontWeight.bold),
                    // ),
                    // SizedBox(
                    //   height: MediaQuery.of(context).size.height * .01,
                    // ),
                    // Container(
                    //   height: 50,
                    //   child: TextFormField(
                    //     readOnly: true,
                    //       maxLength: 10,
                    //       controller: timeCtr,
                    //       decoration: InputDecoration(
                    //           hintText: '',
                    //           counterText: "",
                    //           border: OutlineInputBorder(
                    //               borderRadius: BorderRadius.circular(10),
                    //           ),
                    //       ),
                    //   ),
                    // ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .01,
                    ),
                    const Text(
                      "Dealer & Retailer",
                      style: TextStyle(
                          fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height *.01,
                    ),
                    Container(
                      height: 60,
                      child: Card(
                        elevation: 2,
                        shape: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                        child: DropdownButtonFormField<String>(
                          value: selected,
                          onChanged: (newValue) {
                            setState(() {
                              selected = newValue;
                              print("current indexxx ${selected}");
                               nwIndex = delearRetailerModel!.data!.indexWhere((element) => element.id == selected);
                              // currentIndex = selected;
                              showTextField = true;
                            });
                          },
                          items: delearRetailerModel?.data?.map((items) {
                            return DropdownMenuItem(
                              value: items.id,
                              child: Text(items.ownerName.toString()),
                            );
                          }).toList(),
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(bottom: 5, left: 10),
                            border: InputBorder.none,
                            hintText: 'Select Dealer & Retailer',
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 5),
                    selected!= null?
                    // selected == "801" ? SizedBox():
                    //     selected == "800"?
                    //     Column(
                    //       children: [
                    //         SizedBox(
                    //           height: MediaQuery.of(context).size.height*.01,
                    //         ),
                    //         Row(
                    //           children: [
                    //             Text("Name:", style:TextStyle(fontSize: 12, fontWeight: FontWeight.w800)),
                    //             SizedBox(width: 30),
                    //             Container(
                    //               height: 40,
                    //               width: MediaQuery.of(context).size.width / 2.2,
                    //               child: TextFormField(
                    //                 controller: dealerNameController,
                    //                 // onChanged: (value) {
                    //                 //   // String mobileContractor = value ;
                    //                 //   contractorMobile = value;
                    //                 // },
                    //                 // readOnly: true,
                    //                 //controller: mobilecn,
                    //                 decoration: InputDecoration(
                    //                   contentPadding: EdgeInsets.only(bottom: 4, left: 3),
                    //                   // hintText: '',
                    //                   border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                    //                 ),
                    //               ),
                    //             ),
                    //           ],
                    //         ),
                    //         SizedBox(height: 10),
                    //         Row(
                    //           children: [
                    //             Text("Mail:", style:TextStyle(fontSize: 12, fontWeight: FontWeight.w800)),
                    //             SizedBox(width: 40),
                    //             Container(
                    //               height: 40,
                    //               width: MediaQuery.of(context).size.width / 2.2,
                    //               child: TextFormField(
                    //                 controller: dealerMailController,
                    //                 // onChanged: (value) {
                    //                 //   // String mobileContractor = value ;
                    //                 //   contractorMobile = value;
                    //                 // },
                    //                 // readOnly: true,
                    //                 //controller: mobilecn,
                    //                 decoration: InputDecoration(
                    //                   contentPadding: EdgeInsets.only(bottom: 4, left: 3),
                    //                   // hintText: '',
                    //                   border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                    //                 ),
                    //               ),
                    //             ),
                    //           ],
                    //         ),
                    //         SizedBox(height: 10),
                    //         Row(
                    //           children: [
                    //             Text("Number:", style:TextStyle(fontSize: 12, fontWeight: FontWeight.w800)),
                    //             SizedBox(width: 20),
                    //             Container(
                    //               height: 40,
                    //               width: MediaQuery.of(context).size.width / 2.2,
                    //               child: TextFormField(
                    //                 keyboardType: TextInputType.number,
                    //                 maxLength: 10,
                    //                 controller: dealerNumberController,
                    //                 // onChanged: (value) {
                    //                 //   // String mobileContractor = value ;
                    //                 //   contractorMobile = value;
                    //                 // },
                    //                 // readOnly: true,
                    //                 //controller: mobilecn,
                    //                 decoration: InputDecoration(
                    //                   counterText: "",
                    //                   contentPadding: EdgeInsets.only(bottom: 4, left: 3),
                    //                   // hintText: '',
                    //                   border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                    //                 ),
                    //               ),
                    //             ),
                    //           ],
                    //         ),
                    //         SizedBox(height: 10),
                    //         Row(
                    //           children: [
                    //             Text("Credit Limit:", style:TextStyle(fontSize: 12, fontWeight: FontWeight.w800)),
                    //             SizedBox(width: 10),
                    //             Container(
                    //               height: 40,
                    //               width: MediaQuery.of(context).size.width / 2.2,
                    //               child: TextFormField(
                    //                 keyboardType: TextInputType.number,
                    //                 controller: dealercreditlimitController,
                    //                 decoration: InputDecoration(
                    //                   contentPadding: EdgeInsets.only(bottom: 4, left: 3),
                    //                   // hintText: '',
                    //                   border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                    //                 ),
                    //               ),
                    //             ),
                    //           ],
                    //         ),
                    //       ],
                    //     ),
                            // :
                      Column(
                        children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height*.01,
                        ),
                        Row(
                          children: [
                            Text("Name:", style:TextStyle(fontSize: 12, fontWeight: FontWeight.w800)),
                            SizedBox(width: 10),
                            Text("${delearRetailerModel?.data?[nwIndex].ownerName}", style:TextStyle(fontSize: 12, fontWeight: FontWeight.w800)),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Text("Mail:", style:TextStyle(fontSize: 12, fontWeight: FontWeight.w800)),
                            SizedBox(width: 10),
                            Text("${delearRetailerModel?.data?[nwIndex].email}", style:TextStyle(fontSize: 12, fontWeight: FontWeight.w800)),
                          ],
                        ),
                        SizedBox(height: 10),
                          Row(
                            children: [
                              Text("Address:", style:TextStyle(fontSize: 12, fontWeight: FontWeight.w800)),
                              SizedBox(width: 10),
                              Text("${delearRetailerModel?.data?[nwIndex].address}, ${delearRetailerModel?.data?[nwIndex].state}, ${delearRetailerModel?.data?[nwIndex].district}", style:TextStyle(fontSize: 12, fontWeight: FontWeight.w800)),
                            ],
                          ),
                          SizedBox(height: 10),
                        Row(
                          children: [
                            Text("Contact No:", style:TextStyle(fontSize: 12, fontWeight: FontWeight.w800)),
                            SizedBox(width: 10),
                            Text("${delearRetailerModel?.data?[nwIndex].mobileOne}, ${delearRetailerModel?.data?[nwIndex].mobileTwo}, ${delearRetailerModel?.data?[nwIndex].whatsappNumber}", style:TextStyle(fontSize: 12, fontWeight: FontWeight.w800)),
                          ],
                        ),
                        // SizedBox(height: 10),
                        // Row(
                        //   children: [
                        //     Text("Customer Type:", style:TextStyle(fontSize: 12, fontWeight: FontWeight.w800)),
                        //     SizedBox(width: 10),
                        //     Text("${delearRetailerModel?.data?[nwIndex].customerType}", style:TextStyle(fontSize: 12, fontWeight: FontWeight.w800)),
                        //   ],
                        // ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Text("Credit Limit:", style:TextStyle(fontSize: 12, fontWeight: FontWeight.w800)),
                            SizedBox(width: 10),
                            Text("${delearRetailerModel?.data?[nwIndex].creditLimit}", style:TextStyle(fontSize: 12, fontWeight: FontWeight.w800)),
                          ],
                        ),
                      ],
                      ): SizedBox(),
                    SizedBox(
                      height: MediaQuery.of(context).size.height*.01,
                    ),
                    const Text(
                      "Customer Dealing In",
                      style: TextStyle(
                          fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height*.01,
                    ),
                    Card(
                      elevation: 3,
                      child: Container(
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: Colors.white, border: Border.all(color: Colors.black)),
                        height: 45,
                        width: MediaQuery.of(context).size.width/1.1,
                        child: Padding(
                            padding: const EdgeInsets.only(top: 0, left: 10, bottom: 2, right: 10),
                            child: select(),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height*.04,
                    ),
                    // const Text(
                    //   "Remark",
                    //   style: TextStyle(
                    //       fontSize: 14, fontWeight: FontWeight.bold),
                    // ),
                    // SizedBox(
                    //   height: MediaQuery.of(context).size.height*.01,
                    // ),
                    // Container(
                    //   height: 65,
                    //   child: TextFormField(
                    //       keyboardType: TextInputType.text,
                    //       controller: remarkCtr,
                    //       decoration: InputDecoration(
                    //           hintText: '',
                    //           border: OutlineInputBorder(
                    //               borderRadius: BorderRadius.circular(15)
                    //           ),
                    //       ),
                    //   ),
                    // ),
                    // SizedBox(
                    //   height: MediaQuery.of(context).size.height *.01,
                    // ),
                    // InkWell(
                    //   onTap: () {
                    //     _getFromCamera();
                    //     // pickImageDialog(context, 1);
                    //   },
                    //   child: Container(
                    //       height: 35,
                    //       width: MediaQuery.of(context).size.width/3,
                    //       decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: colors.primary),
                    //       child: const Center(
                    //           child: Text("Select Image", style: TextStyle(fontSize: 15, color: Colors.white, fontWeight: FontWeight.w400)))
                    //   ),
                    // ),
                    // uploadMultiImage(),
                    // Stack(
                    //   children: [
                    //     Center(
                    //       child: Container(
                    //         height: 150,
                    //         width: 150,
                    //         decoration: BoxDecoration(border: Border.all(color: Colors.black)),
                    //         child:_imageFile!=null? Image.file(_imageFile!.absolute,fit: BoxFit.fill,):
                    //         Center(child: Image.asset('assets/img.png')),
                    //       ),
                    //     ),
                    //     // _imageFile!= null?
                    //     Positioned(
                    //       top: 7,
                    //       right: 95,
                    //       child: Column(
                    //         children: [
                    //           Text("${formattedDate}", style: TextStyle(fontSize: 10, color: Colors.red),),
                    //           Text("${timeData}", style: TextStyle(fontSize: 10, color: Colors.red),)
                    //         ],
                    //       ),
                    //     ),
                    //         // : SizedBox()
                    //   ],
                    // ),
                    //    const Text("Select Payment", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                    //    ),
                    // Column(
                    //   crossAxisAlignment: CrossAxisAlignment.start,
                    //    children: [
                    //      Row(
                    //        children: [
                    //          Row(
                    //            children: <Widget>[
                    //              Text('Subscription: ${getPlansModel?.data?[0].amount}', style: const TextStyle(fontSize: 12),),
                    //              Radio(
                    //                value: 'Subscription',
                    //                groupValue: selectedSubscription,
                    //                onChanged: (value) {
                    //                  setState(() {
                    //                    selectedSubscription = value;
                    //                  });
                    //                },
                    //              ),
                    //              const Text('Wallet', style: TextStyle(fontSize: 12)),
                    //              Radio(
                    //                value: 'Wallet',
                    //                groupValue: selectedWallet,
                    //                onChanged: (value) {
                    //                  setState(() {
                    //                    selectedWallet = value;
                    //                  });
                    //                },
                    //              ),
                    //            ],
                    //          ),
                    //          // Radio buttons for Wallet
                    //          // Row(
                    //          //   children: <Widget>[
                    //          //     Text('Online', style: TextStyle(fontSize: 12)),
                    //          //     Radio(
                    //          //       value: 'Online',
                    //          //       groupValue: selectedOnlinePayment,
                    //          //       onChanged: (value) {
                    //          //         setState(() {
                    //          //           selectedOnlinePayment = value;
                    //          //         });
                    //          //       },
                    //          //     ),
                    //          //   ],
                    //          // ),
                    //        ],
                    //      ),
                    // //     RadioListTile(
                    // //     title: const Text('Subscription', style: TextStyle(fontSize: 14)),
                    // //    value: 'Subscription',
                    // //    groupValue: selecteSubscription,
                    // //    onChanged: (value) {
                    // //     setState(() {
                    // //       selecteSubscription = value;
                    // //     });
                    // //   },
                    // // ),
                    // //      Text("${getPlansModel?.data?[0].amount}", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: colors.black),
                    // //      ),
                    // // // RadioListTile(
                    // // //   title: Text('Wallet'),
                    // // //   value: 'Wallet',
                    // // //   groupValue: selecteWallet,
                    // // //   onChanged: (value) {
                    // // //     setState(() {
                    // // //       selecteWallet = value;
                    // // //     });
                    // // //   },
                    // // // ),
                    // // RadioListTile(
                    // //   title: Text('Online Payment'),
                    // //   value: 'Online Payment',
                    // //   groupValue: selecteOnline,
                    // //   onChanged: (value) {
                    // //     setState(() {
                    // //       selecteOnline = value;
                    // //     });
                    // //   },
                    // //     ),
                    //   ],
                    // ),
                    //    SizedBox(
                    //      height: MediaQuery.of(context).size.height *.02,
                    //    ),
                    // ElevatedButton(
                    //   style: ElevatedButton.styleFrom(primary: colors.primary),
                    //   onPressed: () {
                    //     showExitPopup();
                    //   },
                    //   child: const Text("Upload Report"),
                    // ),
                    // const SizedBox(height: 10),
                    // imageFile == null ? const SizedBox.shrink(): InkWell(
                    //   onTap: () {
                    //     showExitPopup();
                    //   },
                    //   child: Container(
                    //     height: 100,
                    //     width: double.infinity,
                    //     margin: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                    //     child: Image.file(imageFile!,fit: BoxFit.fill,),
                    //   ),
                    // ),
                    // SizedBox(
                    //   height: MediaQuery.of(context).size.height * .02,
                    // ),
                    // ElevatedButton(
                    //     style: ElevatedButton.styleFrom(primary: colors.primary),
                    //     onPressed: () {
                    //       showExitPopup1();
                    //     },
                    //     child: const Text("Upload Pet Image")),
                    // SizedBox(height: 10,),
                    // petImage == null ? SizedBox.shrink() :  InkWell(
                    //   onTap: () {
                    //     showExitPopup1();
                    //   },
                    //   child: Container(
                    //     height: 100,
                    //     width: double.infinity,
                    //     margin: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                    //     child: Image.file(petImage!,fit: BoxFit.fill,),
                    //   ),
                    // ),
                    // SizedBox(
                    //   height: MediaQuery.of(context).size.height * .02,
                    // ),
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  if(results.length == 0 || selected == null){
                    Fluttertoast.showToast(msg: "All fields Required");
                  } else{
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Survey(
                      modelList: results,
                      name:delearRetailerModel?.data?[nwIndex].ownerName,
                      email:delearRetailerModel?.data?[nwIndex].email,
                      contact: delearRetailerModel?.data?[nwIndex].mobileOne,
                      creditLimit: delearRetailerModel?.data?[nwIndex].creditLimit,
                      customerType: delearRetailerModel?.data?[nwIndex].customerType,
                      // dealerName: dealerNameController.text,
                      // dealerMobile: dealerMailController.text,
                      // dealermail: dealerMailController.text,
                      // dealerLimit: dealercreditlimitController.text,
                      date: dateCtr.text,
                      time: timeCtr.text,
                      // image: imagePathList,
                      // remark: remarkCtr.text,
                      clintId: selected),
                      ),
                    );
                  }
                },
                child: Center(
                    child: Container(
                      height: 40,
                      width: MediaQuery.of(context).size.width/1.8,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: colors.primary),
                      child: const Center(
                          child: Text("Save", style: TextStyle(fontSize: 15, color: Colors.white, fontWeight: FontWeight.w400),
                          ),
                      ),
                    ),
                ),
              ),
              SizedBox(height: 10)
            ],
          ),
        ),
      ),
    );
  }
}
