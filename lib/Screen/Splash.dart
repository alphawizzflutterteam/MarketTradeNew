// import 'dart:async';
//
// import 'package:omega_employee_management/Provider/SettingProvider.dart';
// import 'package:omega_employee_management/Screen/Intro_Slider.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:omega_employee_management/Screen/Login.dart';
// import 'package:provider/provider.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// import '../Helper/Color.dart';
// import '../Helper/Session.dart';
// import '../Helper/String.dart';
//
// class Splash extends StatefulWidget {
//   @override
//   _SplashScreen createState() => _SplashScreen();
// }
//
// class _SplashScreen extends State<Splash> {
//   final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
//
//   @override
//   void initState() {
//     SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
//         overlays: [SystemUiOverlay.top]);
//     SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
//       statusBarColor: Colors.transparent,
//       statusBarIconBrightness: Brightness.light,
//     ));
//     super.initState();
//     checkingLogin();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     deviceHeight = MediaQuery.of(context).size.height;
//     deviceWidth = MediaQuery.of(context).size.width;
//
//     //  SystemChrome.setEnabledSystemUIOverlays([]);
//     return Scaffold(
//       backgroundColor: colors.black54,
//       //key: _scaffoldKey,
//       // bottomNavigationBar:Image.asset(
//       //   'assets/images/splash1.png',
//       // ),
//       body: Container(
//           child: Center(
//               child: Image.asset('assets/images/splash.png')))
//
//       // Container(
//       //   color: colors.black54,
//       //   decoration: BoxDecoration(
//       //     color: colors.whiteTemp,
//       //     image: DecorationImage(
//       //         image: AssetImage("assets/images/splash.png"),
//       //         // fit: BoxFit.cover
//       //     ),
//       //   ),
//       // )
//     );
//   }
//
//   startTime() async {
//     var _duration = Duration(seconds: 5);
//     return Timer(_duration, navigationPage);
//   }
//
//   String? uid;
//
//   void checkingLogin() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     setState(() {
//      uid = prefs.getString('user_id');
//
//     });
//     if(uid == null || uid == ""){
//       Future.delayed(Duration(
//           seconds: 3
//       ), (){
//         Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> LoginPage()));
//       });
//     }else{
//       Future.delayed(Duration(
//           seconds: 3
//       ), (){
//         Navigator.pushReplacementNamed(context, "/home");
//       });
//     }
//   }
//
//   Future<void> navigationPage() async {
//
//     SettingProvider settingsProvider =
//         Provider.of<SettingProvider>(this.context, listen: false);
//     bool isFirstTime = await settingsProvider.getPrefrenceBool(ISFIRSTTIME);
//     print("this is my $CUR_USERID and $isFirstTime");
//     if (isFirstTime) {
//       Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(
//             builder: (context) => LoginPage(),
//           )
//       );
//     } else {
//       Navigator.pushReplacementNamed(context, "/home");
//     }
//   }
//
//   setSnackbar(String msg) {
//     ScaffoldMessenger.of(context).showSnackBar(new SnackBar(
//       content: new Text(
//         msg,
//         textAlign: TextAlign.center,
//         style: TextStyle(color: Theme.of(context).colorScheme.black),
//       ),
//       backgroundColor: Theme.of(context).colorScheme.white,
//       elevation: 1.0,
//     ));
//   }
//
//   @override
//   void dispose() {
//     //  SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
//     super.dispose();
//   }
// }
import 'dart:async';
import 'dart:convert';

import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:omega_employee_management/Provider/SettingProvider.dart';
import 'package:omega_employee_management/Screen/Intro_Slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:omega_employee_management/Screen/Login.dart';
import 'package:omega_employee_management/Screen/check_In_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../Helper/Color.dart';
import '../Helper/Session.dart';
import '../Helper/String.dart';

class Splash extends StatefulWidget {
  @override
  _SplashScreen createState() => _SplashScreen();
}

