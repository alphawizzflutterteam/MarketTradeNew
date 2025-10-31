import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:omega_employee_management/Helper/Session.dart';
import 'package:omega_employee_management/Helper/String.dart';
import 'package:omega_employee_management/Screen/check_In_screen.dart';

import '../Helper/Color.dart';
import '../Model/DealingProductModel.dart';
import '../Model/GravanceModel.dart';
import 'Dashboard.dart';

class Survey extends StatefulWidget {
  final List<DealingData>? modelList;
  final String? name;
  final String? email;
  final String? contact;
  final String? customerType;
  final String? creditLimit;
  final String? time;
  final String? date;
  // final String? remark;
  // List<String>? image;
  final String? clintId;
  // final String? dealerName;
  // final String? dealerMobile;
  // final String? dealermail;
  // final String? dealerLimit;

  Survey({
    Key? key,
    this.modelList,
    this.name,
    this.email,
    this.contact,
    this.creditLimit,
    this.customerType,
    this.time,
    this.date,
    this.clintId,
    // this.image, this.remark, this.dealerLimit, this.dealermail, this.dealerMobile, this.dealerName
  }) : super(key: key);

  @override
  State<Survey> createState() => _SurveyState();
}

int count = 0;

class _SurveyState extends State<Survey> {
  List<TextEditingController> monthlyControllers = [];
  List<TextEditingController> currentController = [];
  List<TextEditingController> rspController = [];
  int totalMonthlySales = 0;
  int currentSales = 0;
  int sum = 0;
  int currentSum = 0;
  List<int> sums = [];
  // List<int> sumsTemp = [];
  List<int> currentSums = [];
  // List<int> currentSumsTemp = [];
  TextEditingController rsp = TextEditingController();
  TextEditingController purchasingForm = TextEditingController();
  // List<List<TextEditingController>> wholeDataList = [] ;
  List dataList = [];
  List<List<List<TextEditingController>>> feedbackList = [];
  List<List<List<int>>> sumsTemp = [];
  List<List<List<int>>> currentSumsTemp = [];

  void initState() {
    super.initState();
    getCurrentLoc();
    convertDateTimeDispla();
    getgravance();
    for (int i = 0; i < (widget.modelList?.length ?? 0); i++) {
      List<List<TextEditingController>> wholeDataList = [];
      List<List<int>> wholeDataListTemp = [];

      for (int j = 0; j < (widget.modelList?[i].products?.length ?? 0); j++) {
        List<TextEditingController> commenController = [];
        List<int> commenControllerTemp = [];
        commenController.add(TextEditingController());
        commenController.add(TextEditingController());
        commenController.add(TextEditingController());
        commenController.add(TextEditingController());
        commenController.add(TextEditingController());
        commenControllerTemp.add(0);
        commenControllerTemp.add(0);
        commenControllerTemp.add(0);
        commenControllerTemp.add(0);
        commenControllerTemp.add(0);
        wholeDataList.add(commenController);
        wholeDataListTemp.add(commenControllerTemp);
      }
      feedbackList.add(wholeDataList);
      sumsTemp.add(wholeDataListTemp);
    }
    for (var i = 0; i < (widget.modelList?.length ?? 0); i++) {
      sums.add(sum);
      //sumsTemp.add(sum);
    }
    for (var i = 0; i < (widget.modelList?.length ?? 0); i++) {
      currentSums.add(currentSum);
      //currentSumsTemp.add(currentSales);
    }
  }

