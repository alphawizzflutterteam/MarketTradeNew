import 'dart:async';

import 'package:country_code_picker/country_localizations.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:get_storage/get_storage.dart';
import 'package:omega_employee_management/Helper/Color.dart';
import 'package:omega_employee_management/Helper/Constant.dart';
import 'package:omega_employee_management/Provider/CartProvider.dart';
import 'package:omega_employee_management/Provider/CategoryProvider.dart';
import 'package:omega_employee_management/Provider/FavoriteProvider.dart';
import 'package:omega_employee_management/Provider/HomeProvider.dart';
import 'package:omega_employee_management/Provider/ProductDetailProvider.dart';
import 'package:omega_employee_management/Provider/UserProvider.dart';
import 'package:omega_employee_management/Screen/Splash.dart';
// import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Helper/Demo_Localization.dart';
import 'Helper/NotificationService.dart';
import 'Helper/Session.dart';
import 'Helper/String.dart';
import 'Provider/SettingProvider.dart';
import 'Provider/Theme.dart';
import 'Provider/order_provider.dart';
import 'Screen/Dashboard.dart';
import 'Screen/check_In_screen.dart';

Future<void> backgroundHandler(RemoteMessage message) async {
  print(message.data.toString());
  print(message.notification!.title);
}

@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print('Handling a background message ${message.messageId}');
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  initializedDownload();
  await initializeService();
  await GetStorage.init();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
    apiKey: 'AIzaSyAkjU49Zag8PCTkulmKtpYJXKzAOYcleR8',
    appId: "1:403580769762:android:ffffd90e2b15428f2b55bb",
    messagingSenderId: '403580769762',
    projectId: "market-track-a861d",
    storageBucket: "market-track-a861d.firebasestorage.app",
  ));
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  LocalNotificationService.initialize();
  String? token = await FirebaseMessaging.instance.getToken();
  print('${token}  tttt_______________token');
  // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
  //   statusBarColor: Colors.transparent, // status bar color
  // ));
  SharedPreferences prefs = await SharedPreferences.getInstance();
  runApp(
    ChangeNotifierProvider<ThemeNotifier>(
      create: (BuildContext context) {
        String? theme = prefs.getString(APP_THEME);
        if (theme == DARK)
          ISDARK = "true";
        else if (theme == LIGHT) ISDARK = "false";
        if (theme == null || theme == "" || theme == DEFAULT_SYSTEM) {
          prefs.setString(APP_THEME, DEFAULT_SYSTEM);
          var brightness = SchedulerBinding.instance.window.platformBrightness;
          ISDARK = (brightness == Brightness.dark).toString();
          return ThemeNotifier(ThemeMode.system);
        }
        return ThemeNotifier(theme == LIGHT ? ThemeMode.light : ThemeMode.dark);
      },
      child: MyApp(sharedPreferences: prefs),
    ),
  );
}

Future<void> initializedDownload() async {
  await FlutterDownloader.initialize(debug: false);
}

final GlobalKey<ScaffoldMessengerState> rootScaffoldMessengerKey =
    GlobalKey<ScaffoldMessengerState>();

class MyApp extends StatefulWidget {
  late SharedPreferences sharedPreferences;

  MyApp({Key? key, required this.sharedPreferences}) : super(key: key);

  static void setLocale(BuildContext context, Locale newLocale) {
    _MyAppState state = context.findAncestorStateOfType<_MyAppState>()!;
    state.setLocale(newLocale);
  }

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale? _locale;
  setLocale(Locale locale) {
    if (mounted)
      setState(() {
        _locale = locale;
      });
  }

