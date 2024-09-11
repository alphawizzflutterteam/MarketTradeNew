import 'dart:convert';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:omega_employee_management/Screen/Dashboard.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';

import '../Helper/Color.dart';
import '../Helper/Session.dart';
import '../Helper/String.dart';
import '../Model/ClientModel.dart';
import '../Model/DepartmentModel.dart';
import '../Provider/HomeProvider.dart';

class AddPhoto extends StatefulWidget {
  const AddPhoto({Key? key}) : super(key: key);

  @override
  State<AddPhoto> createState() => _AddPhotoState();
}

int count = 0;

class _AddPhotoState extends State<AddPhoto> {
  @override
  void initState() {
    super.initState();
    getDepartment();
  }

  DepartmentModel? departmentModel;
  getDepartment() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? uid = prefs.getString("user_id");
    var headers = {
      'Cookie': 'ci_session=aa83f4f9d3335df625437992bb79565d0973f564'
    };
    var request = http.MultipartRequest('POST', Uri.parse(getDep.toString()));
    request.fields.addAll({
      USER_ID: '${uid}',
    });
    print("this is refer  get departmet request ${request.fields.toString()}");
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      print("permission");
      String str = await response.stream.bytesToString();
      var result = json.decode(str);
      var finalResponse = DepartmentModel.fromJson(result);
      print("permission responseeeeee ${finalResponse}");
      setState(() {
        departmentModel = finalResponse;
        department_id = departmentModel?.data?.first.department.toString();
        print("deeeeeeeeeeeeee ${department_id}");
        getClients();
      });
    } else {
      print(response.reasonPhrase);
    }
  }

  ClientModel? clients;
  List<ClientsData> clientData = [];
  String? department_id;

  getClients() async {
    var headers = {
      'Cookie': 'ci_session=aa83f4f9d3335df625437992bb79565d0973f564'
    };
    var request = http.MultipartRequest(
      'POST',
      Uri.parse(
        getClientApi.toString(),
      ),
    );
    request.fields.addAll(
        {'filter': 'photo', 'department_id': '${department_id.toString()}'});
    print(
        "this is refer request by add photo client ${request.fields.toString()}");
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      String str = await response.stream.bytesToString();
      var result = json.decode(str);
      var finalResponse = ClientModel.fromJson(result);
      print("reponse in clients data ${finalResponse} result ${result}");
      setState(() {
        clients = finalResponse;
        clientData = clients?.data ?? [];
      });
      print("this is response data ${finalResponse}");
    } else {
      print(response.reasonPhrase);
    }
  }

  addPhoto(String? id) async {
    setState(() {
      isLoading = true;
    });
    var headers = {
      'Cookie': 'ci_session=a668203a30aa21277b05b1ffb48275800e081571'
    };
    var request = http.MultipartRequest(
        'POST',
        Uri.parse(
            'https://developmentalphawizz.com/rename_market_track/app/v1/api/update_photo'));
    request.fields.addAll({
      'id': id.toString(),
      'user_id': '${CUR_USERID}',
    });
    print("addd photo parameter ${request.fields}");
    for (var i = 0; i < imagePathList.length; i++) {
      print('Imageeee in upload in heheeh $imagePathList');
      imagePathList.isEmpty
          ? null
          : request.files.add(
              await http.MultipartFile.fromPath('images[]', imagePathList[i]),
            );
    }
    gstImage != null
        ? request.files.add(
            await http.MultipartFile.fromPath('gst_img', gstImage?.path ?? ""),
          )
        : true;
    panImage != null
        ? request.files.add(
            await http.MultipartFile.fromPath('pan_img', panImage?.path ?? ""),
          )
        : true;
    aadharImage != null
        ? request.files.add(
            await http.MultipartFile.fromPath(
                'aadhar_img', aadharImage?.path ?? ""),
          )
        : true;
    aadharBack != null
        ? request.files.add(
            await http.MultipartFile.fromPath(
                'aadhar_back', aadharBack?.path ?? ""),
          )
        : true;
    gstOne != null
        ? request.files.add(
            await http.MultipartFile.fromPath(
                'gst_img_two', gstOne?.path ?? ""),
          )
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
    print("mages upload======${request.files} ${voterIdBackImage}===========");
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var str = await response.stream.bytesToString();
      var result = json.decode(str);
      if (result['error'] == false) {
        Fluttertoast.showToast(msg: result['message']);
        getClients();
        setState(() {
          isLoading = false;
        });
        Navigator.push(
            context, MaterialPageRoute(builder: (clients) => Dashboard()));
      } else {
        Fluttertoast.showToast(msg: result['message']);
      }
    } else {
      print(response.reasonPhrase);
    }
  }

  searchClients(String value) {
    if (value.isEmpty) {
      getClients();
      setState(() {});
    } else {
      final suggestions = clientData.where((element) {
        final ownerName = element.ownerName.toString().toLowerCase();
        final address = element.address.toString().toLowerCase();
        final mobile = element.mobileOne.toString().toLowerCase();
        final firmName = element.nameOfFirm.toString().toLowerCase();
        final input = value.toLowerCase();
        return ownerName.contains(input) ||
            address.contains(input) ||
            mobile.contains(input) ||
            firmName.contains(input);
      }).toList();
      clientData = suggestions;
      setState(() {});
    }
  }

  Future<void> downloadImage(String imageUrl) async {
    var response = await http.get(Uri.parse(imageUrl));

    if (response.statusCode == 200) {
      final Directory directory = await getApplicationDocumentsDirectory();
      final String filePath = '${directory.path}/image.jpg';
      final File file = File(filePath);
      await file.writeAsBytes(response.bodyBytes);
      print('Image downloaded and saved to: $filePath');
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
                    ),
                  ),
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

  TextEditingController searchCtr = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        title: Text(
          "AddPhoto",
          style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: colors.primary,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 10),
            Container(
              height: 50,
              padding: EdgeInsets.only(left: 15, right: 15),
              child: TextFormField(
                onChanged: (value) {
                  searchClients(value);
                },
                controller: searchCtr,
                decoration: InputDecoration(
                  suffixIcon: Container(
                      width: 20,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: colors.primary),
                      child: Icon(Icons.search, color: Colors.white)),
                  hintText: "Search here",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            clients?.error == true
                ? Center(
                    child: Text(
                    "No Data Found",
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
                  ))
                : clientData == null
                    ? CircularProgressIndicator()
                    : Container(
                        child: GridView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 5.0,
                            childAspectRatio: 0.6,
                          ),
                          itemCount: clientData.length ?? 0,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(left: 5, right: 5),
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(color: Colors.redAccent),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      InkWell(
                                        child: Center(
                                          child: new ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(0.0),
                                            child: new FadeInImage(
                                              fadeInDuration:
                                                  Duration(milliseconds: 150),
                                              image: CachedNetworkImageProvider(
                                                  "${clients?.data?[index].photo?[0]}"),
                                              height: 110.0,
                                              width: double.infinity,
                                              fit: BoxFit.cover,
                                              imageErrorBuilder: (context,
                                                      error, stackTrace) =>
                                                  erroWidget(100),
                                              placeholder: placeHolder(50),
                                            ),
                                          ),
                                        ),
                                        onTap: () {
                                          if (clientData[index].photo?[0] !=
                                              null) {
                                            final imageProvider = Image.network(
                                              clientData[index].photo?[0] ?? '',
                                            ).image;
                                            showImageViewer(
                                                context, imageProvider,
                                                onViewerDismissed: () {
                                              print("dismissed");
                                            });
                                          }
                                        },
                                        onLongPress: () {
                                          //  print("download image");

                                          showDilaogBox(
                                              clientData[index].photo![0] ??
                                                  "");
                                          //  downloadImage(clientData?[index].photo!?[0] ?? "");
                                        },
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Firm:',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            "${clientData[index].nameOfFirm}",
                                            style: TextStyle(fontSize: 13),
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
                                            'Owner:',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            "${clientData[index].ownerName}",
                                            style: TextStyle(fontSize: 13),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 8),
                                      Text(
                                        'Mobile:',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text("${clientData[index].mobileOne}"),
                                      SizedBox(height: 8),
                                      Text(
                                        'Address:',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Container(
                                        width: 180,
                                        child: Text(
                                          "${clientData[index].address}",
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 3,
                                          style: TextStyle(fontSize: 13),
                                        ),
                                      ),
                                      Spacer(),
                                      Center(
                                          child: InkWell(
                                        onTap: () {
                                          imageUpload(
                                            clients?.data?[index].id.toString(),
                                          );
                                          // addPhotoDialog(
                                          //     context,
                                          //     clients?.data?[index].id
                                          //             .toString() ??
                                          //         "");
                                          // _getFromCamera(
                                          //     clientData[index].id.toString() ??
                                          //         "");
                                        },
                                        child: Container(
                                          height: 40,
                                          width: 80,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: colors.primary),
                                          child: Center(
                                            child: Text(
                                              "Add",
                                              style: TextStyle(
                                                  color: colors.whiteTemp,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                      )),
                                      SizedBox(
                                        height: 3,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );

                            //   Padding(
                            //   padding: const EdgeInsets.all(5.0),
                            //   child: Container(
                            //     //  height: MediaQuery.of(context).size.height/1.0,
                            //     decoration: BoxDecoration(
                            //         border: Border.all(color: colors.primary),
                            //         borderRadius: BorderRadius.circular(5)),
                            //     child: Column(
                            //       mainAxisAlignment: MainAxisAlignment.center,
                            //       crossAxisAlignment: CrossAxisAlignment.center,
                            //       mainAxisSize: MainAxisSize.min,
                            //       children: <Widget>[
                            //         InkWell(
                            //           child: new ClipRRect(
                            //             borderRadius:
                            //                 BorderRadius.circular(0.0),
                            //             child: new FadeInImage(
                            //               fadeInDuration:
                            //                   Duration(milliseconds: 150),
                            //               image: CachedNetworkImageProvider(
                            //                   "${clients?.data?[index].photo?[0]}"),
                            //               height: 110.0,
                            //               width: double.infinity,
                            //               fit: BoxFit.cover,
                            //               imageErrorBuilder:
                            //                   (context, error, stackTrace) =>
                            //                       erroWidget(50),
                            //               placeholder: placeHolder(50),
                            //             ),
                            //           ),
                            //           onTap: () {
                            //             // print("download image");
                            //             // downloadImage(clientData?[index].photo!?[0] ?? "");
                            //             if (clientData[index].photo?[0] !=
                            //                 null) {
                            //               final imageProvider = Image.network(
                            //                       clientData[index].photo?[0] ??
                            //                           '')
                            //                   .image;
                            //               showImageViewer(
                            //                   context, imageProvider,
                            //                   onViewerDismissed: () {
                            //                 print("dismissed");
                            //               });
                            //             }
                            //           },
                            //           onLongPress: () {
                            //             //  print("download image");
                            //
                            //             showDilaogBox(
                            //                 clientData[index].photo![0] ?? "");
                            //             //  downloadImage(clientData?[index].photo!?[0] ?? "");
                            //           },
                            //         ),
                            //         // const SizedBox(width: 20),
                            //         Padding(
                            //           padding: const EdgeInsets.only(
                            //               left: 5.0, right: 5),
                            //           child: Row(
                            //             mainAxisAlignment:
                            //                 MainAxisAlignment.spaceBetween,
                            //             children: [
                            //               Row(
                            //                 mainAxisAlignment:
                            //                     MainAxisAlignment.spaceBetween,
                            //                 children: [
                            //                   Column(
                            //                     crossAxisAlignment:
                            //                         CrossAxisAlignment.start,
                            //                     children: [
                            //                       Text(
                            //                         'Firm:',
                            //                         style: TextStyle(
                            //                             fontWeight:
                            //                                 FontWeight.bold),
                            //                       ),
                            //                       Text(
                            //                           "${clientData[index].nameOfFirm}"),
                            //                     ],
                            //                   ),
                            //                   Column(
                            //                     crossAxisAlignment:
                            //                         CrossAxisAlignment.end,
                            //                     children: [
                            //                       Text(
                            //                         'Owner:',
                            //                         style: TextStyle(
                            //                             fontWeight:
                            //                                 FontWeight.bold),
                            //                       ),
                            //                       Text(
                            //                           "${clientData[index].ownerName}"),
                            //                     ],
                            //                   ),
                            //                 ],
                            //               ),
                            //               SizedBox(height: 8),
                            //               Text(
                            //                 'Mobile:',
                            //                 style: TextStyle(
                            //                     fontWeight: FontWeight.bold),
                            //               ),
                            //               Text(
                            //                   "${clientData[index].mobileOne}"),
                            //               SizedBox(height: 8),
                            //               Text(
                            //                 'Address:',
                            //                 style: TextStyle(
                            //                     fontWeight: FontWeight.bold),
                            //               ),
                            //               Text("${clientData[index].address}"),
                            //               Spacer(),
                            //               // Column(
                            //               //   crossAxisAlignment:
                            //               //       CrossAxisAlignment.start,
                            //               //   children: [
                            //               //     Text(
                            //               //       "Firm:",
                            //               //       style: TextStyle(
                            //               //           fontSize: 11,
                            //               //           fontWeight: FontWeight.w400,
                            //               //           color: colors.blackTemp),
                            //               //     ),
                            //               //     SizedBox(
                            //               //       height: 18,
                            //               //     ),
                            //               //     Text(
                            //               //       "Owner:",
                            //               //       style: TextStyle(
                            //               //           fontSize: 11,
                            //               //           fontWeight: FontWeight.w400,
                            //               //           color: colors.blackTemp),
                            //               //     ),
                            //               //     SizedBox(
                            //               //       height: 15,
                            //               //     ),
                            //               //     Text(
                            //               //       "Mobile:",
                            //               //       style: TextStyle(
                            //               //           fontSize: 11,
                            //               //           fontWeight: FontWeight.w400,
                            //               //           color: colors.blackTemp),
                            //               //     ),
                            //               //     SizedBox(
                            //               //       height: 15,
                            //               //     ),
                            //               //     Text(
                            //               //       "Address:",
                            //               //       style: TextStyle(
                            //               //           fontSize: 11,
                            //               //           fontWeight: FontWeight.w400,
                            //               //           color: colors.blackTemp),
                            //               //     ),
                            //               //   ],
                            //               // ),
                            //               // Column(
                            //               //   crossAxisAlignment:
                            //               //       CrossAxisAlignment.end,
                            //               //   children: [
                            //               //     Text(
                            //               //       "${clientData[index].nameOfFirm}",
                            //               //       style: TextStyle(
                            //               //           fontSize: 11,
                            //               //           fontWeight: FontWeight.w400,
                            //               //           color: colors.blackTemp,
                            //               //           overflow:
                            //               //               TextOverflow.ellipsis),
                            //               //     ),
                            //               //     SizedBox(height: 10),
                            //               //     Text(
                            //               //         "${clientData[index].ownerName}",
                            //               //         style: TextStyle(
                            //               //             fontSize: 11,
                            //               //             fontWeight:
                            //               //                 FontWeight.w400,
                            //               //             color: colors.blackTemp)),
                            //               //     SizedBox(height: 10),
                            //               //     Text(
                            //               //         "${clientData[index].mobileOne}",
                            //               //         style: TextStyle(
                            //               //             fontSize: 11,
                            //               //             fontWeight:
                            //               //                 FontWeight.w400,
                            //               //             color: colors.blackTemp)),
                            //               //     SizedBox(height: 10),
                            //               //     Container(
                            //               //       width: 90,
                            //               //       child: Text(
                            //               //         "${clientData[index].address}${clientData[index].pinCode}",
                            //               //         style: TextStyle(
                            //               //             fontSize: 11,
                            //               //             fontWeight:
                            //               //                 FontWeight.w400,
                            //               //             color: colors.blackTemp),
                            //               //         maxLines: 3,
                            //               //       ),
                            //               //     ),
                            //               //   ],
                            //               // ),
                            //             ],
                            //           ),
                            //         ),
                            //         SizedBox(height: 5),
                            //         InkWell(
                            //           onTap: () {
                            //             Navigator.push(
                            //                 context,
                            //                 MaterialPageRoute(
                            //                     builder: (context) =>
                            //                         ClientsView(
                            //                             model: clientData[
                            //                                 index])));
                            //           },
                            //           child: Container(
                            //             height: 30,
                            //             width: 70,
                            //             decoration: BoxDecoration(
                            //                 borderRadius:
                            //                     BorderRadius.circular(5),
                            //                 color: colors.primary),
                            //             child: Center(
                            //                 child: Text(
                            //               "View",
                            //               style: TextStyle(
                            //                   color: colors.whiteTemp,
                            //                   fontWeight: FontWeight.bold),
                            //             )),
                            //           ),
                            //         )
                            //       ],
                            //     ),
                            //   ),
                            // );
                          },
                        ),
                      ),
            // _catList(),
          ],
        ),
      ),
    );
  }

  _catList() {
    return Selector<HomeProvider, bool>(
      builder: (context, data, child) {
        return data
            ? Container(
                width: double.infinity,
                child: Shimmer.fromColors(
                    baseColor: Theme.of(context).colorScheme.simmerBase,
                    highlightColor: Theme.of(context).colorScheme.simmerHigh,
                    child: catLoading()),
              )
            : Padding(
                padding: const EdgeInsets.all(5.0),
                child: Column(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height / 1,
                      child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 5,
                            mainAxisSpacing: 5,
                            childAspectRatio: 4 / 5),
                        itemCount: clients?.data?.length ?? 0,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Container(
                              // height: MediaQuery.of(context).size.height/1.0,
                              decoration: BoxDecoration(
                                  border: Border.all(color: colors.primary),
                                  borderRadius: BorderRadius.circular(5)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.all(10),
                                    child: new ClipRRect(
                                      borderRadius: BorderRadius.circular(10.0),
                                      child: new FadeInImage(
                                        fadeInDuration:
                                            Duration(milliseconds: 150),
                                        image: CachedNetworkImageProvider(
                                            "${clients?.data?[index].photo}"),
                                        height: 70.0,
                                        width: 70,
                                        fit: BoxFit.fill,
                                        imageErrorBuilder:
                                            (context, error, stackTrace) =>
                                                erroWidget(50),
                                        placeholder: placeHolder(50),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 20),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10.0, right: 10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Firm:",
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w400,
                                                  color: colors.blackTemp),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                              "Owner:",
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w400,
                                                  color: colors.blackTemp),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                              "Number:",
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w400,
                                                  color: colors.blackTemp),
                                            ),
                                          ],
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Text(
                                              "${clients?.data?[index].nameOfFirm}",
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w400,
                                                  color: colors.blackTemp,
                                                  overflow:
                                                      TextOverflow.ellipsis),
                                            ),
                                            SizedBox(height: 10),
                                            Text(
                                                "${clients?.data?[index].ownerName}",
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w400,
                                                    color: colors.blackTemp)),
                                            SizedBox(height: 10),
                                            Text(
                                                "${clients?.data?[index].mobileOne}",
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w400,
                                                    color: colors.blackTemp)),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      imageUpload(
                                          clients?.data?[index].id.toString());
                                      // addPhotoDialog(context, clients?.data?[index].id.toString() ?? "");
                                      // _getFromCamera(
                                      //     clients?.data?[index].id.toString() ??
                                      //         "");
                                    },
                                    child: Container(
                                      height: 40,
                                      width: 80,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: colors.primary),
                                      child: Center(
                                        child: Text(
                                          "Add",
                                          style: TextStyle(
                                              color: colors.whiteTemp,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              );
      },
      selector: (_, homeProvider) => homeProvider.catLoading,
    );
  }

  // addPhotoDialog(BuildContext context, String id) {
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         actions: <Widget>[
  //           Column(
  //             // crossAxisAlignment: CrossAxisAlignment.center,
  //             children: [
  //               const SizedBox(
  //                 height: 10,
  //               ),
  //               Padding(
  //                 padding: const EdgeInsets.only(right: 55),
  //                 child: InkWell(
  //                   onTap: () async {
  //                     _getFromCamera(id.toString());
  //                   },
  //                   child: Container(
  //                     height: 40,
  //                     width: 145,
  //                     decoration: BoxDecoration(
  //                         borderRadius: BorderRadius.circular(5),
  //                         color: colors.primary),
  //                     child: Center(
  //                       child: Text(
  //                         "Add Photo",
  //                         style: TextStyle(color: colors.whiteTemp),
  //                       ),
  //                     ),
  //                   ),
  //                 ),
  //               ),
  //               const SizedBox(
  //                 height: 5,
  //               ),
  //               Visibility(
  //                 visible: isImages,
  //                 child: Column(
  //                   children: [
  //                     Padding(
  //                       padding: const EdgeInsets.only(right: 50, top: 10),
  //                       child: buildGridView(),
  //                     ),
  //                     SizedBox(height: 10),
  //                   ],
  //                 ),
  //               ),
  //               // SizedBox(height: 10),
  //               // Container(
  //               //   height: 200,
  //               //   child: Card(
  //               //     child: GridView.builder(
  //               //         itemCount: fileModel?.data?.length ?? 0,
  //               //         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
  //               //             crossAxisCount: 2),
  //               //         itemBuilder: (context, index) {
  //               //           return Padding(
  //               //             padding: EdgeInsets.all(5),
  //               //             child: Container(
  //               //               decoration: new BoxDecoration(
  //               //                 image: new DecorationImage(
  //               //                     image: new NetworkImage(
  //               //                         "${imageUrl}${fileModel?.data}"),
  //               //                     fit: BoxFit.cover),
  //               //               ),
  //               //             ),
  //               //           );
  //               //         }),
  //               //   ),
  //               // ),
  //               SizedBox(height: 10),
  //               Padding(
  //                 padding: const EdgeInsets.only(right: 50),
  //                 child: InkWell(
  //                   onTap: () {
  //                     addPhoto(id);
  //                     Navigator.pop(context);
  //                   },
  //                   child: Container(
  //                     height: 40,
  //                     width: 80,
  //                     decoration: BoxDecoration(
  //                         borderRadius: BorderRadius.circular(5),
  //                         color: colors.primary),
  //                     child: Center(
  //                       child: Text("Submit",
  //                           style: TextStyle(
  //                               fontSize: 14,
  //                               color: Colors.white,
  //                               fontWeight: FontWeight.bold)),
  //                     ),
  //                   ),
  //                 ),
  //               ),
  //               SizedBox(height: 10),
  //             ],
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }

  // _getFromCamera(String id) async {
  //   PickedFile? pickedFile = await ImagePicker().getImage(
  //     source: ImageSource.camera,
  //   );
  //   if (pickedFile != null) {
  //     setState(() {
  //       // _imageFile = File(pickedFile.path);
  //       imagePathList.add(_imageFile?.path ?? "");
  //       isImages = true;
  //     });
  //     setState(() {});
  //     // addPhoto(id);
  //     //Navigator.pop(context);
  //   }
  // }

  final ImagePicker _picker = ImagePicker();

  List imagePathList = [];

  Future<void> selectVehicleImage() async {
    final XFile? pickedFile = await _picker.pickImage(
        source: ImageSource.camera,
        imageQuality: 80,
        maxWidth: 400,
        maxHeight: 400);
    if (pickedFile != null) {
      checkoutState!(() {
        _imageFile = File(pickedFile.path);
        imagePathList.add(_imageFile?.path ?? "");
      });
    }
  }

  void removeVehicleImage(File image) {
    checkoutState!(() {
      imagePathList.remove(image);
    });
  }

  uploadMultiImage() {
    return Row(
      children: [
        InkWell(
          onTap: () {
            selectVehicleImage();
          },
          child: UploadImage(
            text: "UPLOAD PHOTO",
            count: imagePathList.length.toString(),
            // finalCount: '6',
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Container(
          height: 110,
          width: 150,
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: imagePathList.length,
            itemBuilder: (context, index) {
              // String? image = imagePathList[index];
              return Padding(
                padding: const EdgeInsets.only(right: 8),
                child: DottedBorder(
                  color: const Color(0xff9AC228),
                  strokeWidth: 2,
                  dashPattern: [10, 5],
                  borderType: BorderType.RRect,
                  radius: Radius.circular(12),
                  child: Stack(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Image.file(
                          File(imagePathList[index]),
                          width: 90,
                          height: 90,
                        ),
                      ),
                      Positioned(
                        top: 0,
                        right: 0,
                        child: GestureDetector(
                          onTap: () => removeVehicleImage(imagePathList[index]),
                          child: Container(
                            // color: Colors.red,
                            child: const Icon(
                              Icons.close,
                              color: Colors.red,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  bool isLoading = false;

  StateSetter? checkoutState;

  File? panImage;
  File? gstImage;
  File? aadharImage;
  File? aadharBack;
  File? voterIdImage;
  File? voterIdBackImage;
  File? udyogIdImage;
  File? gstOne;
  File? gstTwo;

  _getFromCameraPan() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
        source: ImageSource.camera,
        maxHeight: 100,
        maxWidth: 100,
        imageQuality: 40);
    if (pickedFile != null) {
      checkoutState!(() {
        panImage = File(pickedFile.path);
      });
      // Navigator.pop(context);
    }
  }

  _getFromCameraGst() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
        source: ImageSource.camera,
        maxHeight: 100,
        maxWidth: 100,
        imageQuality: 40);
    if (pickedFile != null) {
      checkoutState!(() {
        gstImage = File(pickedFile.path);
      });
      // Navigator.pop(context);
    }
  }

  _getFromCameraGstOne() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
        source: ImageSource.camera,
        maxHeight: 100,
        maxWidth: 100,
        imageQuality: 40);
    if (pickedFile != null) {
      checkoutState!(() {
        gstOne = File(pickedFile.path);
      });
      // Navigator.pop(context);
    }
  }

  _getFromCameraGstTwo() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
        source: ImageSource.camera,
        maxHeight: 100,
        maxWidth: 100,
        imageQuality: 40);
    if (pickedFile != null) {
      checkoutState!(() {
        gstTwo = File(pickedFile.path);
      });
      // Navigator.pop(context);
    }
  }

  getImageFromCamera(src) async {
    var pickedFile = await ImagePicker().pickImage(
        source: ImageSource.camera,
        maxHeight: 100,
        maxWidth: 100,
        imageQuality: 40);
    switch (src) {
      case "aadhar":
        if (pickedFile != null) {
          checkoutState!(() {
            aadharImage = File(pickedFile.path);
          });
        }
        break;
      case "aadhar_back":
        if (pickedFile != null) {
          checkoutState!(() {
            aadharBack = File(pickedFile.path);
          });
        }
        break;
      case "voter_id":
        if (pickedFile != null) {
          checkoutState!(() {
            voterIdImage = File(pickedFile.path);
          });
        }
        break;
      case "voter_id_back":
        if (pickedFile != null) {
          checkoutState!(() {
            voterIdBackImage = File(pickedFile.path);
          });
        }
        break;
      case "pan":
        if (pickedFile != null) {
          checkoutState!(() {
            panImage = File(pickedFile.path);
          });
        }
        break;
      case "gst_one":
        if (pickedFile != null) {
          checkoutState!(() {
            gstImage = File(pickedFile.path);
          });
        }
        break;
      case "gst_two":
        if (pickedFile != null) {
          checkoutState!(() {
            gstOne = File(pickedFile.path);
          });
        }
        break;
      case "gst_three":
        if (pickedFile != null) {
          checkoutState!(() {
            gstTwo = File(pickedFile.path);
          });
        }
        break;
      default:
        if (pickedFile != null) {
          checkoutState!(() {
            count++;
            _imageFile = File(pickedFile.path);
            imagePathList.add(_imageFile?.path ?? "");
            isImages = true;
          });
        }
        break;
    }
  }

  imageUpload(String? id) {
    return showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
        ),
        builder: (builder) {
          return Container(
            height: 650,
            child: StatefulBuilder(
                builder: (BuildContext context, StateSetter setState) {
              checkoutState = setState;
              return Padding(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      _getFromCameraPan();
                                    },
                                    child: Center(
                                      child: Stack(
                                        children: [
                                          Container(
                                            height: 150,
                                            width: 150,
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.black),
                                            ),
                                            child: panImage != null
                                                ? Image.file(panImage!.absolute,
                                                    fit: BoxFit.fill)
                                                : Center(
                                                    child: Text("Pan Image"),
                                                  ),
                                          ),
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
                                                      color: Colors.red
                                                          .withOpacity(0.7),
                                                    ),
                                                  ),
                                                )
                                              : SizedBox()
                                        ],
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      _getFromCameraGst();
                                    },
                                    child: Center(
                                      child: Stack(
                                        children: [
                                          Container(
                                            height: 150,
                                            width: 150,
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.black),
                                            ),
                                            child: gstImage != null
                                                ? Image.file(gstImage!.absolute,
                                                    fit: BoxFit.fill)
                                                : Center(
                                                    child:
                                                        Text("Add GST Image1")),
                                          ),
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
                                                      color: Colors.red
                                                          .withOpacity(0.7),
                                                    ),
                                                  ),
                                                )
                                              : SizedBox()
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      _getFromCameraGstOne();
                                    },
                                    child: Center(
                                      child: Stack(
                                        children: [
                                          Container(
                                            height: 150,
                                            width: 150,
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.black),
                                            ),
                                            child: gstOne != null
                                                ? Image.file(gstOne!.absolute,
                                                    fit: BoxFit.fill)
                                                : Center(
                                                    child:
                                                        Text("Add GST Image2")),
                                          ),
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
                                                      color: Colors.red
                                                          .withOpacity(0.7),
                                                    ),
                                                  ),
                                                )
                                              : SizedBox()
                                        ],
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      _getFromCameraGstTwo();
                                    },
                                    child: Center(
                                      child: Stack(
                                        children: [
                                          Container(
                                            height: 150,
                                            width: 150,
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.black),
                                            ),
                                            child: gstTwo != null
                                                ? Image.file(gstTwo!.absolute,
                                                    fit: BoxFit.fill)
                                                : Center(
                                                    child:
                                                        Text("Add GST Image3")),
                                          ),
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
                                                      color: Colors.red
                                                          .withOpacity(0.7),
                                                    ),
                                                  ),
                                                )
                                              : SizedBox()
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      getImageFromCamera("aadhar");
                                    },
                                    child: Center(
                                      child: Stack(children: [
                                        Container(
                                          height: 150,
                                          width: 150,
                                          decoration: BoxDecoration(
                                            border:
                                                Border.all(color: Colors.black),
                                          ),
                                          child: aadharImage != null
                                              ? Image.file(
                                                  aadharImage!.absolute,
                                                  fit: BoxFit.fill)
                                              : Center(
                                                  child: Text(
                                                      "Add Aadhaar Front")),
                                        ),
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
                                                    color: Colors.red
                                                        .withOpacity(0.7),
                                                  ),
                                                ),
                                              )
                                            : SizedBox()
                                      ]),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      getImageFromCamera("aadhar_back");
                                    },
                                    child: Center(
                                      child: Stack(
                                        children: [
                                          Container(
                                            height: 150,
                                            width: 150,
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.black),
                                            ),
                                            child: aadharBack != null
                                                ? Image.file(
                                                    aadharBack!.absolute,
                                                    fit: BoxFit.fill)
                                                : Center(
                                                    child: Text(
                                                        "Add Aadhaar Back")),
                                          ),
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
                                                      color: Colors.red
                                                          .withOpacity(0.7),
                                                    ),
                                                  ),
                                                )
                                              : SizedBox()
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      getImageFromCamera("voter_id");
                                    },
                                    child: Center(
                                      child: Stack(children: [
                                        Container(
                                          height: 150,
                                          width: 150,
                                          decoration: BoxDecoration(
                                            border:
                                                Border.all(color: Colors.black),
                                          ),
                                          child: voterIdImage != null
                                              ? Image.file(
                                                  voterIdImage!.absolute,
                                                  fit: BoxFit.fill)
                                              : Center(
                                                  child: Text(
                                                      "Add Voter Id Front")),
                                        ),
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
                                                    color: Colors.red
                                                        .withOpacity(0.7),
                                                  ),
                                                ),
                                              )
                                            : SizedBox()
                                      ]),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      getImageFromCamera("voter_id_back");
                                    },
                                    child: Center(
                                      child: Stack(
                                        children: [
                                          Container(
                                            height: 150,
                                            width: 150,
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.black),
                                            ),
                                            child: voterIdBackImage != null
                                                ? Image.file(
                                                    voterIdBackImage!.absolute,
                                                    fit: BoxFit.fill)
                                                : Center(
                                                    child: Text(
                                                        "Add Voter Id Back")),
                                          ),
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
                                                      color: Colors.red
                                                          .withOpacity(0.7),
                                                    ),
                                                  ),
                                                )
                                              : SizedBox()
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.zero,
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                uploadMultiImage(),
                                const SizedBox(
                                  height: 14,
                                ),
                              ],
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            if (imagePathList.isEmpty ||
                                imagePathList == null) {
                              Fluttertoast.showToast(
                                  msg: "Please Select Multiple Images");
                            }
                            setState(() {
                              isLoading = true;
                            });
                            addPhoto(id);
                          },
                          child: Container(
                            height: 40,
                            width: 120,
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
                                  : Text("Submit",
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
          );
        });
  }

  final picker = ImagePicker();
  File? _imageFile;
  bool isImages = false;
  //
  // Widget buildGridView() {
  //   return Container(
  //     height: 200,
  //     child: Card(
  //       shape: RoundedRectangleBorder(
  //           borderRadius: BorderRadius.all(Radius.circular(15))),
  //       child: Container(
  //         width: MediaQuery.of(context).size.width / 2.3,
  //         height: MediaQuery.of(context).size.height / 3,
  //         child: _imageFile == "" || _imageFile == null
  //             ? Text("--")
  //             : ClipRRect(
  //                 borderRadius: BorderRadius.all(Radius.circular(15)),
  //                 child: Image.file(_imageFile!, fit: BoxFit.cover),
  //               ),
  //       ),
  //     ),
  //   );
  // }

  // Widget buildGridView() {
  //   return Container(
  //     height: 170,
  //     child: GridView.builder(
  //       itemCount: imagePathList.length,
  //       gridDelegate:
  //           SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
  //       itemBuilder: (BuildContext context, int index) {
  //         return Stack(
  //           children: [
  //             Container(
  //               decoration: BoxDecoration(
  //                   borderRadius: BorderRadius.circular(10),
  //                   border: Border.all(color: colors.primary)),
  //               width: MediaQuery.of(context).size.width / 2.8,
  //               height: 170,
  //               child: ClipRRect(
  //                 borderRadius: BorderRadius.all(Radius.circular(10)),
  //                 child:
  //                     Image.file(File(imagePathList[index]), fit: BoxFit.cover),
  //               ),
  //             ),
  //             // Positioned(
  //             //   bottom: 0,
  //             //   child: Container(
  //             //     decoration: BoxDecoration(
  //             //       borderRadius: BorderRadius.circular(10),
  //             //       border: Border.all(color: colors.primary),
  //             //     ),
  //             //     width: MediaQuery.of(context).size.width / 2.8,
  //             //     height: 65,
  //             //     child: Padding(
  //             //       padding: const EdgeInsets.all(3.0),
  //             //       child: Column(
  //             //         crossAxisAlignment: CrossAxisAlignment.start,
  //             //         mainAxisAlignment: MainAxisAlignment.center,
  //             //         children: [
  //             //           Text(
  //             //             "Date: ${formattedDate}",
  //             //             style: TextStyle(fontSize: 10, color: Colors.white),
  //             //           ),
  //             //           Text(
  //             //             "Time: ${timeData}",
  //             //             style: TextStyle(fontSize: 10, color: Colors.white),
  //             //           ),
  //             //           Text(
  //             //             "Location: ${currentAddress.text}",
  //             //             style: TextStyle(fontSize: 10, color: Colors.white),
  //             //             overflow: TextOverflow.ellipsis,
  //             //             maxLines: 2,
  //             //           )
  //             //         ],
  //             //       ),
  //             //     ),
  //             //   ),
  //             // ),
  //             // Positioned(
  //             //   top: 0,
  //             //   right: 25,
  //             //   child: InkWell(
  //             //     onTap: () {
  //             //       setState(() {
  //             //         imagePathList.remove(imagePathList[index]);
  //             //         count--;
  //             //       });
  //             //     },
  //             //     child: Icon(
  //             //       Icons.cancel,
  //             //       size: 30,
  //             //       color: Colors.red.withOpacity(0.7),
  //             //     ),
  //             //   ),
  //             // )
  //           ],
  //         );
  //       },
  //     ),
  //   );
  // }

  Widget catLoading() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Column(
                children: [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
                    .map((_) => Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.white,
                              shape: BoxShape.rectangle,
                            ),
                            width: MediaQuery.of(context).size.width,
                            height: 60.0,
                          ),
                        ))
                    .toList()),
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          width: double.infinity,
          height: 18.0,
          color: Theme.of(context).colorScheme.white,
        ),
      ],
    );
  }
}

class UploadImage extends StatelessWidget {
  String? text;
  String? count;
  String? finalCount;
  UploadImage({Key? key, this.text, this.count, this.finalCount})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DottedBorder(
      color: Color(0xff9AC228),
      strokeWidth: 2,
      dashPattern: [10, 5],
      borderType: BorderType.RRect,
      radius: Radius.circular(12),
      child: Container(
        width: 120,
        height: 110,
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/imagePicer2.png',
              height: 28,
            ),
            SizedBox(height: 5),
            Text(
              "Upload Images",
              style: const TextStyle(
                color: Color(0xff9AC228),
                fontWeight: FontWeight.w700,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
