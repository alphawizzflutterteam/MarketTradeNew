import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Helper/Color.dart';
import '../Helper/String.dart';
import '../Model/DepartmentModel.dart';
import '../Model/MySiteVisitModel.dart';
import '../Provider/UserProvider.dart';
import 'MySideDetails.dart';

class MySiteVisite extends StatefulWidget {
  const MySiteVisite({Key? key}) : super(key: key);

  @override
  State<MySiteVisite> createState() => _MySiteVisiteState();
}

class _MySiteVisiteState extends State<MySiteVisite> {
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
    print("this is department request ${request.fields.toString()}");
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
        getData();
      });
    } else {
      print(response.reasonPhrase);
    }
  }

  MySiteVisitModel? getdata;
  String? department_id;

  Future<void> getData() async {
    var headers = {
      'Cookie': 'ci_session=bf12d5586296e8a180885fdf282632a583f96888'
    };
    var request =
        http.MultipartRequest('POST', Uri.parse(siteVisitFormList.toString()));
    request.fields.addAll({
      'user_id': '${CUR_USERID}',
      'department_id': '${department_id.toString()}'
    });
    print("customer survey form ${request.fields}");
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var result = await response.stream.bytesToString();
      var finalresult = MySiteVisitModel.fromJson(json.decode(result));
      setState(() {
        getdata = finalresult;
      });
    } else {
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
        title: Text(
          "Customer Survey Form",
          style: TextStyle(
              fontSize: 17, color: Colors.white, fontWeight: FontWeight.w800),
        ),
      ),
      body: getdata == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : getdata?.error == true
              ? Center(
                  child: Text(
                    "No Data Found",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                  ),
                )
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: getdata?.data?.length ?? 0,
                          itemBuilder: (context, index) {
                            return Card(
                              elevation: 5,
                              child: Column(
                                children: [
                                  Container(
                                    // height: 220,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.white),
                                    width: MediaQuery.of(context).size.width,
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 5),
                                      child: Row(
                                        children: [
                                          Container(
                                            width: 110,
                                            height: 150,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                            ),
                                            child: Image.network(
                                              '${getdata?.data?[index].photo?[0]}',
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          SizedBox(width: 10.0),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 10),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    const Text(
                                                      "Owner Name: ",
                                                      style: TextStyle(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                    Text(
                                                      "${getdata?.data?[index].name}",
                                                      style: const TextStyle(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                // Row(
                                                //   children: [
                                                //     const Text(
                                                //       "Firm Name: ",
                                                //       style: TextStyle(
                                                //         fontSize: 14,
                                                //         fontWeight:
                                                //             FontWeight.bold,
                                                //       ),
                                                //     ),
                                                //     Text(
                                                //       "${getdata?.data?[index].nameOfFirm}",
                                                //       style: const TextStyle(
                                                //         fontSize: 14,
                                                //         fontWeight:
                                                //             FontWeight.w400,
                                                //       ),
                                                //     ),
                                                //   ],
                                                // ),
                                                // const SizedBox(
                                                //   height: 5,
                                                // ),
                                                Row(
                                                  children: [
                                                    const Text(
                                                      "Visit By: ",
                                                      style: TextStyle(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                    Selector<UserProvider,
                                                            String>(
                                                        selector: (_,
                                                                provider) =>
                                                            provider
                                                                .curUserName,
                                                        builder: (context,
                                                            userName, child) {
                                                          return Text(
                                                            userName,
                                                            style:
                                                                const TextStyle(
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                            ),
                                                          );
                                                        }),
                                                  ],
                                                ),
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                Row(
                                                  children: [
                                                    const Text(
                                                      "Date: ",
                                                      style: TextStyle(
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    Text(
                                                      "${getdata?.data?[index].createdAt}",
                                                      style: const TextStyle(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                Row(
                                                  children: [
                                                    const Text(
                                                      "Time: ",
                                                      style: TextStyle(
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    Text(
                                                      "${getdata?.data?[index].time}",
                                                      style: const TextStyle(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                Row(
                                                  children: [
                                                    const Text(
                                                      "Remark: ",
                                                      style: TextStyle(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                    Container(
                                                      width: 175,
                                                      child: Text(
                                                        "${getdata?.data?[index].remarks}",
                                                        style: const TextStyle(
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis),
                                                        maxLines: 2,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 5),
                                    child: Row(
                                      // crossAxisAlignment: CrossAxisAlignment.end,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text(
                                          "Address: ",
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Container(
                                          width: 220,
                                          child: Text(
                                            "${getdata?.data?[index].address} ${getdata?.data?[index].district} ${getdata?.data?[index].state}",
                                            style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            maxLines: 3,
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            TextButton(
                                              onPressed: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        MySiteDetails(
                                                            model: getdata
                                                                ?.data?[index]),
                                                  ),
                                                );
                                              },
                                              child: Container(
                                                width: 50,
                                                padding: EdgeInsets.all(5),
                                                decoration: BoxDecoration(
                                                  color: colors.primary,
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    "View",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
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
