import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:omega_employee_management/Helper/String.dart';
import 'package:omega_employee_management/Screen/Cart.dart';
import 'package:omega_employee_management/Screen/Dashboard.dart';

import '../Helper/Color.dart';
import '../Model/DealingProductModel.dart';
import 'Add_Address.dart';

class SiteSurvey extends StatefulWidget {
  final List<DealingData>? modelList;

  final String? name;
  final String? email;
  final String? contact;
  final String? customerType;
  final String? creditLimit;
  final String? time;
  final String? pincode;
  // final String? date;
  // final String? remark;
  // List<String>? image;
  final String? address;
  final String? state;
  final String? sitesize;
  final String? district;
  final String? contractor;
  final String? contractorMobile;
  final String? expectedDate;
  final String? engineer;
  final String? engineerMobile;
  final String? architec;
  final String? architecMobile;
  final String? mession;
  final String? messionMobile;
  final String? missionName;
  final String? missionAddress;
  final String? contractorName;
  final String? contractorAddress;
  final String? engineerName;
  final String? engineerAddress;
  final String? architecName;
  final String? architecAddress;

   SiteSurvey(
      {Key? key,
      this.modelList,
      this.name,
      this.email,
      this.contact,
      this.state,
      this.customerType,
      this.time,
      // this.date,
        this.expectedDate,
        this.sitesize,
       // this.image,
       // this.remark,
       this.address,
       this.creditLimit,
        this.district,
        this.pincode,
        this.engineer,
        this.engineerMobile,
        this.contractor,
        this.contractorMobile,
        this.architec,
        this.architecMobile,
        this.messionMobile,
        this.mession,
        this.architecAddress,
        this.architecName,
        this.contractorAddress,
        this.contractorName,
        this.engineerAddress,
        this.engineerName,
        this.missionAddress,
        this.missionName
      })
      : super(key: key);

  @override
  State<SiteSurvey> createState() => _SiteSurveyState();
}

class _SiteSurveyState extends State<SiteSurvey> {
  List<TextEditingController> monthlyControllers = [];
  List<TextEditingController> currentController = [];
  List<TextEditingController> rspController = [];
  int totalMonthlySales = 0;
  int currentSales = 0;
  List<int> sums = [];

  TextEditingController rsp = TextEditingController();
  TextEditingController purchasingForm = TextEditingController();
  TextEditingController dateinput = TextEditingController();

  // List<List<TextEditingController>> wholeDataList = [] ;

  List dataList = [];
  int sum = 0;
  List<List<List<TextEditingController>>> feedbackList = [];

  void initState() {
    super.initState();
    getCurrentLoc();
    convertDateTimeDispla();

    for(int i = 0; i < (widget.modelList?.length ?? 0); i++){
      sums.add(sum);
    }

    for (int i = 0; i < (widget.modelList?.length ?? 0); i++) {
      List<List<TextEditingController>> wholeDataList = [];
      for (int j = 0; j < (widget.modelList?[i].products?.length ?? 0); j++) {
        List<TextEditingController> commenController = [];
        commenController.add(TextEditingController());
        commenController.add(TextEditingController());
        commenController.add(TextEditingController());
        commenController.add(TextEditingController());
        commenController.add(TextEditingController());
        wholeDataList.add(commenController);
      }
      feedbackList.add(wholeDataList);
    }
  }

