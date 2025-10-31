import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';

import '../Helper/Color.dart';
import '../Model/MySiteVisitModel.dart';

class MySiteDetails extends StatefulWidget {
  final SiteVisitData? model;
  const MySiteDetails({Key? key, this.model}) : super(key: key);

  @override
  State<MySiteDetails> createState() => _MySiteDetailsState();
}

class _MySiteDetailsState extends State<MySiteDetails> {
  void initState() {
    super.initState();
    var length = widget.model?.survey?.length ?? 0;
    for (int i = 0; i < length; i++) {
      producyNameCtr.add(TextEditingController());
      furtherCusmptionCtr.add(TextEditingController());
      totalConusmptionCtr.add(TextEditingController());
      purchasePriceCtr.add(TextEditingController());
      purchaseFormCtr.add(TextEditingController());
      lastpurchaseCtr.add(TextEditingController());
    }
    // producyNameCtr.text = widget.model?.survey?[0].brandName ?? "";
    //     furtherCusmptionCtr.text = widget.model?.survey?[0].furtherConsumption ?? "";
    //     totalConusmptionCtr.text = widget.model?.survey?[0].totalConsumption ?? "";
    //     purchasePriceCtr.text =  widget.model?.survey?[0].purchasePrice ?? "";
    //     purchaseFormCtr.text = widget.model?.survey?[0].purchasingFrom ?? "";
    //     lastpurchaseCtr.text = widget.model?.survey?[0].lastPurchaseDate ?? "";
  }

  List<TextEditingController> producyNameCtr = [];
  List<TextEditingController> totalConusmptionCtr = [];
  List<TextEditingController> furtherCusmptionCtr = [];
  List<TextEditingController> purchasePriceCtr = [];
  List<TextEditingController> purchaseFormCtr = [];
  List<TextEditingController> lastpurchaseCtr = [];

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

