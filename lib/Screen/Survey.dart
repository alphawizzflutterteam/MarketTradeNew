import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:omega_employee_management/Helper/String.dart';
import 'package:omega_employee_management/Screen/Dashboard.dart';
import 'package:omega_employee_management/Screen/check_In_screen.dart';
import '../Helper/Color.dart';
import '../Model/DealingProductModel.dart';

class Survey extends StatefulWidget {
  final List <DealingData>? modelList ;
  final String? name;
  final String? email;
  final String? contact;
  final String? customerType;
  final String? creditLimit;
  final String? time;
  final String? date;
  final String? remark;
  List<String>? image;
  final String? clintId;
  final String? dealerName;
  final String? dealerMobile;
  final String? dealermail;
  final String? dealerLimit;

   Survey({Key? key, this.modelList,this.name, this.email,this.contact,this.creditLimit, this.customerType, this.time, this.date,this.image,
     this.remark, this.clintId, this.dealerLimit, this.dealermail, this.dealerMobile, this.dealerName}) : super(key: key);

  @override
  State<Survey> createState() => _SurveyState();
}

class _SurveyState extends State<Survey> {

  List<TextEditingController> monthlyControllers = [];
  List<TextEditingController> currentController = [];
  List<TextEditingController> rspController = [];
  int totalMonthlySales = 0;
  int currentSales = 0;

  TextEditingController rsp = TextEditingController();
  TextEditingController purchasingForm = TextEditingController();

 // List<List<TextEditingController>> wholeDataList = [] ;

  List dataList = [];

  List  <List<List<TextEditingController>>> feedbackList  = [] ;

