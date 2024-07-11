import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:omega_employee_management/Helper/ApiBaseHelper.dart';
import 'package:omega_employee_management/Helper/AppBtn.dart';
import 'package:omega_employee_management/Helper/Color.dart';
import 'package:omega_employee_management/Helper/Constant.dart';
import 'package:omega_employee_management/Helper/Session.dart';
import 'package:omega_employee_management/Helper/SimBtn.dart';
import 'package:omega_employee_management/Helper/String.dart';
import 'package:omega_employee_management/Model/Model.dart';
import 'package:omega_employee_management/Model/Section_Model.dart';
import 'package:omega_employee_management/Model/category_model.dart';
import 'package:omega_employee_management/Provider/CartProvider.dart';
import 'package:omega_employee_management/Provider/CategoryProvider.dart';
import 'package:omega_employee_management/Provider/FavoriteProvider.dart';
import 'package:omega_employee_management/Provider/HomeProvider.dart';
import 'package:omega_employee_management/Provider/SettingProvider.dart';
import 'package:omega_employee_management/Provider/UserProvider.dart';
import 'package:omega_employee_management/Screen/AddClients.dart';
import 'package:omega_employee_management/Screen/AddPhoto.dart';
import 'package:omega_employee_management/Screen/My_Wallet.dart';
import 'package:omega_employee_management/Screen/SellerList.dart';
import 'package:omega_employee_management/Screen/Seller_Details.dart';
import 'package:omega_employee_management/Screen/SubCategory.dart';
import 'package:omega_employee_management/Screen/ViewClient.dart';
import 'package:omega_employee_management/Screen/check_out_screen.dart';
import 'package:package_info/package_info.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:version/version.dart';

import '../Model/ClientModel.dart';
import '../Model/PermissionModel.dart';
import 'AddGeoTag.dart';
import 'ClientForm.dart';
import 'EditClent.dart';
import 'FeedbackForm.dart';
import 'Login.dart';
import 'MySiteVisit.dart';
import 'ProductList.dart';
import 'Product_Detail.dart';
import 'SectionList.dart';
import 'SiteVisitForm.dart';
import 'ViewCounterVisitForm.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

