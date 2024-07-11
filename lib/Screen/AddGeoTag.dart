import 'dart:convert';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:omega_employee_management/Screen/Dashboard.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:http/http.dart' as http;
import '../Helper/Color.dart';
import '../Helper/Session.dart';
import '../Helper/String.dart';
import '../Model/ClientModel.dart';
import '../Provider/HomeProvider.dart';
import 'ClientForm.dart';

var latitude;
var longitude;

class AddGeoScreen extends StatefulWidget {
  const AddGeoScreen({Key? key}) : super(key: key);

  @override
  State<AddGeoScreen> createState() => _AddGeoScreenState();
}

class _AddGeoScreenState extends State<AddGeoScreen> {

  @override
  void initState() {
    super.initState();
    getClients();
    getCurrentLoc();
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
      'filter':'geo_tag'
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

  TextEditingController searchCtr = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        title: Text("GeoTage", style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),),
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
            Container(
              child: GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 5,
                    mainAxisSpacing: 5,
                    childAspectRatio: 4/5.8
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
                                    Text("${clientData?[index].nameOfFirm}", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color:colors.blackTemp, overflow: TextOverflow.ellipsis),
                                    ),
                                    SizedBox(height: 10),
                                    Text("${clientData?[index].ownerName}", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color:colors.blackTemp)),
                                    SizedBox(height: 10),
                                    Text("${clientData?[index].mobileOne}", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: colors.blackTemp)),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 10,),
                          InkWell(
                            onTap: () {
                              geoTagDialog(
                                  context, clientData?[index].id.toString() ?? "");
                            },
                            child: Container(
                              height: 30,
                              width: 70,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
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

  addGeoTag(String id) async{
    var headers = {
      'Cookie': 'ci_session=26b532a5b5bb9103195c77bf41a94bc7c6f931bc'
    };
    var request = http.MultipartRequest('POST', Uri.parse('https://developmentalphawizz.com/rename_market_track/app/v1/api/update_geo_tag'));
    request.fields.addAll({
      'id': id.toString(),
      'lat': latitude.toString(),
      'lng': longitude.toString()
    });

    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
      Fluttertoast.showToast(msg: "GeoTag Update Successfully");
      getClients();
      Navigator.push(context, MaterialPageRoute(builder: (context) => Dashboard()));

    }
    else {
      print(response.reasonPhrase);
    }
  }

  void geoTagDialog(BuildContext context, String id) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          // title: Text(title),
          // content: Text(message),
          actions: <Widget>[
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Card(
                    elevation: 3,
                    child: Container(
                      height: 60,
                      width: MediaQuery.of(context).size.width/1.2,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.white),
                      child: TextFormField(
                        // controller: commentCtr,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(left: 5),
                          hintText: "AddGeoTag",
                          hintStyle: TextStyle(fontSize: 13),
                          enabledBorder: OutlineInputBorder(borderSide: BorderSide.none),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 40),
                InkWell(
                  onTap: () {
                    addGeoTag(id);
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
                SizedBox(height: 10),
              ],
            ),
          ],
        );
      },
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
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height,
                child:
                GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 5,
                      mainAxisSpacing: 5,
                      childAspectRatio: 4/6
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
                                geoTagDialog(
                                    context, clients?.data?[index].id.toString() ?? "");
                              },
                              child: Container(
                                height: 30,
                                width: 70,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
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
