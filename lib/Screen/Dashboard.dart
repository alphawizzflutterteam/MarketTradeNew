import 'dart:async';
import 'dart:convert';

import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:omega_employee_management/Helper/Color.dart';
import 'package:omega_employee_management/Helper/Constant.dart';
import 'package:omega_employee_management/Helper/Session.dart';
import 'package:omega_employee_management/Helper/String.dart';
import 'package:omega_employee_management/Model/Section_Model.dart';
import 'package:omega_employee_management/Screen/Login.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Add_Address.dart';
import 'HomePage.dart';
import 'myprofile.dart';

class Dashboard extends StatefulWidget {
  final int? selectedIndex;
  const Dashboard({Key? key, this.selectedIndex}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<Dashboard> with TickerProviderStateMixin {
  int _selBottom = 0;
  late TabController _tabController;
  bool _isNetworkAvail = true;

  @override
  void initState() {
    getUserCheckInStatus();
    locationTimeUpdate();
    // debugPrint("mmmmm"+(DateTime.now().minute).toString());
    // Navigator.push(context,
    //     MaterialPageRoute(
    //       builder: (context) => CheckOutScreen(),
    //     ));
    // if(DateTime.now().hour.toString() == "21" && DateTime.now().minute.toString() == "1"){
    //   Navigator.push(context,
    //                   MaterialPageRoute(
    //                     builder: (context) => CheckOutScreen(),
    //                   ));
    // }
    getCurrentLoc();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.top, SystemUiOverlay.bottom]);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ));
    super.initState();
    initDynamicLinks();
    _tabController = TabController(
      length: 2,
      vsync: this,
    );
    if (widget.selectedIndex != null) {
      setState(() {
        _selBottom = widget.selectedIndex!;
      });
    }

    // final pushNotificationService = PushNotificationService(
    //     context: context, tabController: _tabController);
    // pushNotificationService.initialise();

    _tabController.addListener(
      () {
        // Future.delayed(Duration(seconds: 0)).then(
        //   (value) {
        //     if (_tabController.index == 3) {
        //       if (CUR_USERID == null) {
        //         Navigator.push(
        //           context,
        //           MaterialPageRoute(
        //             builder: (context) => LoginPage(),
        //           ),
        //         );
        //         _tabController.animateTo(0);
        //       }
        //     }
        //   },
        // );
        setState(
          () {
            _selBottom = _tabController.index;
          },
        );
      },
    );
  }

  var pinController = TextEditingController();
  var currentAddress = TextEditingController();

  getCurrentLoc() async {
    LocationPermission permission;
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      print("checking permission here ${permission}");
      if (permission == LocationPermission.deniedForever) {
        return Future.error('Location Not Available');
      }
    }
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    // var loc = Provider.of<LocationProvider>(context, listen: false);
    latitude = position.latitude.toString();
    longitude = position.longitude.toString();
    setState(() {
      longitude_Global = latitude;
      lattitudee_Global = longitude;
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
          currentlocation_Global = currentAddress.text.toString();
        });
        print('Latitudeee${latitude}');
        print('Longitudee${longitude}');

        print('Current Addresssssss${currentAddress.text}');
      });
      if (currentAddress.text == "" || currentAddress.text == null) {
      } else {
        setState(() {
          // navigateToPage();
        });
      }
    }
    updateLocationPeriodically();
  }

  String? locationTime;
  locationTimeUpdate() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    locationTime = pref.getString('location_time');
    print("location timeee ${locationTime}");
  }

  updateLocationPeriodically() {
    Timer.periodic(Duration(seconds: 30), (timer) async {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      if (position != null) {
        print("Location lat lng: ${position.latitude}, ${position.longitude}");
      }
      updateLocation();
      // if (isCheckedIn == false) {
      //
      // } else {}
    });
  }

  // Future<void> updateLiveLocationPeriodically(Duration interval) async {
  //   // Use a timer to periodically update the location
  //   Timer.periodic(interval, (Timer timer) async {
  //     Position position = await Geolocator.getCurrentPosition(
  //       desiredAccuracy: LocationAccuracy.best,
  //     );
  //     setState(() {
  //       _currentLocation = LocationData.fromPosition(position);
  //     });
  //   });
  // }

  bool? isCheckedIn;

  getUserCheckInStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? uid = prefs.getString("user_id");
    var headers = {
      'Cookie': 'ci_session=aa83f4f9d3335df625437992bb79565d0973f564'
    };
    var request = http.MultipartRequest(
      'POST',
      Uri.parse(
        getUserCheckStatusApi.toString(),
      ),
    );
    request.fields.addAll({
      USER_ID: '$uid',
    });
    print("this issss refer request in..... ${request.fields.toString()}");
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      String str = await response.stream.bytesToString();
      var result = json.decode(str);
      bool status = result['data'];
      setState(() {
        isCheckedIn = status;
      });
      print("status of user is ${status}");
    } else {
      print(response.reasonPhrase);
    }
  }

  updateLocation() async {
    var headers = {
      'Cookie': 'ci_session=62f533d7ea1e427426f49c952c6f72cc384b47c7'
    };
    var request =
        http.MultipartRequest('POST', Uri.parse(updateLiveLocation.toString()));
    request.fields.addAll({
      'lat': latitude.toString(),
      'lng': longitude.toString(),
      'user_id': '${CUR_USERID}',
      'address': '${currentAddress.text}'
    });
    print("update location parameter in dashboard ${request.fields}");
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }
  }

  void initDynamicLinks() async {
    FirebaseDynamicLinks.instance.onLink;

    final PendingDynamicLinkData? data =
        await FirebaseDynamicLinks.instance.getInitialLink();
    final Uri? deepLink = data?.link;
    if (deepLink != null) {
      if (deepLink.queryParameters.length > 0) {
        int index = int.parse(deepLink.queryParameters['index']!);

        int secPos = int.parse(deepLink.queryParameters['secPos']!);

        String? id = deepLink.queryParameters['id'];

        // String list = deepLink.queryParameters['list'];

        getProduct(id!, index, secPos, true);
      }
    }
  }

  Future<void> getProduct(String id, int index, int secPos, bool list) async {
    _isNetworkAvail = await isNetworkAvailable();
    if (_isNetworkAvail) {
      try {
        var parameter = {
          ID: id,
        };

        // if (CUR_USERID != null) parameter[USER_ID] = CUR_USERID;
        Response response =
            await post(getProductApi, headers: headers, body: parameter)
                .timeout(Duration(seconds: timeOut));

        var getdata = json.decode(response.body);
        bool error = getdata["error"];
        String msg = getdata["message"];
        if (!error) {
          var data = getdata["data"];

          List<Product> items = [];

          items =
              (data as List).map((data) => new Product.fromJson(data)).toList();

          // Navigator.of(context).push(MaterialPageRoute(
          //     builder: (context) => ProductDetail(
          //           index: list ? int.parse(id) : index,
          //           model: list
          //               ? items[0]
          //               : sectionList[secPos].productList![index],
          //           secPos: secPos,
          //           list: list,
          //         )));
        } else {
          if (msg != "Products Not Found !") setSnackbar(msg, context);
        }
      } on TimeoutException catch (_) {
        setSnackbar(getTranslated(context, 'somethingMSg')!, context);
      }
    } else {
      {
        if (mounted)
          setState(() {
            _isNetworkAvail = false;
          });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // if(DateTime.now().hour == "21"
    //     && DateTime.now().minute == "00"
    //     &&DateTime.now().second == "00"){
    //
    // }
    return WillPopScope(
      onWillPop: () async {
        if (_tabController.index != 0) {
          _tabController.animateTo(0);
          return false;
        }
        return true;
      },
      child: SafeArea(
        top: false,
        bottom: true,
        child: Scaffold(
          backgroundColor: Theme.of(context).colorScheme.lightWhite,
          appBar: _getAppBar(),
          body: TabBarView(
            controller: _tabController,
            children: [
              HomePage(),
              // SiteVisitForm(),
              // UserExpensesScreen(),
              // AllCategory(),
              // Sale(),
              // Cart(
              //   fromBottom: tru     e,
              // ),
              MyProfile(),
            ],
          ),
          //fragments[_selBottom],
          bottomNavigationBar: _getBottomBar(),
        ),
      ),
    );
  }

  AppBar _getAppBar() {
    String? title;
    // if (_selBottom == 1)
    //   title = getTranslated(context, 'CATEGORY');
    if (_selBottom == 1)
      title = getTranslated(context, 'MY_LEADS');
    // else if (_selBottom == 3)
    //   title = getTranslated(context, 'MYBAG');
    else if (_selBottom == 2) title = getTranslated(context, 'PROFILE');
    return AppBar(
      elevation: 0,
      centerTitle: _selBottom == 0 ? true : false,
      title: _selBottom == 0
          ? Image.asset(
              'assets/images/homelogo.png',
              //height: 40,
              //   width: 200,
              height: 90,
              //s
              // width: 45,
            )
          : Text(
              title!,
              style: TextStyle(
                  color: colors.primary, fontWeight: FontWeight.normal),
            ),
      // leading: _selBottom == 0
      //     ? InkWell(
      //         child: Center(
      //             child: SvgPicture.asset(
      //           imagePath + "search.svg",
      //           height: 20,
      //           color: colors.primary,
      //         )),
      //         onTap: () {
      //           Navigator.push(
      //               context,
      //               MaterialPageRoute(
      //                 builder: (context) => Search(),
      //               ));
      //         },
      //       )
      //     : null,
      // iconTheme: new IconThemeData(color: colors.primary),
      // centerTitle:_curSelected == 0? false:true,
      // actions: <Widget>[
      //   _selBottom == 0
      //       ? Container()
      //       : IconButton(
      //           icon: SvgPicture.asset(
      //             imagePath + "search.svg",
      //             height: 20,
      //             color: colors.primary,
      //           ),
      //           onPressed: () {
      //             Navigator.push(
      //                 context,
      //                 MaterialPageRoute(
      //                   builder: (context) => Search(),
      //                 ));
      //           }),
      //   IconButton(
      //     icon: SvgPicture.asset(
      //       imagePath + "desel_notification.svg",
      //       color: colors.primary,
      //     ),
      //     onPressed: () {
      //       CUR_USERID != null
      //           ? Navigator.push(
      //               context,
      //               MaterialPageRoute(
      //                 builder: (context) => NotificationList(),
      //               ))
      //           : Navigator.push(
      //               context,
      //               MaterialPageRoute(
      //                 builder: (context) => LoginPage(),
      //               ));
      //     },
      //   ),
      //   IconButton(
      //     padding: EdgeInsets.all(0),
      //     icon: SvgPicture.asset(
      //       imagePath + "desel_fav.svg",
      //       color: colors.primary,
      //     ),
      //     onPressed: () {
      //       CUR_USERID != null
      //           ? Navigator.push(
      //               context,
      //               MaterialPageRoute(
      //                 builder: (context) => Favorite(),
      //               ))
      //           : Navigator.push(
      //               context,
      //               MaterialPageRoute(
      //                 builder: (context) => LoginPage(),
      //               ));
      //     },
      //   ),
      // ],
      backgroundColor: colors.white70,
    );
  }

  Widget _getBottomBar() {
    return Material(
      color: Theme.of(context).colorScheme.white,
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.white,
          boxShadow: [
            BoxShadow(
                color: Theme.of(context).colorScheme.black26, blurRadius: 10)
          ],
        ),
        child: TabBar(
          onTap: (_) {
            if (_tabController.index == 2) {
              if (CUR_USERID == null) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginPage(),
                  ),
                );
                _tabController.animateTo(0);
              }
            }
          },
          controller: _tabController,
          tabs: [
            Tab(
              icon: _selBottom == 0
                  ? SvgPicture.asset(
                      imagePath + "sel_home.svg",
                      color: colors.primary,
                    )
                  : SvgPicture.asset(
                      imagePath + "desel_home.svg",
                      color: colors.primary,
                    ),
              text: _selBottom == 0 ? getTranslated(context, 'HOME_LBL') : null,
            ),
            // Tab(
            //   icon: _selBottom == 1
            //       ? Icon(
            //       Icons.assignment
            //   )
            //       : Icon(Icons.assignment_outlined),
            //   text:
            //   _selBottom == 1 ? getTranslated(context, 'MY_LEADS') : null,
            // ),
            // Tab(
            //   icon: _selBottom == 1
            //       ? SvgPicture.asset(
            //           imagePath + "category01.svg",
            //           color: colors.primary,
            //         )
            //       : SvgPicture.asset(
            //           imagePath + "category.svg",
            //           color: colors.primary,
            //         ),
            //   text:
            //       _selBottom == 1 ? getTranslated(context, 'category') : null,
            // ),
            // Tab(
            //   icon: _selBottom == 2
            //       ? SvgPicture.asset(
            //           imagePath + "sale02.svg",
            //           color: colors.primary,
            //         )
            //       : SvgPicture.asset(
            //           imagePath + "sale.svg",
            //           color: colors.primary,
            //         ),
            //   text: _selBottom == 2 ? getTranslated(context, 'SALE') : null,
            // ),
            // Tab(
            //   icon: Selector<UserProvider, String>(
            //     builder: (context, data, child) {
            //       return Stack(
            //         children: [
            //           Center(
            //             child: _selBottom == 3
            //                 ? SvgPicture.asset(
            //                     imagePath + "cart01.svg",
            //                     color: colors.primary,
            //                   )
            //                 : SvgPicture.asset(
            //                     imagePath + "cart.svg",
            //                     color: colors.primary,
            //                   ),
            //           ),
            //           (data != null && data.isNotEmpty && data != "0")
            //               ? new Positioned.directional(
            //                   bottom: _selBottom == 3 ? 6 : 20,
            //                   textDirection: Directionality.of(context),
            //                   end: 0,
            //                   child: Container(
            //                     decoration: BoxDecoration(
            //                         shape: BoxShape.circle,
            //                         color: colors.primary),
            //                     child: new Center(
            //                       child: Padding(
            //                         padding: EdgeInsets.all(3),
            //                         child: new Text(
            //                           data,
            //                           style: TextStyle(
            //                               fontSize: 7,
            //                               fontWeight: FontWeight.bold,
            //                               color: Theme.of(context)
            //                                   .colorScheme
            //                                   .white),
            //                         ),
            //                       ),
            //                     ),
            //                   ),
            //                 )
            //               : Container()
            //         ],
            //       );
            //     },
            //     selector: (_, homeProvider) => homeProvider.curCartCount,
            //   ),
            //   text: _selBottom == 3 ? getTranslated(context, 'CART') : null,
            // ),
            Tab(
              icon: _selBottom == 1
                  ? SvgPicture.asset(
                      imagePath + "profile01.svg",
                      color: colors.primary,
                    )
                  : SvgPicture.asset(
                      imagePath + "profile.svg",
                      color: colors.primary,
                    ),
              text: _selBottom == 1 ? getTranslated(context, 'ACCOUNT') : null,
            ),
          ],
          indicator: UnderlineTabIndicator(
            borderSide: BorderSide(color: colors.primary, width: 5.0),
            insets: EdgeInsets.fromLTRB(50.0, 0.0, 50.0, 70.0),
          ),
          labelColor: colors.primary,
          labelStyle: TextStyle(fontSize: 8, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}