class _SplashScreen extends State<Splash> {

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  String? currentAddress;
  var latitude;
  var longitude;
  @override
  void initState() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.top]);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ));
    super.initState();
    checkingLogin();
  }

  @override
  Widget build(BuildContext context) {
    deviceHeight = MediaQuery.of(context).size.height;
    deviceWidth = MediaQuery.of(context).size.width;
    //  SystemChrome.setEnabledSystemUIOverlays([]);
    return Scaffold(
        backgroundColor: Colors.white,
        //key: _scaffoldKey,
        // bottomNavigationBar:Image.asset(
        //   'assets/images/splash1.png',
        // ),
        body: Container(
            child: Center(
                child: Image.asset('assets/images/splash.png')))
      // Container(
      //   color: colors.black54,
      //   decoration: BoxDecoration(
      //     color: colors.whiteTemp,
      //     image: DecorationImage(
      //         image: AssetImage("assets/images/splash.png"),
      //         // fit: BoxFit.cover
      //     ),
      //   ),
      // )
    );
  }

  startTime() async {
    var _duration = Duration(seconds: 5);
    return Timer(_duration, navigationPage);
  }

  String? uid;

  Future<void> getCurrentLoc() async {
    LocationPermission permission;
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      print("checking permission here ${permission}");
      if (permission == LocationPermission.deniedForever) {
        return Future.error('Location Not Available');
      }
    }
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    // var loc = Provider.of<LocationProvider>(context, listen: false);

    latitude = position.latitude.toString();
    longitude = position.longitude.toString();

    List<Placemark> placeMark = await placemarkFromCoordinates(
        double.parse(latitude!), double.parse(longitude!),
        localeIdentifier: "en");
      setState(() {
        currentAddress =
        "${placeMark[0].street}, ${placeMark[0].subLocality}, ${placeMark[0].locality}";
        latitude = position.latitude.toString();
        longitude = position.longitude.toString();
        print('Latitude=============${latitude}');
        print('Longitude*************${longitude}');
        print('Current Addresssssss${currentAddress}');
      });

  }
  setIsCheckOut() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("CheckIn", false);
  }
  Future<void> checkOutNow() async {

    var headers = {
      'Cookie': 'ci_session=3515d88c5cab45d32a201da39275454c5d051af2'
    };
    var request =  http.MultipartRequest('POST', Uri.parse(checkOutNowApi.toString()));
    request.fields.addAll({
      'user_id': uid??"",
      'checkout_latitude': '${latitude}',
      'checkout_longitude': '${longitude}',
      'address': '${currentAddress}',
      'redings': "0",
    });


    print("this is my check in request ${request.fields.toString()}");
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {

      var str = await response.stream.bytesToString();
      var result = json.decode(str);
      // Fluttertoast.showToast(msg: result['msg']);
      if(result['data']['error'] == false) {
        await setIsCheckOut();
        debugPrint("checkOut");
        Navigator.push(context, MaterialPageRoute(builder: (context) => CheckInScreen()));
      }
      // var finalResponse = GetUserExpensesModel.fromJson(result);
      // final finalResponse = CheckInModel.fromJson(json.decode(Response));
    }
    else {
      print("reasonnn" +response.reasonPhrase.toString());
    }
  }

  void checkingLogin() async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      uid = prefs.getString('user_id');
    });
    // debugPrint("fffffff"+uid.toString());
    if(uid == null || uid == ""){
      Future.delayed(Duration(
          seconds: 3
      ), (){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> LoginPage()));
      });
    }else{
      Future.delayed(Duration(
          seconds: 3
      ), () async {
        // String? checkInTime = prefs.getString("CheckInTime");

        // Navigator.pushReplacementNamed(context, "/home");
        bool? checkIn =  await prefs.getBool("CheckIn");
        if(checkIn ?? false){
          String? checkInTime = await prefs.getString("CheckInTime");
          debugPrint("CheckInTime"+ checkInTime.toString());
           DateTime checkInDateTime = await DateTime.parse(checkInTime??"");
          // DateTime checkInDateTime = DateTime.fromMicrosecondsSinceEpoch(checkInTime??0);
          DateTime autoCheckOutDateTime = await DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day,21);
          // Duration timeDifference = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, 21, 00).difference(checkInDateTime);
          if(checkInDateTime.isBefore(autoCheckOutDateTime) && DateTime.now().isAfter(autoCheckOutDateTime)){
            await getCurrentLoc();
            await checkOutNow();
            // Navigator.pushReplacementNamed(context, "/home");
            Navigator.push(context, MaterialPageRoute(builder: (context)=> CheckInScreen()));
          }
          else {
            Navigator.pushReplacementNamed(context, "/home");
          }
        }
        else {
          Navigator.pushReplacementNamed(context, "/home");
        }

      });
    }
  }

  Future<void> navigationPage() async {

    SettingProvider settingsProvider =
    Provider.of<SettingProvider>(this.context, listen: false);
    bool isFirstTime = await settingsProvider.getPrefrenceBool(ISFIRSTTIME);
    print("this is my $CUR_USERID and $isFirstTime");
    if (isFirstTime) {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => LoginPage(),
          )
      );
    } else {
      Navigator.pushReplacementNamed(context, "/home");
    }
  }

  setSnackbar(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(new SnackBar(
      content: new Text(
        msg,
        textAlign: TextAlign.center,
        style: TextStyle(color: Theme.of(context).colorScheme.black),
      ),
      backgroundColor: Theme.of(context).colorScheme.white,
      elevation: 1.0,
    ));
  }

  @override
  void dispose() {
    //  SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    super.dispose();
  }
}