  TextEditingController execteddateCtr = TextEditingController();
  TextEditingController remarkCtr = TextEditingController();
  String? selectDate;
  siteSurvey() async {
    var headers = {
      'Cookie': 'ci_session=1320aad94f004f819d6b7fcd7da8a40903f7ce60'
    };
    var request = http.MultipartRequest(
        'POST',
        Uri.parse('https://developmentalphawizz.com/market_track/app/v1/api/site_visit_form'));
    request.fields.addAll({
      'user_id': '${CUR_USERID}',
      'date': execteddateCtr.text,
      'time': '${widget.time}',
      'lat': latitude.toString(),
      'lng': longitude.toString(),
      'customer_name': '${widget.name}',
      'customer_mobile': '${widget.contact}',
      'address': '${widget.address}',
      'state': '${widget.state}',
      'district': '${widget.district}',
      'pin_code': '${widget.pincode}',
      'contractor_id': '${widget.contractor}',
      'contractor_mobile': '${widget.contractorMobile}',
      'engineer_id': '${widget.engineer}',
      'engineer_mobile': '${widget.engineerMobile}',
      'architect_id': '${widget.architec}',
      'architect_mobile': '${widget.architecMobile}',
      'massion_id': '${widget.mession}',
      'massion_mobile': '${widget.messionMobile}',
      'site_sqr_feet': '${widget.sitesize}',
      'current_status': '${widget.sitesize}',
      'product_used': widget.modelList!.map((product) => product.id).join(','),
      'survey': dataList.toString(),
      'expected_order_date': '${widget.expectedDate}',
      'remarks': remarkCtr.text,
      'contractor_name': '${widget.contractorName}',
      'contractor_address': '${widget.contractorAddress}',
      'engineer_name': '${widget.engineerName}',
      'engineer_address': '${widget.engineerAddress}',
      'architect_name': '${widget.architecName}',
      'architect_address': '${widget.architecAddress}',
      'massion_name': '${widget.missionName}',
      'massion_address': '${widget.architecAddress}'
    });
    print("add coustomer survey parameter ${request.fields}");
    for (var i = 0; i < (imagePathList.length ?? 0); i++) {
      print("imageeeeeeeeeeeee ${imagePathList[i].toString()}");
      imagePathList[i] == ""
          ? null
          : request.files.add(await http.MultipartFile.fromPath(
          'photos[]', imagePathList[i].toString()));
    }
    // print("")
    // request.files.add(await http.MultipartFile.fromPath('photos[]', '${widget.image.toString()}'));
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      print(await response.stream.bytesToString(),
      );
      Navigator.push(context, MaterialPageRoute(builder: (context) => Dashboard()));
    } else {
      print("reasonnnnnnnnnn"+response.reasonPhrase.toString());
    }
  }

  var currentAddress = TextEditingController();

  var pinController = TextEditingController();

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


  File? _imageFile;
  List<String> imagePathList = [];
  bool isImages = false;
  _getFromCamera() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera,
      maxHeight: 500,
      maxWidth: 300,
      imageQuality: 80
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
                        Text("Date: ${formattedDate}", style: TextStyle(fontSize: 10, color: Colors.white),),
                        Text("Time: ${timeData}", style: TextStyle(fontSize: 10, color: Colors.white),),
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

  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 1,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back_ios, color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text("Customer Survey Form",
            style: TextStyle(fontSize: 15, color: Colors.black)),
      ),
      body: SingleChildScrollView(
        child:  Column(
          children: [
            const SizedBox(height: 5),
            Container(
              // height: MediaQuery.of(context).size.height/1.9,
              child: ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                key: Key('${selectedIndex.toString()}'),
                itemCount: widget.modelList?.length ?? 0,
                itemBuilder: (context, index) {
                  var item = widget.modelList?[index];

                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(0),
                          border: Border.all(color: colors.black54)
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          ExpansionTile(
                            collapsedBackgroundColor: colors.whiteTemp,
                            key: Key(index.toString()),
                            initiallyExpanded: index == selectedIndex ,
                            title: Row(
                              children: [
                                Text("Product Name: ", style: TextStyle(fontSize: 14)),
                                Text('${item?.name}', style: TextStyle(fontSize: 14),),
                              ],
                            ),
                            onExpansionChanged: (isExpanded) {
                              if(isExpanded) {
                                setState(()  {
                                  const Duration(milliseconds: 2000);
                                  selectedIndex = index;
                                });
                              }else{
                                setState(() {
                                  selectedIndex = -1;
                                });
                              }
                            },
                            children:[
                              Container(
                                height: MediaQuery.of(context).size.height/3.5,
                                width: MediaQuery.of(context).size.width/1.2,
                                child: ListView.builder(
                                    scrollDirection: Axis.vertical,
                                    shrinkWrap: true,
                                    // physics: NeverScrollableScrollPhysics(),
                                    itemCount: item?.products?.length ?? 0,
                                    itemBuilder: (BuildContext, i) {
                                      var data = item?.products?[i];

                                      return Column(
                                        children: [
                                          Row(
                                            children: [
                                              const Text("Brand Name: ", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                                              Text(data?.name ?? "", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: colors.primary)),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Row(
                                            children: [
                                              const Text(
                                                "Expected Consumption: ",
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight:
                                                    FontWeight
                                                        .bold),
                                              ),
                                              SizedBox(width: 10),
                                              Container(
                                                height: 30,
                                                width: MediaQuery.of(context).size.width / 2.9,
                                                child: TextField(
                                                  controller: feedbackList[index][i][0],
                                                  keyboardType: TextInputType.number,
                                                  // onEditingComplete: (){
                                                  //   sum += int.parse(feedbackList[index][i][0].text);
                                                  //   feedbackList[index][i][0].clear();
                                                  // },

                                                  decoration: InputDecoration(
                                                    contentPadding:
                                                    EdgeInsets.only(top: 7, left: 5),
                                                    border: OutlineInputBorder(
                                                      borderRadius: BorderRadius.circular(
                                                          5.0),
                                                    ),
                                                    filled: true,
                                                    hintStyle: TextStyle(
                                                        color: Colors
                                                            .black,
                                                        fontSize: 10),
                                                    hintText:
                                                    "Expected Consumption",
                                                    fillColor: Colors
                                                        .white70,
                                                  ),
                                                  onSubmitted:(val){
                                                    setState(() {
                                                      sums[index] += int.parse(val);
                                                    });
                                                  }
                                                  //     (value) {
                                                  //   totalMonthlySales +=
                                                  //       int.parse(
                                                  //           value);
                                                  //   setState(() {});
                                                  //   print(
                                                  //       "printtttttttt ${totalMonthlySales}");
                                                  //   // int total = 0;
                                                  //   // for (int i = 0; i < 5; i++) {
                                                  //   //   String text = monthlyControllers[i].text;
                                                  //   //   if (text.isNotEmpty) {
                                                  //   //     total += int.parse(text);
                                                  //   //   }
                                                  //   // }
                                                  //   // setState(() {
                                                  //   //   totalMonthlySales = total;
                                                  //   //   print("total monthly sheet ${totalMonthlySales}");
                                                  //   // });
                                                  // },
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Row(
                                            children: [
                                              const Text(
                                                  "Further Consumption: ",
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                      FontWeight
                                                          .bold)),
                                              SizedBox(width: 10),
                                              Container(
                                                height: 30,
                                                width: MediaQuery.of(
                                                    context)
                                                    .size
                                                    .width /
                                                    2.9,
                                                child: TextField(
                                                  controller: feedbackList[index][i][1],
                                                  // onEditingComplete: (){
                                                  //   setState(() {
                                                  //     sum += int.parse(feedbackList[index][i][1].text);
                                                  //   });
                                                  // },
                                                  keyboardType: TextInputType.number,
                                                  decoration: InputDecoration(
                                                    contentPadding: EdgeInsets.only(top: 7, left: 5),
                                                    border:
                                                    OutlineInputBorder(
                                                      borderRadius:
                                                      BorderRadius
                                                          .circular(
                                                          5.0),
                                                    ),
                                                    filled: true,
                                                    hintStyle: TextStyle(
                                                        color: Colors
                                                            .black,
                                                        fontSize: 10),
                                                    hintText:
                                                    "Fruther Consumption",
                                                    fillColor: Colors
                                                        .white70,
                                                  ),
                                                  onSubmitted:
                                                      (val) {

                                                          setState(() {
                                                            sums[index] += int.parse(val);
                                                          });

                                                    // currentSales +=
                                                    //     int.parse(
                                                    //         val);
                                                    // setState(() {});
                                                    // print(
                                                    //     "printtttttttt ${currentSales}");
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Row(
                                            children: [
                                              const Text(
                                                  "Purchase Price: ",
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                      FontWeight
                                                          .bold)),
                                              SizedBox(width: 10),
                                              Container(
                                                height: 30,
                                                width: MediaQuery.of(
                                                    context)
                                                    .size
                                                    .width /
                                                    2.9,
                                                child: TextField(
                                                  controller: feedbackList[index][i][2],
                                                  keyboardType: TextInputType.number,
                                                  decoration:
                                                  InputDecoration(
                                                    contentPadding:
                                                    EdgeInsets
                                                        .only(
                                                        top: 7, left: 5),
                                                    border:
                                                    OutlineInputBorder(
                                                      borderRadius:
                                                      BorderRadius
                                                          .circular(
                                                          5.0),
                                                    ),
                                                    filled: true,
                                                    hintStyle: TextStyle(
                                                        color: Colors
                                                            .black,
                                                        fontSize: 10),
                                                    hintText: "Price",
                                                    fillColor: Colors
                                                        .white70,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Row(
                                            children: [
                                              const Text(
                                                  "Purchasing Form: ",
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                      FontWeight
                                                          .bold)),
                                              SizedBox(width: 10),
                                              Container(
                                                height: 30,
                                                width: MediaQuery.of(
                                                    context)
                                                    .size
                                                    .width /
                                                    2.9,
                                                child: TextField(
                                                  controller: feedbackList[index][i][3],
                                                  keyboardType:
                                                  TextInputType
                                                      .text,
                                                  decoration:
                                                  InputDecoration(
                                                    contentPadding:
                                                    EdgeInsets
                                                        .only(
                                                        top:
                                                        7,
                                                        left:
                                                        5),
                                                    border:
                                                    OutlineInputBorder(
                                                      borderRadius:
                                                      BorderRadius
                                                          .circular(
                                                          5.0),
                                                    ),
                                                    filled: true,
                                                    hintStyle: TextStyle(
                                                        color: Colors
                                                            .black,
                                                        fontSize: 10),
                                                    hintText: "Form",
                                                    fillColor: Colors
                                                        .white70,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                  "Last Purchase Date: ",
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                      FontWeight
                                                          .bold)),
                                              SizedBox(width: 10),
                                              Row(
                                                children: [
                                                  Container(
                                                    height: 25,
                                                    width: MediaQuery.of(
                                                        context)
                                                        .size
                                                        .width /
                                                        2.9,
                                                    child: TextField(
                                                      readOnly: true,
                                                      controller: feedbackList[index][i][4],
                                                      decoration:
                                                      InputDecoration(
                                                        contentPadding: EdgeInsets.only(top: 7, left: 5),
                                                        border:
                                                        OutlineInputBorder(
                                                          borderRadius:
                                                          BorderRadius.circular(
                                                              5.0),
                                                        ),
                                                        filled: true,
                                                        hintStyle: TextStyle(
                                                            color: Colors
                                                                .black,
                                                            fontSize:
                                                            10),
                                                        hintText:
                                                        "Date",
                                                        fillColor: Colors
                                                            .white70,
                                                      ),
                                                      onTap: () async {
                                                        DateTime?pickedDate =
                                                        await showDatePicker(
                                                            context: context,
                                                            initialDate: DateTime.now(),
                                                            firstDate: DateTime(1950),
                                                            lastDate: DateTime(2100),
                                                            builder: (context, child) {
                                                              return Theme(
                                                                  data: Theme.of(context).copyWith(
                                                                    colorScheme: ColorScheme.light(primary: colors.primary),
                                                                  ),
                                                                  child: child!);
                                                            });
                                                        if (pickedDate != null) {
                                                          String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
                                                          feedbackList[index][i][4].text = formattedDate;
                                                          setState(
                                                                  () {
                                                                dateinput.text = formattedDate;
                                                              });
                                                        }
                                                      },
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Divider(color: Colors.black,),
                                          const SizedBox(height: 5,),
                                          // Padding(
                                          //   padding: const EdgeInsets.only(left: 15, right: 15),
                                          //   child: Row(
                                          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          //     children: [
                                          //       Text(
                                          //         "Sum Of Expected",
                                          //         style: TextStyle(
                                          //           fontSize: 13,
                                          //           fontWeight: FontWeight.w800,
                                          //         ),
                                          //       ),
                                          //       Text("${totalMonthlySales}",
                                          //           style: TextStyle(
                                          //             fontSize: 13,
                                          //             fontWeight: FontWeight.w800,
                                          //           ))
                                          //     ],
                                          //   ),
                                          // ),
                                          // SizedBox(height: 10),
                                          // Padding(
                                          //   padding: const EdgeInsets.only(left: 15, right: 15),
                                          //   child: Row(
                                          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          //     children: [
                                          //       Text(
                                          //         "Sum Of Further",
                                          //         style: TextStyle(fontSize: 13, fontWeight: FontWeight.w800),
                                          //       ),
                                          //       Text("${currentSales}",
                                          //         style: TextStyle(fontSize: 13, fontWeight: FontWeight.w800),
                                          //       )
                                          //     ],
                                          //   ),
                                          // ),
                                          // SizedBox(
                                          //   height: 10,
                                          // ),
                                        ],
                                      );
                                    }),
                              ),
                            ],
                          ),
                          selectedIndex == index ? Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text("Sum of Consumption: "),
                              Text(sums[index].toString())
                            ],
                          ):const SizedBox.shrink()
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  const Text(
                    "Expected Order Date",
                    style: TextStyle(
                        fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .01,
                  ),
                  Container(
                    height: 50,
                    // width: MediaQuery.of(context).size.width / 2.9,
                    child: TextField(
                      controller: execteddateCtr,
                      keyboardType: TextInputType.none,
                      decoration: InputDecoration(
                          hintText: 'Select Expected Order Date',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10))),
                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1950),
                            lastDate: DateTime(2100),
                            builder: (context, child) {
                              return Theme(
                                  data: Theme.of(context).copyWith(
                                    colorScheme:
                                    const ColorScheme.light(
                                        primary: colors.primary),
                                  ),
                                  child: child!);
                            });
                        if (pickedDate != null) {
                          String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
                          setState(() {
                            execteddateCtr.text = formattedDate;
                          });
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Remark",
                  style: TextStyle(
                      fontSize: 14, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height*.01,
                ),
                Container(
                  height: 45,
                  width: MediaQuery.of(context).size.width/1.1,
                  child: TextFormField(
                    keyboardType: TextInputType.text,
                    controller: remarkCtr,
                    decoration: InputDecoration(
                      hintText: '',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)
                      ),
                    ),
                  ),
                ),
              ],
            ),
            // SizedBox(height: 9),
            SizedBox(
              height: MediaQuery.of(context).size.height*.02,
            ),
            uploadMultiImage(),
            SizedBox(
                height: MediaQuery.of(context).size.height*.03
            ),
            // Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: ListView.builder(
            //     shrinkWrap: true,
            //     physics: NeverScrollableScrollPhysics(),
            //     itemCount: widget.modelList?.length ?? 0,
            //     itemBuilder: (context, index) {
            //       var item = widget.modelList?[index];
            //       return Column(
            //           children: [
            //             Card(
            //               elevation: 5,
            //               child: Container(
            //                 height: MediaQuery.of(context).size.height/1.5,
            //                 decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.white),
            //                 width: MediaQuery.of(context).size.width,
            //                 child: Padding(
            //                   padding: const EdgeInsets.all(5),
            //                   child: Row(
            //                     crossAxisAlignment: CrossAxisAlignment.end,
            //                     children: [
            //                       Padding(
            //                         padding: const EdgeInsets.only(left: 5),
            //                         child: Column(
            //                           mainAxisAlignment: MainAxisAlignment.center,
            //                           crossAxisAlignment: CrossAxisAlignment.start,
            //                           children: [
            //                             Padding(
            //                               padding: const EdgeInsets.only(left: 80),
            //                               child: InkWell(
            //                                 onTap: () {
            //                                   if (mounted) setState(() {
            //                                     selectedIndex = index;
            //                                     flag = !flag;
            //                                   });
            //                                 },
            //                                 child: Container(
            //                                   decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: colors.primary),
            //                                   height: 35,
            //                                   width: MediaQuery.of(context).size.width/2.3,
            //                                   child:
            //                                   Row(
            //                                     // crossAxisAlignment: CrossAxisAlignment.center,
            //                                     children: [
            //                                       Center(
            //                                         child: Padding(
            //                                           padding: const EdgeInsets.only(left:10),
            //                                           child: Text("Brand: ", style: TextStyle(
            //                                             fontSize: 14,
            //                                             fontWeight: FontWeight.bold, color: Colors.white),
            //                                           ),
            //                                         ),
            //                                       ),
            //                                       Text(item?.name ?? '', style: TextStyle(
            //                                         fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
            //                                       ),
            //                                       Icon(Icons.keyboard_arrow_down, color: colors.whiteTemp,),
            //                                     ],
            //                                   )
            //                                 ),
            //                               ),
            //                             ),
            //                             const SizedBox(
            //                               height: 10,
            //                             ),
            //                            SingleChildScrollView(
            //                              child: Container(
            //                                height: 400,
            //                                width: MediaQuery.of(context).size.width/1.2,
            //                                child: ListView.builder(
            //                                  scrollDirection: Axis.vertical,
            //                                  shrinkWrap: true,
            //                                  physics: NeverScrollableScrollPhysics(),
            //                                  itemCount: item?.products?.length ?? 0,
            //                                    itemBuilder: (BuildContext, i) {
            //                                    var data = item?.products?[i];
            //                                    return Column(
            //                                    children: [
            //                                    Row(
            //                                    children: [
            //                                      const Text("Product Name: ", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
            //                                       Text(data?.name ?? "", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: colors.primary)),
            //                                    ],
            //                                    ),
            //                                    const SizedBox(height: 5),
            //                                    Row(
            //                                      children: [
            //                                        const Text("Monthly Sale: ", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
            //                                        SizedBox(width: 10),
            //                                        Container(
            //                                          height: 30,
            //                                          width: MediaQuery.of(context).size.width/2.9,
            //                                          child: TextField(
            //                                            controller: feedbackList[index][i][0],
            //                                            keyboardType: TextInputType.number,
            //                                            decoration: InputDecoration(
            //                                              contentPadding: EdgeInsets.only(top: 7, left: 5),
            //                                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
            //                                              filled: true,
            //                                              hintStyle: TextStyle(color: Colors.black, fontSize: 10),
            //                                              hintText: "Monthly Sale",
            //                                              fillColor: Colors.white70,
            //                                            ),
            //                                            onSubmitted: (value) {
            //                                              totalMonthlySales += int.parse(value);
            //                                              setState(() {});
            //                                              print("printtttttttt ${totalMonthlySales}");
            //                                              // int total = 0;
            //                                              // for (int i = 0; i < 5; i++) {
            //                                              //   String text = monthlyControllers[i].text;
            //                                              //   if (text.isNotEmpty) {
            //                                              //     total += int.parse(text);
            //                                              //   }
            //                                              // }
            //                                              // setState(() {
            //                                              //   totalMonthlySales = total;
            //                                              //   print("total monthly sheet ${totalMonthlySales}");
            //                                              // });
            //                                            },
            //                                          ),
            //                                        ),
            //                                      ],
            //                                    ),
            //                                    const SizedBox(
            //                                      height: 5,
            //                                    ),
            //                                    Row(
            //                                      children: [
            //                                        const Text("Current stock: ", style: TextStyle(
            //                                            fontSize: 14,
            //                                            fontWeight: FontWeight.bold)),
            //                                        SizedBox(width: 10),
            //                                        Container(
            //                                          height: 30,
            //                                          width: MediaQuery.of(context).size.width/2.9,
            //                                          child: TextField(
            //                                            controller: feedbackList[index][i][1],
            //                                            keyboardType: TextInputType.number,
            //                                            decoration: InputDecoration(
            //                                              contentPadding: EdgeInsets.only(top: 7, left: 5),
            //                                              border: OutlineInputBorder(
            //                                                borderRadius: BorderRadius.circular(5.0),
            //                                              ),
            //                                              filled: true,
            //                                              hintStyle: TextStyle(color: Colors.black, fontSize: 10),
            //                                              hintText: "Current stock",
            //                                              fillColor: Colors.white70,
            //                                            ),
            //                                            onSubmitted: (value) {
            //                                              currentSales += int.parse(value);
            //                                              setState(() {});
            //                                              print("printtttttttt ${currentSales}");
            //                                            },
            //                                          ),
            //                                        ),
            //                                      ],
            //                                    ),
            //                                    const SizedBox(
            //                                      height: 5,
            //                                    ),
            //                                    Row(
            //                                      children: [
            //                                        const Text("WSP: ", style: TextStyle(
            //                                            fontSize: 14,
            //                                            fontWeight: FontWeight.bold)),
            //                                        SizedBox(width: 10,),
            //                                        Container(
            //                                          height: 30,
            //                                          width: MediaQuery.of(context).size.width/2.9,
            //                                          child: TextField(
            //                                            controller:feedbackList[index][i][2],
            //                                            keyboardType: TextInputType.number,
            //                                            decoration: InputDecoration(
            //                                              contentPadding: EdgeInsets.only(top: 7, left: 5),
            //                                              border: OutlineInputBorder(
            //                                                borderRadius: BorderRadius.circular(5.0),
            //                                              ),
            //                                              filled: true,
            //                                              hintStyle: TextStyle(color: Colors.black, fontSize: 10),
            //                                              hintText: "WSP",
            //                                              fillColor: Colors.white70,
            //                                            ),
            //                                          ),
            //                                        ),
            //                                      ],
            //                                    ),
            //                                    const SizedBox(
            //                                      height: 5,
            //                                    ),
            //                                    Row(
            //                                      children: [
            //                                        const Text("RSP: ", style: TextStyle(
            //                                            fontSize: 14,
            //                                            fontWeight: FontWeight.bold)),
            //                                        SizedBox(width: 10),
            //                                        Container(
            //                                          height: 30,
            //                                          width: MediaQuery.of(context).size.width/2.9,
            //                                          child: TextField(
            //                                            controller: feedbackList[index][i][3],
            //                                            keyboardType: TextInputType.number,
            //                                            decoration: InputDecoration(
            //                                              contentPadding: EdgeInsets.only(top: 7, left: 5),
            //                                              border: OutlineInputBorder(
            //                                                borderRadius: BorderRadius.circular(5.0),
            //                                              ),
            //                                              filled: true,
            //                                              hintStyle: TextStyle(color: Colors.black, fontSize: 10),
            //                                              hintText: "WSP",
            //                                              fillColor: Colors.white70,
            //                                            ),
            //                                          ),
            //                                        ),
            //                                      ],
            //                                    ),
            //                                    const SizedBox(
            //                                      height: 5,
            //                                    ),
            //                                    Row(
            //                                      children: [
            //                                        const Text("Purchasing Form: ", style: TextStyle(
            //                                            fontSize: 14,
            //                                            fontWeight: FontWeight.bold)),
            //                                        SizedBox(width: 10),
            //                                        Row(
            //                                          // mainAxisAlignment: MainAxisAlignment.end,
            //                                          // crossAxisAlignment: CrossAxisAlignment.end,
            //                                          children: [
            //                                            Container(
            //                                              height: 30,
            //                                              width: MediaQuery.of(context).size.width/2.9,
            //                                              child: TextField(
            //                                                controller: feedbackList[index][i][4],
            //                                                keyboardType: TextInputType.text,
            //                                                decoration: InputDecoration(
            //                                                  contentPadding: EdgeInsets.only(top: 7, left: 5),
            //                                                  border: OutlineInputBorder(
            //                                                    borderRadius: BorderRadius.circular(5.0),
            //                                                  ),
            //                                                  filled: true,
            //                                                  hintStyle: TextStyle(color: Colors.black, fontSize: 10),
            //                                                  hintText: "WSP",
            //                                                  fillColor: Colors.white70,
            //                                                ),
            //                                              ),
            //                                            ),
            //                                          ],
            //                                        ),
            //                                      ],
            //                                    ),
            //                                    const SizedBox(
            //                                      height: 5,
            //                                    ),],
            //                                );
            //                                  }),
            //                              ),
            //                            )
            //                           ],
            //                         ),
            //                       ),
            //                     ],
            //                   ),
            //                 ),
            //               ),
            //             ),
            //           ],
            //         );
            //     },
            //   ),
            // ),
          ],
        ),
        // Column(
        //   children: [
        //     const SizedBox(height: 5),
        //     Padding(
        //       padding: const EdgeInsets.all(8.0),
        //       child: ListView.builder(
        //         shrinkWrap: true,
        //         physics: NeverScrollableScrollPhysics(),
        //         itemCount: widget.modelList?.length ?? 0,
        //         itemBuilder: (context, index) {
        //           var item = widget.modelList?[index];
        //           return Column(
        //             children: [
        //               Card(
        //                 elevation: 5,
        //                 child: Container(
        //                   height: MediaQuery.of(context).size.height / 1.5,
        //                   decoration: BoxDecoration(
        //                       borderRadius: BorderRadius.circular(10),
        //                       color: Colors.white),
        //                   width: MediaQuery.of(context).size.width,
        //                   child: Padding(
        //                     padding: const EdgeInsets.all(5),
        //                     child: Row(
        //                       crossAxisAlignment: CrossAxisAlignment.end,
        //                       children: [
        //                         Padding(
        //                           padding: const EdgeInsets.only(left: 5),
        //                           child: Column(
        //                             mainAxisAlignment: MainAxisAlignment.center,
        //                             crossAxisAlignment:
        //                                 CrossAxisAlignment.start,
        //                             children: [
        //                               Padding(
        //                                 padding:
        //                                     const EdgeInsets.only(left: 80),
        //                                 child: Container(
        //                                   decoration: BoxDecoration(
        //                                       borderRadius: BorderRadius.circular(5), color: colors.primary),
        //                                   height: 35,
        //                                   width: MediaQuery.of(context).size.width / 2.1,
        //                                   child: Row(
        //                                     // crossAxisAlignment: CrossAxisAlignment.center,
        //                                     children: [
        //                                       Center(
        //                                         child: Padding(
        //                                           padding: const EdgeInsets.only(left: 10),
        //                                           child: Text(
        //                                             "Product Name: ",
        //                                             style: TextStyle(
        //                                                 fontSize: 14,
        //                                                 fontWeight: FontWeight.bold,
        //                                                 color: Colors.white),
        //                                           ),
        //                                         ),
        //                                       ),
        //                                       Text(
        //                                         item?.name ?? '',
        //                                         style: TextStyle(
        //                                             fontSize: 14,
        //                                             fontWeight: FontWeight.bold,
        //                                             color: Colors.white),
        //                                       ),
        //                                     ],
        //                                   ),
        //                                 ),
        //                               ),
        //                               const SizedBox(
        //                                 height: 10,
        //                               ),
        //                               SingleChildScrollView(
        //                                 child: Container(
        //                                   height: 400,
        //                                   width: MediaQuery.of(context)
        //                                           .size
        //                                           .width /
        //                                       1.2,
        //                                   child: ListView.builder(
        //                                       scrollDirection: Axis.vertical,
        //                                       shrinkWrap: true,
        //                                       physics:
        //                                           NeverScrollableScrollPhysics(),
        //                                       itemCount:
        //                                           item?.products?.length ?? 0,
        //                                       itemBuilder: (BuildContext, i) {
        //                                         var data = item?.products?[i];
        //                                         return Column(
        //                                           children: [
        //                                             Row(
        //                                               children: [
        //                                                 const Text(
        //                                                   "Brand Name: ",
        //                                                   style: TextStyle(
        //                                                     fontSize: 14,
        //                                                     fontWeight:
        //                                                         FontWeight.bold,
        //                                                   ),
        //                                                 ),
        //                                                 Text(data?.name ?? "",
        //                                                     style: TextStyle(
        //                                                         fontSize: 14,
        //                                                         fontWeight: FontWeight.bold, color: colors.primary),
        //                                                 ),
        //                                               ],
        //                                             ),
        //                                             const SizedBox(
        //                                               height: 5,
        //                                             ),
        //                                             Row(
        //                                               children: [
        //                                                 const Text(
        //                                                     "Expanded Consumption: ",
        //                                                     style: TextStyle(
        //                                                         fontSize: 14,
        //                                                         fontWeight:
        //                                                             FontWeight
        //                                                                 .bold),
        //                                                 ),
        //                                                 SizedBox(width: 10),
        //                                                 Container(
        //                                                   height: 30,
        //                                                   width: MediaQuery.of(context).size.width / 2.9,
        //                                                   child: TextField(
        //                                                     controller: feedbackList[index][i][0],
        //                                                     keyboardType: TextInputType.number,
        //                                                     decoration: InputDecoration(
        //                                                       contentPadding:
        //                                                           EdgeInsets.only(top: 7, left: 5),
        //                                                       border: OutlineInputBorder(
        //                                                         borderRadius: BorderRadius.circular(
        //                                                                     5.0),
        //                                                       ),
        //                                                       filled: true,
        //                                                       hintStyle: TextStyle(
        //                                                           color: Colors
        //                                                               .black,
        //                                                           fontSize: 10),
        //                                                       hintText:
        //                                                           "Expected Consumption",
        //                                                       fillColor: Colors
        //                                                           .white70,
        //                                                     ),
        //                                                     onSubmitted:
        //                                                         (value) {
        //                                                       totalMonthlySales +=
        //                                                           int.parse(
        //                                                               value);
        //                                                       setState(() {});
        //                                                       print(
        //                                                           "printtttttttt ${totalMonthlySales}");
        //                                                       // int total = 0;
        //                                                       // for (int i = 0; i < 5; i++) {
        //                                                       //   String text = monthlyControllers[i].text;
        //                                                       //   if (text.isNotEmpty) {
        //                                                       //     total += int.parse(text);
        //                                                       //   }
        //                                                       // }
        //                                                       // setState(() {
        //                                                       //   totalMonthlySales = total;
        //                                                       //   print("total monthly sheet ${totalMonthlySales}");
        //                                                       // });
        //                                                     },
        //                                                   ),
        //                                                 ),
        //                                               ],
        //                                             ),
        //                                             const SizedBox(
        //                                               height: 5,
        //                                             ),
        //                                             Row(
        //                                               children: [
        //                                                 const Text(
        //                                                     "Further Consumption: ",
        //                                                     style: TextStyle(
        //                                                         fontSize: 14,
        //                                                         fontWeight:
        //                                                             FontWeight
        //                                                                 .bold)),
        //                                                 SizedBox(width: 10),
        //                                                 Container(
        //                                                   height: 30,
        //                                                   width: MediaQuery.of(
        //                                                               context)
        //                                                           .size
        //                                                           .width /
        //                                                       2.9,
        //                                                   child: TextField(
        //                                                     controller: feedbackList[index][i][1],
        //                                                     keyboardType: TextInputType.number,
        //                                                     decoration: InputDecoration(
        //                                                       contentPadding: EdgeInsets.only(top: 7, left: 5),
        //                                                       border:
        //                                                           OutlineInputBorder(
        //                                                         borderRadius:
        //                                                             BorderRadius
        //                                                                 .circular(
        //                                                                     5.0),
        //                                                       ),
        //                                                       filled: true,
        //                                                       hintStyle: TextStyle(
        //                                                           color: Colors
        //                                                               .black,
        //                                                           fontSize: 10),
        //                                                       hintText:
        //                                                           "Fruther Consumption",
        //                                                       fillColor: Colors
        //                                                           .white70,
        //                                                     ),
        //                                                     onSubmitted:
        //                                                         (value) {
        //                                                       currentSales +=
        //                                                           int.parse(
        //                                                               value);
        //                                                       setState(() {});
        //                                                       print(
        //                                                           "printtttttttt ${currentSales}");
        //                                                     },
        //                                                   ),
        //                                                 ),
        //                                               ],
        //                                             ),
        //                                             const SizedBox(
        //                                               height: 5,
        //                                             ),
        //                                             Row(
        //                                               children: [
        //                                                 const Text(
        //                                                     "Purchase Price: ",
        //                                                     style: TextStyle(
        //                                                         fontSize: 14,
        //                                                         fontWeight:
        //                                                             FontWeight
        //                                                                 .bold)),
        //                                                 SizedBox(width: 10),
        //                                                 Container(
        //                                                   height: 30,
        //                                                   width: MediaQuery.of(
        //                                                               context)
        //                                                           .size
        //                                                           .width /
        //                                                       2.9,
        //                                                   child: TextField(
        //                                                     controller: feedbackList[index][i][2],
        //                                                     keyboardType: TextInputType.number,
        //                                                     decoration:
        //                                                         InputDecoration(
        //                                                       contentPadding:
        //                                                           EdgeInsets
        //                                                               .only(
        //                                                                   top: 7, left: 5),
        //                                                       border:
        //                                                           OutlineInputBorder(
        //                                                         borderRadius:
        //                                                             BorderRadius
        //                                                                 .circular(
        //                                                                     5.0),
        //                                                       ),
        //                                                       filled: true,
        //                                                       hintStyle: TextStyle(
        //                                                           color: Colors
        //                                                               .black,
        //                                                           fontSize: 10),
        //                                                       hintText: "Price",
        //                                                       fillColor: Colors
        //                                                           .white70,
        //                                                     ),
        //                                                   ),
        //                                                 ),
        //                                               ],
        //                                             ),
        //                                             const SizedBox(
        //                                               height: 5,
        //                                             ),
        //                                             Row(
        //                                               children: [
        //                                                 const Text(
        //                                                     "Purchasing Form: ",
        //                                                     style: TextStyle(
        //                                                         fontSize: 14,
        //                                                         fontWeight:
        //                                                             FontWeight
        //                                                                 .bold)),
        //                                                 SizedBox(width: 10),
        //                                                 Container(
        //                                                   height: 30,
        //                                                   width: MediaQuery.of(
        //                                                               context)
        //                                                           .size
        //                                                           .width /
        //                                                       2.9,
        //                                                   child: TextField(
        //                                                     controller: feedbackList[index][i][3],
        //                                                     keyboardType:
        //                                                         TextInputType
        //                                                             .text,
        //                                                     decoration:
        //                                                         InputDecoration(
        //                                                       contentPadding:
        //                                                           EdgeInsets
        //                                                               .only(
        //                                                                   top:
        //                                                                       7,
        //                                                                   left:
        //                                                                       5),
        //                                                       border:
        //                                                           OutlineInputBorder(
        //                                                         borderRadius:
        //                                                             BorderRadius
        //                                                                 .circular(
        //                                                                     5.0),
        //                                                       ),
        //                                                       filled: true,
        //                                                       hintStyle: TextStyle(
        //                                                           color: Colors
        //                                                               .black,
        //                                                           fontSize: 10),
        //                                                       hintText: "Form",
        //                                                       fillColor: Colors
        //                                                           .white70,
        //                                                     ),
        //                                                   ),
        //                                                 ),
        //                                               ],
        //                                             ),
        //                                             const SizedBox(
        //                                               height: 10,
        //                                             ),
        //                                             Row(
        //                                               children: [
        //                                                  Text(
        //                                                     "Last Purchase Date: ",
        //                                                     style: TextStyle(
        //                                                         fontSize: 14,
        //                                                         fontWeight:
        //                                                             FontWeight
        //                                                                 .bold)),
        //                                                 SizedBox(width: 10),
        //                                                 Row(
        //                                                   children: [
        //                                                     Container(
        //                                                       height: 25,
        //                                                       width: MediaQuery.of(
        //                                                                   context)
        //                                                               .size
        //                                                               .width /
        //                                                           2.9,
        //                                                       child: TextField(
        //                                                         readOnly: true,
        //                                                         controller: feedbackList[index][i][4],
        //                                                         decoration:
        //                                                             InputDecoration(
        //                                                           contentPadding: EdgeInsets.only(top: 7, left: 5),
        //                                                           border:
        //                                                               OutlineInputBorder(
        //                                                             borderRadius:
        //                                                                 BorderRadius.circular(
        //                                                                     5.0),
        //                                                           ),
        //                                                           filled: true,
        //                                                           hintStyle: TextStyle(
        //                                                               color: Colors
        //                                                                   .black,
        //                                                               fontSize:
        //                                                                   10),
        //                                                           hintText:
        //                                                               "Date",
        //                                                           fillColor: Colors
        //                                                               .white70,
        //                                                         ),
        //                                                         onTap: () async {
        //                                                           DateTime?pickedDate =
        //                                                               await showDatePicker(
        //                                                                   context: context,
        //                                                                   initialDate: DateTime.now(),
        //                                                                   firstDate: DateTime(1950),
        //                                                                   lastDate: DateTime(2100),
        //                                                                   builder: (context, child) {
        //                                                                     return Theme(
        //                                                                         data: Theme.of(context).copyWith(
        //                                                                           colorScheme: ColorScheme.light(primary: colors.primary),
        //                                                                         ),
        //                                                                         child: child!);
        //                                                                   });
        //                                                           if (pickedDate != null) {
        //                                                             String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
        //                                                             feedbackList[index][i][4].text = formattedDate;
        //                                                             setState(
        //                                                                 () {
        //                                                               dateinput.text = formattedDate;
        //                                                             });
        //                                                           }
        //                                                         },
        //                                                       ),
        //                                                     ),
        //                                                   ],
        //                                                 ),
        //                                               ],
        //                                             ),
        //                                             const SizedBox(
        //                                               height: 5,
        //                                             ),
        //                                           ],
        //                                         );
        //                                       }),
        //                                 ),
        //                               ),
        //                             ],
        //                           ),
        //                         ),
        //                       ],
        //                     ),
        //                   ),
        //                 ),
        //               ),
        //             ],
        //           );
        //         },
        //       ),
        //     ),
        //     Padding(
        //       padding: const EdgeInsets.only(left: 15, right: 15),
        //       child: Row(
        //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //         children: [
        //           Text(
        //             "Sum Of Expected",
        //             style: TextStyle(
        //               fontSize: 13,
        //               fontWeight: FontWeight.w800,
        //             ),
        //           ),
        //           Text("${totalMonthlySales}",
        //               style: TextStyle(
        //                 fontSize: 13,
        //                 fontWeight: FontWeight.w800,
        //               ))
        //         ],
        //       ),
        //     ),
        //     SizedBox(height: 10),
        //     Padding(
        //       padding: const EdgeInsets.only(left: 15, right: 15),
        //       child: Row(
        //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //         children: [
        //           Text(
        //             "Sum Of Further",
        //             style: TextStyle(fontSize: 13, fontWeight: FontWeight.w800),
        //           ),
        //           Text("${currentSales}",
        //               style: TextStyle(fontSize: 13, fontWeight: FontWeight.w800),
        //           )
        //         ],
        //       ),
        //     ),
        //     SizedBox(
        //       height: 10,
        //     ),
        //     // InkWell(
        //     //   onTap: () {
        //     //     // Navigator.push(context, MaterialPageRoute(builder: (context) => Survey()));
        //     //     for (int i = 0; i < (widget.modelList?.length ?? 0); i++) {
        //     //       for (int j = 0;
        //     //           j < (widget.modelList?[i].products?.length ?? 0);
        //     //           j++) {
        //     //         dataList.add(json.encode({
        //     //
        //     //           "brand_name": widget.modelList?[i].name,
        //     //           "total_consumption": feedbackList[i][i][0].text,
        //     //           "further_consumption": feedbackList[i][j][1].text,
        //     //           "purchase_price": feedbackList[i][j][2].text,
        //     //           "purchasing_from": feedbackList[i][j][3].text,
        //     //           "last_purchase_date": feedbackList[i][j][4].text
        //     //           // "monthly_sale": feedbackList[i][j][0].text,
        //     //           // "current_stock": feedbackList[i][j][1].text,
        //     //           // "wps": feedbackList[i][j][2].text,
        //     //           // "rsp": feedbackList[i][j][3].text,
        //     //           // "purchasing_from": feedbackList[i][j][4].text
        //     //         }));
        //     //       }
        //     //     }
        //     //     siteSurvey();
        //     //   },
        //     //   child: Center(
        //     //     child: Container(
        //     //         height: 40,
        //     //         width: MediaQuery.of(context).size.width / 1.8,
        //     //         decoration: BoxDecoration(
        //     //             borderRadius: BorderRadius.circular(5),
        //     //             color: colors.primary),
        //     //         child: const Center(
        //     //             child: Text("Submit",
        //     //                 style: TextStyle(
        //     //                     fontSize: 15,
        //     //                     color: Colors.white,
        //     //                     fontWeight: FontWeight.w400)))),
        //     //   ),
        //     // ),
        //     // SizedBox(height: 5)
        //   ],
        // ),
      ),
      bottomSheet:  Container(
        color: colors.whiteTemp,
        height: 35,
        child: InkWell(
          onTap: () {
            // Navigator.push(context, MaterialPageRoute(builder: (context) => Survey()));
            if(
            execteddateCtr.text.isEmpty || execteddateCtr.text == ""
            ){
              Fluttertoast.showToast(msg: "Please select expected order date");
            }
            else if(remarkCtr.text.isEmpty || remarkCtr.text ==""){
              Fluttertoast.showToast(msg: "Please enter remark");
            }
            else if(imagePathList.isEmpty){
              Fluttertoast.showToast(msg: "Please upload image");
            }
            else{
              for (int i = 0; i < (widget.modelList?.length ?? 0); i++) {
                for (int j = 0;
                j < (widget.modelList?[i].products?.length ?? 0);
                j++) {
                  dataList.add(json.encode({
                    "brand_name": widget.modelList?[i].name,
                    "total_consumption": feedbackList[i][i][0].text,
                    "further_consumption": feedbackList[i][j][1].text,
                    "purchase_price": feedbackList[i][j][2].text,
                    "purchasing_from": feedbackList[i][j][3].text,
                    "last_purchase_date": feedbackList[i][j][4].text
                    // "monthly_sale": feedbackList[i][j][0].text,
                    // "current_stock": feedbackList[i][j][1].text,
                    // "wps": feedbackList[i][j][2].text,
                    // "rsp": feedbackList[i][j][3].text,
                    // "purchasing_from": feedbackList[i][j][4].text
                  }));
                }
              }
              siteSurvey();
            }

          },
          child: Center(
            child: Container(
                height: 40,
                width: MediaQuery.of(context).size.width / 1.8,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: colors.primary),
                child: const Center(
                    child: Text("Submit",
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                            fontWeight: FontWeight.w400)))),
          ),
        ),
      ),
    );
  }
}
