import 'package:device_info_plus/device_info_plus.dart';
import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';

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
        title: Text("Site Visit Details",
            style: TextStyle(
                fontSize: 17,
                color: Colors.white,
                fontWeight: FontWeight.w800)),
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

                  Center(
                    child: InkWell(
                      onTap: () {
                        final imageProvider =
                            Image.network(widget.model?.photo?.first ?? "")
                                .image;
                        showImageViewer(context, imageProvider,
                            onViewerDismissed: () {
                          print("dismissed");
                        });
                      },
                      child: Stack(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16)),
                            clipBehavior: Clip.hardEdge,
                            height: 200,
                            width: 350,
                            child: ClipRRect(
                                child: widget.model?.photo?.first == null ||
                                        widget.model!.photo!.first.isEmpty
                                    ? Image.asset(
                                        "assets/images/placeholder.png")
                                    : Image.network(
                                        "${widget.model?.photo?.first}",
                                        fit: BoxFit.fill,
                                      )),
                          ),
                          Positioned(
                            top: 170,
                            right: 3,
                            child: InkWell(
                              onTap: () async {
                                try {
                                  if (await _requestPermission(
                                      Permission.storage)) {
                                    final http.Response response =
                                        await http.get(Uri.parse(
                                            widget.model!.photo!.first));
                                    if (response.statusCode == 200) {
                                      final Uint8List data = response.bodyBytes;
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
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content:
                                            Text('Failed to download image')),
                                  );
                                }
                              },
                              child: Container(
                                height: 30,
                                width: 30,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    color: Colors.red),
                                child: Icon(
                                  Icons.download,
                                  size: 20,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Text("Name:  ${widget.model?.name}",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w800)),
                  SizedBox(height: MediaQuery.of(context).size.height * .02),
                  Text("Address:  ${widget.model?.address}",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w800)),
                  SizedBox(height: MediaQuery.of(context).size.height * .02),
                  Text(
                      "Date & Time:  ${widget.model?.date} ${widget.model?.time}",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w800)),
                  SizedBox(height: MediaQuery.of(context).size.height * .02),
                  widget.model?.contractorName == null ||
                          widget.model?.contractorName == ""
                      ? Text("Contractor Name:  NA",
                          style: TextStyle(fontSize: 15))
                      : Text(
                          "Contractor Name:  ${widget.model?.contractorName}",
                          style: TextStyle(fontSize: 15)),
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
                      ? Text("Engineer Mobile:  NA",
                          style: TextStyle(fontSize: 15))
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
                      ? Text("Arti-tech Name:  NA",
                          style: TextStyle(fontSize: 15))
                      : Text("Arti-tech Name:  ${widget.model?.architectName}",
                          style: TextStyle(fontSize: 15)),
                  SizedBox(height: MediaQuery.of(context).size.height * .02),
                  widget.model?.artitechMobile == null ||
                          widget.model?.artitechMobile == ""
                      ? Text("Arti-tech Mobile:  NA",
                          style: TextStyle(fontSize: 15))
                      : Text(
                          "Arti-tech Mobile:  ${widget.model?.artitechMobile}",
                          style: TextStyle(fontSize: 15)),
                  SizedBox(height: MediaQuery.of(context).size.height * .02),
                  widget.model?.architectAddress == null ||
                          widget.model?.architectAddress == ""
                      ? Text("Arti-tech Address:  NA",
                          style: TextStyle(fontSize: 15))
                      : Text(
                          "Arti-tech Address:  ${widget.model?.architectAddress}",
                          style: TextStyle(fontSize: 15)),
                  SizedBox(height: MediaQuery.of(context).size.height * .02),
                  widget.model?.massionName == null ||
                          widget.model?.massionName == ""
                      ? Text("Mission Name:  NA",
                          style: TextStyle(fontSize: 15))
                      : Text("Mission Name:  ${widget.model?.massionName}",
                          style: TextStyle(fontSize: 15)),
                  SizedBox(height: MediaQuery.of(context).size.height * .02),
                  widget.model?.massionMobile == null ||
                          widget.model?.massionMobile == ""
                      ? Text("Mission Mobile:  NA",
                          style: TextStyle(fontSize: 15))
                      : Text("Mission Mobile:  ${widget.model?.massionMobile}",
                          style: TextStyle(fontSize: 15)),
                  SizedBox(height: MediaQuery.of(context).size.height * .02),
                  widget.model?.massionAddress == null ||
                          widget.model?.massionAddress == ""
                      ? Text("Mission Address:  NA",
                          style: TextStyle(fontSize: 15))
                      : Text(
                          "Mission Address:  ${widget.model?.massionAddress}",
                          style: TextStyle(fontSize: 15)),
                  SizedBox(height: MediaQuery.of(context).size.height * .02),
                  widget.model?.expectedOrders == null ||
                          widget.model?.expectedOrders == ""
                      ? Text("Expected Orders:  NA",
                          style: TextStyle(fontSize: 15))
                      : Text(
                          "Expected Orders:  ${widget.model?.expectedOrders}",
                          style: TextStyle(fontSize: 15)),
                  SizedBox(height: MediaQuery.of(context).size.height * .02),
                  widget.model?.pincode == null || widget.model?.pincode == ""
                      ? Text("Pin code:  NA", style: TextStyle(fontSize: 15))
                      : Text("Pin code:  ${widget.model?.pincode}",
                          style: TextStyle(fontSize: 15)),
                  SizedBox(height: MediaQuery.of(context).size.height * .03),
                  Text("Survey Details:- ",
                      style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w900,
                          color: Colors.black)),
                  SizedBox(height: MediaQuery.of(context).size.height * .03),
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
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              widget.model?.survey?[i].brandName == null ||
                                      widget.model?.survey?[i].brandName == ""
                                  ? Text("Product Name:  NA",
                                      style: TextStyle(fontSize: 15))
                                  : Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("Product Name: ",
                                            style: TextStyle(fontSize: 15)),
                                        Container(
                                          height: 30,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              2.9,
                                          child: TextField(
                                            readOnly: true,
                                            controller: producyNameCtr[i],
                                            keyboardType: TextInputType.number,
                                            decoration: InputDecoration(
                                              contentPadding: EdgeInsets.only(
                                                  top: 7, left: 5),
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(5.0),
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
                                      MediaQuery.of(context).size.height * .02),
                              widget.model?.survey?[i].totalConsumption ==
                                          null ||
                                      widget.model?.survey?[i]
                                              .totalConsumption ==
                                          ""
                                  ? Text("Total Consumption:  NA",
                                      style: TextStyle(fontSize: 15))
                                  : Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("Total Consumption: ",
                                            style: TextStyle(fontSize: 15)),
                                        Container(
                                          height: 30,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              2.9,
                                          child: TextField(
                                            readOnly: true,
                                            controller: totalConusmptionCtr[i],
                                            keyboardType: TextInputType.number,
                                            decoration: InputDecoration(
                                              contentPadding: EdgeInsets.only(
                                                  top: 7, left: 5),
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(5.0),
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
                                      MediaQuery.of(context).size.height * .02),
                              widget.model?.survey?[i].furtherConsumption ==
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
                                            style: TextStyle(fontSize: 15)),
                                        Container(
                                          height: 30,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              2.9,
                                          child: TextField(
                                            readOnly: true,
                                            controller: furtherCusmptionCtr[i],
                                            keyboardType: TextInputType.number,
                                            decoration: InputDecoration(
                                              contentPadding: EdgeInsets.only(
                                                  top: 7, left: 5),
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(5.0),
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
                                      MediaQuery.of(context).size.height * .02),
                              widget.model?.survey?[i].purchasePrice == null ||
                                      widget.model?.survey?[i].purchasePrice ==
                                          ""
                                  ? Text("Purchase Price:  NA",
                                      style: TextStyle(fontSize: 15))
                                  : Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("Purchase Price:",
                                            style: TextStyle(fontSize: 15)),
                                        Container(
                                          height: 30,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              2.9,
                                          child: TextField(
                                            readOnly: true,
                                            controller: purchasePriceCtr[i],
                                            keyboardType: TextInputType.number,
                                            decoration: InputDecoration(
                                              contentPadding: EdgeInsets.only(
                                                  top: 7, left: 5),
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(5.0),
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
                                      MediaQuery.of(context).size.height * .02),
                              widget.model?.survey?[i].purchasingFrom == null ||
                                      widget.model?.survey?[i].purchasingFrom ==
                                          ""
                                  ? Text("Purchasing From:  NA",
                                      style: TextStyle(fontSize: 15))
                                  : Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("Purchasing From:",
                                            style: TextStyle(fontSize: 15)),
                                        Container(
                                          height: 30,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              2.9,
                                          child: TextField(
                                            readOnly: true,
                                            controller: purchaseFormCtr[i],
                                            keyboardType: TextInputType.number,
                                            decoration: InputDecoration(
                                              contentPadding: EdgeInsets.only(
                                                  top: 7, left: 5),
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(5.0),
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
                                      MediaQuery.of(context).size.height * .02),
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
                                            style: TextStyle(fontSize: 15)),
                                        Container(
                                          height: 30,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              2.9,
                                          child: TextField(
                                            readOnly: true,
                                            controller: lastpurchaseCtr[i],
                                            keyboardType: TextInputType.number,
                                            decoration: InputDecoration(
                                              contentPadding: EdgeInsets.only(
                                                  top: 7, left: 5),
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(5.0),
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
