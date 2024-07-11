import 'dart:convert';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:omega_employee_management/Screen/Dashboard.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:http/http.dart' as http;
import '../Helper/Color.dart';
import '../Helper/Session.dart';
import '../Helper/String.dart';
import '../Model/ClientModel.dart';
import '../Provider/HomeProvider.dart';
import 'ClientForm.dart';

class AddPhoto extends StatefulWidget {
  const AddPhoto({Key? key}) : super(key: key);

  @override
  State<AddPhoto> createState() => _AddPhotoState();
}

class _AddPhotoState extends State<AddPhoto> {


  @override
  void initState() {
    super.initState();
    getClients();
  }

  ClientModel? clients;
  List<ClientsData> clientData = [];

  getClients() async {
    var headers = {
      'Cookie': 'ci_session=aa83f4f9d3335df625437992bb79565d0973f564'
    };
    var request = http.MultipartRequest('POST', Uri.parse(getClientApi.toString()));
    request.fields.addAll({
      USER_ID: '${CUR_USERID}',
      'filter': 'photo'
    });

    print("this is refer request ${request.fields.toString()}");
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      String str = await response.stream.bytesToString();
      var result = json.decode(str);
      var finalResponse = ClientModel.fromJson(result);
      setState(() {
        clients = finalResponse;
        clientData = clients?.data ?? [];
      });
      print("this is response data ${finalResponse}");
    }
    else {
      print(response.reasonPhrase);
    }
  }

  addPhoto(String? id) async {
    var headers = {
      'Cookie': 'ci_session=a668203a30aa21277b05b1ffb48275800e081571'
    };
    var request = http.MultipartRequest('POST', Uri.parse('https://developmentalphawizz.com/rename_market_track/app/v1/api/update_photo'));
    request.fields.addAll({
      'id': id.toString()
    });
    print("addd photo parameter ${request.fields}");
    request.files.add(await http.MultipartFile.fromPath('images', _imageFile!.path.toString()));
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
      Fluttertoast.showToast(msg: "Image Update Successfully");
      getClients();
      Navigator.push(context, MaterialPageRoute(builder: (clients) => Dashboard()));
    }
    else {
      print(response.reasonPhrase);
    }
  }

  searchClients(String value) {
    if (value.isEmpty) {
      getClients();
      setState(() {});
    }else{
      final suggestions = clientData.where((element) {
        final ownerName = element.ownerName.toString().toLowerCase();
        final address = element.address.toString().toLowerCase();
        final mobile = element.mobileOne.toString().toLowerCase();
        final firmName = element.nameOfFirm.toString().toLowerCase();
        final input = value.toLowerCase();
        return ownerName.contains(input) || address.contains(input) || mobile.contains(input) ||  firmName.contains(input);
      }).toList();
      clientData = suggestions;
      setState(() {
      });
    }
  }

  TextEditingController searchCtr = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        title: Text("AddPhoto", style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),),
        centerTitle: true,
        backgroundColor: colors.primary,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 10),
            Container(
              height:50,
              padding: EdgeInsets.only(left:15,right:15),
              child: TextFormField(
                onChanged: (value){
                  searchClients(value);
                },
                controller: searchCtr,
                decoration: InputDecoration(
                    suffixIcon: Container(
                        width: 20,
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: colors.primary),
                        child: Icon(Icons.search, color: Colors.white)),
                    hintText: "Search here",
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))
                ),
              ),
            ),
            SizedBox(height: 10,),
            Container(
              child: GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 5,
                    mainAxisSpacing: 5,
                    childAspectRatio: 3/4.5
                ),
                itemCount: clientData?.length ?? 0,
                itemBuilder: (context, index) {
                  return  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Container(
                      //  height: MediaQuery.of(context).size.height/1.0,
                      decoration: BoxDecoration(
                          border: Border.all(color: colors.primary),
                          borderRadius: BorderRadius.circular(5)
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.all(0),
                            child: new ClipRRect(
                              borderRadius: BorderRadius.circular(0.0),
                              child: new FadeInImage(
                                fadeInDuration: Duration(milliseconds: 150),
                                image: CachedNetworkImageProvider("${clientData?[index].photo}"),
                                height: 130.0,
                                width: double.infinity,
                                fit: BoxFit.fill,
                                imageErrorBuilder: (context, error, stackTrace) => erroWidget(50),
                                placeholder: placeHolder(50),
                              ),
                            ),
                          ),
                          const SizedBox(width: 20),
                          Padding(
                            padding: const EdgeInsets.only(left:5.0, right:5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Firm:", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color:colors.blackTemp),),
                                    SizedBox(height: 10,),
                                    Text("Owner:", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color:colors.blackTemp),),
                                    SizedBox(height: 10,),
                                    Text("Mobile:", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: colors.blackTemp),),
                                    SizedBox(height: 10,),
                                    Text("Address:", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: colors.blackTemp),),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text("${clientData?[index].nameOfFirm}", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color:colors.blackTemp, overflow: TextOverflow.ellipsis),
                                    ),
                                    SizedBox(height: 10),
                                    Text("${clientData?[index].ownerName}", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color:colors.blackTemp)),
                                    SizedBox(height: 10),
                                    Text("${clientData?[index].mobileOne}", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: colors.blackTemp)),
                                    SizedBox(height: 10),
                                    Container(
                                      width: 105,
                                        child: Text("${clientData?[index].address}", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: colors.blackTemp), maxLines: 2,)),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 10),
                          InkWell(
                            onTap: () {
                              // addPhotoDialog(context, clients?.data?[index].id.toString() ?? "");
                              _getFromCamera(clientData?[index].id.toString() ?? "");
                            },
                            child: Container(
                              height: 40,
                              width: 80,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: colors.primary
                              ),
                              child: Center(child: Text("Add",style: TextStyle(color: colors.whiteTemp,fontWeight: FontWeight.bold),)),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
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
    return  Selector<HomeProvider, bool>(
      builder: (context, data, child) {
        return data
            ? Container(
          width: double.infinity,
          child: Shimmer.fromColors(
              baseColor: Theme.of(context).colorScheme.simmerBase,
              highlightColor: Theme.of(context).colorScheme.simmerHigh,
              child: catLoading()),
        ):
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height/1,
                child:
                GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                  crossAxisSpacing: 5,
                    mainAxisSpacing: 5,
                    childAspectRatio: 4/5
                  ),
                  itemCount: clients?.data?.length ?? 0,
                  itemBuilder: (context, index) {
                    return  Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Container(
                        // height: MediaQuery.of(context).size.height/1.0,
                        decoration: BoxDecoration(
                            border: Border.all(color: colors.primary),
                            borderRadius: BorderRadius.circular(5)
                        ),
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
                                  fadeInDuration: Duration(milliseconds: 150),
                                  image: CachedNetworkImageProvider("${clients?.data?[index].photo}"),
                                  height: 70.0,
                                  width: 70,
                                  fit: BoxFit.fill,
                                  imageErrorBuilder: (context, error, stackTrace) => erroWidget(50),
                                  placeholder: placeHolder(50),
                                ),
                              ),
                            ),
                            const SizedBox(width: 20),
                            Padding(
                              padding: const EdgeInsets.only(left:10.0,right: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("Firm:", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color:colors.blackTemp),),
                                      SizedBox(height: 10,),
                                      Text("Owner:", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color:colors.blackTemp),),
                                      SizedBox(height: 10,),
                                      Text("Number:", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: colors.blackTemp),),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text("${clients?.data?[index].nameOfFirm}", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color:colors.blackTemp,
                                          overflow: TextOverflow.ellipsis),
                                      ),
                                      SizedBox(height: 10),
                                      Text("${clients?.data?[index].ownerName}", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color:colors.blackTemp)),
                                      SizedBox(height: 10),
                                      Text("${clients?.data?[index].mobileOne}", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: colors.blackTemp)),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 10,),
                            InkWell(
                              onTap: () {
                                // addPhotoDialog(context, clients?.data?[index].id.toString() ?? "");
                                _getFromCamera(clients?.data?[index].id.toString() ?? "");
                              },
                              child: Container(
                                height: 40,
                                width: 80,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: colors.primary
                                ),
                                child: Center(child: Text("Add",style: TextStyle(color: colors.whiteTemp,fontWeight: FontWeight.bold),)),
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
      selector: (_,homeProvider) => homeProvider.catLoading,
    );
  }

   addPhotoDialog(BuildContext context, String id) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          actions: <Widget>[
            Column(
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 55),
                  child: InkWell(
                    onTap: () async {
                     // _getFromCamera();
                    },
                    child: Container(
                      height: 40,
                      width: 145,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5), color: colors.primary),
                      child: Center(
                        child: Text(
                          "Add Photo",
                          style: TextStyle(color: colors.whiteTemp),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height:5,
                ),
                Visibility(
                  visible: isImages,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 50, top: 10),
                        child: buildGridView(),
                      ),
                      SizedBox(height: 10),
                    ],
                  ),
                ),
                // SizedBox(height: 10),
                // Container(
                //   height: 200,
                //   child: Card(
                //     child: GridView.builder(
                //         itemCount: fileModel?.data?.length ?? 0,
                //         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                //             crossAxisCount: 2),
                //         itemBuilder: (context, index) {
                //           return Padding(
                //               padding: EdgeInsets.all(5),
                //               child: Container(
                //                   decoration: new BoxDecoration(
                //                       image: new DecorationImage(
                //                           image: new NetworkImage("${imageUrl}${fileModel?.data}"),
                //                           fit: BoxFit.cover))));
                //         }),
                //   ),
                // ),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.only(right: 50),
                  child: InkWell(
                    onTap: () {
                      addPhoto(id);
                      Navigator.pop(context);
                    },
                    child: Container(
                      height: 40,
                      width: 80,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: colors.primary),
                      child: Center(
                        child: Text("Submit", style: TextStyle(fontSize: 14, color: Colors.white, fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
              ],
            ),
          ],
        );
      },
    );
  }

  _getFromCamera(String? id) async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera,
    );
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
        // imagePathList.add(_imageFile?.path ?? "");
        isImages = true ;
      });
      addPhoto(id);
      //Navigator.pop(context);
    }
  }

  final picker = ImagePicker();
  File? _imageFile;
  List<String> imagePathList = [];
  bool isImages = false;

  Widget buildGridView() {
    return Container(
      height: 200,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15))),
        child: Container(
          width: MediaQuery.of(context).size.width/2.3,
          height: MediaQuery.of(context).size.height/3,
          child: _imageFile == "" ? Text("--"):
          ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(15)),
            child: Image.file(_imageFile!,
                fit: BoxFit.cover),
          ),
        ),
      ),
    );
  }

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
                )).toList()),
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