  void initState() {
    super.initState();
    for(int i = 0; i < (widget.modelList?.length ?? 0);  i++) {
      List<List<TextEditingController>> wholeDataList = [] ;

      for (int j = 0; j < (widget.modelList?[i].products?.length ?? 0); j++) {
        List<TextEditingController> commenController = [];

        commenController.add(TextEditingController());
        commenController.add(TextEditingController());
        commenController.add(TextEditingController());
        commenController.add(TextEditingController());
        commenController.add(TextEditingController());
        wholeDataList.add(commenController);
      }
      feedbackList.add(wholeDataList);
    }
  }

Future<void> feedback() async {
    var request = http.MultipartRequest('POST', Uri.parse(customerFeedbackForm.toString()));
    request.fields.addAll({
      'user_id': '${CUR_USERID}',
      'date': widget.date.toString(),
      'time': widget.time.toString(),
      'lat': latitude.toString(),
      'lng': longitude.toString(),
      'name_of_firm': widget.clintId.toString(),
      'basic_detail': jsonEncode({
        'name':widget.name,
        'mobile':widget.contact,
        'email':widget.email,
        'address':"Indore Madhya Pradesh",
        'customer_type':widget.customerType,
        'credit_limit':widget.creditLimit,
        'dealer_name': widget.dealerName,
        'dealer_mobile': widget.dealerMobile,
        'deler_email': widget.dealermail,
       'dealer_limit': widget.dealerLimit,
      }),
      'customer_dealing_in':widget.modelList!.map((product) => product.id).join(','),
      'survey': dataList.toString(),
      'remarks': widget.remark ?? ''
    });
    for (var i = 0; i < (widget.image?.length ?? 0); i++) {
      widget.image?[i] == ""
          ? null
          : request.files.add(await http.MultipartFile.fromPath(
          'photos', widget.image![i].toString()));
    }

    print('sssssssssssss${request.fields}');
    print('${request.url}');
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
      Navigator.push(context, MaterialPageRoute(builder: (context) => Dashboard()));
    }
    else {
      print(response.reasonPhrase);
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 1,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child:  Icon(Icons.arrow_back_ios, color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text("Survey", style: TextStyle(fontSize: 15, color: Colors.black)),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: widget.modelList?.length ?? 0,
                itemBuilder: (context, index) {
                  var item = widget.modelList?[index];
                  return Column(
                      children: [
                        Card(
                          elevation: 5,
                          child: Container(
                            height: MediaQuery.of(context).size.height/1.5,
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.white),
                            width: MediaQuery.of(context).size.width,
                            child: Padding(
                              padding: const EdgeInsets.all(5),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 5),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(left: 80),
                                          child: Container(
                                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: colors.primary),
                                            height: 35,
                                            width: MediaQuery.of(context).size.width/2.2,
                                            child: Row(
                                              // crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                Center(
                                                  child: Padding(
                                                    padding: const EdgeInsets.only(left:10),
                                                    child: Text("Brand Name: ", style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight: FontWeight.bold, color: Colors.white),
                                                    ),
                                                  ),
                                                ),
                                                Text(item?.name ?? '', style: TextStyle(
                                                  fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                       SingleChildScrollView(
                                         child: Container(
                                           height: 400,
                                           width: MediaQuery.of(context).size.width/1.2,
                                           child: ListView.builder(
                                             scrollDirection: Axis.vertical,
                                             shrinkWrap: true,
                                             physics: NeverScrollableScrollPhysics(),
                                             itemCount: item?.products?.length ?? 0,
                                               itemBuilder: (BuildContext, i) {
                                               var data = item?.products?[i];
                                               return Column(
                                             children: [
                                               Row(
                                               children: [
                                                 const Text("Product Name: ", style: TextStyle(
                                                   fontSize: 14,
                                                   fontWeight: FontWeight.bold,
                                                 ),
                                                 ),
                                                  Text(data?.name ?? "", style: TextStyle(
                                                     fontSize: 14,
                                                     fontWeight: FontWeight.bold, color: colors.primary)
                                                 ),
                                               ],
                                               ),
                                               const SizedBox(
                                                 height: 5,
                                               ),
                                               Row(
                                                 children: [
                                                   const Text("Monthly Sale: ", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                                                   SizedBox(width: 10),
                                                   Container(
                                                     height: 30,
                                                     width: MediaQuery.of(context).size.width/2.9,
                                                     child: TextField(
                                                       controller: feedbackList[index][i][0],
                                                       keyboardType: TextInputType.number,
                                                       decoration: InputDecoration(
                                                         contentPadding: EdgeInsets.only(top: 7, left: 5),
                                                         border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0),
                                                         ),
                                                         filled: true,
                                                         hintStyle: TextStyle(color: Colors.black, fontSize: 10),
                                                         hintText: "Monthly Sale",
                                                         fillColor: Colors.white70,
                                                       ),
                                                       onSubmitted: (value) {
                                                         totalMonthlySales += int.parse(value);
                                                         setState(() {});
                                                         print("printtttttttt ${totalMonthlySales}");
                                                         // int total = 0;
                                                         // for (int i = 0; i < 5; i++) {
                                                         //   String text = monthlyControllers[i].text;
                                                         //   if (text.isNotEmpty) {
                                                         //     total += int.parse(text);
                                                         //   }
                                                         // }
                                                         // setState(() {
                                                         //   totalMonthlySales = total;
                                                         //   print("total monthly sheet ${totalMonthlySales}");
                                                         // });
                                                       },
                                                     ),
                                                   ),
                                                 ],
                                               ),
                                               const SizedBox(
                                                 height: 5,
                                               ),
                                               Row(
                                                 children: [
                                                   const Text("Current stock: ", style: TextStyle(
                                                       fontSize: 14,
                                                       fontWeight: FontWeight.bold)),
                                                   SizedBox(width: 10),
                                                   Container(
                                                     height: 30,
                                                     width: MediaQuery.of(context).size.width/2.9,
                                                     child: TextField(
                                                       controller: feedbackList[index][i][1],
                                                       keyboardType: TextInputType.number,
                                                       decoration: InputDecoration(
                                                         contentPadding: EdgeInsets.only(top: 7, left: 5),
                                                         border: OutlineInputBorder(
                                                           borderRadius: BorderRadius.circular(5.0),
                                                         ),
                                                         filled: true,
                                                         hintStyle: TextStyle(color: Colors.black, fontSize: 10),
                                                         hintText: "Current stock",
                                                         fillColor: Colors.white70,
                                                       ),
                                                       onSubmitted: (value) {
                                                         currentSales += int.parse(value);
                                                         setState(() {});
                                                         print("printtttttttt ${currentSales}");
                                                       },
                                                     ),
                                                   ),
                                                 ],
                                               ),
                                               const SizedBox(
                                                 height: 5,
                                               ),
                                               Row(
                                                 children: [
                                                   const Text("WSP: ", style: TextStyle(
                                                       fontSize: 14,
                                                       fontWeight: FontWeight.bold)),
                                                   SizedBox(width: 10,),
                                                   Container(
                                                     height: 30,
                                                     width: MediaQuery.of(context).size.width/2.9,
                                                     child: TextField(
                                                       controller:feedbackList[index][i][2],
                                                       keyboardType: TextInputType.number,
                                                       decoration: InputDecoration(
                                                         contentPadding: EdgeInsets.only(top: 7, left: 5),
                                                         border: OutlineInputBorder(
                                                           borderRadius: BorderRadius.circular(5.0),
                                                         ),
                                                         filled: true,
                                                         hintStyle: TextStyle(color: Colors.black, fontSize: 10),
                                                         hintText: "WSP",
                                                         fillColor: Colors.white70,
                                                       ),
                                                     ),
                                                   ),
                                                 ],
                                               ),
                                               const SizedBox(
                                                 height: 5,
                                               ),
                                               Row(
                                                 children: [
                                                   const Text("RSP: ", style: TextStyle(
                                                       fontSize: 14,
                                                       fontWeight: FontWeight.bold)),
                                                   SizedBox(width: 10),
                                                   Container(
                                                     height: 30,
                                                     width: MediaQuery.of(context).size.width/2.9,
                                                     child: TextField(
                                                       controller: feedbackList[index][i][3],
                                                       keyboardType: TextInputType.number,
                                                       decoration: InputDecoration(
                                                         contentPadding: EdgeInsets.only(top: 7, left: 5),
                                                         border: OutlineInputBorder(
                                                           borderRadius: BorderRadius.circular(5.0),
                                                         ),
                                                         filled: true,
                                                         hintStyle: TextStyle(color: Colors.black, fontSize: 10),
                                                         hintText: "WSP",
                                                         fillColor: Colors.white70,
                                                       ),
                                                     ),
                                                   ),
                                                 ],
                                               ),
                                               const SizedBox(
                                                 height: 5,
                                               ),
                                               Row(
                                                 children: [
                                                   const Text("Purchasing Form: ", style: TextStyle(
                                                       fontSize: 14,
                                                       fontWeight: FontWeight.bold)),
                                                   SizedBox(width: 10),
                                                   Row(
                                                     // mainAxisAlignment: MainAxisAlignment.end,
                                                     // crossAxisAlignment: CrossAxisAlignment.end,
                                                     children: [
                                                       Container(
                                                         height: 30,
                                                         width: MediaQuery.of(context).size.width/2.9,
                                                         child: TextField(
                                                           controller: feedbackList[index][i][4],
                                                           keyboardType: TextInputType.text,
                                                           decoration: InputDecoration(
                                                             contentPadding: EdgeInsets.only(top: 7, left: 5),
                                                             border: OutlineInputBorder(
                                                               borderRadius: BorderRadius.circular(5.0),
                                                             ),
                                                             filled: true,
                                                             hintStyle: TextStyle(color: Colors.black, fontSize: 10),
                                                             hintText: "WSP",
                                                             fillColor: Colors.white70,
                                                           ),
                                                         ),
                                                       ),
                                                     ],
                                                   ),
                                                 ],
                                               ),
                                               const SizedBox(
                                                 height: 5,
                                               ),],
                                           );
                                             }),
                                         ),
                                       )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Sum Of Monthly sale", style: TextStyle(fontSize: 13, fontWeight: FontWeight.w800, ),),
                  Text("${totalMonthlySales}", style: TextStyle(fontSize: 13, fontWeight: FontWeight.w800, ))
                ],
              ),
            ),
            SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Sum Of Current Stock", style: TextStyle(fontSize: 13, fontWeight: FontWeight.w800),),
                  Text("${currentSales}", style: TextStyle(fontSize: 13, fontWeight: FontWeight.w800))
                ],
              ),
            ),
            SizedBox(height: 10),
            InkWell(
              onTap: () {
                // Navigator.push(context, MaterialPageRoute(builder: (context) => Survey()));
                for(int i=0; i<(widget.modelList?.length ?? 0); i++ ) {
                  for(int j =0 ; j <(widget.modelList?[i].products?.length ?? 0); j++ )
                    {
                      print('${widget.modelList?[i].products?.length}');
                      dataList.add(json.encode({
                        "brand_name": widget.modelList?[i].products?[j].name,
                        "monthly_sale": feedbackList[i][j][0].text,
                        "current_stock": feedbackList[i][j][1].text,
                        "wps": feedbackList[i][j][2].text,
                        "rsp": feedbackList[i][j][3].text,
                        "purchasing_from": feedbackList[i][j][4].text
                      }),
                      );
                    }
                  print('${dataList}');
                }
               feedback();
              },
              child: Center(
                  child: Container(
                      height: 40,
                      width: MediaQuery.of(context).size.width/1.8,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: colors.primary),
                      child: const Center(
                          child: Text("Submit Feedback", style: TextStyle(fontSize: 15, color: Colors.white, fontWeight: FontWeight.w400)))
                  ),
              ),
            ),
            SizedBox(height: 5)
          ],
        ),
      ),
    );
  }
}
