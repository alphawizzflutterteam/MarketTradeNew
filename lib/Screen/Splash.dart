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

import 'package:omega_employee_management/Provider/SettingProvider.dart';
import 'package:omega_employee_management/Screen/Intro_Slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:omega_employee_management/Screen/Login.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Helper/Color.dart';
import '../Helper/Session.dart';
import '../Helper/String.dart';

class Splash extends StatefulWidget {
  @override
  _SplashScreen createState() => _SplashScreen();
}

class _SplashScreen extends State<Splash> {

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

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

  void checkingLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      uid = prefs.getString('user_id');
    });
    if(uid == null || uid == ""){
      Future.delayed(Duration(
          seconds: 3
      ), (){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> LoginPage()));
      });
    }else{
      Future.delayed(Duration(
          seconds: 3
      ), (){
        Navigator.pushReplacementNamed(context, "/home");
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