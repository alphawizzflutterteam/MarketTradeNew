// import 'dart:convert';
//
// import 'package:omega_employee_management/Helper/Color.dart';
// import 'package:omega_employee_management/Helper/Session.dart';
// import 'package:omega_employee_management/Helper/String.dart';
// import 'package:omega_employee_management/Model/get_user_expenses_model.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:intl/intl.dart';
//
// class MyEarnings extends StatefulWidget {
//   const MyEarnings({Key? key}) : super(key: key);
//
//   @override
//   State<MyEarnings> createState() => _MyEarningsState();
// }
//
// class _MyEarningsState extends State<MyEarnings> {
//
//
//   List<ReferList> referralList = [];
//
//   getReferralList() async{
//     var headers = {
//       // 'Token': jwtToken.toString(),
//       // 'Authorisedkey': authKey.toString(),
//       'Cookie': 'ci_session=aa83f4f9d3335df625437992bb79565d0973f564'
//     };
//     var request = http.MultipartRequest('POST', Uri.parse(transactionsListApi.toString()));
//     request.fields.addAll({
//       USER_ID: '$CUR_USERID',
//     });
//
//     print("this is refer request ${request.fields.toString()}");
//     request.headers.addAll(headers);
//
//     http.StreamedResponse response = await request.send();
//     if (response.statusCode == 200) {
//       String str = await response.stream.bytesToString();
//       var result = json.decode(str);
//       var finalResponse = ReferralListModel.fromJson(result);
//       setState(() {
//         referralList = finalResponse.data!;
//       });
//       print("this is referral data ${referralList.length}");
//       // setState(() {
//       // animalList = finalResponse.data!;
//       // });
//       // print("this is operator list ----->>>> ${operatorList[0].name}");
//     }
//     else {
//       print(response.reasonPhrase);
//     }
//   }
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     getReferralList();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: referralList.isNotEmpty ?
//       Padding(
//         padding: const EdgeInsets.all(15.0),
//         child: ListView.builder(
//             itemCount: referralList.length,
//             itemBuilder: (context, index){
//               return Padding(
//                 padding: const EdgeInsets.only(top: 20.0),
//                 child: Container(
//                   padding: EdgeInsets.all(15),
//                   width: MediaQuery.of(context).size.width,
//                   height: 120,
//                   decoration: BoxDecoration(
//                       color: Theme.of(context).colorScheme.white,
//                       border: Border.all(color: colors.primary),
//                       borderRadius: BorderRadius.circular(20)
//                   ),
//                   child: Column(
//                     children: [
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Row(
//                             children: [
//                               Text("Name : ", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Theme.of(context).colorScheme.fontColor),),
//                               Text(referralList[index].name.toString(),
//                                   style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600,  color: Theme.of(context).colorScheme.fontColor) ),
//                             ],
//                           ),
//                           Row(
//                             children: [
//                               // String formattedDate = DateFormat('dd MMM yyyy').format(dateTime);
//                               Text(DateFormat('dd MMM yyyy').format(DateTime.parse(referralList[index].createdAt.toString())).toString(),
//                                   style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600,  color: Theme.of(context).colorScheme.fontColor) ),
//                             ],
//                           ),
//                         ],
//                       ),
//                       Row(
//                         children: [
//                           Text("Product : ", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Theme.of(context).colorScheme.fontColor),),
//                           Text(referralList[index].product.toString(),
//                               style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600,  color: Theme.of(context).colorScheme.fontColor) ),
//                         ],
//                       ),
//                       Spacer(),
//                       Divider(
//                         thickness: 2,
//                         color: colors.secondary,
//                       ),
//
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.end,
//                         children: [
//                           // Text("Product : ", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Theme.of(context).colorScheme.fontColor),),
//                           Container(
//                               padding: EdgeInsets.all(8),
//                               decoration: BoxDecoration(
//                                   color: colors.secondary,
//                                   borderRadius: BorderRadius.circular(10)
//                               ),
//                               child: Center(child: Text(referralList[index].status.toString(), style: TextStyle(fontSize: 14,
//                                   color: colors.whiteTemp,
//                                   fontWeight: FontWeight.w600)))),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               );
//             }),
//       )
//           : Container(
//         width: MediaQuery.of(context).size.width,
//         height: MediaQuery.of(context).size.height,
//         child: Center(child: Text("No data found !!")),
//       ),
//     );
//   }
// }
//
//