  @override
  void didChangeDependencies() {
    getLocale().then((locale) {
      if (mounted)
        setState(() {
          this._locale = locale;
        });
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    if (this._locale == null) {
      return Container(
        child: Center(
          child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color?>(colors.primary)),
        ),
      );
    } else {
      return MultiProvider(
        providers: [
          Provider<SettingProvider>(
            create: (context) => SettingProvider(widget.sharedPreferences),
          ),
          ChangeNotifierProvider<UserProvider>(
              create: (context) => UserProvider()),
          ChangeNotifierProvider<HomeProvider>(
              create: (context) => HomeProvider()),
          ChangeNotifierProvider<CategoryProvider>(
              create: (context) => CategoryProvider()),
          ChangeNotifierProvider<ProductDetailProvider>(
              create: (context) => ProductDetailProvider()),
          ChangeNotifierProvider<FavoriteProvider>(
              create: (context) => FavoriteProvider()),
          ChangeNotifierProvider<OrderProvider>(
              create: (context) => OrderProvider()),
          ChangeNotifierProvider<CartProvider>(
              create: (context) => CartProvider()),
        ],
        child: MaterialApp(
          //scaffoldMessengerKey: rootScaffoldMessengerKey,
          locale: _locale,
          supportedLocales: [
            Locale("en", "US"),
            Locale("zh", "CN"),
            Locale("es", "ES"),
            Locale("hi", "IN"),
            Locale("ar", "DZ"),
            Locale("ru", "RU"),
            Locale("ja", "JP"),
            Locale("de", "DE")
          ],
          localizationsDelegates: [
            CountryLocalizations.delegate,
            DemoLocalization.delegate,
            // GlobalMaterialLocalizations.delegate,
            // GlobalWidgetsLocalizations.delegate,
            // GlobalCupertinoLocalizations.delegate,
          ],
          localeResolutionCallback: (locale, supportedLocales) {
            for (var supportedLocale in supportedLocales) {
              if (supportedLocale.languageCode == locale!.languageCode &&
                  supportedLocale.countryCode == locale.countryCode) {
                return supportedLocale;
              }
            }
            return supportedLocales.first;
          },
          title: appName,

          theme: ThemeData(
            canvasColor: Theme.of(context).colorScheme.lightWhite,
            cardColor: Theme.of(context).colorScheme.white,
            dialogBackgroundColor: Theme.of(context).colorScheme.white,
            iconTheme:
                Theme.of(context).iconTheme.copyWith(color: colors.primary),
            primarySwatch: colors.primary_app,
            primaryColor: Theme.of(context).colorScheme.lightWhite,
            fontFamily: 'opensans',
            brightness: Brightness.light,
            textTheme: TextTheme(
                    headline6: TextStyle(
                      color: Theme.of(context).colorScheme.fontColor,
                      fontWeight: FontWeight.w600,
                    ),
                    subtitle1: TextStyle(
                        color: Theme.of(context).colorScheme.fontColor,
                        fontWeight: FontWeight.bold))
                .apply(bodyColor: Theme.of(context).colorScheme.fontColor),
          ),
          debugShowCheckedModeBanner: false,
          initialRoute: '/',
          routes: {
            '/': (context) => Splash(),
            '/home': (context) => Dashboard(),
          },
          darkTheme: ThemeData(
            canvasColor: colors.darkColor,
            cardColor: colors.darkColor2,
            dialogBackgroundColor: colors.darkColor2,
            primarySwatch: colors.primary_app,
            primaryColor: colors.darkColor,
            textSelectionTheme: TextSelectionThemeData(
                cursorColor: colors.darkIcon,
                selectionColor: colors.darkIcon,
                selectionHandleColor: colors.darkIcon),
            toggleableActiveColor: colors.primary,
            fontFamily: 'opensans',
            brightness: Brightness.dark,
            // accentColor: colors.darkIcon,
            iconTheme:
                Theme.of(context).iconTheme.copyWith(color: colors.secondary),
            textTheme: TextTheme(
                    headline6: TextStyle(
                      color: Theme.of(context).colorScheme.fontColor,
                      fontWeight: FontWeight.w600,
                    ),
                    subtitle1: TextStyle(
                        color: Theme.of(context).colorScheme.fontColor,
                        fontWeight: FontWeight.bold))
                .apply(bodyColor: Theme.of(context).colorScheme.fontColor),
          ),
          themeMode: themeNotifier.getThemeMode(),
        ),
      );
    }
  }
}

// import 'package:country_code_picker/country_localizations.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/scheduler.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_downloader/flutter_downloader.dart';
// import 'package:flutter_localizations/flutter_localizations.dart';
// import 'package:provider/provider.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// import 'Helper/Color.dart';
// import 'Helper/Constant.dart';
// import 'Helper/Demo_Localization.dart';
// import 'Helper/PushNotificationService.dart';
// import 'Helper/Session.dart';
// import 'Helper/String.dart';
// import 'Provider/CartProvider.dart';
// import 'Provider/CategoryProvider.dart';
// import 'Provider/FavoriteProvider.dart';
// import 'Provider/HomeProvider.dart';
// import 'Provider/ProductDetailProvider.dart';
// import 'Provider/SettingProvider.dart';
// import 'Provider/Theme.dart';
// import 'Provider/UserProvider.dart';
// import 'Provider/order_provider.dart';
// import 'Screen/Dashboard.dart';
// import 'Screen/Splash.dart';
//
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//
//   await Firebase.initializeApp();
// //  await Upgrader.clearSavedSettings();
//
//   initializedDownload();
//   FirebaseMessaging.onBackgroundMessage(myForgroundMessageHandler);
//   SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
//   // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
//   //   statusBarColor: Colors.transparent, // status bar color
//   // ));
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//
//   runApp(
//     ChangeNotifierProvider<ThemeNotifier>(
//       create: (BuildContext context) {
//         String? theme = prefs.getString(APP_THEME);
//
//         if (theme == DARK)
//           ISDARK = "true";
//         else if (theme == LIGHT) ISDARK = "false";
//
//         if (theme == null || theme == "" || theme == DEFAULT_SYSTEM) {
//           prefs.setString(APP_THEME, DEFAULT_SYSTEM);
//           var brightness = SchedulerBinding.instance.window.platformBrightness;
//           ISDARK = (brightness == Brightness.dark).toString();
//
//           return ThemeNotifier(ThemeMode.light);
//         }
//
//         return ThemeNotifier(
//             theme == LIGHT ? ThemeMode.light : ThemeMode.light);
//       },
//       child: MyApp(sharedPreferences: prefs),
//     ),
//   );
// }
//
// Future<void> initializedDownload() async {
//   await FlutterDownloader.initialize(debug: false);
// }
//
// final GlobalKey<ScaffoldMessengerState> rootScaffoldMessengerKey =
// GlobalKey<ScaffoldMessengerState>();
//
// class MyApp extends StatefulWidget {
//   late SharedPreferences sharedPreferences;
//
//   MyApp({Key? key, required this.sharedPreferences}) : super(key: key);
//
//   static void setLocale(BuildContext context, Locale newLocale) {
//     _MyAppState state = context.findAncestorStateOfType<_MyAppState>()!;
//     state.setLocale(newLocale);
//   }
//
//   @override
//   MyAppState createState() => MyAppState();
// }
//
// class _MyAppState extends State<MyApp> {
//   Locale? _locale;
//
//   setLocale(Locale locale) {
//     if (mounted)
//       setState(() {
//         _locale = locale;
//       });
//   }
//
//   @override
//   void didChangeDependencies() {
//     getLocale().then((locale) {
//       if (mounted)
//         setState(() {
//           this._locale = locale;
//         });
//     });
//     super.didChangeDependencies();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final themeNotifier = Provider.of<ThemeNotifier>(context);
//     if (this._locale == null) {
//       return Container(
//         child: Center(
//           child: CircularProgressIndicator(
//               valueColor: AlwaysStoppedAnimation<Color?>(colors.primary)),
//         ),
//       );
//     } else {
//       return MultiProvider(
//           providers: [
//             Provider<SettingProvider>(
//               create: (context) => SettingProvider(widget.sharedPreferences),
//             ),
//             ChangeNotifierProvider<UserProvider>(
//                 create: (context) => UserProvider()),
//             ChangeNotifierProvider<HomeProvider>(
//                 create: (context) => HomeProvider()),
//             ChangeNotifierProvider<CategoryProvider>(
//                 create: (context) => CategoryProvider()),
//             ChangeNotifierProvider<ProductDetailProvider>(
//                 create: (context) => ProductDetailProvider()),
//             ChangeNotifierProvider<FavoriteProvider>(
//                 create: (context) => FavoriteProvider()),
//             ChangeNotifierProvider<OrderProvider>(
//                 create: (context) => OrderProvider()),
//             ChangeNotifierProvider<CartProvider>(
//                 create: (context) => CartProvider()),
//           ],
//           child: MaterialApp(
//             builder: (context, child) {
//               return MediaQuery(
//                   data: MediaQuery.of(context).copyWith(textScaleFactor: 1),
//                   child: child!);
//             },
//             //scaffoldMessengerKey: rootScaffoldMessengerKey,
//             locale: _locale,
//             supportedLocales: [
//               Locale("en", "US"),
//               Locale("zh", "CN"),
//               Locale("es", "ES"),
//               Locale("hi", "IN"),
//               Locale("ar", "DZ"),
//               Locale("ru", "RU"),
//               Locale("ja", "JP"),
//               Locale("de", "DE")
//             ],
//             localizationsDelegates: [
//               CountryLocalizations.delegate,
//               DemoLocalization.delegate,
//               GlobalMaterialLocalizations.delegate,
//               GlobalWidgetsLocalizations.delegate,
//               GlobalCupertinoLocalizations.delegate,
//             ],
//             localeResolutionCallback: (locale, supportedLocales) {
//               for (var supportedLocale in supportedLocales) {
//                 if (supportedLocale.languageCode == locale!.languageCode &&
//                     supportedLocale.countryCode == locale.countryCode) {
//                   return supportedLocale;
//                 }
//               }
//               return supportedLocales.first;
//             },
//             title: appName,
//
//             theme: ThemeData(
//               canvasColor: Theme.of(context).colorScheme.lightWhite,
//               cardColor: Theme.of(context).colorScheme.white,
//               dialogBackgroundColor: Theme.of(context).colorScheme.white,
//               iconTheme:
//               Theme.of(context).iconTheme.copyWith(color: colors.primary),
//               primarySwatch: colors.primary_app,
//               primaryColor: Theme.of(context).colorScheme.lightWhite,
//               fontFamily: 'opensans',
//               brightness: Brightness.light,
//               textTheme: TextTheme(
//                   headline6: TextStyle(
//                     color: Theme.of(context).colorScheme.fontColor,
//                     fontWeight: FontWeight.w600,
//                   ),
//                   subtitle1: TextStyle(
//                       color: Theme.of(context).colorScheme.fontColor,
//                       fontWeight: FontWeight.bold))
//                   .apply(bodyColor: Theme.of(context).colorScheme.fontColor),
//             ),
//             debugShowCheckedModeBanner: false,
//             initialRoute: '/',
//             routes: {
//               '/': (context) => Splash(),
//               '/home': (context) => Dashboard(),
//             },
//             darkTheme: ThemeData(
//               canvasColor: colors.darkColor,
//               cardColor: colors.darkColor2,
//               dialogBackgroundColor: colors.darkColor2,
//               primarySwatch: colors.primary_app,
//               primaryColor: colors.darkColor,
//               textSelectionTheme: TextSelectionThemeData(
//                   cursorColor: colors.darkIcon,
//                   selectionColor: colors.darkIcon,
//                   selectionHandleColor: colors.darkIcon),
//               toggleableActiveColor: colors.primary,
//               fontFamily: 'opensans',
//               brightness: Brightness.dark,
//               iconTheme:
//               Theme.of(context).iconTheme.copyWith(color: colors.secondary),
//               textTheme: TextTheme(
//                   headline6: TextStyle(
//                     color: Theme.of(context).colorScheme.fontColor,
//                     fontWeight: FontWeight.w600,
//                   ),
//                   subtitle1: TextStyle(
//                       color: Theme.of(context).colorScheme.fontColor,
//                       fontWeight: FontWeight.bold))
//                   .apply(bodyColor: Theme.of(context).colorScheme.fontColor),
//             ),
//             themeMode: themeNotifier.getThemeMode(),
//           ));
//     }
//   }
// }
