import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../Helper/Color.dart';
import '../Helper/String.dart';
import '../Model/GetFeedbackModel.dart';
import '../Model/MySiteVisitModel.dart';
import 'MySideDetails.dart';

class MySiteVisite extends StatefulWidget {
  const MySiteVisite({Key? key}) : super(key: key);

  @override
  State<MySiteVisite> createState() => _MySiteVisiteState();
}

class _MySiteVisiteState extends State<MySiteVisite> {
  void initState() {
    super.initState();
    getData(1);

  }

  MySiteVisitModel? getdata;
  Future<void> getData(index) async {
    var headers = {
      'Cookie': 'ci_session=bf12d5586296e8a180885fdf282632a583f96888'
    };
    var request = http.MultipartRequest('POST', Uri.parse(siteVisitFormList.toString()));
    request.fields.addAll({
      'user_id': '${CUR_USERID}',
    });
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var  result=await response.stream.bytesToString();
      var finalresult=MySiteVisitModel.fromJson(json.decode(result));
      setState(() {
        getdata = finalresult;
      });
    }
    else {
      print(response.reasonPhrase);
    }
  }


  @override
  Widget build(BuildContext context) {
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
        title: Text("Customer Survey Form", style: TextStyle(fontSize: 17, color: Colors.white, fontWeight: FontWeight.w800),),
      ),
      body: getdata== null ? Center(child: CircularProgressIndicator()) : SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: getdata?.data?.length ?? 0,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => MySiteDetails(model: getdata?.data?[index])));
                    },
                    child: Card(
                      elevation: 5,
                      child: Container(
                        height: 180,
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.white),
                        width: MediaQuery.of(context).size.width,
                        child: Padding(
                          padding: const EdgeInsets.all(5),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              // Container(
                              //   padding: EdgeInsets.all(5),
                              //   decoration: BoxDecoration(
                              //     borderRadius: BorderRadius.circular(10),
                              //   ),
                              //   child: ClipRRect(
                              //     borderRadius: BorderRadius.circular(9),
                              //     child: getdata?.data?[index].photo?[index] == null || getdata?.data?[index].photo?[index] == "" ? Text(" No Imagae"):
                              //     Image.network(
                              //       "${getdata?.data?[index].photo?[index]}",
                              //       height: 200,
                              //       width: 100,
                              //       // fit: BoxFit.fill,
                              //     ),
                              //   ),
                              // ),
                              Padding(
                                padding: const EdgeInsets.only(left: 5),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(children: [
                                      const Text("Name: ", style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,)),
                                      Text(
                                        "${getdata?.data?[index].name}",
                                        style: const TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400,),
                                      ),
                                    ],),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Row(
                                      children: [
                                        const Text("Mobile: ", style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold, )),
                                        Text(
                                          "${getdata?.data?[index].mobile}",
                                          style: const TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w400, ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Row(
                                      children: [
                                        const Text("UserName: ", style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold, )),
                                        Text(
                                          "${getdata?.data?[index].name}",
                                          style: const TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400,),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Row(
                                      children: [
                                        const Text("Address: ", style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,),
                                        ),
                                        Text(
                                          "${getdata?.data?[index].address}",
                                          style: const TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w400,),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Row(
                                      children: [
                                        const Text("Remark: ", style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,),
                                        ),
                                        Text(
                                          "${getdata?.data?[index].remarks}",
                                          style: const TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400,),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Row(
                                      children: [
                                        const Text("Date & Time: ", style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          "${getdata?.data?[index].date} ${getdata?.data?[index].time}",
                                          style: const TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400,),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                  ],
                                ),
                              ),

                            ],
                          ),
                        ),
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
}
