import 'dart:convert';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:image_gallery_saver_plus/image_gallery_saver_plus.dart';
import 'package:omega_employee_management/Helper/String.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../Helper/Color.dart';
import '../Model/GetFeedbackModel.dart';

class Customer_feedback extends StatefulWidget {
  final CounterData? model;
  Customer_feedback({Key? key, this.model}) : super(key: key);

  @override
  State<Customer_feedback> createState() => _Customer_feedbackState();
}

class _Customer_feedbackState extends State<Customer_feedback> {
  TextEditingController namecn = TextEditingController();
  TextEditingController emailcn = TextEditingController();
  TextEditingController timecn = TextEditingController();
  TextEditingController firmnamecn = TextEditingController();
  TextEditingController datecn = TextEditingController();
  TextEditingController remarkcn = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    var length = widget.model?.survey?.length ?? 0;
    for (int i = 0; i < length; i++) {
      monthlyCtr.add(TextEditingController());
      purchasingFormCtr.add(TextEditingController());
      rspCtr.add(TextEditingController());
      wspCtr.add(TextEditingController());
      currentStockCtr.add(TextEditingController());
    }
    // monthlyCtr.text = widget.model?.survey?[0].monthlySale ?? "";
    // purchasingFormCtr.text = widget.model?.survey?[0].purchasingFrom ?? "";
    // rspCtr.text = widget.model?.survey?[0].rsp ?? "";
    // wspCtr.text = widget.model?.survey?[0].wps ?? "";
    // currentStockCtr.text = widget.model?.survey?[0].currentStock ?? "";
  }

  List<TextEditingController> monthlyCtr = [];
  List<TextEditingController> purchasingFormCtr = [];
  List<TextEditingController> rspCtr = [];
  List<TextEditingController> wspCtr = [];
  List<TextEditingController> currentStockCtr = [];

  _launchMap(lat, lng) async {
    var url = '';
    if (Platform.isAndroid) {
      url =
          "https://www.google.com/maps/dir/?api=1&destination=$lat,$lng&travelmode=driving&dir_action=navigate";
    } else {
      url =
          "http://maps.apple.com/?saddr=&daddr=$lat,$lng&directionsmode=driving&dir_action=navigate";
    }
    await launch(url);
/*    if (await canLaunch(url)) {

    } else {
      throw 'Could not launch $url';
    }*/
  }

  Future<bool> _requestPermission(Permission permission) async {
    final plugin = DeviceInfoPlugin();
    final android = await plugin.androidInfo;
    print("++++++++++++");
    var status = android.version.sdkInt < 33
        ? await Permission.storage.request()
        : PermissionStatus.granted;
    if (await permission.isGranted) {
      return true;
    } else {
      return status == PermissionStatus.granted;
    }
  }

  Future<void> downloadImage(String imageUrl) async {
    // print("mmmmmmmm");
    var response = await http.get(Uri.parse(imageUrl));

    if (response.statusCode == 200) {
      final result = await ImageGallerySaverPlus.saveImage(
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.whit,
      appBar: AppBar(
        elevation: 1,
        backgroundColor: colors.primary,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back_ios),
        ),
        centerTitle: true,
        title: Text(
          "Counter Visit View",
          style: TextStyle(
              fontSize: 17, color: Colors.white, fontWeight: FontWeight.w800),
        ),
      ),
      body: widget.model == null
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Card(
                      elevation: 3,
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white),
                        // height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width / 1,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 10, right: 15, top: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 150,
                                child: ListView.builder(
                                  scrollDirection: Axis
                                      .horizontal, // Scroll direction set to horizontal
                                  itemCount: widget.model?.photo?.length,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: const EdgeInsets.only(left: 5),
                                      child: Stack(
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              if (widget.model?.photo?[index] !=
                                                  null) {
                                                final imageProvider =
                                                    Image.network(widget.model
                                                                    ?.photo?[
                                                                index] ??
                                                            '')
                                                        .image;
                                                showImageViewer(
                                                    context, imageProvider,
                                                    onViewerDismissed: () {
                                                  print("dismissed");
                                                });
                                              }
                                            },
                                            onLongPress: () {
                                              if (widget.model?.photo?[index] !=
                                                  null)
                                                showDilaogBox(widget
                                                        .model?.photo?[index] ??
                                                    "");
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  border: Border.all(
                                                      color: colors.primary)),
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  2.6,
                                              height: 180,
                                              child: ClipRRect(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10)),
                                                child: Image.network(
                                                  '${widget.model?.photo?[index]}',
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            top: 105,
                                            right: 0,
                                            child: InkWell(
                                              onTap: () async {
                                                try {
                                                  if (await _requestPermission(
                                                      Permission.storage)) {
                                                    final http.Response
                                                        response =
                                                        await http.get(
                                                            Uri.parse(widget
                                                                    .model!
                                                                    .photo![
                                                                index]));
                                                    if (response.statusCode ==
                                                        200) {
                                                      final Uint8List data =
                                                          response.bodyBytes;
                                                      final result =
                                                          await ImageGallerySaverPlus
                                                              .saveImage(data);
                                                      print(result);
                                                      if (result['isSuccess'] ==
                                                          true) {
                                                        ScaffoldMessenger.of(
                                                                context)
                                                            .showSnackBar(
                                                          SnackBar(
                                                              content: Text(
                                                                  'Image downloaded')),
                                                        );
                                                      } else {
                                                        ScaffoldMessenger.of(
                                                                context)
                                                            .showSnackBar(
                                                          SnackBar(
                                                              content: Text(
                                                                  'Failed to download image')),
                                                        );
                                                      }
                                                    } else {
                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .showSnackBar(
                                                        SnackBar(
                                                            content: Text(
                                                                'Failed to download image')),
                                                      );
                                                    }
                                                  }
                                                } catch (e) {
                                                  print(e);
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                    SnackBar(
                                                        content: Text(
                                                            'Failed to download image')),
                                                  );
                                                }
                                              },
                                              child: Row(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 0, bottom: 5),
                                                    child: Column(
                                                      children: [
                                                        Text(
                                                          "${widget.model?.createdAt}",
                                                          style: TextStyle(
                                                              fontSize: 10,
                                                              color:
                                                                  Colors.red),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  left: 14),
                                                          child: Text(
                                                            "${widget.model?.lat},${widget.model?.lng}",
                                                            style: TextStyle(
                                                                fontSize: 10,
                                                                color:
                                                                    Colors.red),
                                                          ),
                                                        ),
                                                        Text(
                                                          "${widget.model?.basicDetail?.address}",
                                                          style: TextStyle(
                                                              fontSize: 10,
                                                              color:
                                                                  Colors.red),
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          maxLines: 1,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Container(
                                                    height: 30,
                                                    width: 30,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(30),
                                                        color: Colors.red),
                                                    child: Icon(
                                                      Icons.download,
                                                      size: 20,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ),
                              SizedBox(height: 10),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Firm Address:",
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.black)),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                2,
                                        child: Text(
                                          "${widget.model?.refAddress ?? ""} ${widget.model?.refDist ?? ""}",
                                          style: TextStyle(
                                            overflow: TextOverflow.ellipsis,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w200,
                                            color: Colors.black,
                                          ),
                                          maxLines: 4,
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Firm Name:",
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        "${widget.model?.firmname ?? ""}",
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w200,
                                            color: Colors.black),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Owner Name:",
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black),
                                      ),
                                      Text(
                                          "${widget.model?.basicDetail?.name ?? ""}",
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w200,
                                              color: Colors.black))
                                    ],
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Customer Type:",
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.black)),
                                      Text(
                                          "${widget.model?.basicDetail?.customerType ?? ""}",
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w200,
                                              color: Colors.black))
                                    ],
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Mobile Number:",
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.black)),
                                      Text(
                                        "${widget.model?.basicDetail?.mobile ?? ""}",
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w200,
                                            color: Colors.black),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "User Name:",
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black),
                                      ),
                                      Text(
                                        "${widget.model?.username ?? ""}",
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w200,
                                            color: Colors.black),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Date & Time:",
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black),
                                      ),
                                      Text(
                                        "${widget.model?.date ?? ""}${widget.model?.time ?? ""}",
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w200,
                                            color: Colors.black),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Latitude:",
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.black)),
                                      Text(
                                        "${widget.model?.lat ?? ""}",
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w200,
                                            color: Colors.black),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Longitude:",
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.black)),
                                      Text(
                                        "${widget.model?.lng ?? ""}",
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w200,
                                            color: Colors.black),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Address:",
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black),
                                      ),
                                      SizedBox(
                                        width: 64,
                                      ),
                                      Text(
                                        "${widget.model?.basicDetail?.address ?? ""}",
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w200,
                                            color: Colors.black),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      SizedBox(
                                        width: 4,
                                      ),
                                      InkWell(
                                        onTap: () {
                                          _launchMap(
                                            widget.model?.lat,
                                            widget.model?.lng,
                                            // orderItem.sellerLatitude,
                                            // orderItem.sellerLongitude
                                          );
                                        },
                                        child: Icon(
                                          Icons.location_disabled,
                                          color: colors.primary,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Grievance:",
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black),
                                      ),
                                      Text(
                                        "${widget.model?.basicDetail?.grivenance ?? ""}",
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w200,
                                            color: Colors.black),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Remarks:",
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.black)),
                                      Text(
                                        "${widget.model?.remarks ?? ""}",
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w200,
                                            color: Colors.black),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  ListView.builder(
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      itemCount:
                                          widget.model?.finalTotal?.length,
                                      itemBuilder: (c, j) {
                                        return Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  "Sum Of Monthly Sale Of ${widget.model?.finalTotal?[j].title}"
                                                      .toUpperCase(),
                                                  style: TextStyle(
                                                      fontSize: 13,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: Colors.black),
                                                ),
                                                Text(
                                                  "₹ ${widget.model?.finalTotal?[j].monthlySale}"
                                                      .toUpperCase(),
                                                  style: TextStyle(
                                                      fontSize: 13,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: Colors.black),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  "Sum Of Current Stock Of ${widget.model?.finalTotal?[j].title}"
                                                      .toUpperCase(),
                                                  style: TextStyle(
                                                      fontSize: 13,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: Colors.black),
                                                ),
                                                Text(
                                                  "₹ ${widget.model?.finalTotal?[j].currentStock}",
                                                  style: TextStyle(
                                                      fontSize: 13,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: Colors.black),
                                                ),
                                              ],
                                            ),
                                          ],
                                        );
                                      }),
                                  Divider(
                                    color: Colors.black,
                                  ),
                                  ListView.builder(
                                      shrinkWrap: true,
                                      itemCount:
                                          widget.model?.survey?.length ?? 0,
                                      physics: NeverScrollableScrollPhysics(),
                                      itemBuilder: (_, i) {
                                        monthlyCtr[i].text = widget.model
                                                ?.survey?[i].monthlySale ??
                                            "";
                                        currentStockCtr[i].text = widget.model
                                                ?.survey?[i].currentStock ??
                                            "";
                                        wspCtr[i].text =
                                            widget.model?.survey?[i].wps ?? "";
                                        rspCtr[i].text =
                                            widget.model?.survey?[i].rsp ?? "";
                                        purchasingFormCtr[i].text = widget.model
                                                ?.survey?[i].purchasingFrom ??
                                            "";
                                        return widget.model?.survey?[i].wps ==
                                                    "" ||
                                                widget.model?.survey?[i]
                                                        .monthlySale ==
                                                    "" ||
                                                widget.model?.survey?[i]
                                                        .currentStock ==
                                                    "" ||
                                                widget.model?.survey?[i].rsp ==
                                                    "" ||
                                                widget.model?.survey?[i]
                                                        .purchasingFrom ==
                                                    ""
                                            ? SizedBox()
                                            : Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        "Product Name:",
                                                        style: TextStyle(
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            color:
                                                                Colors.black),
                                                      ),
                                                      Text(
                                                        "${widget.model?.survey?[i].cid}",
                                                        style: TextStyle(
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            color:
                                                                Colors.black),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            .02,
                                                  ),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text(
                                                            "Brand Name:",
                                                            style: TextStyle(
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                color: Colors
                                                                    .black),
                                                          ),
                                                          Text(
                                                            "${widget.model?.survey?[i].brandName}",
                                                            style: TextStyle(
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                color: Colors
                                                                    .black),
                                                          ),
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        height: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .height *
                                                            .01,
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text(
                                                            "Monthly Sale:",
                                                            style: TextStyle(
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                color: Colors
                                                                    .black),
                                                          ),
                                                          Container(
                                                            height: 30,
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width /
                                                                2.9,
                                                            child: TextField(
                                                              readOnly: true,
                                                              controller:
                                                                  monthlyCtr[i],
                                                              keyboardType:
                                                                  TextInputType
                                                                      .number,
                                                              decoration:
                                                                  InputDecoration(
                                                                contentPadding:
                                                                    EdgeInsets.only(
                                                                        top: 7,
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
                                                                    fontSize:
                                                                        10),
                                                                hintText: "",
                                                                fillColor: Colors
                                                                    .white70,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        height: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .height *
                                                            .02,
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text(
                                                              "Current Stock: ",
                                                              style: TextStyle(
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  color: Colors
                                                                      .black)),
                                                          Container(
                                                            height: 30,
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width /
                                                                2.9,
                                                            child: TextField(
                                                              readOnly: true,
                                                              controller:
                                                                  currentStockCtr[
                                                                      i],
                                                              keyboardType:
                                                                  TextInputType
                                                                      .number,
                                                              decoration:
                                                                  InputDecoration(
                                                                contentPadding:
                                                                    EdgeInsets.only(
                                                                        top: 7,
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
                                                                    fontSize:
                                                                        10),
                                                                hintText: "",
                                                                fillColor: Colors
                                                                    .white70,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        height: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .height *
                                                            .02,
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text("WPS:",
                                                              style: TextStyle(
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  color: Colors
                                                                      .black)),
                                                          Container(
                                                            height: 30,
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width /
                                                                2.9,
                                                            child: TextField(
                                                              readOnly: true,
                                                              controller:
                                                                  wspCtr[i],
                                                              keyboardType:
                                                                  TextInputType
                                                                      .number,
                                                              decoration:
                                                                  InputDecoration(
                                                                contentPadding:
                                                                    EdgeInsets.only(
                                                                        top: 7,
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
                                                                    fontSize:
                                                                        10),
                                                                hintText: "",
                                                                fillColor: Colors
                                                                    .white70,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        height: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .height *
                                                            .02,
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text("RSP:",
                                                              style: TextStyle(
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  color: Colors
                                                                      .black)),
                                                          Container(
                                                            height: 30,
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width /
                                                                2.9,
                                                            child: TextField(
                                                              readOnly: true,
                                                              controller:
                                                                  rspCtr[i],
                                                              keyboardType:
                                                                  TextInputType
                                                                      .number,
                                                              decoration:
                                                                  InputDecoration(
                                                                contentPadding:
                                                                    EdgeInsets.only(
                                                                        top: 7,
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
                                                                    fontSize:
                                                                        10),
                                                                hintText: "",
                                                                fillColor: Colors
                                                                    .white70,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        height: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .height *
                                                            .02,
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text(
                                                              "Purchasing From: ",
                                                              style: TextStyle(
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  color: Colors
                                                                      .black)),
                                                          Container(
                                                            height: 30,
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width /
                                                                2.9,
                                                            child: TextField(
                                                              readOnly: true,
                                                              controller:
                                                                  purchasingFormCtr[
                                                                      i],
                                                              keyboardType:
                                                                  TextInputType
                                                                      .number,
                                                              decoration:
                                                                  InputDecoration(
                                                                contentPadding:
                                                                    EdgeInsets.only(
                                                                        top: 7,
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
                                                                    fontSize:
                                                                        10),
                                                                hintText: "",
                                                                fillColor: Colors
                                                                    .white70,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        height: 5,
                                                      ),
                                                      Divider(
                                                        color: Colors.black,
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                ],
                                              );
                                      }),
                                  SizedBox(
                                    height: 5,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
      // ListView.builder(
      //   itemCount: widget. ?? 0,
      //      shrinkWrap: true,
      //     // physics: NeverScrollableScrollPhysics(),
      //     itemBuilder: (BuildContext, index) {
      //       namecn.text='${getdata?.data?[index].basicDetail?.name??""}';
      //       firmnamecn.text='${getdata?.data?[index].nameOfFirm??""}';
      //       remarkcn.text='${getdata?.data?[index].remarks??""}';
      //       // debugPrint("remarkkkk"+remarkcn.text);
      //       datecn.text='${getdata?.data?[index].date??""}';
      //       timecn.text='${getdata?.data?[index].time??""}';
      //       debugPrint("photos ${getdata?.data?[index].photo}");
      //  return
      //    Card(
      //   elevation: 3,
      //   child: Container(
      //     decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.white),
      //     // height: MediaQuery.of(context).size.height,
      //     width: MediaQuery.of(context).size.width/1,
      //     child: Padding(
      //       padding: const EdgeInsets.only(left: 15, right: 15,top: 20),
      //       child: Column(
      //         crossAxisAlignment: CrossAxisAlignment.start,
      //         children: [
      //           Center(
      //             child: Container(
      //               decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
      //               clipBehavior: Clip.hardEdge,
      //               height: 150,
      //               width: 200,
      //               child: ClipRRect(child: Image.network("${getdata?.data?[index].photo?.first}",fit: BoxFit.fill,)),
      //             ),
      //           ),
      //           SizedBox(height: 10),
      //           Column(
      //             crossAxisAlignment: CrossAxisAlignment.start,
      //             children: [
      //               Text("User Name",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
      //               SizedBox(height: MediaQuery.of(context).size.height*.01),
      //               TextFormField(
      //                   readOnly: true,
      //                   keyboardType: TextInputType.text,
      //                   controller: namecn,
      //                   decoration: InputDecoration(hintText: 'hfg', border: OutlineInputBorder(borderRadius:  BorderRadius.circular(10)))),
      //               SizedBox(height: MediaQuery.of(context).size.height*.02),
      //               Text("Date",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
      //               SizedBox(height: MediaQuery.of(context).size.height*.01,),
      //               TextFormField(
      //                   readOnly: true,
      //                   keyboardType: TextInputType.text,
      //                   controller: datecn,
      //                   decoration: InputDecoration(border: OutlineInputBorder(borderRadius:  BorderRadius.circular(10)))),
      //               SizedBox(height: MediaQuery.of(context).size.height*.02,),
      //               Text("Time",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
      //               SizedBox(height: MediaQuery.of(context).size.height*.01,),
      //               TextFormField(
      //                   readOnly: true,
      //                   keyboardType: TextInputType.text,
      //                   controller: timecn,
      //                   decoration: InputDecoration(border: OutlineInputBorder(borderRadius:  BorderRadius.circular(10)))),
      //               // SizedBox(height: MediaQuery.of(context).size.height*.02,),
      //               // Text("Firm Name",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
      //               // SizedBox(height: MediaQuery.of(context).size.height*.01,),
      //               // TextFormField(
      //               //     readOnly: true,
      //               //     keyboardType: TextInputType.text,
      //               //     controller: firmnamecn,
      //               //     decoration: InputDecoration(border: OutlineInputBorder(borderRadius:  BorderRadius.circular(10)))),
      //               SizedBox(height: MediaQuery.of(context).size.height*.02,),
      //               Text("Remark",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
      //               SizedBox(height: MediaQuery.of(context).size.height*.01,),
      //               TextFormField(
      //                   readOnly: true,
      //                   keyboardType: TextInputType.text,
      //                   controller: remarkcn,
      //                   decoration: InputDecoration(border: OutlineInputBorder(borderRadius:  BorderRadius.circular(10)))),
      //               SizedBox(height: 5,),
      //               Text("Address: ${getdata?.data?[index].basicDetail?.address}",style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),),
      //               SizedBox(height: MediaQuery.of(context).size.height*.02,),
      //               Text("Basic Details:-",style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold),),
      //               SizedBox(height: MediaQuery.of(context).size.height*.02,),
      //               Text("Name: ${getdata?.data?[index].basicDetail?.name}",style: TextStyle(fontSize: 15),),
      //               SizedBox(height: MediaQuery.of(context).size.height*.02,),
      //               Text("Mobile: ${getdata?.data?[index].basicDetail?.mobile}",style: TextStyle(fontSize: 15),),
      //               SizedBox(height: MediaQuery.of(context).size.height*.02,),
      //               Text("email: ${getdata?.data?[index].basicDetail?.email}",style: TextStyle(fontSize: 15),),
      //               SizedBox(height: MediaQuery.of(context).size.height*.02,),
      //               Text("Address: ${getdata?.data?[index].basicDetail?.address}",style: TextStyle(fontSize: 15),),
      //               SizedBox(height: MediaQuery.of(context).size.height*.02,),
      //               Text("Customer Type: ${getdata?.data?[index].basicDetail?.customerType}",style: TextStyle(fontSize: 15),),
      //               SizedBox(height: MediaQuery.of(context).size.height*.02,),
      //               Text("Credit Limit: ${getdata?.data?[index].basicDetail?.creditLimit}",style: TextStyle(fontSize: 15),),
      //               SizedBox(height: MediaQuery.of(context).size.height*.03,),
      //               Text("Customer Dealing:-",style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold),),
      //               Text("ID & Name",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
      //               SizedBox(height: MediaQuery.of(context).size.height*.02,),
      //               Text("1  ${getdata?.data?[index].customerDealingIn?[0].name}",style: TextStyle(fontSize: 15),),
      //               // Text("2  ${getdata?.data?[index].customerDealingIn[0].name}",style: TextStyle(fontSize: 15),),
      //               SizedBox(height: MediaQuery.of(context).size.height*.03,),
      //               Text("Survey:-",style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold),),
      //               SizedBox(height: MediaQuery.of(context).size.height*.02,),
      //               ListView.builder(
      //                 shrinkWrap: true,
      //                   itemCount: getdata?.data?[index].survey?.length,
      //                   physics: NeverScrollableScrollPhysics(),
      //                   itemBuilder: (_,i){
      //                     return Column(
      //                       crossAxisAlignment: CrossAxisAlignment.start,
      //                       children: [
      //                         Text("Brand Name: ${getdata?.data?[index].survey?[i].brandName}",style: TextStyle(fontSize: 14,),),
      //                         SizedBox(height: MediaQuery.of(context).size.height*.02,),
      //                         Text("Monthly Sale: ${getdata?.data?[index].survey?[i].monthlySale}",style: TextStyle(fontSize: 14,),),
      //                         SizedBox(height: MediaQuery.of(context).size.height*.02,),
      //                         Text("Current Stock: ${getdata?.data?[index].survey?[i].currentStock}",style: TextStyle(fontSize: 14,),),
      //                         SizedBox(height: MediaQuery.of(context).size.height*.02,),
      //                         Text("WPS: ${getdata?.data?[index].survey?[i].wps}",style: TextStyle(fontSize: 14,),),
      //                         SizedBox(height: MediaQuery.of(context).size.height*.02,),
      //                         Text("RSP: ${getdata?.data?[index].survey?[i].rsp}",style: TextStyle(fontSize: 14,),),
      //                         SizedBox(height: MediaQuery.of(context).size.height*.02,),
      //                         Text("Purchasing From: ${getdata?.data?[index].survey?[i].purchasingFrom}",style: TextStyle(fontSize: 15),),
      //                       ],
      //                     );
      //                   }),
      //             ],
      //           ),
      //           SizedBox(height: MediaQuery.of(context).size.height*.03,),
      //         ],
      //       ),
      //     ),
      //   ),
      // );
      // }),
    );
  }

  GetFeedbackModel? getdata;
  String? department_id;

  Future<void> getData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    department_id = pref.getString('department');
    var headers = {
      'Cookie': 'ci_session=bf12d5586296e8a180885fdf282632a583f96888'
    };
    var request = http.MultipartRequest(
        'POST',
        Uri.parse(
            'https://businesstrack.co.in/app/v1/api/customer_feedback_lists'));
    request.fields.addAll({
      'user_id': '${CUR_USERID}',
      'department_id': '${department_id.toString()}'
    });
    print("customerrr feedbackk ${request.fields}");
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      print("responseee" + response.statusCode.toString());
      var result = await response.stream.bytesToString();
      var finalresult = GetFeedbackModel.fromJson(json.decode(result));
      print("result" + result.toString());
      setState(() {
        getdata = finalresult;
      });
    } else {
      print("reasonnnnnnnnn" + response.reasonPhrase.toString());
    }
  }
}