List<SectionModel> sectionList = [];
List<Product> catList = [];
List<Product> popularList = [];
ApiBaseHelper apiBaseHelper = ApiBaseHelper();
List<String> tagList = [];
List<Product> sellerList = [];
int count = 1;
List<Model> homeSliderList = [];
List<Widget> pages = [];

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin<HomePage>, TickerProviderStateMixin {
  bool _isNetworkAvail = true;
  var userId;
  final _controller = PageController();
  late Animation buttonSqueezeanimation;
  late AnimationController buttonController;
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  List<Model> offerImages = [];
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();
  int currentIndex = 0;
  bool isCheckedIn = false;
  //String? curPin;

  @override
  bool get wantKeepAlive => true;

  List<Categories> categories = [];
  String? catId;

  setCatid() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    userId = pref.getString('user_id');
    pref.setString('cat_id', catId ?? "");
    var checkinTime = pref.getString("CheckInTime");
    debugPrint("checkintime $checkinTime}");
    print('helllllo cat Iddddd${catId}');
  }

  ClientModel? clients;
  getClients() async {
    var headers = {
      'Cookie': 'ci_session=aa83f4f9d3335df625437992bb79565d0973f564'
    };
    var request =
        http.MultipartRequest('POST', Uri.parse(getClientApi.toString()));
    request.fields.addAll({
      USER_ID: '$userId',
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
      });
      print("this is response data ${finalResponse}");
      // setState(() {
      // animalList = finalResponse.data!;
      // });
      // print("this is operator list ----->>>> ${operatorList[0].name}");
    } else {
      print(response.reasonPhrase);
    }
  }

  PermissionModel? permission;
  getPermission() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? uid = prefs.getString("user_id");
    var headers = {
      'Cookie': 'ci_session=aa83f4f9d3335df625437992bb79565d0973f564'
    };
    var request =
        http.MultipartRequest('POST', Uri.parse(getPermissionApi.toString()));
    request.fields.addAll({
      USER_ID: '${uid}',
    });

    print("this is refer  get permission request ${request.fields.toString()}");
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      print("permission");
      String str = await response.stream.bytesToString();
      var result = json.decode(str);
      var finalResponse = PermissionModel.fromJson(result);
      print("permission responseeeeee ${finalResponse}");
      setState(() {
        permission = finalResponse;
      });
      // setState(() {
      // animalList = finalResponse.data!;
      // });
      // print("this is operator list ----->>>> ${operatorList[0].name}");
    } else {
      print(response.reasonPhrase);
    }
  }

  getUserCheckInStatus() async {
    var headers = {
      // 'Token': jwtToken.toString(),
      // 'Authorisedkey': authKey.toString(),
      'Cookie': 'ci_session=aa83f4f9d3335df625437992bb79565d0973f564'
    };
    var request = http.MultipartRequest(
        'POST', Uri.parse(getUserCheckStatusApi.toString()));
    request.fields.addAll({
      USER_ID: '$CUR_USERID',
      // 'status' : status.toString()
      // categoryValue != null ?
      //     categoryValue.toString() : ""
    });

    print("this is refer request..... ${request.fields.toString()}");
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      String str = await response.stream.bytesToString();
      var result = json.decode(str);
      bool status = result['data'];
      setState(() {
        isCheckedIn = status;
      });
      // var finalResponse = GetUserExpensesModel.fromJson(result);
      // setState(() {
      //   userExpenses = finalResponse.data!;
      // });
      // print("this is referral data ${userExpenses.length}");
      // setState(() {
      // animalList = finalResponse.data!;
      // });
      // print("this is operator list ----->>>> ${operatorList[0].name}");
    } else {
      print(response.reasonPhrase);
    }
  }

  @override
  void initState() {
    super.initState();
    getClients();
    getPermission();
    callApi();
    setCatid();
    buttonController = new AnimationController(
        duration: new Duration(milliseconds: 2000), vsync: this);
    buttonSqueezeanimation = new Tween(
      begin: deviceWidth! * 0.7,
      end: 50.0,
    ).animate(
      new CurvedAnimation(
        parent: buttonController,
        curve: new Interval(
          0.0,
          0.150,
        ),
      ),
    );
    WidgetsBinding.instance.addPostFrameCallback((_) => _animateSlider());
  }

  // subCatItem(List<Product> subList, int index, BuildContext context) {
  //   return GestureDetector(
  //     child: Column(
  //       children: <Widget>[
  //         Expanded(
  //             child: Card(
  //               elevation: 4,
  //               shape:
  //               RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
  //               child: Container(
  //                 decoration: BoxDecoration(
  //                     borderRadius: BorderRadius.circular(15),
  //                     image: DecorationImage(
  //                         fit: BoxFit.contain,
  //                         image: NetworkImage('${subList[index].image!}'))),
  //                 // child: FadeInImage(
  //                 //   image: CachedNetworkImageProvider(subList[index].image!),
  //                 //   fadeInDuration: Duration(milliseconds: 150),
  //                 //   fit: BoxFit.cover,
  //                 //   imageErrorBuilder: (context, error, stackTrace) =>
  //                 //       erroWidget(50),
  //                 //   placeholder: placeHolder(50),
  //                 // ),
  //               ),
  //             )),
  //         Text(
  //           subList[index].name! + "\n",
  //           textAlign: TextAlign.center,
  //           maxLines: 2,
  //           overflow: TextOverflow.ellipsis,
  //           style: Theme.of(context)
  //               .textTheme
  //               .caption!
  //               .copyWith(color: Theme.of(context).colorScheme.fontColor),
  //         )
  //       ],
  //     ),
  //     onTap: () {
  //       Navigator.push(context, MaterialPageRoute(builder: (context) => ReferForm()));
  //       // if (context.read<CategoryProvider>().curCat == 0 &&
  //       //     popularList.length > 0) {
  //       //   if (popularList[index].subList == null ||
  //       //       popularList[index].subList!.length == 0) {
  //       //     Navigator.push(
  //       //         context,
  //       //         MaterialPageRoute(
  //       //           builder: (context) => ProductList(
  //       //             name: popularList[index].name,
  //       //             id: popularList[index].id,
  //       //             tag: false,
  //       //             fromSeller: false,
  //       //           ),
  //       //         ));
  //       //   } else {
  //       //
  //       //     Navigator.push(
  //       //         context,
  //       //         MaterialPageRoute(
  //       //           builder: (context) => SubCategory(
  //       //             subList: popularList[index].subList,
  //       //             title: popularList[index].name ?? "",
  //       //             catId: popularList[index].id,
  //       //           ),
  //       //         ));
  //       //   }
  //       // } else if (subList[index].subList == null ||
  //       //     subList[index].subList!.length == 0) {
  //       //   print(StackTrace.current);
  //       //   Navigator.push(
  //       //       context,
  //       //       MaterialPageRoute(
  //       //         builder: (context) => ProductList(
  //       //           name: subList[index].name,
  //       //           id: subList[index].id,
  //       //           tag: false,
  //       //           fromSeller: false,
  //       //         ),
  //       //       ));
  //       // } else {
  //       //   print(StackTrace.current);
  //       //   Navigator.push(
  //       //       context,
  //       //       MaterialPageRoute(
  //       //         builder: (context) => SubCategory(
  //       //           subList: subList[index].subList,
  //       //           title: subList[index].name ?? "",
  //       //         ),
  //       //       ));
  //       // }
  //     },
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text("Confirm Exit"),
                content: const Text("Are you sure you want to exit this app?"),
                actions: <Widget>[
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: colors.secondary),
                    child: const Text("YES"),
                    onPressed: () {
                      SystemNavigator.pop();
                    },
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: colors.secondary),
                    child: const Text("NO"),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            });
        return true;
      },
      child: SafeArea(
        bottom: true,
        top: false,
        child: Scaffold(
          // floatingActionButton: Padding(
          //   padding: const EdgeInsets.only(bottom: 30),
          //   child: Container(
          //     // key: whatsapppBoxKey,
          //     height: 70.0,
          //     width: 70.0,
          //     child: FloatingActionButton(
          //       backgroundColor: colors.primary,
          //       onPressed: () {
          //         Navigator.push(context, MaterialPageRoute(builder: (context) => AddClients()));
          //       },
          //       child: Text("Add Client", style: TextStyle(fontSize: 10, color: Colors.white, fontWeight: FontWeight.bold),)
          //     ),
          //   ),
          // ),
          bottomSheet: Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // ElevatedButton(
                //   onPressed: () async {
                //   var result = await   Navigator.push(context, MaterialPageRoute(builder: (context)=> CheckInScreen()));
                //   if(result != null){
                //     setState(() {
                //       getUserCheckInStatus();
                //     });
                //   }
                //   }, child: Text("CHECK-IN",
                //   ),
                // style: ElevatedButton.styleFrom(
                //   elevation: 0,
                //   shape: StadiumBorder(),
                //   fixedSize: Size(150, 40),
                //   backgroundColor: colors.blackTemp.withOpacity(0.8)
                // ),),
                // SizedBox(width: 20,),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CheckOutScreen()));
                  },
                  child: Text("CHECK-OUT"),
                  style: ElevatedButton.styleFrom(
                      elevation: 0,
                      shape: StadiumBorder(),
                      fixedSize: Size(150, 40),
                      backgroundColor: colors.blackTemp.withOpacity(0.8)),
                ),
              ],
            ),
          ),
          appBar: AppBar(
            automaticallyImplyLeading: false,
            centerTitle: true,
            elevation: 0,
            title: Text(
              isCheckedIn ? "CHECKED-IN" : "CHECKED-OUT",
              style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 16,
                  color: colors.whiteTemp),
            ),
            backgroundColor: isCheckedIn ? Colors.green : Colors.red,
          ),
          // appBar: AppBar(
          //   backgroundColor: Theme.of(context).colorScheme.white,
          //   centerTitle: true,
          //   title: Image.asset(
          //     'assets/images/homelogo.png',
          //     height: 65,
          //   ),
          //   actions: [
          //     IconButton(onPressed: (){}, icon: Icon(Icons.notifications, color: colors.primary,))
          //   ],
          // ),
          body: _isNetworkAvail
              ? RefreshIndicator(
                  color: colors.primary,
                  key: _refreshIndicatorKey,
                  onRefresh: _refresh,
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 25),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 10),
                          _slider(),
                          Padding(
                            padding: const EdgeInsets.all(12),
                            child: Text(
                              "Clients",
                              style: TextStyle(
                                  color: colors.primary,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                          Column(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 20, right: 20),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    permission?.data?.clients?.add == "on"
                                        ? InkWell(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          AddClients()));
                                            },
                                            child: Container(
                                              height: 40,
                                              width: 80,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  color: colors.primary),
                                              child: Center(
                                                  child: Text("ADD",
                                                      style: TextStyle(
                                                          fontSize: 13,
                                                          color:
                                                              Colors.white))),
                                            ),
                                          )
                                        : SizedBox(),
                                    permission?.data?.clients?.view == "on"
                                        ? InkWell(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          ViewClient()));
                                            },
                                            child: Container(
                                              height: 40,
                                              width: 80,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  color: colors.primary),
                                              child: Center(
                                                  child: Text("View",
                                                      style: TextStyle(
                                                          fontSize: 13,
                                                          color:
                                                              Colors.white))),
                                            ),
                                          )
                                        : SizedBox(),
                                    permission?.data?.clients?.edit == "on"
                                        ? InkWell(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          EditClient()));
                                            },
                                            child: Container(
                                              height: 40,
                                              width: 80,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  color: colors.primary),
                                              child: Center(
                                                  child: Text("Edit",
                                                      style: TextStyle(
                                                          fontSize: 13,
                                                          color:
                                                              Colors.white))),
                                            ),
                                          )
                                        : SizedBox(),
                                    // Container(
                                    //   height: 40,
                                    //   width: 95,
                                    //   decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: colors.primary),
                                    //   child: Center(
                                    //       child: Text("Edit Client", style: TextStyle(fontSize: 13, color: Colors.white))),
                                    // ),
                                  ],
                                ),
                              ),
                              // SizedBox(height: 10),
                              // Padding(
                              //   padding: const EdgeInsets.only(left: 90, right: 20),
                              //   child: Row(
                              //     children: [
                              //
                              //     ],
                              //   ),
                              // ),
                            ],
                          ),
                          SizedBox(height: 10),
                          Column(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 50, right: 20),
                                child: Row(
                                  children: [
                                    permission?.data?.clients?.gioTag == "on"
                                        ? InkWell(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          AddGeoScreen()));
                                            },
                                            child: Container(
                                              height: 40,
                                              width: 120,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  color: colors.primary),
                                              child: Center(
                                                child: Text(
                                                  "Pending GeoTag",
                                                  style: TextStyle(
                                                      fontSize: 13,
                                                      color: Colors.white),
                                                ),
                                              ),
                                            ),
                                          )
                                        : SizedBox(),
                                    SizedBox(width: 20),
                                    permission?.data?.clients?.gioTag == "on"
                                        ? InkWell(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          AddPhoto()));
                                            },
                                            child: Container(
                                              height: 40,
                                              width: 120,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  color: colors.primary),
                                              child: Center(
                                                  child: Text("Pending Photo",
                                                      style: TextStyle(
                                                          fontSize: 13,
                                                          color:
                                                              Colors.white))),
                                            ),
                                          )
                                        : SizedBox(),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          Padding(
                            padding: const EdgeInsets.all(12),
                            child: Text(
                              "Counter Visit Form",
                              style: TextStyle(
                                  color: colors.primary,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                          Column(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 10, right: 10),
                                child: Row(
                                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    permission?.data?.feedback?.add == "on"
                                        ? InkWell(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          FeedbackForm()));
                                            },
                                            child: Container(
                                              height: 40,
                                              width: 95,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  color: colors.primary),
                                              child: Center(
                                                  child: Text("Add Form",
                                                      style: TextStyle(
                                                          fontSize: 13,
                                                          color:
                                                              Colors.white))),
                                            ),
                                          )
                                        : SizedBox(),
                                    SizedBox(width: 30),
                                    permission?.data?.feedback?.view == "on"
                                        ? InkWell(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          ViewCounterVisitForm()));
                                            },
                                            child: Container(
                                              height: 40,
                                              width: 95,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  color: colors.primary),
                                              child: Center(
                                                  child: Text("View Form",
                                                      style: TextStyle(
                                                          fontSize: 13,
                                                          color:
                                                              Colors.white))),
                                            ),
                                          )
                                        : SizedBox(),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 15),
                          Padding(
                            padding: const EdgeInsets.all(12),
                            child: Text(
                              "Customer Survey Form",
                              style: TextStyle(
                                  color: colors.primary,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                          Column(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 10, right: 10),
                                child: Row(
                                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    permission?.data?.surveyForm?.add == "on"
                                        ? InkWell(
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      SiteVisitForm(),
                                                ),
                                              );
                                            },
                                            child: Container(
                                              height: 40,
                                              width: 95,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  color: colors.primary),
                                              child: Center(
                                                  child: Text("Add Form",
                                                      style: TextStyle(
                                                          fontSize: 13,
                                                          color:
                                                              Colors.white))),
                                            ),
                                          )
                                        : SizedBox(),
                                    SizedBox(width: 30),
                                    permission?.data?.surveyForm?.view == "on"
                                        ? InkWell(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          MySiteVisite()));
                                            },
                                            child: Container(
                                              height: 40,
                                              width: 95,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  color: colors.primary),
                                              child: Center(
                                                child: Text(
                                                  "View Form",
                                                  style: TextStyle(
                                                      fontSize: 13,
                                                      color: Colors.white),
                                                ),
                                              ),
                                            ),
                                          )
                                        : SizedBox(),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 45),
                          // _catList(),
                          //   const SizedBox(height: 15),
                        ],
                      ),
                    ),
                  ),
                )
              : noInternet(context),
        ),
      ),
    );
  }

  Future<Null> _refresh() {
    context.read<HomeProvider>().setCatLoading(true);
    context.read<HomeProvider>().setSecLoading(true);
    context.read<HomeProvider>().setSliderLoading(true);
    return callApi();
  }

  Widget _slider() {
    double height = deviceWidth! / 2.2;
    return Selector<HomeProvider, bool>(
      builder: (context, data, child) {
        return data
            ? sliderLoading()
            : ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Column(
                  children: [
                    Container(
                      height: height,
                      width: double.infinity,
                      child: CarouselSlider(
                        options: CarouselOptions(
                          viewportFraction: 0.8,
                          initialPage: 0,
                          enableInfiniteScroll: true,
                          reverse: false,
                          autoPlay: true,
                          autoPlayInterval: Duration(seconds: 3),
                          autoPlayAnimationDuration:
                              Duration(milliseconds: 1200),
                          autoPlayCurve: Curves.fastOutSlowIn,
                          enlargeCenterPage: true,
                          scrollDirection: Axis.horizontal,
                          height: height,
                          onPageChanged: (position, reason) {
                            setState(() {
                              currentIndex = position;
                            });
                            print(reason);
                            print(CarouselPageChangedReason.controller);
                          },
                        ),
                        items: homeSliderList.map((val) {
                          return InkWell(
                            onTap: () {
                              // if (homeSliderList[currentindex].type ==
                              //     "restaurants") {
                              //   print(homeSliderList[currentindex].list);
                              //   if (homeSliderList[currentindex].list!=null) {
                              //     var item =
                              //         homeSliderList[currentindex].list;
                              //     // Navigator.push(
                              //     //     context,
                              //     //     MaterialPageRoute(
                              //     //         builder: (context) => SellerProfile(
                              //     //           title: item.store_name.toString(),
                              //     //           sellerID: item.seller_id.toString(),
                              //     //           sellerId: item.seller_id.toString(),
                              //     //           sellerData: item,
                              //     //           userLocation: currentAddress.text,
                              //     //           // catId: widget.catId,
                              //     //           shop: false,
                              //     //         )));
                              //     /*Navigator.push(
                              //             context,
                              //             PageRouteBuilder(
                              //                 pageBuilder: (_, __, ___) =>
                              //                     ProductDetail(
                              //                         model: item,
                              //                         secPos: 0,
                              //                         index: 0,
                              //                         list: true)),
                              //           );*/
                              //   }
                              // } else if (homeSliderList[currentindex].type ==
                              //     "categories") {
                              //   var item = homeSliderList[currentindex].list;
                              //   Navigator.push(
                              //       context,
                              //       MaterialPageRoute(
                              //           builder: (context) => SellerList(
                              //             catId: item.categoryId,
                              //             catName: item.name,
                              //             userLocation:
                              //             currentAddress.text,
                              //             getByLocation: true,
                              //           )));
                              // }
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.network(
                                  "${val.image}",
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                      // margin: EdgeInsetsDirectional.only(top: 10),
                      // child: PageView.builder(
                      //   itemCount: homeSliderList.length,
                      //   scrollDirection: Axis.horizontal,
                      //   controller: _controller,
                      //   pageSnapping: true,
                      //   physics: AlwaysScrollableScrollPhysics(),
                      //   onPageChanged: (index) {
                      //     context.read<HomeProvider>().setCurSlider(index);
                      //   },
                      //   itemBuilder: (BuildContext context, int index) {
                      //     return pages[index];
                      //   },
                      // ),
                    ),
                    Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: homeSliderList.map((e) {
                          int index = homeSliderList.indexOf(e);
                          return Container(
                              width: 8.0,
                              height: 8.0,
                              margin: EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 2.0),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: currentIndex == index
                                    ? Theme.of(context).colorScheme.fontColor
                                    : Theme.of(context).colorScheme.lightBlack,
                              ));
                        }).toList()),
                  ],
                ),
              );
      },
      selector: (_, homeProvider) => homeProvider.sliderLoading,
    );
  }

  Widget _firstHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
          onTap: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => MyWallet()));
          },
          child: Card(
            elevation: 4,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: Container(
              height: MediaQuery.of(context).size.width / 2 - 40,
              width: MediaQuery.of(context).size.width / 2 - 40,
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Consumer<UserProvider>(builder: (context, userProvider, _) {
                      return Text(
                        myEarnings == '' || myEarnings == null
                            ? CUR_CURRENCY! + " " + "0"
                            : CUR_CURRENCY! + " " + myEarnings.toString(),
                        style: TextStyle(
                            fontSize: 36,
                            fontWeight: FontWeight.w600,
                            color: colors.secondary),
                      );
                    }),
                    Text(
                      "My Earning",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Theme.of(context).colorScheme.fontColor),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        InkWell(
          onTap: () {
            // Navigator.push(context, MaterialPageRoute(builder: (context)=> MyLeadsAccounts()));
          },
          child: Card(
            elevation: 4,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: Container(
              height: MediaQuery.of(context).size.width / 2 - 40,
              width: MediaQuery.of(context).size.width / 2 - 40,
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Consumer<UserProvider>(builder: (context, userProvider, _) {
                      return Text(
                        leadsCount == '' || leadsCount == null
                            ? '0'
                            : leadsCount.toString(),
                        style: TextStyle(
                            fontSize: 36,
                            fontWeight: FontWeight.w600,
                            color: colors.secondary),
                      );
                    }),
                    Text(
                      "My Leads",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Theme.of(context).colorScheme.fontColor),
                    ),
                  ],
                ),
              ),
            ),
          ),
        )
      ],
    );
  }

  void _animateSlider() {
    Future.delayed(Duration(seconds: 30)).then(
      (_) {
        if (mounted) {
          int nextPage = _controller.hasClients
              ? _controller.page!.round() + 1
              : _controller.initialPage;

          if (nextPage == homeSliderList.length) {
            nextPage = 0;
          }
          if (_controller.hasClients)
            _controller
                .animateToPage(nextPage,
                    duration: Duration(milliseconds: 200), curve: Curves.linear)
                .then((_) => _animateSlider());
        }
      },
    );
  }

  _singleSection(int index) {
    Color back;
    int pos = index % 5;
    if (pos == 0)
      back = Theme.of(context).colorScheme.back1;
    else if (pos == 1)
      back = Theme.of(context).colorScheme.back2;
    else if (pos == 2)
      back = Theme.of(context).colorScheme.back3;
    else if (pos == 3)
      back = Theme.of(context).colorScheme.back4;
    else
      back = Theme.of(context).colorScheme.back5;

    return sectionList[index].productList!.length > 0
        ? Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    _getHeading(sectionList[index].title ?? "", index),
                    _getSection(index),
                  ],
                ),
              ),
              offerImages.length > index ? _getOfferImage(index) : Container(),
            ],
          )
        : Container();
  }

  _getHeading(String title, int index) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 20.0),
          child: Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.centerRight,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                  color: colors.yellow,
                ),
                padding: EdgeInsetsDirectional.only(
                    start: 10, bottom: 3, top: 3, end: 10),
                child: Text(
                  title,
                  style: Theme.of(context)
                      .textTheme
                      .subtitle2!
                      .copyWith(color: colors.blackTemp),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              /*   Positioned(
                  // clipBehavior: Clip.hardEdge,
                  // margin: EdgeInsets.symmetric(horizontal: 20),

                  right: -14,
                  child: SvgPicture.asset("assets/images/eshop.svg"))*/
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(sectionList[index].shortDesc ?? "",
                    style: Theme.of(context).textTheme.subtitle1!.copyWith(
                        color: Theme.of(context).colorScheme.fontColor)),
              ),
              TextButton(
                style: TextButton.styleFrom(
                    minimumSize: Size.zero, // <
                    backgroundColor: (Theme.of(context).colorScheme.white),
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5)),
                child: Text(
                  getTranslated(context, 'SHOP_NOW')!,
                  style: Theme.of(context).textTheme.caption!.copyWith(
                      color: Theme.of(context).colorScheme.fontColor,
                      fontWeight: FontWeight.bold),
                ),
                onPressed: () {
                  SectionModel model = sectionList[index];
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SectionList(
                        index: index,
                        section_model: model,
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  _getOfferImage(index) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: InkWell(
        child: FadeInImage(
            fit: BoxFit.contain,
            fadeInDuration: Duration(milliseconds: 150),
            image: CachedNetworkImageProvider(offerImages[index].image!),
            width: double.maxFinite,
            imageErrorBuilder: (context, error, stackTrace) => erroWidget(50),

            // errorWidget: (context, url, e) => placeHolder(50),
            placeholder: AssetImage(
              "assets/images/sliderph.png",
            )),
        onTap: () {
          if (offerImages[index].type == "products") {
            Product? item = offerImages[index].list;

            Navigator.push(
              context,
              PageRouteBuilder(
                  //transitionDuration: Duration(seconds: 1),
                  pageBuilder: (_, __, ___) =>
                      ProductDetail(model: item, secPos: 0, index: 0, list: true
                          //  title: sectionList[secPos].title,
                          )),
            );
          } else if (offerImages[index].type == "categories") {
            Product item = offerImages[index].list;
            if (item.subList == null || item.subList!.length == 0) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProductList(
                    name: item.name,
                    id: item.id,
                    tag: false,
                    fromSeller: false,
                  ),
                ),
              );
            } else {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SubCategory(
                    title: item.name!,
                    subList: item.subList,
                  ),
                ),
              );
            }
          }
        },
      ),
    );
  }

  _getSection(int i) {
    var orient = MediaQuery.of(context).orientation;

    return sectionList[i].style == DEFAULT
        ? Padding(
            padding: const EdgeInsets.all(15.0),
            child: GridView.count(
              // mainAxisSpacing: 12,
              // crossAxisSpacing: 12,
              padding: EdgeInsetsDirectional.only(top: 5),
              crossAxisCount: 2,
              shrinkWrap: true,
              childAspectRatio: 0.750,

              //  childAspectRatio: 1.0,
              physics: NeverScrollableScrollPhysics(),
              children:
                  //  [
                  //   Container(height: 500, width: 1200, color: Colors.red),
                  //   Text("hello"),
                  //   Container(height: 10, width: 50, color: Colors.green),
                  // ]
                  List.generate(
                sectionList[i].productList!.length < 4
                    ? sectionList[i].productList!.length
                    : 4,
                (index) {
                  // return Container(
                  //   width: 600,
                  //   height: 50,
                  //   color: Colors.red,
                  // );

                  return productItem(i, index, index % 2 == 0 ? true : false);
                },
              ),
            ),
          )
        : sectionList[i].style == STYLE1
            ? sectionList[i].productList!.length > 0
                ? Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                      children: [
                        Flexible(
                            flex: 3,
                            fit: FlexFit.loose,
                            child: Container(
                                height: orient == Orientation.portrait
                                    ? deviceHeight! * 0.4
                                    : deviceHeight!,
                                child: productItem(i, 0, true))),
                        Flexible(
                          flex: 2,
                          fit: FlexFit.loose,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                  height: orient == Orientation.portrait
                                      ? deviceHeight! * 0.2
                                      : deviceHeight! * 0.5,
                                  child: productItem(i, 1, false)),
                              Container(
                                  height: orient == Orientation.portrait
                                      ? deviceHeight! * 0.2
                                      : deviceHeight! * 0.5,
                                  child: productItem(i, 2, false)),
                            ],
                          ),
                        ),
                      ],
                    ))
                : Container()
            : sectionList[i].style == STYLE2
                ? Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                      children: [
                        Flexible(
                          flex: 2,
                          fit: FlexFit.loose,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                  height: orient == Orientation.portrait
                                      ? deviceHeight! * 0.2
                                      : deviceHeight! * 0.5,
                                  child: productItem(i, 0, true)),
                              Container(
                                  height: orient == Orientation.portrait
                                      ? deviceHeight! * 0.2
                                      : deviceHeight! * 0.5,
                                  child: productItem(i, 1, true)),
                            ],
                          ),
                        ),
                        Flexible(
                            flex: 3,
                            fit: FlexFit.loose,
                            child: Container(
                                height: orient == Orientation.portrait
                                    ? deviceHeight! * 0.4
                                    : deviceHeight,
                                child: productItem(i, 2, false))),
                      ],
                    ))
                : sectionList[i].style == STYLE3
                    ? Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Flexible(
                                flex: 1,
                                fit: FlexFit.loose,
                                child: Container(
                                    height: orient == Orientation.portrait
                                        ? deviceHeight! * 0.3
                                        : deviceHeight! * 0.6,
                                    child: productItem(i, 0, false))),
                            Container(
                              height: orient == Orientation.portrait
                                  ? deviceHeight! * 0.2
                                  : deviceHeight! * 0.5,
                              child: Row(
                                children: [
                                  Flexible(
                                      flex: 1,
                                      fit: FlexFit.loose,
                                      child: productItem(i, 1, true)),
                                  Flexible(
                                      flex: 1,
                                      fit: FlexFit.loose,
                                      child: productItem(i, 2, true)),
                                  Flexible(
                                      flex: 1,
                                      fit: FlexFit.loose,
                                      child: productItem(i, 3, false)),
                                ],
                              ),
                            ),
                          ],
                        ))
                    : sectionList[i].style == STYLE4
                        ? Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Flexible(
                                    flex: 1,
                                    fit: FlexFit.loose,
                                    child: Container(
                                        height: orient == Orientation.portrait
                                            ? deviceHeight! * 0.25
                                            : deviceHeight! * 0.5,
                                        child: productItem(i, 0, false))),
                                Container(
                                  height: orient == Orientation.portrait
                                      ? deviceHeight! * 0.2
                                      : deviceHeight! * 0.5,
                                  child: Row(
                                    children: [
                                      Flexible(
                                          flex: 1,
                                          fit: FlexFit.loose,
                                          child: productItem(i, 1, true)),
                                      Flexible(
                                          flex: 1,
                                          fit: FlexFit.loose,
                                          child: productItem(i, 2, false)),
                                    ],
                                  ),
                                ),
                              ],
                            ))
                        : Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: GridView.count(
                                padding: EdgeInsetsDirectional.only(top: 5),
                                crossAxisCount: 2,
                                shrinkWrap: true,
                                childAspectRatio: 1.2,
                                physics: NeverScrollableScrollPhysics(),
                                mainAxisSpacing: 0,
                                crossAxisSpacing: 0,
                                children: List.generate(
                                  sectionList[i].productList!.length < 6
                                      ? sectionList[i].productList!.length
                                      : 6,
                                  (index) {
                                    return productItem(i, index,
                                        index % 2 == 0 ? true : false);
                                  },
                                )));
  }

  Widget productItem(int secPos, int index, bool pad) {
    if (sectionList[secPos].productList!.length > index) {
      String? offPer;
      double price = double.parse(
          sectionList[secPos].productList![index].prVarientList![0].disPrice!);
      if (price == 0) {
        price = double.parse(
            sectionList[secPos].productList![index].prVarientList![0].price!);
      } else {
        double off = double.parse(sectionList[secPos]
                .productList![index]
                .prVarientList![0]
                .price!) -
            price;
        offPer = ((off * 100) /
                double.parse(sectionList[secPos]
                    .productList![index]
                    .prVarientList![0]
                    .price!))
            .toStringAsFixed(2);
      }

      double width = deviceWidth! * 0.5;

      return Card(
        elevation: 0.0,

        margin: EdgeInsetsDirectional.only(bottom: 2, end: 2),
        //end: pad ? 5 : 0),
        child: InkWell(
          borderRadius: BorderRadius.circular(4),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                /*       child: ClipRRect(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(5),
                        topRight: Radius.circular(5)),
                    child: Hero(
                      tag:
                      "${sectionList[secPos].productList![index].id}$secPos$index",
                      child: FadeInImage(
                        fadeInDuration: Duration(milliseconds: 150),
                        image: NetworkImage(
                            sectionList[secPos].productList![index].image!),
                        height: double.maxFinite,
                        width: double.maxFinite,
                        fit: extendImg ? BoxFit.fill : BoxFit.contain,
                        imageErrorBuilder: (context, error, stackTrace) =>
                            erroWidget(width),

                        // errorWidget: (context, url, e) => placeHolder(width),
                        placeholder: placeHolder(width),
                      ),
                    )),*/
                child: Stack(
                  alignment: Alignment.topRight,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(5),
                          topRight: Radius.circular(5)),
                      child: Hero(
                        transitionOnUserGestures: true,
                        tag:
                            "${sectionList[secPos].productList![index].id}$secPos$index",
                        child: FadeInImage(
                          fadeInDuration: Duration(milliseconds: 150),
                          image: CachedNetworkImageProvider(
                              sectionList[secPos].productList![index].image!),
                          height: double.maxFinite,
                          width: double.maxFinite,
                          imageErrorBuilder: (context, error, stackTrace) =>
                              erroWidget(double.maxFinite),
                          fit: BoxFit.contain,
                          placeholder: placeHolder(width),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.only(
                  start: 5.0,
                  top: 3,
                ),
                child: Text(
                  sectionList[secPos].productList![index].name!,
                  style: Theme.of(context).textTheme.caption!.copyWith(
                      color: Theme.of(context).colorScheme.lightBlack),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Text(
                " " + CUR_CURRENCY! + " " + price.toString(),
                style: TextStyle(
                  color: Theme.of(context).colorScheme.fontColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.only(
                    start: 5.0, bottom: 5, top: 3),
                child: double.parse(sectionList[secPos]
                            .productList![index]
                            .prVarientList![0]
                            .disPrice!) !=
                        0
                    ? Row(
                        children: <Widget>[
                          Text(
                            double.parse(sectionList[secPos]
                                        .productList![index]
                                        .prVarientList![0]
                                        .disPrice!) !=
                                    0
                                ? CUR_CURRENCY! +
                                    "" +
                                    sectionList[secPos]
                                        .productList![index]
                                        .prVarientList![0]
                                        .price!
                                : "",
                            style: Theme.of(context)
                                .textTheme
                                .overline!
                                .copyWith(
                                    decoration: TextDecoration.lineThrough,
                                    letterSpacing: 0),
                          ),
                          Flexible(
                            child: Text(" | " + "-$offPer%",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context)
                                    .textTheme
                                    .overline!
                                    .copyWith(
                                        color: colors.primary,
                                        letterSpacing: 0)),
                          ),
                        ],
                      )
                    : Container(
                        height: 5,
                      ),
              )
            ],
          ),
          onTap: () {
            Product model = sectionList[secPos].productList![index];
            Navigator.push(
              context,
              PageRouteBuilder(
                // transitionDuration: Duration(milliseconds: 150),
                pageBuilder: (_, __, ___) => ProductDetail(
                    model: model, secPos: secPos, index: index, list: false
                    //  title: sectionList[secPos].title,
                    ),
              ),
            );
          },
        ),
      );
    } else
      return Container();
  }

  _section() {
    return Selector<HomeProvider, bool>(
      builder: (context, data, child) {
        return data
            ? Container(
                width: double.infinity,
                child: Shimmer.fromColors(
                  baseColor: Theme.of(context).colorScheme.simmerBase,
                  highlightColor: Theme.of(context).colorScheme.simmerHigh,
                  child: sectionLoading(),
                ),
              )
            : ListView.builder(
                padding: EdgeInsets.all(0),
                itemCount: sectionList.length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  print("here");
                  return _singleSection(index);
                },
              );
      },
      selector: (_, homeProvider) => homeProvider.secLoading,
    );
  }

  subCatItem(List<Product> subList, int index, BuildContext context) {
    return GestureDetector(
      child: Column(
        children: <Widget>[
          Expanded(
              child: Card(
            elevation: 4,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  image: DecorationImage(
                      fit: BoxFit.contain,
                      image: NetworkImage('${catList[index].image!}'))),
              // child: FadeInImage(
              //   image: CachedNetworkImageProvider(subList[index].image!),
              //   fadeInDuration: Duration(milliseconds: 150),
              //   fit: BoxFit.cover,
              //   imageErrorBuilder: (context, error, stackTrace) =>
              //       erroWidget(50),
              //   placeholder: placeHolder(50),
              // ),
            ),
          )),
          Text(
            subList[index].name! + "\n",
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context)
                .textTheme
                .caption!
                .copyWith(color: Theme.of(context).colorScheme.fontColor),
          )
        ],
      ),
      onTap: () {
        if (context.read<CategoryProvider>().curCat == 0 &&
            popularList.length > 0) {
          if (popularList[index].subList == null ||
              popularList[index].subList!.length == 0) {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProductList(
                    name: popularList[index].name,
                    id: popularList[index].id,
                    tag: false,
                    fromSeller: false,
                  ),
                ));
          } else {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SubCategory(
                    subList: popularList[index].subList,
                    title: popularList[index].name ?? "",
                    catId: popularList[index].id,
                  ),
                ));
          }
        } else if (subList[index].subList == null ||
            subList[index].subList!.length == 0) {
          print(StackTrace.current);
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProductList(
                  name: subList[index].name,
                  id: subList[index].id,
                  tag: false,
                  fromSeller: false,
                ),
              ));
        } else {
          print(StackTrace.current);
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SubCategory(
                  subList: subList[index].subList,
                  title: subList[index].name ?? "",
                ),
              ));
        }
      },
    );
  }

  _catList() {
    return Selector<HomeProvider, bool>(
      builder: (context, data, child) {
        return data
            ? Container(
                width: double.infinity,
                child: Shimmer.fromColors(
                    baseColor: Theme.of(context).colorScheme.simmerBase,
                    highlightColor: Theme.of(context).colorScheme.simmerHigh,
                    child: catLoading()),
              )
            : Padding(
                padding: const EdgeInsets.all(5.0),
                child: Container(
                    height: MediaQuery.of(context).size.height,
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2),
                      itemCount: clients?.data?.length,
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        // catId = catList[index].id;
                        // if (index == 0)
                        //   return Container();
                        // else
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Client_form(
                                        model: clients?.data?[index])));
                          },
                          // onTap: () async {
                          //   Navigator.push(context, MaterialPageRoute(builder: (context) => AddExpenseScreen(
                          //     data: catList[index],
                          //     isUpdate: false,
                          //   ),
                          //   ),
                          //   );
                          //   // onTap: () async {
                          //   //   Navigator.push(context, MaterialPageRoute(builder: (context) => ReferForm(
                          //   //     data: catList[index],
                          //   //   )));
                          //   // if (catList[index].subList == null ||
                          //   //     catList[index].subList!.length == 0) {
                          //   //   await Navigator.push(
                          //   //       context,
                          //   //       MaterialPageRoute(
                          //   //         builder: (context) => ProductList(
                          //   //           name: catList[index].name,
                          //   //           id: catList[index].id,
                          //   //           tag: false,
                          //   //           fromSeller: false,
                          //   //         ),
                          //   //       ));
                          //   // } else {
                          //   //   await Navigator.push(
                          //   //       context,
                          //   //       MaterialPageRoute(
                          //   //         builder: (context) => SubCategory(
                          //   //           title: catList[index].name!,
                          //   //           subList: catList[index].subList,
                          //   //           catId: catList[index].id,
                          //   //         ),
                          //   //       ));
                          //   // }
                          // },
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Container(
                              decoration: BoxDecoration(
                                  border: Border.all(color: colors.primary),
                                  borderRadius: BorderRadius.circular(5)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.all(10),
                                    child: new ClipRRect(
                                      borderRadius: BorderRadius.circular(10.0),
                                      child: new FadeInImage(
                                        fadeInDuration:
                                            Duration(milliseconds: 150),
                                        image: CachedNetworkImageProvider(
                                            "${clients?.data?[index].photo}"),
                                        height: 70.0,
                                        width: 70,
                                        fit: BoxFit.fill,
                                        imageErrorBuilder:
                                            (context, error, stackTrace) =>
                                                erroWidget(50),
                                        placeholder: placeHolder(50),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 20),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10.0, right: 10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Firm:",
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w400,
                                                  color: colors.blackTemp),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                              "Owner:",
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w400,
                                                  color: colors.blackTemp),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                              "Number:",
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w400,
                                                  color: colors.blackTemp),
                                            ),
                                          ],
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Text(
                                              "${clients?.data?[index].nameOfFirm}",
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w400,
                                                  color: colors.blackTemp,
                                                  overflow:
                                                      TextOverflow.ellipsis),
                                            ),
                                            SizedBox(height: 10),
                                            Text(
                                              "${clients?.data?[index].ownerName}",
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w400,
                                                  color: colors.blackTemp),
                                            ),
                                            SizedBox(height: 10),
                                            Text(
                                              "${clients?.data?[index].mobileOne}",
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w400,
                                                  color: colors.blackTemp),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  // Container(
                                  //   height: 40,
                                  //   decoration: BoxDecoration(
                                  //     color: colors.primary,
                                  //       borderRadius: BorderRadius.only(bottomLeft: Radius.circular(12), bottomRight: Radius.circular(12))
                                  //   ),
                                  //   width: MediaQuery.of(context).size.width,
                                  //   child: Center(
                                  //     child:
                                  //     Text(
                                  //     catList[index].name!,
                                  //     style: TextStyle(
                                  //         color: colors.whiteTemp,
                                  //         fontSize: 16, fontWeight: FontWeight.w600
                                  //     ),
                                  //     // Theme.of(context)
                                  //     //     .textTheme
                                  //     //     .bodyText1!
                                  //     //     .copyWith(
                                  //     //         color: Theme.of(context)
                                  //     //             .colorScheme
                                  //     //             .fontColor,
                                  //     //         fontWeight: FontWeight.w700,
                                  //     //         fontSize: 14),
                                  //     overflow: TextOverflow.ellipsis,
                                  //     textAlign: TextAlign.center,
                                  //   )
                                  //   ),
                                  //   // width: 50,
                                  // ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    )));
        // GridView.count(
        //     padding: EdgeInsets.symmetric(horizontal: 20),
        //     crossAxisCount: 3,
        //     shrinkWrap: true,
        //     crossAxisSpacing: 5,
        //     children: List.generate(
        //       catList.length,
        //           (index) {
        //         if (index == 0)
        //           return Container();
        //         else
        //           return GestureDetector(
        //             onTap: () async {
        //               Navigator.push(context, MaterialPageRoute(builder: (context) => ReferForm(
        //                 catId: catList[index].id.toString(),
        //               )));
        //               // if (catList[index].subList == null ||
        //               //     catList[index].subList!.length == 0) {
        //               //   await Navigator.push(
        //               //       context,
        //               //       MaterialPageRoute(
        //               //         builder: (context) => ProductList(
        //               //           name: catList[index].name,
        //               //           id: catList[index].id,
        //               //           tag: false,
        //               //           fromSeller: false,
        //               //         ),
        //               //       ));
        //               // } else {
        //               //   await Navigator.push(
        //               //       context,
        //               //       MaterialPageRoute(
        //               //         builder: (context) => SubCategory(
        //               //           title: catList[index].name!,
        //               //           subList: catList[index].subList,
        //               //           catId: catList[index].id,
        //               //         ),
        //               //       ));
        //               // }
        //             },
        //             child: Card(
        //               shape: RoundedRectangleBorder(
        //                   borderRadius: BorderRadius.circular(20)
        //               ),
        //               child: Padding(
        //                 padding: const EdgeInsets.all(10.0),
        //                 child: Column(
        //                   mainAxisAlignment: MainAxisAlignment.start,
        //                   mainAxisSize: MainAxisSize.min,
        //                   children: <Widget>[
        //                     Padding(
        //                       padding: const EdgeInsetsDirectional.only(
        //                           bottom: 5.0),
        //                       child: new ClipRRect(
        //                         borderRadius: BorderRadius.circular(100.0),
        //                         child: new FadeInImage(
        //                           fadeInDuration: Duration(milliseconds: 150),
        //                           image: CachedNetworkImageProvider(
        //                             catList[index].image!,
        //                           ),
        //                           height: 75.0,
        //                           width: 75.0,
        //                           fit: BoxFit.fill,
        //                           imageErrorBuilder:
        //                               (context, error, stackTrace) =>
        //                               erroWidget(50),
        //                           placeholder: placeHolder(50),
        //                         ),
        //                       ),
        //                     ),
        //                     const SizedBox(width: 10,),
        //                     Container(
        //                       child: Text(
        //                         catList[index].name!,
        //                         style: TextStyle(
        //                             fontSize: 16, fontWeight: FontWeight.w600
        //                         ),
        //                         // Theme.of(context)
        //                         //     .textTheme
        //                         //     .bodyText1!
        //                         //     .copyWith(
        //                         //         color: Theme.of(context)
        //                         //             .colorScheme
        //                         //             .fontColor,
        //                         //         fontWeight: FontWeight.w700,
        //                         //         fontSize: 14),
        //                         overflow: TextOverflow.ellipsis,
        //                         textAlign: TextAlign.center,
        //                       ),
        //                       // width: 50,
        //                     ),
        //                   ],
        //                 ),
        //               ),
        //             ),
        //           );
        //       },
        //     ));
      },
      selector: (_, homeProvider) => homeProvider.catLoading,
    );
    //   Selector<CategoryProvider, List<Product>>(
    //   builder: (context, data, child) {
    //     return catList.length > 0
    //         ? GridView.count(
    //         padding: EdgeInsets.symmetric(horizontal: 20),
    //         crossAxisCount: 2,
    //         shrinkWrap: true,
    //         crossAxisSpacing: 5,
    //         children: List.generate(
    //           catList.length,
    //               (index) {
    //             return subCatItem(data, index, context);
    //           },
    //         ))
    //         : Center(
    //         child:
    //         Text(getTranslated(context, 'noItem')!));
    //   },
    //   selector: (_, categoryProvider) =>
    //   categoryProvider.subList,
    // );
  }

  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }

    return result;
  }

  Future<Null> callApi() async {
    UserProvider user = Provider.of<UserProvider>(context, listen: false);
    SettingProvider setting =
        Provider.of<SettingProvider>(context, listen: false);

    user.setUserId(setting.userId);

    _isNetworkAvail = await isNetworkAvailable();
    if (_isNetworkAvail) {
      getClients();
      getPermission();
      getSetting();
      getSlider();
      getCat();
      getUserCheckInStatus();
      // getSeller();
      // getSection();
      getOfferImages();
      setCatid();
    } else {
      if (mounted)
        setState(() {
          _isNetworkAvail = false;
        });
    }
    return null;
  }

  Future _getFav() async {
    _isNetworkAvail = await isNetworkAvailable();
    if (_isNetworkAvail) {
      if (CUR_USERID != null) {
        Map parameter = {
          USER_ID: CUR_USERID,
        };
        apiBaseHelper.postAPICall(getFavApi, parameter).then((getdata) {
          bool error = getdata["error"];
          String? msg = getdata["message"];
          if (!error) {
            var data = getdata["data"];

            List<Product> tempList = (data as List)
                .map((data) => new Product.fromJson(data))
                .toList();

            context.read<FavoriteProvider>().setFavlist(tempList);
          } else {
            if (msg != 'No Favourite(s) Product Are Added')
              setSnackbar(msg!, context);
          }

          context.read<FavoriteProvider>().setLoading(false);
        }, onError: (error) {
          setSnackbar(error.toString(), context);
          context.read<FavoriteProvider>().setLoading(false);
        });
      } else {
        context.read<FavoriteProvider>().setLoading(false);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LoginPage()),
        );
      }
    } else {
      if (mounted)
        setState(() {
          _isNetworkAvail = false;
        });
    }
  }

  void getOfferImages() {
    Map parameter = Map();

    apiBaseHelper.postAPICall(getOfferImageApi, parameter).then((getdata) {
      bool error = getdata["error"];
      String? msg = getdata["message"];
      if (!error) {
        var data = getdata["data"];
        offerImages.clear();
        offerImages =
            (data as List).map((data) => new Model.fromSlider(data)).toList();
      } else {
        setSnackbar(msg!, context);
      }

      context.read<HomeProvider>().setOfferLoading(false);
    }, onError: (error) {
      setSnackbar(error.toString(), context);
      context.read<HomeProvider>().setOfferLoading(false);
    });
  }

  void getSection() {
    Map parameter = {PRODUCT_LIMIT: "6", PRODUCT_OFFSET: "0"};

    if (CUR_USERID != null) parameter[USER_ID] = CUR_USERID!;
    String curPin = context.read<UserProvider>().curPincode;
    if (curPin != '') parameter[ZIPCODE] = curPin;

    apiBaseHelper.postAPICall(getSectionApi, parameter).then((getdata) {
      bool error = getdata["error"];
      String? msg = getdata["message"];
      sectionList.clear();
      if (!error) {
        var data = getdata["data"];

        sectionList = (data as List)
            .map((data) => new SectionModel.fromJson(data))
            .toList();
      } else {
        if (curPin != '') context.read<UserProvider>().setPincode('');
        setSnackbar(msg!, context);
      }

      context.read<HomeProvider>().setSecLoading(false);
    }, onError: (error) {
      setSnackbar(error.toString(), context);
      context.read<HomeProvider>().setSecLoading(false);
    });
  }

  String? leadsCount;
  String? myEarnings;

  void getSetting() {
    CUR_USERID = context.read<SettingProvider>().userId;
    //print("")
    Map parameter = Map();
    if (CUR_USERID != null) parameter = {USER_ID: CUR_USERID};

    apiBaseHelper.postAPICall(getSettingApi, parameter).then((getdata) async {
      bool error = getdata["error"];
      String? msg = getdata["message"];

      if (!error) {
        var data = getdata["data"]["system_settings"][0];
        cartBtnList = data["cart_btn_on_list"] == "1" ? true : false;
        refer = data["is_refer_earn_on"] == "1" ? true : false;
        CUR_CURRENCY = data["currency"];
        RETURN_DAYS = data['max_product_return_days'];
        MAX_ITEMS = data["max_items_cart"];
        MIN_AMT = data['min_amount'];
        CUR_DEL_CHR = data['delivery_charge'];
        String? isVerion = data['is_version_system_on'];
        extendImg = data["expand_product_images"] == "1" ? true : false;
        String? del = data["area_wise_delivery_charge"];
        MIN_ALLOW_CART_AMT = data[MIN_CART_AMT];

        if (del == "0")
          ISFLAT_DEL = true;
        else
          ISFLAT_DEL = false;

        if (CUR_USERID != null) {
          REFER_CODE = getdata['data']['user_data'][0]['referral_code'];

          context
              .read<UserProvider>()
              .setPincode(getdata["data"]["user_data"][0][PINCODE]);

          if (REFER_CODE == null || REFER_CODE == '' || REFER_CODE!.isEmpty)
            generateReferral();

          context.read<UserProvider>().setCartCount(
              getdata["data"]["user_data"][0]["cart_total_items"].toString());
          context
              .read<UserProvider>()
              .setBalance(getdata["data"]["user_data"][0]["balance"]);
          leadsCount = getdata["data"]["total_leads"];
          myEarnings = getdata["data"]["user_data"][0]["balance"];

          _getFav();
          _getCart("0");
        }

        UserProvider user = Provider.of<UserProvider>(context, listen: false);
        SettingProvider setting =
            Provider.of<SettingProvider>(context, listen: false);
        user.setMobile(setting.mobile);
        user.setName(setting.userName);
        user.setEmail(setting.email);
        user.setProfilePic(setting.profileUrl);

        Map<String, dynamic> tempData = getdata["data"];
        if (tempData.containsKey(TAG))
          tagList = List<String>.from(getdata["data"][TAG]);

        if (isVerion == "1") {
          String? verionAnd = data['current_version'];
          String? verionIOS = data['current_version_ios'];

          PackageInfo packageInfo = await PackageInfo.fromPlatform();

          String version = packageInfo.version;

          final Version currentVersion = Version.parse(version);
          final Version latestVersionAnd = Version.parse(verionAnd);
          final Version latestVersionIos = Version.parse(verionIOS);

          if ((Platform.isAndroid && latestVersionAnd > currentVersion) ||
              (Platform.isIOS && latestVersionIos > currentVersion))
            updateDailog();
        }
      } else {
        setSnackbar(msg!, context);
      }
    }, onError: (error) {
      setSnackbar(error.toString(), context);
    });
  }

  Future<void> _getCart(String save) async {
    _isNetworkAvail = await isNetworkAvailable();

    if (_isNetworkAvail) {
      try {
        var parameter = {USER_ID: CUR_USERID, SAVE_LATER: save};

        Response response =
            await post(getCartApi, body: parameter, headers: headers)
                .timeout(Duration(seconds: timeOut));

        var getdata = json.decode(response.body);
        bool error = getdata["error"];
        String? msg = getdata["message"];
        if (!error) {
          var data = getdata["data"];

          List<SectionModel> cartList = (data as List)
              .map((data) => new SectionModel.fromCart(data))
              .toList();
          context.read<CartProvider>().setCartlist(cartList);
        }
      } on TimeoutException catch (_) {}
    } else {
      if (mounted)
        setState(() {
          _isNetworkAvail = false;
        });
    }
  }

  final _chars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  Random _rnd = Random();

  String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
      length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

  Future<Null> generateReferral() async {
    String refer = getRandomString(8);

    //////

    Map parameter = {
      REFERCODE: refer,
    };

    apiBaseHelper.postAPICall(validateReferalApi, parameter).then((getdata) {
      bool error = getdata["error"];
      String? msg = getdata["message"];
      if (!error) {
        REFER_CODE = refer;

        Map parameter = {
          USER_ID: CUR_USERID,
          REFERCODE: refer,
        };

        apiBaseHelper.postAPICall(getUpdateUserApi, parameter);
      } else {
        if (count < 5) generateReferral();
        count++;
      }

      context.read<HomeProvider>().setSecLoading(false);
    }, onError: (error) {
      setSnackbar(error.toString(), context);
      context.read<HomeProvider>().setSecLoading(false);
    });
  }

  updateDailog() async {
    await dialogAnimate(context,
        StatefulBuilder(builder: (BuildContext context, StateSetter setStater) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(5.0))),
        title: Text(getTranslated(context, 'UPDATE_APP')!),
        content: Text(
          getTranslated(context, 'UPDATE_AVAIL')!,
          style: Theme.of(this.context)
              .textTheme
              .subtitle1!
              .copyWith(color: Theme.of(context).colorScheme.fontColor),
        ),
        actions: <Widget>[
          new TextButton(
              child: Text(
                getTranslated(context, 'NO')!,
                style: Theme.of(this.context).textTheme.subtitle2!.copyWith(
                    color: Theme.of(context).colorScheme.lightBlack,
                    fontWeight: FontWeight.bold),
              ),
              onPressed: () {
                Navigator.of(context).pop(false);
              }),
          new TextButton(
              child: Text(
                getTranslated(context, 'YES')!,
                style: Theme.of(this.context).textTheme.subtitle2!.copyWith(
                    color: Theme.of(context).colorScheme.fontColor,
                    fontWeight: FontWeight.bold),
              ),
              onPressed: () async {
                Navigator.of(context).pop(false);

                String _url = '';
                if (Platform.isAndroid) {
                  _url = androidLink + packageName;
                } else if (Platform.isIOS) {
                  _url = iosLink;
                }

                if (await canLaunch(_url)) {
                  await launch(_url);
                } else {
                  throw 'Could not launch $_url';
                }
              })
        ],
      );
    }));
  }

  Widget homeShimmer() {
    return Container(
      width: double.infinity,
      child: Shimmer.fromColors(
        baseColor: Theme.of(context).colorScheme.simmerBase,
        highlightColor: Theme.of(context).colorScheme.simmerHigh,
        child: SingleChildScrollView(
            child: Column(
          children: [
            catLoading(),
            sliderLoading(),
            sectionLoading(),
          ],
        )),
      ),
    );
  }

  Widget sliderLoading() {
    double width = deviceWidth!;
    double height = width / 2;
    return Shimmer.fromColors(
        baseColor: Theme.of(context).colorScheme.simmerBase,
        highlightColor: Theme.of(context).colorScheme.simmerHigh,
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 10),
          width: double.infinity,
          height: height,
          color: Theme.of(context).colorScheme.white,
        ));
  }

  Widget _buildImagePageItem(Model slider) {
    double height = deviceWidth! / 0.5;

    return GestureDetector(
      child: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
        child: FadeInImage(
            fadeInDuration: Duration(milliseconds: 150),
            image: CachedNetworkImageProvider(slider.image!),
            height: height,
            width: double.maxFinite,
            fit: BoxFit.contain,
            imageErrorBuilder: (context, error, stackTrace) => Image.asset(
                  "assets/images/sliderph.png",
                  fit: BoxFit.contain,
                  height: height,
                  color: colors.primary,
                ),
            placeholderErrorBuilder: (context, error, stackTrace) =>
                Image.asset(
                  "assets/images/sliderph.png",
                  fit: BoxFit.contain,
                  height: height,
                  color: colors.primary,
                ),
            placeholder: AssetImage(imagePath + "splash1.png")),
      ),
      onTap: () async {
        int curSlider = context.read<HomeProvider>().curSlider;
        // if (homeSliderList[curSlider].type == "products") {
        //   Product? item = homeSliderList[curSlider].list;
        //
        //   Navigator.push(
        //     context,
        //     PageRouteBuilder(
        //         pageBuilder: (_, __, ___) => ProductDetail(
        //             model: item, secPos: 0, index: 0, list: true)),
        //   );
        // } else if (homeSliderList[curSlider].type == "categories") {
        //   Product item = homeSliderList[curSlider].list;
        //   if (item.subList == null || item.subList!.length == 0) {
        //     Navigator.push(
        //         context,
        //         MaterialPageRoute(
        //           builder: (context) => ProductList(
        //             name: item.name,
        //             id: item.id,
        //             tag: false,
        //             fromSeller: false,
        //           ),
        //         ));
        //   } else {
        //     Navigator.push(
        //         context,
        //         MaterialPageRoute(
        //           builder: (context) => SubCategory(
        //             title: item.name!,
        //             subList: item.subList,
        //           ),
        //         ));
        //   }
        // }
      },
    );
  }

  Widget deliverLoading() {
    return Shimmer.fromColors(
        baseColor: Theme.of(context).colorScheme.simmerBase,
        highlightColor: Theme.of(context).colorScheme.simmerHigh,
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          width: double.infinity,
          height: 18.0,
          color: Theme.of(context).colorScheme.white,
        ));
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

  Widget noInternet(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          noIntImage(),
          noIntText(context),
          noIntDec(context),
          AppBtn(
            title: getTranslated(context, 'TRY_AGAIN_INT_LBL'),
            btnAnim: buttonSqueezeanimation,
            btnCntrl: buttonController,
            onBtnSelected: () async {
              context.read<HomeProvider>().setCatLoading(true);
              context.read<HomeProvider>().setSecLoading(true);
              context.read<HomeProvider>().setSliderLoading(true);
              _playAnimation();

              Future.delayed(Duration(seconds: 2)).then((_) async {
                _isNetworkAvail = await isNetworkAvailable();
                if (_isNetworkAvail) {
                  if (mounted)
                    setState(() {
                      _isNetworkAvail = true;
                    });
                  callApi();
                } else {
                  await buttonController.reverse();
                  if (mounted) setState(() {});
                }
              });
            },
          )
        ]),
      ),
    );
  }

  _deliverPincode() {
    // String curpin = context.read<UserProvider>().curPincode;
    return GestureDetector(
      child: Container(
        // padding: EdgeInsets.symmetric(vertical: 8),
        color: Theme.of(context).colorScheme.white,
        child: ListTile(
          dense: true,
          minLeadingWidth: 10,
          leading: Icon(
            Icons.location_pin,
          ),
          title: Selector<UserProvider, String>(
            builder: (context, data, child) {
              return Text(
                data == ''
                    ? getTranslated(context, 'SELOC')!
                    : getTranslated(context, 'DELIVERTO')! + data,
                style:
                    TextStyle(color: Theme.of(context).colorScheme.fontColor),
              );
            },
            selector: (_, provider) => provider.curPincode,
          ),
          trailing: Icon(Icons.keyboard_arrow_right),
        ),
      ),
      onTap: _pincodeCheck,
    );
  }

  void _pincodeCheck() {
    showModalBottomSheet<dynamic>(
        context: context,
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25), topRight: Radius.circular(25))),
        builder: (builder) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return Container(
              constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height * 0.9),
              child: ListView(shrinkWrap: true, children: [
                Padding(
                    padding: const EdgeInsets.only(
                        left: 20.0, right: 20, bottom: 40, top: 30),
                    child: Padding(
                      padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom),
                      child: Form(
                          key: _formkey,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Align(
                                alignment: Alignment.topRight,
                                child: InkWell(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: Icon(Icons.close),
                                ),
                              ),
                              TextFormField(
                                keyboardType: TextInputType.text,
                                textCapitalization: TextCapitalization.words,
                                validator: (val) => validatePincode(val!,
                                    getTranslated(context, 'PIN_REQUIRED')),
                                onSaved: (String? value) {
                                  context
                                      .read<UserProvider>()
                                      .setPincode(value!);
                                },
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle2!
                                    .copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .fontColor),
                                decoration: InputDecoration(
                                  isDense: true,
                                  prefixIcon: Icon(Icons.location_on),
                                  hintText:
                                      getTranslated(context, 'PINCODEHINT_LBL'),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Row(
                                  children: [
                                    Container(
                                      margin:
                                          EdgeInsetsDirectional.only(start: 20),
                                      width: deviceWidth! * 0.35,
                                      child: OutlinedButton(
                                        onPressed: () {
                                          context
                                              .read<UserProvider>()
                                              .setPincode('');

                                          context
                                              .read<HomeProvider>()
                                              .setSecLoading(true);
                                          getSection();
                                          Navigator.pop(context);
                                        },
                                        child: Text(
                                            getTranslated(context, 'All')!),
                                      ),
                                    ),
                                    Spacer(),
                                    SimBtn(
                                        size: 0.35,
                                        title: getTranslated(context, 'APPLY'),
                                        onBtnSelected: () async {
                                          if (validateAndSave()) {
                                            // validatePin(curPin);
                                            context
                                                .read<HomeProvider>()
                                                .setSecLoading(true);
                                            getSection();

                                            context
                                                .read<HomeProvider>()
                                                .setSellerLoading(true);
                                            // getSeller();

                                            Navigator.pop(context);
                                          }
                                        }),
                                  ],
                                ),
                              ),
                            ],
                          )),
                    ))
              ]),
            );
            //});
          });
        });
  }

  bool validateAndSave() {
    final form = _formkey.currentState!;

    form.save();
    if (form.validate()) {
      return true;
    }
    return false;
  }

  Future<Null> _playAnimation() async {
    try {
      await buttonController.forward();
    } on TickerCanceled {}
  }

  void getSlider() {
    Map map = Map();

    apiBaseHelper.postAPICall(getSliderApi, map).then((getdata) {
      bool error = getdata["error"];
      String? msg = getdata["message"];
      if (!error) {
        var data = getdata["data"];

        homeSliderList =
            (data as List).map((data) => new Model.fromSlider(data)).toList();
        pages = homeSliderList.map((slider) {
          return _buildImagePageItem(slider);
        }).toList();
      } else {
        setSnackbar(msg!, context);
      }
      context.read<HomeProvider>().setSliderLoading(false);
    }, onError: (error) {
      setSnackbar(error.toString(), context);
      context.read<HomeProvider>().setSliderLoading(false);
    });
  }

  void getCat() {
    Map parameter = {
      // CAT_FILTER: "false",
    };
    apiBaseHelper.postAPICall(getCatApi, parameter).then((getdata) {
      print(getCatApi.toString());
      print(parameter.toString());
      bool error = getdata["error"];
      String? msg = getdata["message"];
      if (!error) {
        var data = getdata["data"];
        catList =
            (data as List).map((data) => new Product.fromCat(data)).toList();
        if (getdata.containsKey("popular_categories")) {
          var data = getdata["popular_categories"];
          popularList =
              (data as List).map((data) => new Product.fromCat(data)).toList();
          if (popularList.length > 0) {
            Product pop =
                new Product.popular("Popular", imagePath + "popular.svg");
            catList.insert(0, pop);

            context.read<CategoryProvider>().setSubList(popularList);
          }
        }
      } else {
        setSnackbar(msg!, context);
      }

      context.read<HomeProvider>().setCatLoading(false);
    }, onError: (error) {
      setSnackbar(error.toString(), context);
      context.read<HomeProvider>().setCatLoading(false);
    });
  }

  sectionLoading() {
    return Column(
        children: [0, 1, 2, 3, 4]
            .map((_) => Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Stack(
                        children: [
                          Positioned.fill(
                            child: Container(
                              margin: EdgeInsets.only(bottom: 40),
                              decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.white,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(20),
                                ),
                              ),
                            ),
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 5),
                                width: double.infinity,
                                height: 18.0,
                                color: Theme.of(context).colorScheme.white,
                              ),
                              GridView.count(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                                crossAxisCount: 2,
                                shrinkWrap: true,
                                childAspectRatio: 1.0,
                                physics: NeverScrollableScrollPhysics(),
                                mainAxisSpacing: 5,
                                crossAxisSpacing: 5,
                                children: List.generate(
                                  4,
                                  (index) {
                                    return Container(
                                      width: double.infinity,
                                      height: double.infinity,
                                      color:
                                          Theme.of(context).colorScheme.white,
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    sliderLoading()
                    //offerImages.length > index ? _getOfferImage(index) : Container(),
                  ],
                ))
            .toList());
  }

  void getSeller() {
    String pin = context.read<UserProvider>().curPincode;
    Map parameter = {};
    if (pin != '') {
      parameter = {
        ZIPCODE: pin,
      };
    }
    apiBaseHelper.postAPICall(getSellerApi, parameter).then((getdata) {
      bool error = getdata["error"];
      String? msg = getdata["message"];
      if (!error) {
        var data = getdata["data"];

        sellerList =
            (data as List).map((data) => new Product.fromSeller(data)).toList();
      } else {
        setSnackbar(msg!, context);
      }

      context.read<HomeProvider>().setSellerLoading(false);
    }, onError: (error) {
      setSnackbar(error.toString(), context);
      context.read<HomeProvider>().setSellerLoading(false);
    });
  }

  _seller() {
    return Selector<HomeProvider, bool>(
      builder: (context, data, child) {
        return data
            ? Container(
                width: double.infinity,
                child: Shimmer.fromColors(
                    baseColor: Theme.of(context).colorScheme.simmerBase,
                    highlightColor: Theme.of(context).colorScheme.simmerHigh,
                    child: catLoading()))
            : Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(getTranslated(context, 'SHOP_BY_SELLER')!,
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.fontColor,
                                fontWeight: FontWeight.bold)),
                        GestureDetector(
                          child: Text(getTranslated(context, 'VIEW_ALL')!),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SellerList()));
                          },
                        )
                      ],
                    ),
                  ),
                  Container(
                    height: 100,
                    padding: const EdgeInsets.only(top: 10, left: 10),
                    child: ListView.builder(
                      itemCount: sellerList.length,
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      physics: AlwaysScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsetsDirectional.only(end: 10),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SellerProfile(
                                            sellerStoreName:
                                                sellerList[index].store_name ??
                                                    "",
                                            sellerRating: sellerList[index]
                                                    .seller_rating ??
                                                "",
                                            sellerImage: sellerList[index]
                                                    .seller_profile ??
                                                "",
                                            sellerName:
                                                sellerList[index].seller_name ??
                                                    "",
                                            sellerID:
                                                sellerList[index].seller_id,
                                            storeDesc: sellerList[index]
                                                .store_description,
                                          )));
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsetsDirectional.only(
                                      bottom: 5.0),
                                  child: new ClipRRect(
                                    borderRadius: BorderRadius.circular(25.0),
                                    child: new FadeInImage(
                                      fadeInDuration:
                                          Duration(milliseconds: 150),
                                      image: CachedNetworkImageProvider(
                                        sellerList[index].seller_profile!,
                                      ),
                                      height: 50.0,
                                      width: 50.0,
                                      fit: BoxFit.contain,
                                      imageErrorBuilder:
                                          (context, error, stackTrace) =>
                                              erroWidget(50),
                                      placeholder: placeHolder(50),
                                    ),
                                  ),
                                ),
                                Container(
                                  child: Text(
                                    sellerList[index].seller_name!,
                                    style: Theme.of(context)
                                        .textTheme
                                        .caption!
                                        .copyWith(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .fontColor,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 10),
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.center,
                                  ),
                                  width: 50,
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              );
      },
      selector: (_, homeProvider) => homeProvider.sellerLoading,
    );
  }
}
