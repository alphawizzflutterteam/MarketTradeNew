import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:http/http.dart' as http;
import '../Helper/Color.dart';
import '../Helper/Session.dart';
import '../Helper/String.dart';
import '../Model/ClientModel.dart';
import '../Provider/HomeProvider.dart';
import 'ClientForm.dart';

class EditClient extends StatefulWidget {
  const EditClient({Key? key}) : super(key: key);

  @override
  State<EditClient> createState() => _EditClientState();
}

class _EditClientState extends State<EditClient> {

  @override
  void initState() {
    super.initState();
    getClients();
  }

  ClientModel? clients;
  List<ClientsData> clientData = [];
  getClients() async{
    var headers = {
      'Cookie': 'ci_session=aa83f4f9d3335df625437992bb79565d0973f564'
    };
    var request = http.MultipartRequest('POST', Uri.parse(getClientApi.toString()));
    request.fields.addAll({
      USER_ID: '${CUR_USERID}',
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
        title: Text("Edit Clients", style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),),
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
                          SizedBox(height: 10),
                          InkWell(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => Client_form(model: clients?.data?[index])));
                            },
                            child: Container(
                              height: 30,
                              width: 70,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: colors.primary
                              ),
                              child: Center(
                                  child: Text("Edit",style: TextStyle(color: colors.whiteTemp,fontWeight: FontWeight.bold),)),
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
                            SizedBox(height: 10),
                            InkWell(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => Client_form(model: clients?.data?[index])));
                              },
                              child: Container(
                                height: 30,
                                width: 70,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: colors.primary
                                ),
                                child: Center(
                                    child: Text("Edit",style: TextStyle(color: colors.whiteTemp,fontWeight: FontWeight.bold),)),
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
