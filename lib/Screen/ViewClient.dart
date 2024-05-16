import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import 'package:http/http.dart' as http;
import '../Helper/Color.dart';
import '../Helper/Session.dart';
import '../Helper/String.dart';
import '../Model/ClientModel.dart';
import '../Provider/HomeProvider.dart';
import 'ClientForm.dart';
import 'ClientsView.dart';

class ViewClient extends StatefulWidget {
  const ViewClient({Key? key}) : super(key: key);

  @override
  State<ViewClient> createState() => _ViewClientState();
}

class _ViewClientState extends State<ViewClient> {

@override
void initState() {
  super.initState();
  getClients();
}

String? department_id;
  ClientModel? clients;
  List<ClientsData> clientData = [];
  getClients() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    department_id = pref.getString('department');
    var parm={
      USER_ID: '${CUR_USERID}',
      'department_id': '${department_id.toString()}'
    };
    var headers = {
      'Cookie': 'ci_session=aa83f4f9d3335df625437992bb79565d0973f564'
    };
    var request = http.MultipartRequest('POST', Uri.parse(getClientApi.toString()));
    request.fields.addAll({
      USER_ID: '${CUR_USERID}',
       'department_id': '${department_id.toString()}'
    });

    print("this is refer request for department${request.fields.toString()}");
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      String str = await response.stream.bytesToString();
      print('data-----${str}');
      var result = json.decode(str);
      var finalResponse = ClientModel.fromJson(result);
      setState(() {

        clients = finalResponse;
        clientData = clients?.data ?? [];
        print('clients length : ${clients?.data?.length}');
      });
      print("this is response data ${finalResponse.data.toString()}");
      // setState(() {
      // animalList = finalResponse.data!;
      // });
      // print("this is operator list ----->>>> ${operatorList[0].name}");
    }
    else {
      print(response.reasonPhrase);
    }
  }


searchClients(String value) {
    print("mmm$value");
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
      print('client data length : ${clientData.length}');
    });
  }
}
Future<void> downloadImage(String imageUrl) async {
    print("mmmmmmmm");
  var response = await http.get(Uri.parse(imageUrl));

  if (response.statusCode == 200) {
    final result = await ImageGallerySaver.saveImage(Uint8List.fromList(response.bodyBytes));
    Fluttertoast.showToast(msg: "Image saved to gallery");
    print('Image saved to gallery: $result');
  } else {
    print('Failed to download image: ${response.statusCode}');
  }
}

TextEditingController searchCtr = TextEditingController();

  showDilaogBox(String imageUrl)
  {
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
                      color: colors.primary
                  ),
                  child: Center(child: Text("Yes",style: TextStyle(color: colors.whiteTemp),)),
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
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
                      color: colors.primary),
                  child: Center(child: Text("No",style: TextStyle(color: colors.whiteTemp),)),
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
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        title: Text("Clients List", style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),),
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
                        child: Icon(
                            Icons.search, color: Colors.white),
                    ),
                    hintText: "Search here",
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))
                ),
              ),
            ),
            SizedBox(height: 10),
            Container(
              child: GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 5,
                    mainAxisSpacing: 5,
                    childAspectRatio: 3/4.8
                ),
                itemCount: clientData.length ?? 0,
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
                          InkWell(

                            child: Padding(
                              padding: EdgeInsets.all(0),
                              child: new ClipRRect(
                                borderRadius: BorderRadius.circular(0.0),
                                child: new FadeInImage(
                                  fadeInDuration: Duration(milliseconds: 150),
                                  image: CachedNetworkImageProvider("${clients?.data?[index].photo?[0]}"),
                                  height: 110.0,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                  imageErrorBuilder: (context, error, stackTrace) => erroWidget(50),
                                  placeholder: placeHolder(50),
                                ),
                              ),
                            ),
                            onTap: (){
                              // print("download image");
                              // downloadImage(clientData?[index].photo!?[0] ?? "");
                              if(clientData?[index].photo?[0]!=null)
                              {
                                final imageProvider = Image.network(clientData?[index].photo?[0]?? '').image;
                                showImageViewer(context, imageProvider,
                                    onViewerDismissed: () {
                                      print("dismissed");
                                    });
                              }
                            },
                            onLongPress: (){
                            //  print("download image");

                              showDilaogBox(clientData?[index].photo!?[0] ?? "");
                            //  downloadImage(clientData?[index].photo!?[0] ?? "");
                            },
                          ),
                          const SizedBox(width: 20),
                          Padding(
                            padding: const EdgeInsets.only(left: 5.0, right: 5),
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
                                      width: 90,
                                        child: Text("${clientData?[index].address}", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: colors.blackTemp), maxLines: 2,)),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 5),
                          InkWell(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => ClientsView(model: clientData?[index])));
                            },
                            child: Container(
                              height: 30,
                              width: 70,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: colors.primary
                              ),
                              child: Center(
                                  child: Text("View",style: TextStyle(color: colors.whiteTemp,fontWeight: FontWeight.bold),)),
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
        ): Padding(
            padding: const EdgeInsets.all(5.0),
            child: Container(
               height: MediaQuery.of(context).size.height,
                child:
                GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 5,
                      mainAxisSpacing: 5,
                      childAspectRatio: 4/5.8
                  ),
                  itemCount: clients?.data?.length ?? 0,
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
                                  image: CachedNetworkImageProvider("${clients?.data?[index].photo}"),
                                  height: 130.0,
                                  width: MediaQuery.of(context).size.width,
                                  fit: BoxFit.cover,
                                  imageErrorBuilder: (context, error, stackTrace) => erroWidget(50),
                                  placeholder: placeHolder(50),
                                ),
                              ),
                            ),
                            const SizedBox(width: 20),
                            Padding(
                              padding: const EdgeInsets.only(left: 10.0, right: 10),
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
                                      Text("${clients?.data?[index].nameOfFirm}", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color:colors.blackTemp, overflow: TextOverflow.ellipsis),
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

                            // InkWell(
                            //   onTap: () {
                            //     Navigator.push(context, MaterialPageRoute(builder: (context) => Client_form(model: clients?.data?[index])));
                            //   },
                            //   child: Container(
                            //     height: 30,
                            //     width: 70,
                            //     decoration: BoxDecoration(
                            //         borderRadius: BorderRadius.circular(5),
                            //         color: colors.primary
                            //     ),
                            //     child: Center(child: Text("Add",style: TextStyle(color: colors.whiteTemp,fontWeight: FontWeight.bold),)),
                            //   ),
                            // )
                          ],
                        ),
                      ),
                    );
                  },
                ),
            ),
        );
      },
      selector: (_,homeProvider) => homeProvider.catLoading,
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