  @override
  Widget build(BuildContext context) {
    // debugPrint("photos ${widget.model?.photos}");
    return Scaffold(
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
          "Site Visit View",
          style: TextStyle(
              fontSize: 17, color: Colors.white, fontWeight: FontWeight.w800),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 15, right: 15, top: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Text("User Name",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
                  // SizedBox(height: MediaQuery.of(context).size.height*.03,),
                  // TextFormField(
                  //     keyboardType: TextInputType.text,
                  //     controller: namecn,
                  //     decoration: InputDecoration(
                  //         hintText: 'hfg',
                  //         border: OutlineInputBorder(
                  //             borderRadius:  BorderRadius.circular(15)))),
                  // SizedBox(height: MediaQuery.of(context).size.height*.03,),
                  // Text("Date",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
                  // SizedBox(height: MediaQuery.of(context).size.height*.03,),
                  // TextFormField(
                  //     keyboardType: TextInputType.text,
                  //     controller: datecn,
                  //     decoration: InputDecoration(
                  //         border: OutlineInputBorder(
                  //             borderRadius:  BorderRadius.circular(15)))),
                  // SizedBox(height: MediaQuery.of(context).size.height*.03,),
                  //
                  // Text("Time",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
                  // SizedBox(height: MediaQuery.of(context).size.height*.03,),
                  // TextFormField(
                  //     keyboardType: TextInputType.text,
                  //     controller: timecn,
                  //     decoration: InputDecoration(
                  //         border: OutlineInputBorder(
                  //             borderRadius:  BorderRadius.circular(15)))),
                  // SizedBox(height: MediaQuery.of(context).size.height*.03,),
                  // Text("Firm Name",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
                  // SizedBox(height: MediaQuery.of(context).size.height*.03,),
                  // TextFormField(
                  //     keyboardType: TextInputType.text,
                  //     controller: firmnamecn,
                  //     decoration: InputDecoration(
                  //         border: OutlineInputBorder(
                  //             borderRadius:  BorderRadius.circular(15)))),
                  // SizedBox(height: MediaQuery.of(context).size.height*.03,),
                  // Text("Remark",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
                  // SizedBox(height: MediaQuery.of(context).size.height*.03,),
                  // TextFormField(
                  //     keyboardType: TextInputType.text,
                  //     controller: remarkcn,
                  //     decoration: InputDecoration(
                  //         border: OutlineInputBorder(
                  //             borderRadius:  BorderRadius.circular(15)))),
                  // SizedBox(height: MediaQuery.of(context).size.height*.03,),
                  // Text("Survey:",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
                  // SizedBox(height: MediaQuery.of(context).size.height*.03,),
                  // Text("Name:${widget.model.?.data[0].basicDetail.name}",style: TextStyle(fontSize: 15),),
                  Container(
                    height: 150,
                    child: ListView.builder(
                      scrollDirection:
                          Axis.horizontal, // Scroll direction set to horizontal
                      itemCount: widget.model?.photo?.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(left: 5),
                          child: Stack(
                            children: [
                              InkWell(
                                onTap: () {
                                  if (widget.model?.photo?[index] != null) {
                                    final imageProvider = Image.network(
                                            widget.model?.photo?[index] ?? '')
                                        .image;
                                    showImageViewer(context, imageProvider,
                                        onViewerDismissed: () {
                                      print("dismissed");
                                    });
                                  }
                                },
                                onLongPress: () {
                                  if (widget.model?.photo?[index] != null)
                                    showDilaogBox(
                                        widget.model?.photo?[index] ?? "");
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border:
                                          Border.all(color: colors.primary)),
                                  width:
                                      MediaQuery.of(context).size.width / 2.6,
                                  height: 180,
                                  child: ClipRRect(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
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
                                        final http.Response response =
                                            await http.get(Uri.parse(
                                                widget.model!.photo![index]));
                                        if (response.statusCode == 200) {
                                          final Uint8List data =
                                              response.bodyBytes;
                                          final result =
                                              await ImageGallerySaver.saveImage(
                                                  data);
                                          print(result);
                                          if (result['isSuccess'] == true) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                  content:
                                                      Text('Image downloaded')),
                                            );
                                          } else {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                  content: Text(
                                                      'Failed to download image')),
                                            );
                                          }
                                        } else {
                                          ScaffoldMessenger.of(context)
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
                                        padding: const EdgeInsets.only(
                                            left: 0, bottom: 5),
                                        child: Column(
                                          children: [
                                            Text(
                                              "${widget.model?.createdAt}",
                                              style: TextStyle(
                                                  fontSize: 10,
                                                  color: Colors.red),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 14),
                                              child: Text(
                                                "${widget.model?.lat},${widget.model?.lng}",
                                                style: TextStyle(
                                                    fontSize: 10,
                                                    color: Colors.red),
                                              ),
                                            ),
                                            Text(
                                              "${widget.model?.currentAddress}",
                                              style: TextStyle(
                                                  fontSize: 10,
                                                  color: Colors.red),
                                              overflow: TextOverflow.ellipsis,
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
                                                BorderRadius.circular(30),
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
                  Text(
                    "Name:  ${widget.model?.name}",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w800),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * .02),
                  Text("Date & Time:  ${widget.model?.createdAt}",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w800)),
                  SizedBox(height: MediaQuery.of(context).size.height * .02),
                  widget.model?.expectedOrders == null ||
                          widget.model?.expectedOrders == ""
                      ? Text(
                          "Expected Orders:  NA",
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w800),
                        )
                      : Text(
                          "Expected Order Date:  ${widget.model?.date}",
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w800),
                        ),
                  SizedBox(height: MediaQuery.of(context).size.height * .02),
                  widget.model?.pincode == null || widget.model?.pincode == ""
                      ? Text(
                          "Pin code:  NA",
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w800),
                        )
                      : Text(
                          "Pin code:  ${widget.model?.pincode}",
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w800),
                        ),
                  SizedBox(height: MediaQuery.of(context).size.height * .02),
                  widget.model?.remarks == null || widget.model?.remarks == ""
                      ? Text(
                          "Remark:  NA",
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w800),
                        )
                      : Text(
                          "Remarks:  ${widget.model?.remarks}",
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w800),
                        ),
                  SizedBox(height: MediaQuery.of(context).size.height * .02),
                  widget.model?.currentStatus == null ||
                          widget.model?.currentStatus == ""
                      ? Text(
                          "Current Status:  NA",
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w800),
                        )
                      : Text(
                          "Current Status:  ${widget.model?.currentStatus}",
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w800),
                        ),
                  SizedBox(height: MediaQuery.of(context).size.height * .02),
                  widget.model?.contractorName == null ||
                          widget.model?.contractorName == ""
                      ? Text(
                          "Contractor Name:  NA",
                          style: TextStyle(fontSize: 15),
                        )
                      : Text(
                          "Contractor Name:  ${widget.model?.contractorName}",
                          style: TextStyle(fontSize: 15),
                        ),
                  SizedBox(height: MediaQuery.of(context).size.height * .02),
                  widget.model?.contractorMobile == null ||
                          widget.model?.contractorMobile == ""
                      ? Text("Contractor Mobile:  NA",
                          style: TextStyle(fontSize: 15))
                      : Text(
                          "Contractor Mobile:  ${widget.model?.contractorMobile}",
                          style: TextStyle(fontSize: 15)),
                  SizedBox(height: MediaQuery.of(context).size.height * .02),
                  widget.model?.contractorAddress == null ||
                          widget.model?.contractorAddress == ""
                      ? Text("Contractor Address:  NA",
                          style: TextStyle(fontSize: 15))
                      : Text(
                          "Contractor Address:  ${widget.model?.contractorAddress}",
                          style: TextStyle(fontSize: 15)),
                  SizedBox(height: MediaQuery.of(context).size.height * .02),
                  widget.model?.engineerName == null ||
                          widget.model?.engineerName == ""
                      ? Text("Engineer Name:  NA",
                          style: TextStyle(fontSize: 15))
                      : Text("Engineer Name:  ${widget.model?.engineerName}",
                          style: TextStyle(fontSize: 15)),
                  SizedBox(height: MediaQuery.of(context).size.height * .02),
                  widget.model?.engineerMobile == null ||
                          widget.model?.engineerMobile == ""
                      ? Text(
                          "Engineer Mobile:  NA",
                          style: TextStyle(fontSize: 15),
                        )
                      : Text(
                          "Engineer Mobile:  ${widget.model?.engineerMobile}",
                          style: TextStyle(fontSize: 15)),
                  SizedBox(height: MediaQuery.of(context).size.height * .02),
                  widget.model?.engineerAddress == null ||
                          widget.model?.engineerAddress == ""
                      ? Text("Engineer Address:  NA",
                          style: TextStyle(fontSize: 15))
                      : Text(
                          "Engineer Address:  ${widget.model?.engineerAddress}",
                          style: TextStyle(fontSize: 15)),
                  SizedBox(height: MediaQuery.of(context).size.height * .02),
                  widget.model?.architectName == null ||
                          widget.model?.architectName == ""
                      ? Text(
                          "Architech Name:  NA",
                          style: TextStyle(fontSize: 15),
                        )
                      : Text("Architech Name:  ${widget.model?.architectName}",
                          style: TextStyle(fontSize: 15)),
                  SizedBox(height: MediaQuery.of(context).size.height * .02),
                  widget.model?.artitechMobile == null ||
                          widget.model?.artitechMobile == ""
                      ? Text("Architech Mobile:  NA",
                          style: TextStyle(fontSize: 15))
                      : Text(
                          "Architech Mobile:  ${widget.model?.artitechMobile}",
                          style: TextStyle(fontSize: 15)),
                  SizedBox(height: MediaQuery.of(context).size.height * .02),
                  widget.model?.architectAddress == null ||
                          widget.model?.architectAddress == ""
                      ? Text(
                          "Architech Address:  NA",
                          style: TextStyle(fontSize: 15),
                        )
                      : Text(
                          "Architech Address:  ${widget.model?.architectAddress}",
                          style: TextStyle(fontSize: 15)),
                  SizedBox(height: MediaQuery.of(context).size.height * .02),
                  widget.model?.massionName == null ||
                          widget.model?.massionName == ""
                      ? Text("Mason  Name:  NA", style: TextStyle(fontSize: 15))
                      : Text("Mason Name:  ${widget.model?.massionName}",
                          style: TextStyle(fontSize: 15)),
                  SizedBox(height: MediaQuery.of(context).size.height * .02),
                  widget.model?.massionMobile == null ||
                          widget.model?.massionMobile == ""
                      ? Text("Mason Mobile:  NA",
                          style: TextStyle(fontSize: 15))
                      : Text("Mason Mobile:  ${widget.model?.massionMobile}",
                          style: TextStyle(fontSize: 15)),
                  SizedBox(height: MediaQuery.of(context).size.height * .02),
                  widget.model?.massionAddress == null ||
                          widget.model?.massionAddress == ""
                      ? Text("Mason Address:  NA",
                          style: TextStyle(fontSize: 15))
                      : Text("Mason Address:  ${widget.model?.massionAddress}",
                          style: TextStyle(fontSize: 15)),
                  SizedBox(height: MediaQuery.of(context).size.height * .01),
                  Text("Lat: ${widget.model?.lat}",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w800)),
                  SizedBox(height: MediaQuery.of(context).size.height * .01),
                  Text("Long: ${widget.model?.lat}",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w800)),
                  SizedBox(height: MediaQuery.of(context).size.height * .01),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                          "Address:  ${widget.model?.address} ${widget.model?.district}",
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w800)),
                      InkWell(
                        onTap: () {
                          _launchMap(
                            widget.model?.lat,
                            widget.model?.lng,
                          );
                        },
                        child: Icon(Icons.location_disabled),
                      ),
                    ],
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * .01),
                  ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: widget.model?.finalTotal?.length,
                      itemBuilder: (c, j) {
                        return Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Sum Of Total Consumption Of ${widget.model?.finalTotal?[j].title}"
                                      .toUpperCase(),
                                  style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black),
                                ),
                                Text(
                                  "₹ ${widget.model?.finalTotal?[j].totalConsumption}",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Sum Of Further Consumption Of ${widget.model?.finalTotal?[j].title}"
                                      .toUpperCase(),
                                  style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black),
                                ),
                                Text(
                                  "₹ ${widget.model?.finalTotal?[j].furtherConsumption}"
                                      .toUpperCase(),
                                  style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black),
                                ),
                              ],
                            ),
                          ],
                        );
                      }),
                  SizedBox(height: MediaQuery.of(context).size.height * .01),
                  Text(
                    "Survey Details:- ",
                    style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w900,
                        color: Colors.black),
                  ),
                  Divider(
                    color: Colors.black,
                  ),
                  SizedBox(
                    child: ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: widget.model?.survey?.length,
                        itemBuilder: (_, i) {
                          producyNameCtr[i].text =
                              widget.model?.survey?[0].brandName ?? "";
                          totalConusmptionCtr[i].text =
                              widget.model?.survey?[i].totalConsumption ?? "";
                          furtherCusmptionCtr[i].text =
                              widget.model?.survey?[i].furtherConsumption ?? "";
                          purchasePriceCtr[i].text =
                              widget.model?.survey?[i].purchasePrice ?? "";
                          purchaseFormCtr[i].text =
                              widget.model?.survey?[i].purchasingFrom ?? "";
                          lastpurchaseCtr[i].text =
                              widget.model?.survey?[i].lastPurchaseDate ?? "";
                          return widget.model?.survey?[i].brandName == null ||
                                  widget.model?.survey?[i].brandName == "" ||
                                  widget.model?.survey?[i].totalConsumption ==
                                      null ||
                                  widget.model?.survey?[i].totalConsumption ==
                                      "" ||
                                  widget.model?.survey?[i].furtherConsumption ==
                                      null ||
                                  widget.model?.survey?[i].furtherConsumption ==
                                      "" ||
                                  widget.model?.survey?[i].purchasingFrom ==
                                      null ||
                                  widget.model?.survey?[i].purchasingFrom ==
                                      "" ||
                                  widget.model?.survey?[i].lastPurchaseDate ==
                                      null ||
                                  widget.model?.survey?[i].lastPurchaseDate ==
                                      ""
                              ? SizedBox()
                              : Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Product Name:",
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.black),
                                        ),
                                        Text(
                                          "${widget.model?.survey?[i].cid}",
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.black),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    widget.model?.survey?[i].brandName ==
                                                null ||
                                            widget.model?.survey?[i]
                                                    .brandName ==
                                                ""
                                        ? Text("Brand Name:  NA",
                                            style: TextStyle(fontSize: 15))
                                        : Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "Brand Name:",
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w600,
                                                    color: Colors.black),
                                              ),
                                              Text(
                                                "${widget.model?.survey?[i].brandName}",
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w600,
                                                    color: Colors.black),
                                              ),
                                            ],
                                          ),
                                    SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                .02),
                                    widget.model?.survey?[i].totalConsumption ==
                                                null ||
                                            widget.model?.survey?[i]
                                                    .totalConsumption ==
                                                ""
                                        ? Text(
                                            "Total Consumption:  NA",
                                            style: TextStyle(fontSize: 15),
                                          )
                                        : Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text("Total Consumption: ",
                                                  style:
                                                      TextStyle(fontSize: 15)),
                                              Container(
                                                height: 30,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    2.9,
                                                child: TextField(
                                                  readOnly: true,
                                                  controller:
                                                      totalConusmptionCtr[i],
                                                  keyboardType:
                                                      TextInputType.number,
                                                  decoration: InputDecoration(
                                                    contentPadding:
                                                        EdgeInsets.only(
                                                            top: 7, left: 5),
                                                    border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5.0),
                                                    ),
                                                    filled: true,
                                                    hintStyle: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 10),
                                                    hintText: "",
                                                    fillColor: Colors.white70,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                    SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                .02),
                                    widget.model?.survey?[i]
                                                    .furtherConsumption ==
                                                null ||
                                            widget.model?.survey?[i]
                                                    .furtherConsumption ==
                                                ""
                                        ? Text("Further Consumption:  NA",
                                            style: TextStyle(fontSize: 15))
                                        : Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text("Further Consumption: ",
                                                  style:
                                                      TextStyle(fontSize: 15)),
                                              Container(
                                                height: 30,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    2.9,
                                                child: TextField(
                                                  readOnly: true,
                                                  controller:
                                                      furtherCusmptionCtr[i],
                                                  keyboardType:
                                                      TextInputType.number,
                                                  decoration: InputDecoration(
                                                    contentPadding:
                                                        EdgeInsets.only(
                                                            top: 7, left: 5),
                                                    border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5.0),
                                                    ),
                                                    filled: true,
                                                    hintStyle: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 10),
                                                    hintText: "",
                                                    fillColor: Colors.white70,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                    SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                .02),
                                    widget.model?.survey?[i].purchasePrice ==
                                                null ||
                                            widget.model?.survey?[i]
                                                    .purchasePrice ==
                                                ""
                                        ? Text("Purchase Price:  NA",
                                            style: TextStyle(fontSize: 15))
                                        : Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text("Purchase Price:",
                                                  style:
                                                      TextStyle(fontSize: 15)),
                                              Container(
                                                height: 30,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    2.9,
                                                child: TextField(
                                                  readOnly: true,
                                                  controller:
                                                      purchasePriceCtr[i],
                                                  keyboardType:
                                                      TextInputType.number,
                                                  decoration: InputDecoration(
                                                    contentPadding:
                                                        EdgeInsets.only(
                                                            top: 7, left: 5),
                                                    border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5.0),
                                                    ),
                                                    filled: true,
                                                    hintStyle: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 10),
                                                    hintText: "",
                                                    fillColor: Colors.white70,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                    SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                .02),
                                    widget.model?.survey?[i].purchasingFrom ==
                                                null ||
                                            widget.model?.survey?[i]
                                                    .purchasingFrom ==
                                                ""
                                        ? Text("Purchasing From:  NA",
                                            style: TextStyle(fontSize: 15))
                                        : Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text("Purchasing From:",
                                                  style:
                                                      TextStyle(fontSize: 15)),
                                              Container(
                                                height: 30,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    2.9,
                                                child: TextField(
                                                  readOnly: true,
                                                  controller:
                                                      purchaseFormCtr[i],
                                                  keyboardType:
                                                      TextInputType.number,
                                                  decoration: InputDecoration(
                                                    contentPadding:
                                                        EdgeInsets.only(
                                                            top: 7, left: 5),
                                                    border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5.0),
                                                    ),
                                                    filled: true,
                                                    hintStyle: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 10),
                                                    hintText: "",
                                                    fillColor: Colors.white70,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                    SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                .02),
                                    widget.model?.survey?[i].lastPurchaseDate ==
                                                null ||
                                            widget.model?.survey?[i]
                                                    .lastPurchaseDate ==
                                                ""
                                        ? Text("Last Purchase Date:  NA",
                                            style: TextStyle(fontSize: 15))
                                        : Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text("Last Purchase Date: ",
                                                  style:
                                                      TextStyle(fontSize: 15)),
                                              Container(
                                                height: 30,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    2.9,
                                                child: TextField(
                                                  readOnly: true,
                                                  controller:
                                                      lastpurchaseCtr[i],
                                                  keyboardType:
                                                      TextInputType.number,
                                                  decoration: InputDecoration(
                                                    contentPadding:
                                                        EdgeInsets.only(
                                                            top: 7, left: 5),
                                                    border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5.0),
                                                    ),
                                                    filled: true,
                                                    hintStyle: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 10),
                                                    hintText: "",
                                                    fillColor: Colors.white70,
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
                                );
                        }),
                  )
                  // Text("Credit_Limit:${getdata?.data[0].basicDetail.creditLimit}",style: TextStyle(fontSize: 15),),
                  // SizedBox(height: MediaQuery.of(context).size.height*.03,),
                  // Text("Customer Dealing:",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
                  // Text("ID Name",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
                  // SizedBox(height: MediaQuery.of(context).size.height*.02,),
                  // Text("1  ${getdata?.data[0].customerDealingIn[0].name}",style: TextStyle(fontSize: 15),),
                  // Text("2  ${getdata?.data[0].customerDealingIn[1].name}",style: TextStyle(fontSize: 15),),
                  // SizedBox(height: MediaQuery.of(context).size.height*.03,),
                  // Text("Survey:",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
                  // SizedBox(height: MediaQuery.of(context).size.height*.03,),
                  // Text("Brand Name:",style: TextStyle(fontSize: 14,),),
                  // SizedBox(height: MediaQuery.of(context).size.height*.02,),
                  // Text("Monthly Sale:",style: TextStyle(fontSize: 14,),),
                  // SizedBox(height: MediaQuery.of(context).size.height*.02,),
                  // Text("Current Stock:",style: TextStyle(fontSize: 14,),),
                  // SizedBox(height: MediaQuery.of(context).size.height*.02,),
                  // Text("WPS:",style: TextStyle(fontSize: 14,),),
                  // SizedBox(height: MediaQuery.of(context).size.height*.02,),
                  // Text("RSP:",style: TextStyle(fontSize: 14,),),
                  // SizedBox(height: MediaQuery.of(context).size.height*.02,),
                  // Text("purchasing_from:${getdata?.data[0].survey[0].purchasingFrom}",style: TextStyle(fontSize: 15),),
                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.height * .03),
            ],
          ),
        ),
      ),
    );
  }
}
