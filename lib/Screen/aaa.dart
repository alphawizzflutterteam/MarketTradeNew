// import 'dart:async';
// import 'dart:convert';
// import 'dart:io';
// import 'dart:math';
// import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:intl/intl.dart';
// import 'package:omega_employee_management/Model/category_model.dart';
// import 'package:omega_employee_management/Screen/ReportsScreen.dart';
// import 'package:omega_employee_management/Screen/check_in_check_out_screens/check_In_screen.dart';
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:omega_employee_management/Helper/ApiBaseHelper.dart';
// import 'package:omega_employee_management/Helper/AppBtn.dart';
// import 'package:omega_employee_management/Helper/Color.dart';
// import 'package:omega_employee_management/Helper/Constant.dart';
// import 'package:omega_employee_management/Helper/Session.dart';
// import 'package:omega_employee_management/Helper/String.dart';
// import 'package:omega_employee_management/Model/Model.dart';
// import 'package:omega_employee_management/Model/Section_Model.dart';
// import 'package:omega_employee_management/Provider/CartProvider.dart';
// import 'package:omega_employee_management/Provider/CategoryProvider.dart';
// import 'package:omega_employee_management/Provider/FavoriteProvider.dart';
// import 'package:omega_employee_management/Provider/HomeProvider.dart';
// import 'package:omega_employee_management/Provider/SettingProvider.dart';
// import 'package:omega_employee_management/Provider/UserProvider.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart';
// import 'package:omega_employee_management/model_all_response/GetEarningModel.dart';
// import 'package:omega_employee_management/model_all_response/get_leads_status_model.dart';
// import 'package:package_info/package_info.dart';
// import 'package:provider/provider.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:shimmer/shimmer.dart';
// import 'package:url_launcher/url_launcher.dart';
// import 'package:version/version.dart';
// import '../../Model/BankDetailsModel.dart';
// import '../../model_all_response/GetFtdModel.dart';
// import '../../model_all_response/GetReportModel.dart';
// import '../../model_all_response/check_in_model.dart';
// import '../../model_all_response/checkinout_model.dart';
// import '../../model_all_response/get_leads_model.dart';
// import '../../model_all_response/get_user_check_in_out.dart';
// import '../AllLeadsDetails.dart';
// import '../Auth_view/Login.dart';
// import 'package:http/http.dart' as http;
// import '../BankLeads.dart';
// import '../FosCollection.dart';
// import '../check_in_check_out_screens/check_out_screen.dart';
//
// class HomePage extends StatefulWidget {
//   const HomePage({Key? key}) : super(key: key);
//
//   @override
//   _HomePageState createState() => _HomePageState();
// }
//
// List<SectionModel> sectionList = [];
// List<Product> catList = [];
// List<Product> popularList = [];
// ApiBaseHelper apiBaseHelper = ApiBaseHelper();
// List<String> tagList = [];
// List<Product> sellerList = [];
// int count = 1;
// List<Model> homeSliderList = [];
// List<Widget> pages = [];
// int? selected=0;
//
// class _HomePageState extends State<HomePage>
//     with AutomaticKeepAliveClientMixin<HomePage>, TickerProviderStateMixin {
//   bool _isNetworkAvail = true;
//
//   final _controller = PageController();
//   TextEditingController searchCtr = TextEditingController();
//
//   late Animation buttonSqueezeanimation;
//   late AnimationController buttonController;
//   final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
//   List<Model> offerImages = [];
//
//
//   String? lat2;
//   String? long2;
//   String? lat1;
//   String? long1;
//   String? address1;
//   String? address2;
//   String? address3;
//   String? address4;
//
//   TextEditingController  pinCodeController = TextEditingController();
//   final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
//   new GlobalKey<RefreshIndicatorState>();
//
//   //String? curPin;
//
//   @override
//   bool get wantKeepAlive => true;
//   List<Categories> categories = [];
//
//   GetLeadsStatusModel?getLeadStatus;
//   Future<void> getStatus() async {
//     var headers = {
//       'Cookie': 'ci_session=85dc808070002f22be4d6aceec73de5a280d52d6'
//     };
//     var request = http.MultipartRequest('GET', Uri.parse('${baseUrl}get_lead_status?user_id=${CUR_USERID}'));
//     request.fields.addAll({
//       'user_id': '${CUR_USERID}'
//     });
//
//     request.headers.addAll(headers);
//     http.StreamedResponse response = await request.send();
//     if (response.statusCode == 200) {
//       var Response = await response.stream.bytesToString();
//       final finalResponse = GetLeadsStatusModel.fromJson(json.decode(Response));
//       setState(() {
//         getLeadStatus = finalResponse;
//       });
//     }
//     else {
//       print(response.reasonPhrase);
//     }
//   }
//
//   bool? errorMassage;
//   Future<void> getUserCheckIn() async {
//     SharedPreferences preferences= await SharedPreferences.getInstance();
//
//     setState(() {
//       lat1 = preferences.getString('lattt');
//       long1 = preferences.getString('longg');
//       address1 = preferences.getString('address1');
//       print('mmmmmmmmmmmmmmmmmm${long1}');
//       print("lllllllllllllllll${lat1}");
//       print("aaaaaaaaaaaa${address1}");
//     });
//
//     var headers = {
//       'Cookie': 'ci_session=45a1d8071ef0fa0ad71c47efe8f4c8ef16788c68'
//     };
//     var request = http.MultipartRequest('POST', Uri.parse("${baseUrl}checkinNow"));
//     request.fields.addAll({
//       'checkin_latitude': '${lat1}',
//       'checkin_longitude': '${long1}',
//       'address': '${address1}',
//       'user_id': '${CUR_USERID}'
//     });
//
//     request.headers.addAll(headers);
//     http.StreamedResponse response = await request.send();
//     if (response.statusCode == 200) {
//       var Result = await response.stream.bytesToString();
//       final finalResult = CheckInModel.fromJson(json.decode(Result));
//
//       errorMassage =finalResult.data.error;
//       print('-------------errorr${errorMassage}');
//       if(errorMassage==false){
//         Navigator.push(context, MaterialPageRoute(builder: (context)=>CheckInScreen()));
//       } else {
//         Fluttertoast.showToast(msg:'${finalResult.data.msg}');
//       }
//     }
//     else {
//       print(response.reasonPhrase);
//     }
//
//   }
//
//   bool? errorMassage2;
//   Future<void> CheckOut()async {
//     SharedPreferences preferences= await SharedPreferences.getInstance();
//
//     setState(() {
//       lat2 = preferences.getString('lat2');
//       long2 = preferences.getString('long2');
//       address2 = preferences.getString('address2');
//       print('mmmmmmmmmmmmmmmmmm${long2}');
//       print("lllllllllllllllll${address2}");
//     });
//
//
//     var headers = {
//       'Cookie': 'ci_session=ebec56d32bab8f418215d9b9a59c49312fa7206c'
//     };
//     var request = http.MultipartRequest('POST', Uri.parse('${baseUrl}checkoutNow'));
//     request.fields.addAll({
//       'checkout_latitude': '${lat2}',
//       'checkout_longitude': '${long2}',
//       'address': '${address2}',
//       'user_id': '${CUR_USERID}'
//     });
//     print('-----fields------${request.fields}');
//     request.headers.addAll(headers);
//     http.StreamedResponse response = await request.send();
//
//     if (response.statusCode == 200) {
//       var Result = await response.stream.bytesToString();
//       final finalResult = CheckInOutModel.fromJson(json.decode(Result));
//       errorMassage2 = finalResult.data.error;
//
//       if(errorMassage2==false){
//         Navigator.push(context, MaterialPageRoute(builder: (context)=>CheckOutScreen()));
//       }else{
//
//         Fluttertoast.showToast(msg:'${finalResult.data.msg}');
//       }
//     }
//     else {
//       print(response.reasonPhrase);
//     }
//   }
//
//
//   Future<void> getAddress()async {
//     SharedPreferences preferences= await SharedPreferences.getInstance();
//     address3 = preferences.getString('address2');
//     address4 = preferences.getString('address1');
//     print('iiiiiiiiiiiiiiiiii${address3}');
//   }
//
//   Future<void> getDistance() async {
//     SharedPreferences preferences = await SharedPreferences.getInstance();
//     distance = preferences.getString('distance');
//     print('disssssssssssssssss${distance}');
//   }
//   String? distance;
//   GetLeadsModel? getLeadData;
//   List <LeadsData> leadData = [];
//   Future<void> GetLeadsPinData() async {
//     SharedPreferences preferences = await SharedPreferences.getInstance();
//     var headers = {
//       'Cookie': 'ci_session=e739bf3509ae8bb7102d8891dd88233ab61f48ff'
//     };
//     var request = http.MultipartRequest('POST', Uri.parse('https://alphawizzserver.com/sahu/app/v1/api/get_leads?user_id=${CUR_USERID}&search=${pinCodeController.text}'));
//     request.fields.addAll({
//       'user_id': '${CUR_USERID}',
//       'search':'${pinCodeController.text}'
//     });
//     print("---fieldsssss dadadadad----${request.fields}");
//     request.headers.addAll(headers);
//     http.StreamedResponse response = await request.send();
//     if (response.statusCode == 200) {
//       var Result = await response.stream.bytesToString();
//       print(Result);
//       final finalResult = GetLeadsModel.fromJson(json.decode(Result));
//       if(pinCodeController.text.isNotEmpty){
//         setState(() {
//           getLeadData = finalResult;
//           print("${finalResult} ${getLeadData?.data?.length} get leads datatat ===========");
//           // print('Primary pin is heree--------${getLeadData?.data?.first.primaryAddressPin}');
//         });
//       }else{
//         Fluttertoast.showToast(msg: 'Something went wrong');
//       }
//     }
//     else {
//       print(response.reasonPhrase);
//     }
//   }
//
//
//   GetUserCheckInOutModel?getUserCheckInOutModel;
//   Future<void> getTodaysData() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     String? uids = prefs.getString('new_user_id');
//     print('kkkkkkkk ${uids}');
//     var headers = {
//       'Cookie': 'ci_session=67b5132e21cb7d4694508715c31844e52b6adf48'
//     };
//     var request = http.MultipartRequest('POST', Uri.parse('${baseUrl}get_user_checkinout'));
//     request.fields.addAll({
//       'user_id': '${uids}'
//     });
//     print('user iddddddddddd${CUR_USERID}');
//     request.headers.addAll(headers);
//     http.StreamedResponse response = await request.send();
//     if (response.statusCode == 200) {
//       var Result = await response.stream.bytesToString();
//       final finalResult = GetUserCheckInOutModel.fromJson(json.decode(Result));
//       setState(() {
//         getUserCheckInOutModel=finalResult;
//       });
//     }
//     else {
//       print(response.reasonPhrase);
//     }
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     convertDateTimeDispla();
//     getTodayAmount();
//     getStatus();
//     getAddress();
//     GetLeads();
//     GetLeadsData();
//     bankData();
//     getEarning();
//     //callApi();
//     getDistance();
//     getTodaysData();
//     // getReport();
//     // getFtdReports();
//     buttonController = new AnimationController(
//         duration: new Duration(milliseconds: 2000), vsync: this);
//     buttonSqueezeanimation = new Tween(
//       begin: deviceWidth! * 0.7,
//       end: 50.0,
//     ).animate(
//       new CurvedAnimation(
//         parent: buttonController,
//         curve: new Interval(
//           0.0,
//           0.150,
//         ),
//       ),
//     );
//     WidgetsBinding.instance.addPostFrameCallback((_) => _animateSlider());
//   }
//
//   GetEarningModel? getEarningModel;
//   getEarning() async{
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     String? uids = prefs.getString('new_user_id');
//     var headers = {
//       'Cookie': 'ci_session=83da20d925f1c44fe2981ea94e69997c2b87882d'
//     };
//     var request = http.MultipartRequest('POST', Uri.parse('https://alphawizzserver.com/sahu/app/v1/api/get_user_earnings'));
//     request.fields.addAll({
//       'user_id': '${uids}'
//     });
//     print("user earning parameter ${request.fields}");
//     request.headers.addAll(headers);
//     http.StreamedResponse response = await request.send();
//     if (response.statusCode == 200) {
//       var Response = await response.stream.bytesToString();
//       final finalResponse = GetEarningModel.fromJson(json.decode(Response));
//       setState(() {
//         getEarningModel = finalResponse;
//       });
//     }
//   }
//
//   var dateFormate;
//   String? formattedDate;
//   String? timeData;
//
//   convertDateTimeDispla() {
//     var now = new DateTime.now();
//     var formatter = new DateFormat('dd-MM-yyyy');
//     formattedDate = formatter.format(now);
//     print("datedetet$formattedDate"); // 2016-01-25
//     timeData = DateFormat("hh:mm:ss a").format(DateTime.now());
//     print("timeeeeeeeeee$timeData");
//   }
//
//   String? todayAmount, todayMessage;
//   bool? earningStatus;
//   getTodayAmount() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     String? uids = prefs.getString('new_user_id');
//     var headers = {
//       'Cookie': 'ci_session=66a81baee62d9c6eab0f0eb8a336c7fceea8d415'
//     };
//     var request = http.MultipartRequest('POST', Uri.parse('https://alphawizzserver.com/sahu/app/v1/api/get_received_amount'));
//     request.fields.addAll({
//       'user_id': '${uids}',
//       'date': '${formattedDate}',
//       'type': 'current'
//     });
//     print("gettoday amount para${request.fields}===========");
//     request.headers.addAll(headers);
//     http.StreamedResponse response = await request.send();
//     if (response.statusCode == 200) {
//       var finalResponse = await response.stream.bytesToString();
//       final jsonResponse = json.decode(finalResponse);
//       todayAmount = jsonResponse['amount'];
//       todayMessage = jsonResponse['message'];
//       earningStatus = jsonResponse['earning_status'];
//       print("=======today amonunt========${todayAmount} ${todayMessage} ${earningStatus}===========");
//       setState(() {});
//     }
//     else {
//       print(response.reasonPhrase);
//     }
//   }
//
//   TextEditingController amtCtr = TextEditingController();
//   TextEditingController remarksCtr = TextEditingController();
//
//   collectionDialog() {
//     showDialog(
//         context: context,
//         builder: (context) {
//           return AlertDialog(
//             shape:
//             RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//             content: SizedBox(
//               height: 250,
//               width: 550,
//               child: Column(
//                 children: [
//                   Container(
//                     // height: 180,
//                     // width: 250,
//                     // padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
//                     // decoration: BoxDecoration(
//                     //     border: Border.all(color: const Color(0xFF112c48), width: 2),
//                     //     borderRadius: BorderRadius.circular(16),
//                     // ),
//                     child: Column(
//                       children: [
//                         const SizedBox(height: 20),
//                         Container(
//                           child: TextField(
//                             keyboardType: TextInputType.number,
//                             controller: amtCtr,
//                             // textAlign: TextAlign.center,
//                             decoration: InputDecoration(
//                               border: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(10),
//                               ),
//                               filled: true,
//                               fillColor: Colors.white,
//                               hintText: 'Enter Amount',
//                               contentPadding: const EdgeInsets.all(10),
//                             ),
//                           ),
//                         ),
//                         const SizedBox(
//                           height: 20,
//                         ),
//                         Container(
//                           child: TextField(
//
//                             controller: remarksCtr,
//                             // textAlign: TextAlign.center,
//                             decoration: InputDecoration(
//                               border: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(10),
//                               ),
//                               filled: true,
//                               fillColor: Colors.white,
//                               hintText: 'Enter Remarks',
//                               contentPadding: const EdgeInsets.all(10),
//                             ),
//                           ),
//                         ),
//                         const SizedBox(
//                           height: 20,
//                         ),
//                         InkWell(
//                           onTap: () {
//                             if(amtCtr.text== "" ||  amtCtr.text == null || remarksCtr.text == "" || remarksCtr.text == null){
//                               Fluttertoast.showToast(msg: "Pls Enter Fields");
//                             } else{
//                               fosCollection();
//                               Navigator.pop(context);
//                             }
//                           },
//                           child: Container(
//                             height: 45,
//                             width: 130,
//                             decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: colors.primary),
//                             child: Center(child: Text("Save", style: TextStyle(fontSize: 15, color: Colors.white),)),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           );
//         });
//   }
//
//
//   fosCollection() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     String? uids = prefs.getString('new_user_id');
//     var headers = {
//       'Cookie': 'ci_session=c2f6d65d231bb09a25b69b42d7f113f4f517913c'
//     };
//     var request = http.MultipartRequest('POST', Uri.parse('https://alphawizzserver.com/sahu/app/v1/api/update_collection_amount'));
//     request.fields.addAll({
//       'fos_id': '${uids}',
//       'amount': '${amtCtr.text}',
//       'remarks': '${remarksCtr.text}',
//       'user_id': ''
//     });
//     print("=========fos add parameeter======${request.fields}===========");
//     request.headers.addAll(headers);
//     http.StreamedResponse response = await request.send();
//     if (response.statusCode == 200) {
//       print(await response.stream.bytesToString());
//       Fluttertoast.showToast(msg: "Collection added successfully");
//     }
//     else {
//       print(response.reasonPhrase);
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: SingleChildScrollView(
//           child: Padding(
//             padding: const EdgeInsets.only(left:10,top: 10),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.start,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 SizedBox(height: 10),
//                 Container(
//                   height:50,
//                   padding: EdgeInsets.only(left:15,right:15),
//                   child: TextFormField(
//                     onChanged: (value){
//                       searchLeads(value);
//                     },
//                     controller: searchCtr,
//                     decoration: InputDecoration(
//                         suffixIcon: Container(
//                             width: 20,
//                             decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: colors.primary),
//                             child: Icon(Icons.search, color: Colors.white)),
//                         hintText: "Search here",
//                         border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: 10),
//                 Stack(
//                   children: [
//
//                     _catList2(),
//                     Padding(
//                       padding: const EdgeInsets.only(left:10.0),
//                       child: Container(
//                         height: 35,
//                         width: MediaQuery.of(context).size.width/1.085,
//                         decoration: BoxDecoration(
//                           color: colors.primary,
//                           borderRadius: BorderRadius.circular(2),
//                         ),
//                         child:Padding(
//                           padding: const EdgeInsets.only(top:7.0),
//                           child: Text('Agent Outstanding',textAlign:TextAlign.center,style: TextStyle(fontSize:15,fontWeight: FontWeight.bold,color: colors.whiteTemp),),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//                 SizedBox(height: 10),
//                 InkWell(
//                   onTap: () {
//                     collectionDialog();
//                     // Navigator.push(context, MaterialPageRoute(builder: (context) => FosCollection()));
//                   },
//                   child: Padding(
//                     padding: const EdgeInsets.only(left:10.0,right: 10,top:5),
//                     child: Card(
//                       elevation:5,
//                       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//                       child: Column(
//                         children: [
//                           Container(
//                             height: 35,
//                             width: MediaQuery.of(context).size.width/1,
//                             decoration: BoxDecoration(
//                               color: colors.primary,
//                               borderRadius: BorderRadius.circular(2),
//                             ),
//                             child: Padding(
//                               padding: const EdgeInsets.only(top:7.0),
//                               child: Text('Cash Collection',textAlign:TextAlign.center,style: TextStyle(fontSize:15,fontWeight: FontWeight.bold,color: colors.whiteTemp),),
//                             ),
//                           ),
//                           SizedBox(height: 20),
//                           Padding(
//                             padding: const EdgeInsets.only(left:10.0,right: 10),
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Text("${todayMessage}", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color:colors.blackTemp),),
//                                   ],
//                                 ),
//                                 Column(
//                                   crossAxisAlignment: CrossAxisAlignment.end,
//                                   children: [
//                                     Text("${todayAmount}", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color:colors.blackTemp),),
//                                   ],
//                                 ),
//                               ],
//                             ),
//                           ),
//                           SizedBox(height: 20),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: 10),
//                 customTabbar(),
//                 SizedBox(height: 10),
//                 _currentIndex==1?
//                 Container(
//                   height:MediaQuery.of(context).size.height/2.8,
//                   child: bankDetailsModel?.data.length == null || bankDetailsModel?.data.length == "" ? Center(child: Text("Data Not Found", style: TextStyle(fontSize: 12),)):
//                   ListView.builder(
//                       itemCount: bankDetailsModel?.data==null || bankDetailsModel?.data== ""? 0 : bankDetailsModel?.data.length,
//                       shrinkWrap: true,
//                       //physics: NeverScrollableScrollPhysics(),
//                       itemBuilder: (context, index) {
//                         return InkWell(
//                           onTap: (){
//                             Navigator.push(context, MaterialPageRoute(builder: (context) => BankLeads(bankModel: bankDetailsModel?.data[index])));
//                           },
//                           child:
//                           Padding(
//                             padding: const EdgeInsets.only(left:10.0,right: 10,top:5),
//                             child: Card(
//                               elevation:5,
//                               shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//                               child: Column(
//                                 children: [
//                                   Container(
//                                     height: 35,
//                                     width: MediaQuery.of(context).size.width/1,
//                                     decoration: BoxDecoration(
//                                       color: colors.primary,
//                                       borderRadius: BorderRadius.circular(2),
//                                     ),
//                                     child:Padding(
//                                       padding: const EdgeInsets.only(top:7.0),
//                                       child: Text('Banks',textAlign:TextAlign.center,style: TextStyle(fontSize:15,fontWeight: FontWeight.bold,color: colors.whiteTemp),),
//                                     ),
//                                   ),
//                                   SizedBox(height: 20),
//                                   Padding(
//                                     padding: const EdgeInsets.only(left:10.0,right: 10),
//                                     child: Row(
//                                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                       children: [
//                                         Column(
//                                           crossAxisAlignment: CrossAxisAlignment.start,
//                                           children: [
//                                             Text("Bank Name :", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color:colors.blackTemp),),
//                                             SizedBox(height: 10,),
//                                             Text("Total :", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: colors.blackTemp),),
//                                           ],
//                                         ),
//                                         Column(
//                                           crossAxisAlignment: CrossAxisAlignment.end,
//                                           children: [
//                                             Text("${bankDetailsModel?.data[index].bankName}", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color:colors.blackTemp),),
//                                             SizedBox(height: 10),
//                                             Text("${bankDetailsModel?.data[index].total}", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: colors.blackTemp),),
//                                           ],
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                   SizedBox(height: 20),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         );
//                       }),
//                 ):
//                 _currentIndex==2? Container(
//                   height: MediaQuery.of(context).size.height/2.5,
//                   child: leadData == null||leadData ==""? Center(child: Text("No Leads Found")) :ListView.builder(
//                       itemCount: leadData.length == null || leadData.length==""?0:leadData.length,
//                       shrinkWrap: true,
//                       //physics: NeverScrollableScrollPhysics(),
//                       itemBuilder: (context, index) {
//                         return Padding(
//                           padding: const EdgeInsets.only(left:10.0,right: 10,bottom: 10),
//                           child: InkWell(
//                             onTap: () {
//                               Navigator.push(context, MaterialPageRoute(builder: (context) => AllLeadsDetails(model: leadData[index])));
//                             },
//                             child: Card(
//                               elevation:5,
//                               shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//                               child: Column(
//                                 children: [
//                                   SizedBox(height: 10),
//                                   Padding(
//                                     padding: const EdgeInsets.only(left:10.0,right: 10),
//                                     child: Row(
//                                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                       children: [
//                                         Column(
//                                           crossAxisAlignment: CrossAxisAlignment.start,
//                                           children: [
//                                             Text("Bank Name :", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color:colors.blackTemp),),
//                                             SizedBox(height: 15,),
//                                             Text("Customer Name :", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: colors.blackTemp),),
//                                             SizedBox(height: 15,),
//                                             Text("EMI amount:", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color:colors.blackTemp),),
//                                             SizedBox(height: 15,),
//                                             Text("Phone :", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color:colors.blackTemp),),
//                                             SizedBox(height: 15,),
//                                             Text("Total Charge :", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: colors.blackTemp),),
//                                             SizedBox(height: 10,),
//                                             Text("Primary Address Pin:", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: colors.blackTemp),),
//                                           ],
//                                         ),
//                                         Column(
//                                           crossAxisAlignment: CrossAxisAlignment.start,
//                                           children: [
//                                             leadData[index].bankName == null || leadData[index].bankName == "" ? Text("--") : Text("${leadData[index].bankName}", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color:colors.blackTemp),),
//                                             SizedBox(height: 15),
//                                             Text("${leadData[index].customername}", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: colors.blackTemp),),
//                                             SizedBox(height: 15),
//                                             Text("${leadData[index].emiAmt}", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: colors.blackTemp),),
//                                             SizedBox(height: 15),
//                                             InkWell(
//                                                 onTap: () {
//                                                   _callNumber(leadData[index].phone1);
//                                                 },
//                                                 child: Text("${leadData[index].phone1}", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color:colors.blackTemp),)),
//                                             SizedBox(height: 15),
//                                             Text("${leadData[index].totalCharges}", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: colors.blackTemp),),
//                                             SizedBox(height: 15),
//                                             Text("${leadData[index].primaryAddressPin}", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: colors.primary),),
//                                             SizedBox(height: 10),
//                                           ],
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                   SizedBox(height: 10),
//                                   Container(
//                                     width:MediaQuery.of(context).size.width/1.2,
//                                     child: Divider(
//                                       color: colors.primary,
//                                       height:15,
//                                       thickness: 1,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         );
//                       }),
//                 ):_currentIndex==3? Text("-", style: TextStyle(color: Colors.white),):_currentIndex==4? earningView():SizedBox.shrink(),
//                 SizedBox(height:30),
//                 Padding(
//                   padding: const EdgeInsets.only(left:10.0),
//                   child: Text('All Leads',style: TextStyle(color: colors.primary,fontWeight: FontWeight.w700,fontSize:18)),
//                 ),
//                 SizedBox(height:20,),
//                 Container(
//                   height: MediaQuery.of(context).size.height/2.5,
//                   child: leadData.length == null || leadData.length == "" ? Center(
//                       child: Text("No Leads Available", style: TextStyle(fontSize: 13))):
//                   ListView.builder(
//                       itemCount: leadData.length == null || leadData.length==""? 0: leadData.length,
//                       shrinkWrap: true,
//                       //physics: NeverScrollableScrollPhysics(),
//                       itemBuilder: (context, index) {
//                         return InkWell(
//                           onTap: () {
//                             Navigator.push(context, MaterialPageRoute(builder: (context) => AllLeadsDetails(model: leadData[index])));
//                           },
//                           child: Padding(
//                             padding: const EdgeInsets.only(left:10.0,right: 10),
//                             child: Card(
//                               elevation:5,
//                               shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//                               child: Column(
//                                 children: [
//                                   SizedBox(height: 10),
//                                   Padding(
//                                     padding: const EdgeInsets.only(left:10.0,right: 10),
//                                     child: Row(
//                                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                       children: [
//                                         Column(
//                                           crossAxisAlignment: CrossAxisAlignment.start,
//                                           children: [
//                                             Text("Bank Name:", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color:colors.blackTemp),),
//                                             SizedBox(height: 12,),
//                                             Text("Customer Name:", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color:colors.blackTemp),),
//                                             SizedBox(height: 10,),
//                                             Text("Bucket :", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: colors.blackTemp),),
//                                             SizedBox(height: 10,),
//                                             SizedBox(height: 10,),
//                                             Text("Caller :", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: colors.blackTemp),),
//                                             SizedBox(height: 10,),
//                                             Text("Principal Outstanding", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: colors.blackTemp),),
//                                           ],
//                                         ),
//                                         Column(
//                                           crossAxisAlignment: CrossAxisAlignment.start,
//                                           children: [
//                                             Text("${leadData[index].bankName}", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color:colors.blackTemp),),
//                                             SizedBox(height: 12),
//                                             Container(
//                                                 width: 120,
//                                                 child: Text("${leadData[index].customername}", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: colors.blackTemp))),
//                                             SizedBox(height: 12),
//                                             Text("${leadData[index].bomBkt}", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: colors.blackTemp),),
//                                             SizedBox(height: 12),
//                                             Text("${leadData[index].caller}", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: colors.blackTemp),),
//                                             SizedBox(height: 12),
//                                             Text("${leadData[index].principalOutstanding}", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: colors.blackTemp)),
//                                             // SizedBox(height: 10,),
//                                             // address3!=null ?Text("${getLeadData?.data?[index].primaryAddress}", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: colors.blackTemp),):Text('Address not found'),
//                                             // SizedBox(height: 10,),
//                                             // address4!=null?Text("${address4}", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: colors.blackTemp),):Text('Address not found'),
//                                             // SizedBox(height: 10,),
//                                             // distance ==null||distance==""?Text('0.00km'):Text("${distance} km", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: colors.blackTemp),),
//                                           ],
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                   SizedBox(height: 10),
//                                   Container(
//                                     width:MediaQuery.of(context).size.width/1.2,
//                                     child: Divider(
//                                       color: colors.primary,
//                                       height:15,
//                                       thickness: 1,
//                                     ),
//                                   ),
//                                   SizedBox(height: 10),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         );
//                       }),
//                 ),
//               ],
//             ),
//           ),
//         )
//     );
//   }
//
//
//   _callNumber(String? mobileNumber) async {
//     var number = "${mobileNumber}";
//     print("numberrrrr ${number}");
//     bool? res = await FlutterPhoneDirectCaller.callNumber(number);
//     print("mobileee ${res}");
//   }
//
//   Widget earningView() {
//     return  getEarningModel?.error == true ? Text("No Earning Available!", style: TextStyle(fontSize: 13,),):
//     Column(
//       children: [
//         Container(
//           height:MediaQuery.of(context).size.height/5.3,
//           child: Padding(
//             padding: const EdgeInsets.only(left:10.0,right: 10),
//             child:
//             ListView.builder(
//                 itemCount: getEarningModel?.data?.length,
//                 shrinkWrap: true,
//                 // physics: NeverScrollableScrollPhysics(),
//                 itemBuilder: (context, index) {
//                   return
//                     Padding(
//                       padding: const EdgeInsets.only(left:10.0,right: 10),
//                       child: Card(
//                         elevation:5,
//                         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//                         child: Column(
//                           children: [
//                             SizedBox(height: 10),
//                             Padding(
//                               padding: const EdgeInsets.only(left:10.0,right: 10),
//                               child: Row(
//                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   Column(
//                                     crossAxisAlignment: CrossAxisAlignment.start,
//                                     children: [
//                                       Text("Month:", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color:colors.blackTemp),),
//                                       SizedBox(height: 10),
//                                       Text("Earning Percent:", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: colors.blackTemp),),
//                                       SizedBox(height: 10),
//                                       Text("Earning Amount:", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: colors.blackTemp),),
//                                       SizedBox(height: 10),
//                                       Text("Bank Name:", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: colors.blackTemp),),
//                                       SizedBox(height: 10),
//                                       Text("BKT:", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: colors.blackTemp),),
//                                     ],
//                                   ),
//                                   Column(
//                                     crossAxisAlignment: CrossAxisAlignment.start,
//                                     children: [
//                                       Text("${getEarningModel?.data?[index].month}", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color:colors.blackTemp),),
//                                       SizedBox(height: 10),
//                                       Text("${getEarningModel?.data?[index].earningPercent}", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color:colors.blackTemp), overflow: TextOverflow.ellipsis,),
//                                       SizedBox(height: 10),
//                                       Text("${getEarningModel?.data?[index].earningAmount}", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color:colors.blackTemp),),
//                                       SizedBox(height: 10),
//                                       Text("${getEarningModel?.data?[index].bankName}", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color:colors.blackTemp),),
//                                       SizedBox(height: 10),
//                                       Text("${getEarningModel?.data?[index].bomBkt}", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color:colors.blackTemp),),
//                                     ],
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             SizedBox(height: 10),
//                           ],
//                         ),
//                       ),
//                     );
//                 }),
//             // Card(
//             //   elevation:5,
//             //   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//             //   child: Column(
//             //     children: [
//             //       SizedBox(height: 10),
//             //       Padding(
//             //         padding: const EdgeInsets.only(left:10.0,right: 10),
//             //         child: Row(
//             //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             //           children: [
//             //             Column(
//             //               crossAxisAlignment: CrossAxisAlignment.start,
//             //               children: [
//             //                 Text("Month:", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color:colors.blackTemp),),
//             //                 SizedBox(height: 10),
//             //                 Text("Earning Percent:", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: colors.blackTemp),),
//             //                 SizedBox(height: 10),
//             //                 Text("Earning Amount:", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: colors.blackTemp),),
//             //               ],
//             //             ),
//             //             Column(
//             //               crossAxisAlignment: CrossAxisAlignment.start,
//             //               children: [
//             //                 Text("${getEarningModel?.data?[0].month}", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color:colors.blackTemp),),
//             //                 SizedBox(height: 10),
//             //                 Text("${getEarningModel?.data?[0].earningPercent}", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color:colors.blackTemp), overflow: TextOverflow.ellipsis,),
//             //                 SizedBox(height: 10),
//             //                 Text("${getEarningModel?.data?[0].earningAmount}", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color:colors.blackTemp),),
//             //               ],
//             //             ),
//             //           ],
//             //         ),
//             //       ),
//             //       SizedBox(height: 10),
//             //     ],
//             //   ),
//             // ),
//           ),
//         ),
//       ],
//     );
//   }
//
//   _catList2() {
//     return  Selector<HomeProvider, bool>(
//       builder: (context, data, child) {
//         return GridView.builder(
//           //padding: const EdgeInsets.symmetric(horizontal: 10),
//           itemCount:1,
//           shrinkWrap: true,
//           physics: const NeverScrollableScrollPhysics(),
//           gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//               crossAxisCount:1,
//               mainAxisSpacing:10,
//               mainAxisExtent: 190
//           ),
//           itemBuilder:(context, index) {
//             return Container(
//               height:110,
//               width:MediaQuery.of(context).size.width/1.8,
//               child: Card(
//                 elevation:2,
//                 margin: EdgeInsets.only(left: 10,right: 10),
//                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
//                 child:Padding(
//                   padding: const EdgeInsets.only(left:10,right:10),
//                   child: Column(
//                     children: [
//                       SizedBox(height:45,),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text("Total Lead", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.fontColor),),
//                           getLeadStatus?.data==null?Text('Not Found'):Text("${getLeadStatus?.data?.total}", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Theme.of(context).colorScheme.fontColor),),
//                         ],
//                       ),
//                       SizedBox(height: 5,),
//                       Divider(
//                         color: colors.primary,
//                         height:15,
//                         thickness: 1,
//                       ),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text("Pending Lead", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color:colors.blackTemp),),
//                           getLeadStatus?.data==null?Text('Not Found'):Text("${getLeadStatus?.data?.pending}", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Theme.of(context).colorScheme.fontColor),),
//
//                         ],
//                       ),
//                       SizedBox(height: 5,),
//                       Divider(
//                         color: colors.primary,
//                         height: 15,
//                         thickness: 1,
//                       ),
//                       SizedBox(height: 5,),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text("Complete Lead", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.green),),
//                           getLeadStatus?.data==null?Text('Not Found'):Text("${getLeadStatus?.data?.completed}", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Theme.of(context).colorScheme.fontColor),),
//
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             );
//           },);
//       },
//       selector: (_, homeProvider) => homeProvider.catLoading,
//     );
//
//   }
//
//
//   void _animateSlider() {
//     Future.delayed(Duration(seconds: 30)).then(
//           (_) {
//         if (mounted) {
//           int nextPage = _controller.hasClients
//               ? _controller.page!.round() + 1
//               : _controller.initialPage;
//
//           if (nextPage == homeSliderList.length) {
//             nextPage = 0;
//           }
//           if (_controller.hasClients)
//             _controller
//                 .animateToPage(nextPage,
//                 duration: Duration(milliseconds: 200), curve: Curves.linear)
//                 .then((_) => _animateSlider());
//         }
//       },
//     );
//   }
//
//   List<T> map<T>(List list, Function handler) {
//     List<T> result = [];
//     for (var i = 0; i < list.length; i++) {
//       result.add(handler(i, list[i]));
//     }
//     return result;
//   }
//
//   Future _getFav() async {
//     _isNetworkAvail = await isNetworkAvailable();
//     if (_isNetworkAvail) {
//       if (CUR_USERID != null) {
//         Map parameter = {
//           USER_ID: CUR_USERID,
//         };
//         apiBaseHelper.postAPICall(getFavApi, parameter).then((getdata) {
//           bool error = getdata["error"];
//           String? msg = getdata["message"];
//           if (!error) {
//             var data = getdata["data"];
//
//             List<Product> tempList = (data as List)
//                 .map((data) => new Product.fromJson(data))
//                 .toList();
//
//             context.read<FavoriteProvider>().setFavlist(tempList);
//           } else {
//             if (msg != 'No Favourite(s) Product Are Added')
//               setSnackbar(msg!, context);
//           }
//
//           context.read<FavoriteProvider>().setLoading(false);
//         }, onError: (error) {
//           setSnackbar(error.toString(), context);
//           context.read<FavoriteProvider>().setLoading(false);
//         });
//       } else {
//         context.read<FavoriteProvider>().setLoading(false);
//         Navigator.push(
//           context,
//           MaterialPageRoute(builder: (context) => LoginPage()),
//         );
//       }
//     } else {
//       if (mounted)
//         setState(() {
//           _isNetworkAvail = false;
//         });
//     }
//   }
//
//   void getOfferImages() {
//     Map parameter = Map();
//
//     apiBaseHelper.postAPICall(getOfferImageApi, parameter).then((getdata) {
//       bool error = getdata["error"];
//       String? msg = getdata["message"];
//       if (!error) {
//         var data = getdata["data"];
//         offerImages.clear();
//         offerImages =
//             (data as List).map((data) => new Model.fromSlider(data)).toList();
//       } else {
//         setSnackbar(msg!, context);
//       }
//
//       context.read<HomeProvider>().setOfferLoading(false);
//     }, onError: (error) {
//       setSnackbar(error.toString(), context);
//       context.read<HomeProvider>().setOfferLoading(false);
//     });
//   }
//
//   void getSection() {
//     Map parameter = {PRODUCT_LIMIT: "6", PRODUCT_OFFSET: "0"};
//
//     if (CUR_USERID != null) parameter[USER_ID] = CUR_USERID!;
//     String curPin = context.read<UserProvider>().curPincode;
//     if (curPin != '') parameter[ZIPCODE] = curPin;
//
//     apiBaseHelper.postAPICall(getSectionApi, parameter).then((getdata) {
//       bool error = getdata["error"];
//       String? msg = getdata["message"];
//       sectionList.clear();
//       if (!error) {
//         var data = getdata["data"];
//
//         sectionList = (data as List)
//             .map((data) => new SectionModel.fromJson(data))
//             .toList();
//       } else {
//         if (curPin != '') context.read<UserProvider>().setPincode('');
//         setSnackbar(msg!, context);
//       }
//
//       context.read<HomeProvider>().setSecLoading(false);
//     }, onError: (error) {
//       setSnackbar(error.toString(), context);
//       context.read<HomeProvider>().setSecLoading(false);
//     });
//   }
//   String? leadsCount;
//   String? myEarnings;
//
//   void getSetting() {
//     CUR_USERID = context.read<SettingProvider>().userId;
//     //print("")
//     Map parameter = Map();
//     if (CUR_USERID != null) parameter = {USER_ID: CUR_USERID};
//
//     apiBaseHelper.postAPICall(getSettingApi, parameter).then((getdata) async {
//       bool error = getdata["error"];
//       String? msg = getdata["message"];
//       if (!error) {
//         var data = getdata["data"]["system_settings"][0];
//         cartBtnList = data["cart_btn_on_list"] == "1" ? true : false;
//         refer = data["is_refer_earn_on"] == "1" ? true : false;
//         CUR_CURRENCY = data["currency"];
//         RETURN_DAYS = data['max_product_return_days'];
//         MAX_ITEMS = data["max_items_cart"];
//         MIN_AMT = data['min_amount'];
//         CUR_DEL_CHR = data['delivery_charge'];
//         String? isVerion = data['is_version_system_on'];
//         extendImg = data["expand_product_images"] == "1" ? true : false;
//         String? del = data["area_wise_delivery_charge"];
//         MIN_ALLOW_CART_AMT = data[MIN_CART_AMT];
//         if (del == "0")
//           ISFLAT_DEL = true;
//         else
//           ISFLAT_DEL = false;
//         if (CUR_USERID != null) {
//           REFER_CODE = getdata['data']['user_data'][0]['referral_code'];
//           context.read<UserProvider>().setPincode(getdata["data"]["user_data"][0][PINCODE]);
//           if (REFER_CODE == null || REFER_CODE == '' || REFER_CODE!.isEmpty)
//             generateReferral();
//           context.read<UserProvider>().setCartCount(getdata["data"]["user_data"][0]["cart_total_items"].toString());
//           context.read<UserProvider>().setBalance(getdata["data"]["user_data"][0]["balance"]);
//           leadsCount = getdata["data"]["total_leads"];
//           myEarnings = getdata["data"]["user_data"][0]["balance"];
//           _getFav();
//           _getCart("0");
//         }
//         UserProvider user = Provider.of<UserProvider>(context, listen: false);
//         SettingProvider setting =
//         Provider.of<SettingProvider>(context, listen: false);
//         user.setMobile(setting.mobile);
//         // user.setName(setting.userName);
//         user.setEmail(setting.email);
//         user.setProfilePic(setting.profileUrl);
//
//         Map<String, dynamic> tempData = getdata["data"];
//         if (tempData.containsKey(TAG))
//           tagList = List<String>.from(getdata["data"][TAG]);
//
//         if (isVerion == "1") {
//           String? verionAnd = data['current_version'];
//           String? verionIOS = data['current_version_ios'];
//           PackageInfo packageInfo = await PackageInfo.fromPlatform();
//           String version = packageInfo.version;
//           final Version currentVersion = Version.parse(version);
//           final Version latestVersionAnd = Version.parse(verionAnd);
//           final Version latestVersionIos = Version.parse(verionIOS);
//           if ((Platform.isAndroid && latestVersionAnd > currentVersion) ||
//               (Platform.isIOS && latestVersionIos > currentVersion))
//             updateDailog();
//         }
//       } else {
//         setSnackbar(msg!, context);
//       }
//     }, onError: (error) {
//       setSnackbar(error.toString(), context);
//     });
//   }
//
//   Future<void> _getCart(String save) async {
//     _isNetworkAvail = await isNetworkAvailable();
//
//     if (_isNetworkAvail) {
//       try {
//         var parameter = {USER_ID: CUR_USERID, SAVE_LATER: save};
//
//         Response response =
//         await post(getCartApi, body: parameter, headers: headers)
//             .timeout(Duration(seconds: timeOut));
//
//         var getdata = json.decode(response.body);
//         bool error = getdata["error"];
//         String? msg = getdata["message"];
//         if (!error) {
//           var data = getdata["data"];
//
//           List<SectionModel> cartList = (data as List)
//               .map((data) => new SectionModel.fromCart(data))
//               .toList();
//           context.read<CartProvider>().setCartlist(cartList);
//         }
//       } on TimeoutException catch (_) {}
//     } else {
//       if (mounted)
//         setState(() {
//           _isNetworkAvail = false;
//         });
//     }
//   }
//
//   final _chars =
//       'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
//   Random _rnd = Random();
//
//   String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
//       length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));
//
//   Future<Null> generateReferral() async {
//     String refer = getRandomString(8);
//
//     //////
//
//     Map parameter = {
//       REFERCODE: refer,
//     };
//
//     apiBaseHelper.postAPICall(validateReferalApi, parameter).then((getdata) {
//       bool error = getdata["error"];
//       String? msg = getdata["message"];
//       if (!error) {
//         REFER_CODE = refer;
//
//         Map parameter = {
//           USER_ID: CUR_USERID,
//           REFERCODE: refer,
//         };
//
//         apiBaseHelper.postAPICall(getUpdateUserApi, parameter);
//       } else {
//         if (count < 5) generateReferral();
//         count++;
//       }
//
//       context.read<HomeProvider>().setSecLoading(false);
//     }, onError: (error) {
//       setSnackbar(error.toString(), context);
//       context.read<HomeProvider>().setSecLoading(false);
//     });
//   }
//
//   updateDailog() async {
//     await dialogAnimate(context,
//         StatefulBuilder(builder: (BuildContext context, StateSetter setStater) {
//           return AlertDialog(
//             shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.all(Radius.circular(5.0))),
//             title: Text(getTranslated(context, 'UPDATE_APP')!),
//             content: Text(
//               getTranslated(context, 'UPDATE_AVAIL')!,
//               style: Theme.of(this.context)
//                   .textTheme
//                   .subtitle1!
//                   .copyWith(color: Theme.of(context).colorScheme.fontColor),
//             ),
//             actions: <Widget>[
//               new TextButton(
//                   child: Text(
//                     getTranslated(context, 'NO')!,
//                     style: Theme.of(this.context).textTheme.subtitle2!.copyWith(
//                         color: Theme.of(context).colorScheme.lightBlack,
//                         fontWeight: FontWeight.bold),
//                   ),
//                   onPressed: () {
//                     Navigator.of(context).pop(false);
//                   }),
//               new TextButton(
//                   child: Text(
//                     getTranslated(context, 'YES')!,
//                     style: Theme.of(this.context).textTheme.subtitle2!.copyWith(
//                         color: Theme.of(context).colorScheme.fontColor,
//                         fontWeight: FontWeight.bold),
//                   ),
//                   onPressed: () async {
//                     Navigator.of(context).pop(false);
//
//                     String _url = '';
//                     if (Platform.isAndroid) {
//                       _url = androidLink + packageName;
//                     } else if (Platform.isIOS) {
//                       _url = iosLink;
//                     }
//
//                     if (await canLaunch(_url)) {
//                       await launch(_url);
//                     } else {
//                       throw 'Could not launch $_url';
//                     }
//                   })
//             ],
//           );
//         }));
//   }
//
//
//
//   Widget sliderLoading() {
//     double width = deviceWidth!;
//     double height = width / 2;
//     return Shimmer.fromColors(
//         baseColor: Theme.of(context).colorScheme.simmerBase,
//         highlightColor: Theme.of(context).colorScheme.simmerHigh,
//         child: Container(
//           margin: EdgeInsets.symmetric(vertical: 10),
//           width: double.infinity,
//           height: height,
//           color: Theme.of(context).colorScheme.white,
//         ));
//   }
//
//   Widget _buildImagePageItem(Model slider) {
//     double height = deviceWidth! / 0.5;
//
//     return GestureDetector(
//       child: Container(
//         decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(15)
//         ),
//         child: FadeInImage(
//             fadeInDuration: Duration(milliseconds: 150),
//             image: CachedNetworkImageProvider(slider.image!),
//             height: height,
//             width: double.maxFinite,
//             fit: BoxFit.contain,
//             imageErrorBuilder: (context, error, stackTrace) => Image.asset(
//               "assets/images/sliderph.png",
//               fit: BoxFit.contain,
//               height: height,
//               color: colors.primary,
//             ),
//             placeholderErrorBuilder: (context, error, stackTrace) =>
//                 Image.asset(
//                   "assets/images/sliderph.png",
//                   fit: BoxFit.contain,
//                   height: height,
//                   color: colors.primary,
//                 ),
//             placeholder: AssetImage(imagePath + "splash.png")),
//       ),
//       onTap: () async {
//         int curSlider = context.read<HomeProvider>().curSlider;
//         // if (homeSliderList[curSlider].type == "products") {
//         //   Product? item = homeSliderList[curSlider].list;
//         //
//         //   Navigator.push(
//         //     context,
//         //     PageRouteBuilder(
//         //         pageBuilder: (_, __, ___) => ProductDetail(
//         //             model: item, secPos: 0, index: 0, list: true)),
//         //   );
//         // } else if (homeSliderList[curSlider].type == "categories") {
//         //   Product item = homeSliderList[curSlider].list;
//         //   if (item.subList == null || item.subList!.length == 0) {
//         //     Navigator.push(
//         //         context,
//         //         MaterialPageRoute(
//         //           builder: (context) => ProductList(
//         //             name: item.name,
//         //             id: item.id,
//         //             tag: false,
//         //             fromSeller: false,
//         //           ),
//         //         ));
//         //   } else {
//         //     Navigator.push(
//         //         context,
//         //         MaterialPageRoute(
//         //           builder: (context) => SubCategory(
//         //             title: item.name!,
//         //             subList: item.subList,
//         //           ),
//         //         ));
//         //   }
//         // }
//       },
//     );
//   }
//
//   Widget deliverLoading() {
//     return Shimmer.fromColors(
//         baseColor: Theme.of(context).colorScheme.simmerBase,
//         highlightColor: Theme.of(context).colorScheme.simmerHigh,
//         child: Container(
//           margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
//           width: double.infinity,
//           height: 18.0,
//           color: Theme.of(context).colorScheme.white,
//         ));
//   }
//
//   Widget catLoading() {
//     return Column(
//       children: [
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
//           child: SingleChildScrollView(
//             scrollDirection: Axis.horizontal,
//             child: Column(
//                 children: [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
//                     .map((_) => Padding(
//                   padding: const EdgeInsets.only(top: 8.0),
//                   child: Container(
//                     margin: EdgeInsets.symmetric(horizontal: 10),
//                     decoration: BoxDecoration(
//                       color: Theme.of(context).colorScheme.white,
//                       shape: BoxShape.rectangle,
//                     ),
//                     width: MediaQuery.of(context).size.width,
//                     height: 60.0,
//                   ),
//                 ))
//                     .toList()),
//           ),
//         ),
//         Container(
//           margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
//           width: double.infinity,
//           height: 18.0,
//           color: Theme.of(context).colorScheme.white,
//         ),
//       ],
//     );
//   }
//
//   Widget noInternet(BuildContext context) {
//     return Center(
//       child: SingleChildScrollView(
//         child: Column(mainAxisSize: MainAxisSize.min, children: [
//           noIntImage(),
//           noIntText(context),
//           noIntDec(context),
//           AppBtn(
//             title: getTranslated(context, 'TRY_AGAIN_INT_LBL'),
//             btnAnim: buttonSqueezeanimation,
//             btnCntrl: buttonController,
//             onBtnSelected: () async {
//               context.read<HomeProvider>().setCatLoading(true);
//               context.read<HomeProvider>().setSecLoading(true);
//               context.read<HomeProvider>().setSliderLoading(true);
//               _playAnimation();
//
//               Future.delayed(Duration(seconds: 2)).then((_) async {
//                 _isNetworkAvail = await isNetworkAvailable();
//                 if (_isNetworkAvail) {
//                   if (mounted)
//                     setState(() {
//                       _isNetworkAvail = true;
//                     });
//                   //callApi();
//                 } else {
//                   await buttonController.reverse();
//                   if (mounted) setState(() {});
//                 }
//               });
//             },
//           )
//         ]),
//       ),
//     );
//   }
//
//   _deliverPincode() {
//     // String curpin = context.read<UserProvider>().curPincode;
//     // return GestureDetector(
//     //   child: Container(
//     //     // padding: EdgeInsets.symmetric(vertical: 8),
//     //     color: Theme.of(context).colorScheme.white,
//     //     child: ListTile(
//     //       dense: true,
//     //       minLeadingWidth: 10,
//     //       leading: Icon(
//     //         Icons.location_pin,
//     //       ),
//     //       title: Selector<UserProvider, String>(
//     //         builder: (context, data, child) {
//     //           return Text(
//     //             data == ''
//     //                 ? getTranslated(context, 'SELOC')!
//     //                 : getTranslated(context, 'DELIVERTO')! + data,
//     //             style:
//     //                 TextStyle(color: Theme.of(context).colorScheme.fontColor),
//     //           );
//     //         },
//     //         selector: (_, provider) => provider.curPincode,
//     //       ),
//     //       trailing: Icon(Icons.keyboard_arrow_right),
//     //     ),
//     //   ),
//     //   //onTap: _pincodeCheck,
//     // );
//   }
//
//   // void _pincodeCheck() {
//   //   showModalBottomSheet<dynamic>(
//   //       context: context,
//   //       isScrollControlled: true,
//   //       shape: RoundedRectangleBorder(
//   //           borderRadius: BorderRadius.only(
//   //               topLeft: Radius.circular(25), topRight: Radius.circular(25))),
//   //       builder: (builder) {
//   //         return StatefulBuilder(
//   //             builder: (BuildContext context, StateSetter setState) {
//   //           return Container(
//   //             constraints: BoxConstraints(
//   //                 maxHeight: MediaQuery.of(context).size.height * 0.9),
//   //             child: ListView(shrinkWrap: true, children: [
//   //               Padding(
//   //                   padding: const EdgeInsets.only(
//   //                       left: 20.0, right: 20, bottom: 40, top: 30),
//   //                   child: Padding(
//   //                     padding: EdgeInsets.only(
//   //                         bottom: MediaQuery.of(context).viewInsets.bottom),
//   //                     child: Form(
//   //                         key: _formkey,
//   //                         child: Column(
//   //                           mainAxisSize: MainAxisSize.min,
//   //                           crossAxisAlignment: CrossAxisAlignment.start,
//   //                           children: [
//   //                             Align(
//   //                               alignment: Alignment.topRight,
//   //                               child: InkWell(
//   //                                 onTap: () {
//   //                                   Navigator.pop(context);
//   //                                 },
//   //                                 child: Icon(Icons.close),
//   //                               ),
//   //                             ),
//   //                             TextFormField(
//   //                               keyboardType: TextInputType.text,
//   //                               textCapitalization: TextCapitalization.words,
//   //                               validator: (val) => validatePincode(val!,
//   //                                   getTranslated(context, 'PIN_REQUIRED')),
//   //                               onSaved: (String? value) {
//   //                                 context
//   //                                     .read<UserProvider>()
//   //                                     .setPincode(value!);
//   //                               },
//   //                               style: Theme.of(context)
//   //                                   .textTheme
//   //                                   .subtitle2!
//   //                                   .copyWith(
//   //                                       color: Theme.of(context)
//   //                                           .colorScheme
//   //                                           .fontColor),
//   //                               decoration: InputDecoration(
//   //                                 isDense: true,
//   //                                 prefixIcon: Icon(Icons.location_on),
//   //                                 hintText:
//   //                                     getTranslated(context, 'PINCODEHINT_LBL'),
//   //                               ),
//   //                             ),
//   //                             Padding(
//   //                               padding: const EdgeInsets.only(top: 8.0),
//   //                               child: Row(
//   //                                 children: [
//   //                                   Container(
//   //                                     margin:
//   //                                         EdgeInsetsDirectional.only(start: 20),
//   //                                     width: deviceWidth! * 0.35,
//   //                                     child: OutlinedButton(
//   //                                       onPressed: () {
//   //                                         context
//   //                                             .read<UserProvider>()
//   //                                             .setPincode('');
//   //
//   //                                         context
//   //                                             .read<HomeProvider>()
//   //                                             .setSecLoading(true);
//   //                                         getSection();
//   //                                         Navigator.pop(context);
//   //                                       },
//   //                                       child: Text(
//   //                                           getTranslated(context, 'All')!),
//   //                                     ),
//   //                                   ),
//   //                                   Spacer(),
//   //                                   SimBtn(
//   //                                       size: 0.35,
//   //                                       title: getTranslated(context, 'APPLY'),
//   //                                       onBtnSelected: () async {
//   //                                         if (validateAndSave()) {
//   //                                           // validatePin(curPin);
//   //                                           context
//   //                                               .read<HomeProvider>()
//   //                                               .setSecLoading(true);
//   //                                           getSection();
//   //
//   //                                           context
//   //                                               .read<HomeProvider>()
//   //                                               .setSellerLoading(true);
//   //                                           // getSeller();
//   //
//   //                                           Navigator.pop(context);
//   //                                         }
//   //                                       }),
//   //                                 ],
//   //                               ),
//   //                             ),
//   //                           ],
//   //                         )),
//   //                   ))
//   //             ]),
//   //           );
//   //           //});
//   //         });
//   //       });
//   // }
//
//   bool validateAndSave() {
//     final form = _formkey.currentState!;
//
//     form.save();
//     if (form.validate()) {
//       return true;
//     }
//     return false;
//   }
//
//   Future<Null> _playAnimation() async {
//     try {
//       await buttonController.forward();
//     } on TickerCanceled {}
//   }
//
//   // void getSlider() {
//   //   Map map = Map();
//   //
//   //   apiBaseHelper.postAPICall(getSliderApi, map).then((getdata) {
//   //     bool error = getdata["error"];
//   //     String? msg = getdata["message"];
//   //     if (!error) {
//   //       var data = getdata["data"];
//   //
//   //       homeSliderList =
//   //           (data as List).map((data) => new Model.fromSlider(data)).toList();
//   //
//   //       pages = homeSliderList.map((slider) {
//   //         return _buildImagePageItem(slider);
//   //       }).toList();
//   //     } else {
//   //       setSnackbar(msg!, context);
//   //     }
//   //
//   //     context.read<HomeProvider>().setSliderLoading(false);
//   //   }, onError: (error) {
//   //     setSnackbar(error.toString(), context);
//   //     context.read<HomeProvider>().setSliderLoading(false);
//   //   });
//   // }
//
//   void getCat() {
//     Map parameter = {
//       // CAT_FILTER: "false",
//     };
//     apiBaseHelper.postAPICall(getCatApi, parameter).then((getdata) {
//       print(getCatApi.toString());
//       print(parameter.toString());
//       bool error = getdata["error"];
//       String? msg = getdata["message"];
//       if (!error) {
//         var data = getdata["data"];
//         catList =
//             (data as List).map((data) => new Product.fromCat(data)).toList();
//         if (getdata.containsKey("popular_categories")) {
//           var data = getdata["popular_categories"];
//           popularList =
//               (data as List).map((data) => new Product.fromCat(data)).toList();
//           if (popularList.length > 0) {
//             Product pop =
//             new Product.popular("Popular", imagePath + "popular.svg");
//             catList.insert(0, pop);
//             context.read<CategoryProvider>().setSubList(popularList);
//           }
//         }
//       } else {
//         setSnackbar(msg!, context);
//       }
//
//       context.read<HomeProvider>().setCatLoading(false);
//     }, onError: (error) {
//       setSnackbar(error.toString(), context);
//       context.read<HomeProvider>().setCatLoading(false);
//     });
//   }
//
//   sectionLoading() {
//     return Column(
//         children: [0, 1, 2, 3, 4]
//             .map((_) => Column(
//           mainAxisSize: MainAxisSize.min,
//           children: <Widget>[
//             Padding(
//               padding: const EdgeInsets.only(top: 8.0),
//               child: Stack(
//                 children: [
//                   Positioned.fill(
//                     child: Container(
//                       margin: EdgeInsets.only(bottom: 40),
//                       decoration: BoxDecoration(
//                         color: Theme.of(context).colorScheme.white,
//                         borderRadius: BorderRadius.only(
//                           topLeft: Radius.circular(20),
//                           topRight: Radius.circular(20),
//                         ),
//                       ),
//                     ),
//                   ),
//                   Column(
//                     mainAxisSize: MainAxisSize.min,
//                     children: <Widget>[
//                       Container(
//                         margin: EdgeInsets.symmetric(
//                             horizontal: 20, vertical: 5),
//                         width: double.infinity,
//                         height: 18.0,
//                         color: Theme.of(context).colorScheme.white,
//                       ),
//                       GridView.count(
//                         padding: EdgeInsets.symmetric(
//                             horizontal: 20, vertical: 10),
//                         crossAxisCount: 2,
//                         shrinkWrap: true,
//                         childAspectRatio: 1.0,
//                         physics: NeverScrollableScrollPhysics(),
//                         mainAxisSpacing: 5,
//                         crossAxisSpacing: 5,
//                         children: List.generate(
//                           4,
//                               (index) {
//                             return Container(
//                               width: double.infinity,
//                               height: double.infinity,
//                               color:
//                               Theme.of(context).colorScheme.white,
//                             );
//                           },
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//             //sliderLoading()
//             //offerImages.length > index ? _getOfferImage(index) : Container(),
//           ],
//         ))
//             .toList());
//   }
//
//   void getSeller() {
//     String pin = context.read<UserProvider>().curPincode;
//     Map parameter = {};
//     if (pin != '') {
//       parameter = {
//         ZIPCODE: pin,
//       };
//     }
//     apiBaseHelper.postAPICall(getSellerApi, parameter).then((getdata) {
//       bool error = getdata["error"];
//       String? msg = getdata["message"];
//       if (!error) {
//         var data = getdata["data"];
//
//         sellerList =
//             (data as List).map((data) => new Product.fromSeller(data)).toList();
//       } else {
//         setSnackbar(msg!, context);
//       }
//
//       context.read<HomeProvider>().setSellerLoading(false);
//     }, onError: (error) {
//       setSnackbar(error.toString(), context);
//       context.read<HomeProvider>().setSellerLoading(false);
//     });
//   }
//
//
//   int _currentIndex = 1;
//   var bankiNDEX;
//
//   customTabbar(){
//     return Padding(
//       padding: const EdgeInsets.only(left:10.0,right:10),
//       child: Container(
//         width: MediaQuery.of(context).size.width,
//         height: 50,
//         decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(20)),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             InkWell(
//               onTap: (){
//                 setState(() {
//                   _currentIndex = 1;
//                   bankData();
//
//                 });
//               },
//               child: Container(
//                 decoration: BoxDecoration(
//                     color: _currentIndex == 1 ?
//                     colors.primary
//                         : colors.primary.withOpacity(0.2),
//                     borderRadius: BorderRadius.circular(5)
//                 ),
//                 height: 40,
//                 width:70,
//                 child: Center(
//                   child: Text("Bank",style: TextStyle(color: _currentIndex == 1 ?colors.whiteTemp:colors.blackTemp)),
//                 ),
//               ),
//             ),
//             SizedBox(width:10),
//             InkWell(
//               onTap: () {
//                 setState(() {
//                   _currentIndex = 2;
//                   showAlertDialog(
//                     context,
//                     'Pin Code',
//                     'Please Enter Pin Code Here!',
//                   );
//                 });
//               },
//               child: Container(
//                 decoration: BoxDecoration(
//                     color: _currentIndex == 2 ?
//                     colors.primary
//                         : colors.primary.withOpacity(0.2),
//                     borderRadius: BorderRadius.circular(5)
//                 ),
//                 height: 40,
//                 width: 70,
//                 child: Center(
//                   child: Text("Pincode",style: TextStyle(color: _currentIndex == 2 ?colors.whiteTemp:colors.blackTemp)),
//                 ),
//               ),
//             ),
//             SizedBox(width:10),
//             InkWell(
//               onTap: () {
//                 setState(() {
//                   _currentIndex = 3;
//                   Navigator.push(context, MaterialPageRoute(builder: (context) => ReportScreen()));
//                 });
//               },
//               child: Padding(
//                 padding: const EdgeInsets.all(2.0),
//                 child: Container(
//                   decoration: BoxDecoration(
//                       color: _currentIndex == 3 ?
//                       colors.primary : colors.primary.withOpacity(0.2),
//                       borderRadius: BorderRadius.circular(5)
//                   ),
//                   // width: 120,
//                   height: 40,
//                   width: 70,
//                   child: Center(
//                     child: Text("Report",style: TextStyle(color: _currentIndex == 3 ?colors.whiteTemp:colors.blackTemp),),
//                   ),
//                 ),
//               ),
//             ),
//             SizedBox(width:10,),
//             earningStatus == false ? SizedBox() :
//             InkWell(
//               onTap: (){
//                 setState(() {
//                   _currentIndex = 4;
//
//                 });
//               },
//               child: Container(
//                 decoration: BoxDecoration(
//                     color: _currentIndex == 4 ?
//                     colors.primary
//                         : colors.primary.withOpacity(0.2),
//                     borderRadius: BorderRadius.circular(5)
//                 ),
//                 // width: 120,
//                 height: 40,
//                 width:70,
//                 child: Center(
//                   child: Text("Earnings",style: TextStyle(color: _currentIndex == 4 ? colors.whiteTemp:colors.blackTemp)),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   BankDetailsModel? bankDetailsModel;
//   bool isLoading = true;
//   Future<void> bankData() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     String? uids = prefs.getString('new_user_id');
//     print('kkkkkkkk ${uids}');
//     var headers = {
//       'Cookie': 'ci_session=42a35e75aaf07f07785090cfdbb39c7f0a875c13'
//     };
//     var request = http.Request('GET', Uri.parse('${baseUrl}get_lead_bankname?user_id=${uids}'));
//     request.headers.addAll(headers);
//     http.StreamedResponse response = await request.send();
//     if (response.statusCode == 200) {
//       var Result = await response.stream.bytesToString();
//       final finalResult = BankDetailsModel.fromJson(json.decode(Result));
//       setState(() {
//         bankDetailsModel = finalResult;
//         print('Bank Nameeeee${bankDetailsModel}');
//         print("User id is here----------${CUR_USERID}");
//       });
//       setState(() {
//         isLoading = false;
//       });
//     }
//     else {
//       print(response.reasonPhrase);
//     }
//   }
//
//   void showAlertDialog(BuildContext context, String title, String message) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text(title),
//           content: Text(message),
//           actions: <Widget>[
//             TextFormField(
//               maxLength: 6,
//               onChanged: (value) {
//                 setState(() {
//                   searchLeads1(value);
//                   GetLeadsData();
//                 });
//               },
//               controller: pinCodeController,
//               keyboardType: TextInputType.number,
//               decoration: InputDecoration(
//                 hintText: 'Pin code',
//                 contentPadding: EdgeInsets.only(top: 5,left: 10),
//                 border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(10)
//                 ),
//               ),
//             ),
//             SizedBox(height: 10),
//             ElevatedButton(onPressed: () {
//               if(pinCodeController.text.isNotEmpty) {
//                 GetLeadsPinData();
//                 Navigator.pop(context);
//               }else{
//                 Fluttertoast.showToast(msg: 'Please Enter Pin code');
//               }
//             }, style: ElevatedButton.styleFrom(backgroundColor: colors.primary),
//               child:Text('Done',style: TextStyle(color: colors.whiteTemp),
//               ),
//             ),
//           ],
//         );
//       },
//     );
//   }
//
//
//   Future<void> GetLeadsData() async {
//     SharedPreferences preferences = await SharedPreferences.getInstance();
//     var headers = {
//       'Cookie': 'ci_session=e739bf3509ae8bb7102d8891dd88233ab61f48ff'
//     };
//     var request = http.MultipartRequest('POST', Uri.parse('https://alphawizzserver.com/sahu/app/v1/api/get_leads?user_id=${CUR_USERID}&search=${pinCodeController.text}'));
//     // request.fields.addAll({
//     //   'user_id':'${CUR_USERID}',
//     //   'search':_currentIndex==2?'${pinCodeController.text}':" "
//     // });
//     print("---fieldsssss----${request.fields}");
//     request.headers.addAll(headers);
//     http.StreamedResponse response = await request.send();
//     if (response.statusCode == 200) {
//       var Result = await response.stream.bytesToString();
//       print(Result);
//       final finalResult = GetLeadsModel.fromJson(json.decode(Result));
//       setState(() {
//         leadData = finalResult.data ?? [];
//         print("leadss lengthh ${leadData.length}===========");
//       });
//       for(int i=0; i< leadData.length; i++)
//         preferences.setString("lead_id", leadData[i].id ?? "");
//       print("get-----leads---data${leadData}");
//     }
//     else {
//       print(response.reasonPhrase);
//     }
//   }
//
//
//
//   Future<void> GetLeads() async {
//     SharedPreferences preferences = await SharedPreferences.getInstance();
//     var headers = {
//       'Cookie': 'ci_session=e739bf3509ae8bb7102d8891dd88233ab61f48ff'
//     };
//     var request = http.MultipartRequest('POST', Uri.parse('https://alphawizzserver.com/sahu/app/v1/api/get_leads'));
//     request.fields.addAll({
//       'user_id':'${CUR_USERID}',
//       // 'search':_currentIndex==2?'${pinCodeController.text}':" "
//     });
//     print("---fieldsssss hereerere${request.fields}");
//     request.headers.addAll(headers);
//     http.StreamedResponse response = await request.send();
//     if (response.statusCode == 200) {
//       var Result = await response.stream.bytesToString();
//       print(Result);
//       final finalResult = GetLeadsModel.fromJson(json.decode(Result));
//       setState(() {
//         leadData = finalResult.data ?? [];
//       });
//       for(int i=0; i< leadData.length; i++)
//         preferences.setString("lead_id", leadData[i].id ?? "");
//       print("get-----leads---data${leadData}");
//     }
//     else {
//       print(response.reasonPhrase);
//     }
//   }
//
//   searchLeads(String value) {
//     if (value.isEmpty) {
//       GetLeadsData();
//       setState(() {});
//     }else{
//       final suggestions = leadData.where((element) {
//         final leadsTitle = element.customername.toString().toLowerCase();
//         final leadsPhone = element.phone1.toString().toLowerCase();
//         final leadsId = element.agreementid.toString().toLowerCase();
//         final input = value.toLowerCase();
//         return leadsTitle.contains(input) || leadsPhone.contains(input) || leadsId.contains(input)  ;
//       }).toList();
//       leadData = suggestions;
//       setState(() {
//       });
//     }
//   }
//
//
//   searchLeads1(String value) {
//     if (value.isEmpty) {
//       GetLeadsData();
//       setState(() {});
//     }else{
//       final suggestions = leadData.where((element) {
//         final leadsTitle = element.primaryAddressPin!.toLowerCase();
//         final input = value.toLowerCase();
//         return leadsTitle.contains(input);
//       }).toList();
//       leadData = suggestions;
//       setState(() {
//       });
//     }
//   }
// }
