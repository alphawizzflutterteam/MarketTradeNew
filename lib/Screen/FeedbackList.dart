import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart'as http;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:omega_employee_management/Helper/String.dart';
import '../Helper/Color.dart';
import '../Model/GetFeedbackModel.dart';


class Customer_feedback extends StatefulWidget {

  const Customer_feedback({Key? key}) : super(key: key);

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
  void initState(){
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
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
        title: Text("Counter Visit Form", style: TextStyle(fontSize: 17, color: Colors.white, fontWeight: FontWeight.w800),),
      ),
      body: getdata== null ? Center(child: CircularProgressIndicator()) :Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: getdata?.data?.length ?? 0,
             shrinkWrap: true,
            // physics: NeverScrollableScrollPhysics(),
            itemBuilder: (BuildContext, index) {
              namecn.text='${getdata?.data?[index].basicDetail?.name??""}';
              firmnamecn.text='${getdata?.data?[index].nameOfFirm??""}';
              remarkcn.text='${getdata?.data?[index].remarks??""}';
              // debugPrint("remarkkkk"+remarkcn.text);
              datecn.text='${getdata?.data?[index].date??""}';
              timecn.text='${getdata?.data?[index].time??""}';
              debugPrint("photos ${getdata?.data?[index].photos}");
        return Card(
          elevation: 3,
          child: Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.white),
            // height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width/1,
            child: Padding(
              padding: const EdgeInsets.only(left: 15,right: 15,top: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
                      clipBehavior: Clip.hardEdge,
                      height: 150,
                      width: 200,
                      child: ClipRRect(child: Image.network("${getdata?.data?[index].photos?.first}",fit: BoxFit.fill,)),
                    ),
                  ),
                  SizedBox(height: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("User Name",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
                      SizedBox(height: MediaQuery.of(context).size.height*.01,),
                      TextFormField(
                          readOnly: true,
                          keyboardType: TextInputType.text,
                          controller: namecn,
                          decoration: InputDecoration(hintText: 'hfg', border: OutlineInputBorder(borderRadius:  BorderRadius.circular(10)))),
                      SizedBox(height: MediaQuery.of(context).size.height*.02,),
                      Text("Date",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
                      SizedBox(height: MediaQuery.of(context).size.height*.01,),
                      TextFormField(
                          readOnly: true,
                          keyboardType: TextInputType.text,
                          controller: datecn,
                          decoration: InputDecoration(border: OutlineInputBorder(borderRadius:  BorderRadius.circular(10)))),
                      SizedBox(height: MediaQuery.of(context).size.height*.02,),
                      Text("Time",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
                      SizedBox(height: MediaQuery.of(context).size.height*.01,),
                      TextFormField(
                          readOnly: true,
                          keyboardType: TextInputType.text,
                          controller: timecn,
                          decoration: InputDecoration(border: OutlineInputBorder(borderRadius:  BorderRadius.circular(10)))),
                      // SizedBox(height: MediaQuery.of(context).size.height*.02,),
                      // Text("Firm Name",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
                      // SizedBox(height: MediaQuery.of(context).size.height*.01,),
                      // TextFormField(
                      //     readOnly: true,
                      //     keyboardType: TextInputType.text,
                      //     controller: firmnamecn,
                      //     decoration: InputDecoration(border: OutlineInputBorder(borderRadius:  BorderRadius.circular(10)))),
                      SizedBox(height: MediaQuery.of(context).size.height*.02,),
                      Text("Remark",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
                      SizedBox(height: MediaQuery.of(context).size.height*.01,),
                      TextFormField(
                          readOnly: true,
                          keyboardType: TextInputType.text,
                          controller: remarkcn,
                          decoration: InputDecoration(border: OutlineInputBorder(borderRadius:  BorderRadius.circular(10)))),
                      SizedBox(height: 5,),
                      Text("Address: ${getdata?.data?[index].basicDetail?.address}",style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),),
                      SizedBox(height: MediaQuery.of(context).size.height*.02,),
                      Text("Basic Details:-",style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold),),
                      SizedBox(height: MediaQuery.of(context).size.height*.02,),
                      Text("Name: ${getdata?.data?[index].basicDetail?.name}",style: TextStyle(fontSize: 15),),
                      SizedBox(height: MediaQuery.of(context).size.height*.02,),
                      Text("Mobile: ${getdata?.data?[index].basicDetail?.mobile}",style: TextStyle(fontSize: 15),),
                      SizedBox(height: MediaQuery.of(context).size.height*.02,),
                      Text("email: ${getdata?.data?[index].basicDetail?.email}",style: TextStyle(fontSize: 15),),
                      SizedBox(height: MediaQuery.of(context).size.height*.02,),
                      Text("Address: ${getdata?.data?[index].basicDetail?.address}",style: TextStyle(fontSize: 15),),
                      SizedBox(height: MediaQuery.of(context).size.height*.02,),
                      Text("Customer Type: ${getdata?.data?[index].basicDetail?.customerType}",style: TextStyle(fontSize: 15),),
                      SizedBox(height: MediaQuery.of(context).size.height*.02,),
                      Text("Credit Limit: ${getdata?.data?[index].basicDetail?.creditLimit}",style: TextStyle(fontSize: 15),),
                      SizedBox(height: MediaQuery.of(context).size.height*.03,),
                      Text("Customer Dealing:-",style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold),),
                      Text("ID & Name",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
                      SizedBox(height: MediaQuery.of(context).size.height*.02,),
                      Text("1  ${getdata?.data?[index].customerDealingIn?[0].name}",style: TextStyle(fontSize: 15),),
                      // Text("2  ${getdata?.data?[index].customerDealingIn[0].name}",style: TextStyle(fontSize: 15),),
                      SizedBox(height: MediaQuery.of(context).size.height*.03,),
                      Text("Survey:-",style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold),),
                      SizedBox(height: MediaQuery.of(context).size.height*.02,),
                      ListView.builder(
                        shrinkWrap: true,
                          itemCount: getdata?.data?[index].survey?.length,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (_,i){
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Brand Name: ${getdata?.data?[index].survey?[i].brandName}",style: TextStyle(fontSize: 14,),),
                                SizedBox(height: MediaQuery.of(context).size.height*.02,),
                                Text("Monthly Sale: ${getdata?.data?[index].survey?[i].monthlySale}",style: TextStyle(fontSize: 14,),),
                                SizedBox(height: MediaQuery.of(context).size.height*.02,),
                                Text("Current Stock: ${getdata?.data?[index].survey?[i].currentStock}",style: TextStyle(fontSize: 14,),),
                                SizedBox(height: MediaQuery.of(context).size.height*.02,),
                                Text("WPS: ${getdata?.data?[index].survey?[i].wps}",style: TextStyle(fontSize: 14,),),
                                SizedBox(height: MediaQuery.of(context).size.height*.02,),
                                Text("RSP: ${getdata?.data?[index].survey?[i].rsp}",style: TextStyle(fontSize: 14,),),
                                SizedBox(height: MediaQuery.of(context).size.height*.02,),
                                Text("Purchasing From: ${getdata?.data?[index].survey?[i].purchasingFrom}",style: TextStyle(fontSize: 15),),

                              ],
                            );
                          })

                    ],
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height*.03,),
                ],
              ),
            ),
          ),
        );
        }),
      ),
    );
  }

  GetFeedbackModel? getdata;
  Future<void> getData() async {
    var headers = {
      'Cookie': 'ci_session=bf12d5586296e8a180885fdf282632a583f96888'
    };
    var request = http.MultipartRequest('POST', Uri.parse('https://developmentalphawizz.com/market_track/app/v1/api/customer_feedback_lists'));
    request.fields.addAll({
      'user_id': '${CUR_USERID}'
    });
    print("customerrr feedbackk ${request.fields}");
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      print("responseee"+response.statusCode.toString());
      var  result = await response.stream.bytesToString();
      var finalresult = GetFeedbackModel.fromJson(json.decode(result));
      print("result"+result.toString());
      setState(() {
        getdata = finalresult;

      });
    }
    else {
      print("reasonnnnnnnnn"+response.reasonPhrase.toString());
    }
  }
}