  Future<void> feedback() async {
    setState(() {
      isLoading = true;
    });
    var request = http.MultipartRequest(
        'POST', Uri.parse(customerFeedbackForm.toString()));
    request.fields.addAll({
      'user_id': '${CUR_USERID}',
      'date': widget.date.toString(),
      'time': widget.time.toString(),
      'lat': latitude.toString(),
      'lng': longitude.toString(),
      'name_of_firm': widget.clintId.toString(),
      'total_current_stock': '${sumOfCurrentStock}',
      'total_monthly_sale': '${sumOfMonthlySale}',
      'basic_detail': jsonEncode({
        'name': widget.name,
        'mobile': widget.contact,
        'email': widget.email,
        'address': "${currentAddress.text}",
        'customer_type': widget.customerType,
        'credit_limit': widget.creditLimit,
        'grivenance': selectedName.toString(),
      }),
      'customer_dealing_in':
          widget.modelList!.map((product) => product.id).join(','),
      'survey': dataList.toString(),
      'remarks': remarkCtr.text ?? ''
    });
    for (var i = 0; i < (imagePathList.length ?? 0); i++) {
      debugPrint("imageeeee: ${imagePathList[i].toString()}");
      imagePathList[i] == ""
          ? null
          : request.files.add(await http.MultipartFile.fromPath(
              'photos[]', "${imagePathList[i].toString()}"));
    }
    print('sssssssssssss${request.fields}');
    log(request.fields.toString());
    print('${request.url}');
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
      setState(() {
        isLoading = false;
      });
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => Dashboard()));
    } else {
      print("reasonnnnnn" + response.reasonPhrase.toString());
    }
  }

  int selectedIndex = 0;
  List toggled = [];
  bool flag = true;
  bool expand = true;
  File? _imageFile;

  _getFromCamera() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
        source: ImageSource.camera,
        maxWidth: 300,
        maxHeight: 500,
        imageQuality: 80);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
        imagePathList.add(_imageFile?.path ?? "");
        isImages = true;
      });
      //Navigator.pop(context);
    }
  }

  TextEditingController remarkCtr = TextEditingController();
  List<String> imagePathList = [];
  bool isImages = false;
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
        Visibility(visible: isImages, child: buildGridView()),
      ],
    );
  }

  var dateFormate;
  String? formattedDate;
  String? timeData;

  convertDateTimeDispla() {
    var now = new DateTime.now();
    var formatter = new DateFormat('dd-MM-yyyy');
    formattedDate = formatter.format(now);
    print("datedetet${formattedDate}"); // 2016-01-25
    timeData = DateFormat("hh:mm:ss a").format(DateTime.now());
    print("timeeeeeeeeee${timeData}");
  }

  Widget buildGridView() {
    return Container(
      height: 160,
      child: GridView.builder(
        itemCount: imagePathList.length,
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (BuildContext context, int index) {
          return Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: colors.primary)),
                width: MediaQuery.of(context).size.width / 2.8,
                height: 160,
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  child:
                      Image.file(File(imagePathList[index]), fit: BoxFit.cover),
                ),
              ),
              Positioned(
                bottom: 5,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: colors.primary),
                  ),
                  width: MediaQuery.of(context).size.width / 2.8,
                  height: 120,
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
              Positioned(
                top: 0,
                right: 40,
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

  GravanceModel? gravanceModel;
  getgravance() async {
    var headers = {
      'Cookie': 'ci_session=ef29e61acfe01ba495d2b60947f70ae0b26cc807'
    };
    var request = http.MultipartRequest('POST',
        Uri.parse('https://businesstrack.co.in/app/v1/api/grivenance_list'));
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      String str = await response.stream.bytesToString();
      var result = json.decode(str);
      var finalResponse = GravanceModel.fromJson(result);
      setState(() {
        gravanceModel = finalResponse;
      });
    } else {
      print(response.reasonPhrase);
    }
  }

  int? sumOfMonthlySale;
  int? sumOfCurrentStock;
  String? gravance;
  bool isExpanded = false;
  String? selectedName;
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: true,
      top: false,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 1,
          leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back_ios, color: Colors.white),
          ),
          centerTitle: true,
          backgroundColor: colors.primary,
          title: Text(
            "Feedback",
            style: TextStyle(
                fontSize: 15, color: Colors.white, fontWeight: FontWeight.w800),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 5),
              Container(
                // height: MediaQuery.of(context).size.height / 1.9,
                child: ListView.builder(
                  shrinkWrap: true,
                  key: Key('${selectedIndex.toString()}'),
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: widget.modelList?.length ?? 0,
                  itemBuilder: (context, index) {
                    var item = widget.modelList?[index];
                    return Padding(
                      padding: const EdgeInsets.all(8),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 4),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(0),
                            border: Border.all(color: colors.black54)),
                        child:
                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            //   children: [
                            //     Row(
                            //       children: [
                            //         const Text("Product Name: "),
                            //         Text(
                            //           '${item?.name}',
                            //           style: TextStyle(fontSize: 14),
                            //         ),
                            //       ],
                            //     ),
                            //     IconButton(
                            //         onPressed: () {
                            //           setState(() {
                            //             isExpanded = !isExpanded;
                            //           });
                            //         },
                            //         icon: Icon(isExpanded
                            //             ? Icons.arrow_drop_up
                            //             : Icons.arrow_drop_down))
                            //   ],
                            // )
                            Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            ExpansionTile(
                              collapsedBackgroundColor: colors.whiteTemp,
                              key: Key(index.toString()),
                              initiallyExpanded: index == selectedIndex,
                              title: Column(
                                children: [
                                  Row(
                                    children: [
                                      Text("Product Name: ",
                                          style: TextStyle(fontSize: 14)),
                                      Text(
                                        '${item?.name}',
                                        style: TextStyle(fontSize: 14),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              onExpansionChanged: (isExpanded) {
                                if (isExpanded) {
                                  setState(() {
                                    const Duration(milliseconds: 2000);
                                    selectedIndex = index;
                                    // isExpanded = true;
                                  });
                                } else {
                                  setState(() {
                                    selectedIndex = -1;
                                  });
                                }
                              },
                              children: [
                                Container(
                                  height:
                                      MediaQuery.of(context).size.height / 3.6,
                                  width:
                                      MediaQuery.of(context).size.width / 1.2,
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
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                const Text("Brand Name: ",
                                                    style: TextStyle(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                                Text(data?.name ?? "",
                                                    style: TextStyle(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: colors.primary)),
                                              ],
                                            ),
                                            const SizedBox(height: 5),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                const Text("Monthly Sale: ",
                                                    style: TextStyle(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                                SizedBox(width: 10),
                                                Container(
                                                  height: 30,
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      2.9,
                                                  child: TextField(
                                                    controller:
                                                        feedbackList[index][i]
                                                            [0],
                                                    onChanged: (val) {
                                                      setState(() {
                                                        if (sumsTemp[index][i]
                                                                [0] !=
                                                            0) {
                                                          sums[index] -=
                                                              sumsTemp[index][i]
                                                                  [0];
                                                        }
                                                        sumsTemp[index][i]
                                                            [0] = val
                                                                .isEmpty
                                                            ? 0
                                                            : int.parse(val);
                                                        sums[index] =
                                                            sums[index] +
                                                                (val.isEmpty
                                                                    ? 0
                                                                    : int.parse(
                                                                        val));
                                                        sumOfMonthlySale =
                                                            sums[index];
                                                        print(
                                                            "jhjshjsajd ${sumOfMonthlySale}");
                                                      });
                                                      // FocusScope.of(context).unfocus();
                                                    },
                                                    keyboardType:
                                                        TextInputType.number,
                                                    decoration: InputDecoration(
                                                      contentPadding:
                                                          EdgeInsets.only(
                                                              top: 7, left: 5),
                                                      border:
                                                          OutlineInputBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          5.0)),
                                                      filled: true,
                                                      hintStyle: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 10),
                                                      hintText: "Monthly Sale",
                                                      fillColor: Colors.white70,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                const Text("Current Stock: ",
                                                    style: TextStyle(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                                SizedBox(width: 10),
                                                Container(
                                                  height: 30,
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      2.9,
                                                  child: TextField(
                                                    controller:
                                                        feedbackList[index][i]
                                                            [1],
                                                    onChanged: (val) {
                                                      setState(() {
                                                        if (sumsTemp[index][i]
                                                                [1] !=
                                                            0) {
                                                          currentSums[index] -=
                                                              sumsTemp[index][i]
                                                                  [1];
                                                        }
                                                        sumsTemp[index][i]
                                                            [1] = val
                                                                .isEmpty
                                                            ? 0
                                                            : int.parse(val);
                                                        currentSums[index] +=
                                                            val.isEmpty
                                                                ? 0
                                                                : int.parse(
                                                                    val);
                                                        sumOfCurrentStock =
                                                            currentSums[index];
                                                        // feedbackList[index][i][0].text
                                                      });
                                                    },
                                                    keyboardType:
                                                        TextInputType.number,
                                                    decoration: InputDecoration(
                                                      contentPadding:
                                                          EdgeInsets.only(
                                                              top: 7, left: 5),
                                                      border:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5.0),
                                                      ),
                                                      filled: true,
                                                      hintStyle: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 10),
                                                      hintText: "Current stock",
                                                      fillColor: Colors.white70,
                                                    ),
                                                    // onSubmitted: (value) {
                                                    //   currentSales += int.parse(value);
                                                    //   setState(() {});
                                                    //   print("printtttttttt ${currentSales}");
                                                    // },
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                const Text("WSP: ",
                                                    style: TextStyle(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Container(
                                                  height: 30,
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      2.9,
                                                  child: TextField(
                                                    controller:
                                                        feedbackList[index][i]
                                                            [2],
                                                    keyboardType:
                                                        TextInputType.number,
                                                    decoration: InputDecoration(
                                                      contentPadding:
                                                          EdgeInsets.only(
                                                              top: 7, left: 5),
                                                      border:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5.0),
                                                      ),
                                                      filled: true,
                                                      hintStyle: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 10),
                                                      hintText: "WSP",
                                                      fillColor: Colors.white70,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                const Text("RSP: ",
                                                    style: TextStyle(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                                SizedBox(width: 10),
                                                Container(
                                                  height: 30,
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      2.9,
                                                  child: TextField(
                                                    controller:
                                                        feedbackList[index][i]
                                                            [3],
                                                    keyboardType:
                                                        TextInputType.number,
                                                    decoration: InputDecoration(
                                                      contentPadding:
                                                          EdgeInsets.only(
                                                              top: 7, left: 5),
                                                      border:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5.0),
                                                      ),
                                                      filled: true,
                                                      hintStyle: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 10),
                                                      hintText: "RSP",
                                                      fillColor: Colors.white70,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                const Text("Purchasing Form: ",
                                                    style: TextStyle(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                                SizedBox(width: 10),
                                                Row(
                                                  // mainAxisAlignment: MainAxisAlignment.end,
                                                  // crossAxisAlignment: CrossAxisAlignment.end,
                                                  children: [
                                                    Container(
                                                      height: 30,
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width /
                                                              2.9,
                                                      child: TextField(
                                                        controller:
                                                            feedbackList[index]
                                                                [i][4],
                                                        keyboardType:
                                                            TextInputType.text,
                                                        decoration:
                                                            InputDecoration(
                                                          contentPadding:
                                                              EdgeInsets.only(
                                                                  top: 7,
                                                                  left: 5),
                                                          border:
                                                              OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5.0),
                                                          ),
                                                          filled: true,
                                                          hintStyle: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 10),
                                                          hintText: "",
                                                          fillColor:
                                                              Colors.white70,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Divider(
                                              color: Colors.black,
                                            ),
                                            SizedBox(height: 5),
                                            // if(item?.products?.last == item?.products?[i])
                                            //   SizedBox(
                                            //     height: 120,
                                            //   ),
                                            // const SizedBox(height: 5,),
                                            // Row(
                                            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            //   children: [
                                            //     Text("Sum Of Monthly sale", style: TextStyle(fontSize: 13, fontWeight: FontWeight.w800, ),),
                                            //     Text("${totalMonthlySales}", style: TextStyle(fontSize: 13, fontWeight: FontWeight.w800, ))
                                            //   ],
                                            // ),
                                            // SizedBox(height: 10),
                                            // Row(
                                            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            //   children: [
                                            //     Text("Sum Of Current Stock", style: TextStyle(fontSize: 13, fontWeight: FontWeight.w800),),
                                            //     Text("${currentSales}", style: TextStyle(fontSize: 13, fontWeight: FontWeight.w800))
                                            //   ],
                                            // ),
                                          ],
                                        );
                                      }),
                                ),
                              ],
                            ),
                            selectedIndex == index
                                ? Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        "Sum of Monthly Sale: ",
                                        style: TextStyle(
                                            fontSize: 15,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      Text(
                                        sums[index].toString(),
                                        style: TextStyle(
                                            fontSize: 15,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ],
                                  )
                                : const SizedBox.shrink(),
                            SizedBox(
                              height: 3,
                            ),
                            selectedIndex == index
                                ? Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        "Sum of Current Stock: ",
                                        style: TextStyle(
                                            fontSize: 15,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      Text(
                                        currentSums[index].toString(),
                                        style: TextStyle(
                                            fontSize: 15,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ],
                                  )
                                : const SizedBox.shrink()
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 9),
                  const Text(
                    "Grievance",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .01,
                  ),
                  Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width / 1.1,
                    child: Card(
                      elevation: 2,
                      shape: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      child: DropdownButtonFormField<String>(
                        value: gravance,
                        onChanged: (newValue) {
                          setState(() {
                            gravance = newValue;
                            print("current indexxx ${gravance} ");
                            selectedName = gravanceModel?.data
                                ?.firstWhere((item) => item.id == newValue)
                                .title;
                            print(
                                "Selected ID: $gravance, Selected Name: $selectedName");
                            // nwIndex = delearRetailerModel!.data!.indexWhere((element) => element.id == selected);
                            // currentIndex = selected;
                            // showTextField = true;
                          });
                        },
                        items: gravanceModel?.data?.map((items) {
                          return DropdownMenuItem(
                            value: items.id,
                            child: Text(items.title.toString()),
                          );
                        }).toList(),
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(bottom: 5, left: 10),
                          border: InputBorder.none,
                          hintText: '',
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * .02,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Remark",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .01,
                  ),
                  Container(
                    height: 45,
                    width: MediaQuery.of(context).size.width / 1.1,
                    child: TextFormField(
                      keyboardType: TextInputType.text,
                      controller: remarkCtr,
                      decoration: InputDecoration(
                        hintText: '',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * .02,
              ),
              uploadMultiImage(),
              SizedBox(height: MediaQuery.of(context).size.height * .05),
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
        ),
        bottomSheet: Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: Container(
            color: colors.whiteTemp,
            height: 35,
            child: InkWell(
              onTap: () {
                if (gravance == null || gravance == "") {
                  setSnackbar("Please select Grievance", context);
                } else if (imagePathList.isEmpty) {
                  Fluttertoast.showToast(msg: "Please upload image");
                } else if (remarkCtr.text.isEmpty || remarkCtr.text == "") {
                  Fluttertoast.showToast(msg: "Please enter remark");
                }
                // Navigator.push(context, MaterialPageRoute(builder: (context) => Survey()));
                else {
                  for (int i = 0; i < (widget.modelList?.length ?? 0); i++) {
                    for (int j = 0;
                        j < (widget.modelList?[i].products?.length ?? 0);
                        j++) {
                      print('${widget.modelList?[i].products?.length}');
                      dataList.add(
                        json.encode({
                          "cid": "${widget.modelList![i].products?[j].id}",
                          "brand_name": widget.modelList?[i].products?[j].name,
                          "monthly_sale": feedbackList[i][j][0].text,
                          "current_stock": feedbackList[i][j][1].text,
                          "wps": feedbackList[i][j][2].text,
                          "rsp": feedbackList[i][j][3].text,
                          "purchasing_from": feedbackList[i][j][4].text
                        }),
                      );
                    }
                    setState(() {
                      isLoading = true;
                    });
                    print('${dataList}');
                  }
                  feedback();
                }
              },
              child: Center(
                child: Container(
                  height: 35,
                  width: MediaQuery.of(context).size.width / 1.8,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: colors.primary),
                  child: Center(
                      child: isLoading
                          ? Center(
                              child: CircularProgressIndicator(
                                color: Colors.white,
                              ),
                            )
                          : Text("Submit Feedback",
                              style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w400))),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
