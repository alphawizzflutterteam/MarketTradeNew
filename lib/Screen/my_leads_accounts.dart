// import 'dart:convert';
//
// import 'package:omega_employee_management/Helper/Color.dart';
//
// import 'package:omega_employee_management/Helper/String.dart';
// import 'package:omega_employee_management/Model/get_user_expenses_model.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:intl/intl.dart';
//
//
// class MyLeadsAccounts extends StatefulWidget {
//   const MyLeadsAccounts({Key? key}) : super(key: key);
//
//   @override
//   State<MyLeadsAccounts> createState() => _MyLeadsAccountsState();
// }
//
// class _MyLeadsAccountsState extends State<MyLeadsAccounts> {
//
//   List<ReferList> referralList = [];
//
//   getReferralList(String status) async{
//     var headers = {
//       // 'Token': jwtToken.toString(),
//       // 'Authorisedkey': authKey.toString(),
//       'Cookie': 'ci_session=aa83f4f9d3335df625437992bb79565d0973f564'
//     };
//     var request = http.MultipartRequest('POST', Uri.parse(referralListApi.toString()));
//     request.fields.addAll({
//       USER_ID: '$CUR_USERID',
//       'status' : status.toString()
//       // categoryValue != null ?
//       // categoryValue.toString() : ""
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
//     getReferralList('');
//   }
//   String? categoryValue;
//
//   List<String> leadStatus = [
//     'All',
//     'New Lead',
//     'Open',
//     'Follow Up',
//     'Proceeded',
//     'Not Interested',
//     'Closed',
//     'Rejected',
//     'Not Eligible'
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(onPressed: (){
//           Navigator.pop(context);
//         }, icon: Icon(Icons.arrow_back_ios, color: colors.primary,)),
//         backgroundColor: colors.whiteTemp,
//         centerTitle: true,
//         title: Text("My Leads", style: TextStyle(
//             color: colors.primary
//         ),),
//       ),
//       body:
//       Padding(
//         padding: const EdgeInsets.all(15.0),
//         child: Column(
//           children: [
//             Card(
//               elevation: 3,
//               shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
//               child: Container(
//                 padding: EdgeInsets.only(left: 10),
//                 decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(15),
//                     border: Border.all(color: colors.primary)
//                 ),
//                 child: Row(
//                   children: [
//                     Text("Filter by : ", style: TextStyle(
//                         fontSize: 20, color: Colors.black87
//                     ),),
//                     Padding(
//                         padding: const EdgeInsets.all(20),
//                         child: Container(
//                           padding: EdgeInsets.all(8),
//                           height: 50,
//                           width: MediaQuery.of(context).size.width - 185,
//                           decoration: BoxDecoration(
//                               color: Theme.of(context).colorScheme.white,
//                               borderRadius: BorderRadius.circular(12),
//                               border: Border.all(color: Theme.of(context).colorScheme.fontColor)
//                           ),
//                           child: DropdownButtonHideUnderline(
//                             child: DropdownButton(
//                               hint: Text('Select type'), // Not necessary for Option 1
//                               value: categoryValue,
//                               onChanged: (String? newValue) {
//                                 setState(() {
//                                   categoryValue = newValue;
//                                 });
//                                 if(categoryValue == "All"){
//                                   getReferralList('');
//                                 }else{
//                                   getReferralList(categoryValue.toString());
//                                 }
//                                 print("this is category value $categoryValue");
//                               },
//                               items: leadStatus.map((item) {
//                                 return DropdownMenuItem(
//                                   child:  Text(item, style:TextStyle(color: Theme.of(context).colorScheme.fontColor),),
//                                   value: item,
//                                 );
//                               }).toList(),
//                             ),
//                           ),
//                         )
//                     )
//                   ],
//                 ),),
//             ),
//             referralList.isNotEmpty ?
//             Expanded(
//               child: ListView.builder(
//                   itemCount: referralList.length,
//                   itemBuilder: (context, index){
//                     return Padding(
//                       padding: const EdgeInsets.only(top: 20.0),
//                       child: Container(
//                         padding: EdgeInsets.all(15),
//                         width: MediaQuery.of(context).size.width,
//                         height: 250,
//                         decoration: BoxDecoration(
//                             color: Theme.of(context).colorScheme.white,
//                             border: Border.all(color: colors.primary),
//                             borderRadius: BorderRadius.circular(20)
//                         ),
//                         child: Column(
//                           children: [
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Row(
//                                   children: [
//                                     Text("Name : ", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Theme.of(context).colorScheme.fontColor),),
//                                     Text(referralList[index].name.toString(),
//                                         style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600,  color: Theme.of(context).colorScheme.fontColor) ),
//                                   ],
//                                 ),
//                                 Row(
//                                   children: [
//                                     // String formattedDate = DateFormat('dd MMM yyyy').format(dateTime);
//                                     Text(DateFormat('dd MMM yyyy').format(DateTime.parse(referralList[index].createdAt.toString())).toString(),
//                                         style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600,  color: Theme.of(context).colorScheme.fontColor) ),
//                                   ],
//                                 ),
//                               ],
//                             ),
//                             Padding(
//                               padding: const EdgeInsets.only(top: 8.0, bottom: 8),
//                               child: Row(
//                                 children: [
//                                   Text("Mobile : ", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Theme.of(context).colorScheme.fontColor),),
//                                   Text(referralList[index].mobile.toString(),
//                                       style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600,  color: Theme.of(context).colorScheme.fontColor) ),
//                                 ],
//                               ),
//                             ),
//                             Row(
//                               children: [
//                                 Text("Product Type : ", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Theme.of(context).colorScheme.fontColor),),
//                                 Text(referralList[index].product.toString(),
//                                     style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600,  color: Theme.of(context).colorScheme.fontColor) ),
//                               ],
//                             ),
//                             Divider(
//                               thickness: 1,
//                               color: colors.secondary,),
//                             Spacer(),
//
//                             Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text("Sales Co-ordinate Details : ",  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Theme.of(context).colorScheme.fontColor),),
//                                 const SizedBox(height: 8,),
//                                 Row(
//                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                   children: [
//
//                                     Row(
//                                       children: [
//                                         Text("Name : ", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Theme.of(context).colorScheme.fontColor),),
//                                         Text(referralList[index].staffName.toString() ?? "Not Assigned yet!",
//                                             style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600,  color: Theme.of(context).colorScheme.fontColor) ),
//                                       ],
//                                     ),
//                                     Row(
//                                       children: [
//                                         Text("Mobile : ", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Theme.of(context).colorScheme.fontColor),),
//                                         Text(referralList[index].staffMobile.toString() ?? "Not Assigned yet!",
//                                             style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600,  color: Theme.of(context).colorScheme.fontColor) ),
//                                       ],
//                                     ),
//                                   ],
//                                 ),
//
//                               ],
//                             ),
//                             const SizedBox(height: 6,),
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Text("Referral Associate Details: ", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Theme.of(context).colorScheme.fontColor),),
//
//                                 Container(
//                                   // width: 100,
//                                   padding: EdgeInsets.all(8),
//                                   decoration: BoxDecoration(
//                                       borderRadius: BorderRadius.circular(10),
//                                       color: referralList[index].shareInfo.toString() == "1"?
//                                       Colors.green : Colors.red
//                                   ),
//                                   child: Center(
//                                     child: Text(referralList[index].shareInfo.toString() == "1"?
//                                     "Share"
//                                         : "Do Not Share",
//                                       style: TextStyle(color: Colors.white, fontWeight: FontWeight.w400),),
//                                   ),
//                                 ),
//                               ],
//                             ),
//
//                             Spacer(),
//                             Divider(
//                               thickness: 2,
//                               color: colors.secondary,
//                             ),
//
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.end,
//                               children: [
//
//                                 // Text("Product : ", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Theme.of(context).colorScheme.fontColor),),
//                                 Container(
//                                     padding: EdgeInsets.all(8),
//                                     decoration: BoxDecoration(
//                                         color: colors.secondary,
//                                         borderRadius: BorderRadius.circular(10)
//                                     ),
//                                     child: Center(child: Text(referralList[index].status.toString(), style: TextStyle(fontSize: 14,
//                                         color: colors.whiteTemp,
//                                         fontWeight: FontWeight.w600)))),
//                               ],
//                             ),
//                           ],
//                         ),
//                       ),
//                     );
//                   }),
//             )
//                 : Container(
//               width: MediaQuery.of(context).size.width,
//               height: MediaQuery.of(context).size.height/2,
//               child: Center(child: Text("No data found !!")),
//             ),
//           ],
//         ),
//       )
//
//     );
//   }
// }