import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;
import 'package:in_app_review/in_app_review.dart';
import 'package:omega_employee_management/Helper/ApiBaseHelper.dart';
import 'package:omega_employee_management/Helper/Color.dart';
import 'package:omega_employee_management/Helper/Session.dart';
import 'package:omega_employee_management/Helper/String.dart';
import 'package:omega_employee_management/Model/Section_Model.dart';
import 'package:omega_employee_management/Provider/CategoryProvider.dart';
import 'package:omega_employee_management/Provider/HomeProvider.dart';
import 'package:omega_employee_management/Provider/SettingProvider.dart';
import 'package:omega_employee_management/Provider/UserProvider.dart';
import 'package:omega_employee_management/Screen/Customer_Support.dart';
import 'package:omega_employee_management/Screen/HomePage.dart';
import 'package:omega_employee_management/Screen/Login.dart';
import 'package:omega_employee_management/Screen/ReferEarn.dart';
import 'package:omega_employee_management/Screen/Setting.dart';
import 'package:omega_employee_management/Screen/SiteVisitForm.dart';
import 'package:omega_employee_management/Screen/work_allotment/work_allotment_screen.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Helper/Constant.dart';
import '../Model/DeleteAccountModel.dart';
import '../Provider/Theme.dart';
import '../main.dart';
import 'Example.dart';
import 'Faqs.dart';
import 'FeedbackList.dart';
import 'Manage_Address.dart';
import 'NotificationLIst.dart';
import 'Privacy_Policy.dart';

class MyProfile extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => StateProfile();
}

class StateProfile extends State<MyProfile> with TickerProviderStateMixin {
  //String? profile, email;
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  final InAppReview _inAppReview = InAppReview.instance;
  var isDarkTheme;
  bool isDark = false;
  late ThemeNotifier themeNotifier;
  List<String> langCode = ["en", "hi", "zh", "es", "ar", "ru", "ja", "de"];
  List<String?> themeList = [];
  List<String?> languageList = [];
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  int? selectLan, curTheme;
  TextEditingController? curPassC, newPassC, confPassC;
  String? curPass, newPass, confPass, mobile;
  bool _showPassword = false, _showNPassword = false, _showCPassword = false;

  final GlobalKey<FormState> _changePwdKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _changeUserDetailsKey = GlobalKey<FormState>();
  final confirmpassController = TextEditingController();
  final newpassController = TextEditingController();
  final passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController messageController = TextEditingController();

  String? currentPwd, newPwd, confirmPwd;
  FocusNode confirmPwdFocus = FocusNode();

  bool _isNetworkAvail = true;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  Animation? buttonSqueezeanimation;
  AnimationController? buttonController;

  requestTraining() async {
    var headers = {
      // 'Token': jwtToken.toString(),
      // 'Authorisedkey': authKey.toString(),
      'Cookie': 'ci_session=aa83f4f9d3335df625437992bb79565d0973f564'
    };
    var request =
        http.MultipartRequest('POST', Uri.parse(requestTrainingApi.toString()));
    request.fields.addAll({
      USER_ID: '$CUR_USERID',
      'message': messageController.text.toString(),
      'product_id': categoryValue != null ? categoryValue.toString() : ""
    });

    print("this is request training request ${request.fields.toString()}");
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      String str = await response.stream.bytesToString();
      var result = json.decode(str);
      setSnackbar("${result['message'].toString()}");
      Navigator.pop(context);
      // final finalResponse = AnimalTypeModel.fromJson(result);
      // setState(() {
      // animalList = finalResponse.data!;
      // });
      // print("this is operator list ----->>>> ${operatorList[0].name}");
    } else {
      print(response.reasonPhrase);
    }
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
      } else {}

      context.read<HomeProvider>().setCatLoading(false);
    }, onError: (error) {
      // setSnackbar(error.toString(), context);
      context.read<HomeProvider>().setCatLoading(false);
    });
  }

  @override
  void initState() {
    //getUserDetails();
    // SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [SystemUiOverlay.top]);
    // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    //   statusBarColor: Colors.transparent,
    //   statusBarIconBrightness: Brightness.light,
    // ));
    new Future.delayed(Duration.zero, () {
      languageList = [
        getTranslated(context, 'ENGLISH_LAN'),
        getTranslated(context, 'HINDI_LAN'),
        // getTranslated(context, 'CHINESE_LAN'),
        // getTranslated(context, 'SPANISH_LAN'),
        //
        // getTranslated(context, 'ARABIC_LAN'),
        // getTranslated(context, 'RUSSIAN_LAN'),
        // getTranslated(context, 'JAPANISE_LAN'),
        // getTranslated(context, 'GERMAN_LAN')
      ];

      themeList = [
        getTranslated(context, 'SYSTEM_DEFAULT'),
        getTranslated(context, 'LIGHT_THEME'),
        getTranslated(context, 'DARK_THEME')
      ];

      _getSaved();
    });

    super.initState();
    getCat();
  }

  _getSaved() async {
    SettingProvider settingsProvider =
        Provider.of<SettingProvider>(this.context, listen: false);

    //String get = await settingsProvider.getPrefrence(APP_THEME) ?? '';

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? get = prefs.getString(APP_THEME);
    String? username = prefs.getString("usernamee");
    String? email = prefs.getString("email");
    String? MOBILE = prefs.getString("mobile");
    String? image = prefs.getString("image");
    UserProvider userProvider =
        Provider.of<UserProvider>(this.context, listen: false);

    userProvider.setName(username ?? "");
    userProvider.setEmail(email ?? "");
    userProvider.setMobile(MOBILE ?? "");
    userProvider.setProfilePic(image ?? "");

    curTheme = themeList.indexOf(get == '' || get == DEFAULT_SYSTEM
        ? getTranslated(context, 'SYSTEM_DEFAULT')
        : get == LIGHT
            ? getTranslated(context, 'LIGHT_THEME')
            : getTranslated(context, 'DARK_THEME'));

    String getlng = await settingsProvider.getPrefrence(LAGUAGE_CODE) ?? '';

    selectLan = langCode.indexOf(getlng == '' ? "en" : getlng);

    if (mounted) setState(() {});
  }

  /* getUserDetails() async {

    CUR_USERID = await getPrefrence(ID);
    CUR_USERNAME = await getPrefrence(USERNAME);
    email = await getPrefrence(EMAIL);
    profile = await getPrefrence(IMAGE);



    if (mounted) setState(() {});
  }*/

  _getHeader() {
    return Padding(
      padding: const EdgeInsetsDirectional.only(bottom: 10.0, top: 10),
      child: Container(
        padding: EdgeInsetsDirectional.only(
          start: 10.0,
        ),
        child: Row(
          children: [
            Selector<UserProvider, String>(
                selector: (_, provider) => provider.profilePic,
                builder: (context, profileImage, child) {
                  return getUserImage(
                      profileImage, openChangeUserDetailsBottomSheet);
                }),
            /*         Container(
                margin: EdgeInsetsDirectional.only(end: 20),
                height: 80,
                width: 80,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(width: 1.0, color: Theme.of(context).colorScheme.white)),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100.0),
                  child: Consumer<UserProvider>(
                      builder: (context, userProvider, _) {
                        return userProvider.profilePic != ''
                            ? new FadeInImage(
                          fadeInDuration: Duration(milliseconds: 150),
                          image: NetworkImage(userProvider.profilePic),
                          height: 64.0,
                          width: 64.0,
                          fit: BoxFit.cover,
                          imageErrorBuilder: (context, error, stackTrace) =>
                              erroWidget(64),
                          placeholder: placeHolder(64),
                        )
                            : imagePlaceHolder(62);
                      }),
                ),
              ),*/
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Selector<UserProvider, String>(
                    selector: (_, provider) => provider.curUserName,
                    builder: (context, userName, child) {
                      nameController = TextEditingController(text: userName);
                      return Text(
                        userName == ""
                            ? getTranslated(context, 'GUEST')!
                            : userName,
                        style: Theme.of(context).textTheme.subtitle1!.copyWith(
                              color: Theme.of(context).colorScheme.fontColor,
                            ),
                      );
                    }),
                Selector<UserProvider, String>(
                    selector: (_, provider) => provider.mob,
                    builder: (context, userMobile, child) {
                      return userMobile != ""
                          ? Text(
                              userMobile,
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle2!
                                  .copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .fontColor,
                                      fontWeight: FontWeight.normal),
                            )
                          : Container(
                              height: 0,
                            );
                    }),
                Selector<UserProvider, String>(
                    selector: (_, provider) => provider.email,
                    builder: (context, userEmail, child) {
                      emailController = TextEditingController(text: userEmail);
                      return userEmail != ""
                          ? Text(
                              userEmail,
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle2!
                                  .copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .fontColor,
                                      fontWeight: FontWeight.normal),
                            )
                          : Container(height: 0);
                    }),
                /* Consumer<UserProvider>(builder: (context, userProvider, _) {
                    print("mobb**${userProvider.profilePic}");
                    return (userProvider.mob != "")
                        ? Text(
                            userProvider.mob,
                            style: Theme.of(context)
                                .textTheme
                                .subtitle2!
                                .copyWith(color: Theme.of(context).colorScheme.fontColor),
                          )
                        : Container(
                            height: 0,
                          );
                  }),*/
                Consumer<UserProvider>(builder: (context, userProvider, _) {
                  return userProvider.curUserName == ""
                      ? Padding(
                          padding: const EdgeInsetsDirectional.only(top: 7),
                          child: InkWell(
                            child: Text(
                              getTranslated(context, 'LOGIN_REGISTER_LBL')!,
                              style:
                                  Theme.of(context).textTheme.caption!.copyWith(
                                        color: colors.primary,
                                        decoration: TextDecoration.underline,
                                      ),
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => LoginPage(),
                                ),
                              );
                            },
                          ),
                        )
                      : Container();
                }),
              ],
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> getLngList(BuildContext ctx, StateSetter setModalState) {
    return languageList
        .asMap()
        .map(
          (index, element) => MapEntry(
            index,
            InkWell(
              onTap: () {
                if (mounted)
                  setState(() {
                    selectLan = index;
                    _changeLan(langCode[index], ctx);
                  });
                setModalState(() {});
              },
              child: Padding(
                padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          height: 25.0,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: selectLan == index
                                ? colors.grad2Color
                                : Theme.of(context).colorScheme.white,
                            border: Border.all(color: colors.grad2Color),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: selectLan == index
                                ? Icon(
                                    Icons.check,
                                    size: 17.0,
                                    color:
                                        Theme.of(context).colorScheme.fontColor,
                                  )
                                : Icon(
                                    Icons.check_box_outline_blank,
                                    size: 15.0,
                                    color: Theme.of(context).colorScheme.white,
                                  ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.only(
                            start: 15.0,
                          ),
                          child: Text(
                            languageList[index]!,
                            style: Theme.of(this.context)
                                .textTheme
                                .subtitle1!
                                .copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .lightBlack),
                          ),
                        ),
                      ],
                    ),
                    // index == languageList.length - 1
                    //     ? Container(
                    //         margin: EdgeInsetsDirectional.only(
                    //           bottom: 10,
                    //         ),
                    //       )
                    //     : Divider(
                    //         color: Theme.of(context).colorScheme.lightBlack,
                    //       ),
                  ],
                ),
              ),
            ),
          ),
        )
        .values
        .toList();
  }

  void _changeLan(String language, BuildContext ctx) async {
    Locale _locale = await setLocale(language);

    MyApp.setLocale(ctx, _locale);
  }

  Future<void> setUpdateUser(String userID,
      [oldPwd, newPwd, username, userEmail]) async {
    var apiBaseHelper = ApiBaseHelper();
    var data = {USER_ID: userID};
    if ((oldPwd != "") && (newPwd != "")) {
      data[OLDPASS] = oldPwd;
      data[NEWPASS] = newPwd;
    } else if ((username != "") && (userEmail != "")) {
      data[USERNAME] = username;
      data[EMAIL] = userEmail;
    }

    final result = await apiBaseHelper.postAPICall(getUpdateUserApi, data);

    bool error = result["error"];
    String? msg = result["message"];

    Navigator.of(context).pop();
    if (!error) {
      var settingProvider =
          Provider.of<SettingProvider>(context, listen: false);
      var userProvider = Provider.of<UserProvider>(context, listen: false);

      if ((username != "") && (userEmail != "")) {
        settingProvider.setPrefrence(USERNAME, username);
        userProvider.setName(username);
        settingProvider.setPrefrence(EMAIL, userEmail);
        userProvider.setEmail(userEmail);
      }

      setSnackbar(getTranslated(context, 'USER_UPDATE_MSG')!);
    } else {
      setSnackbar(msg!);
    }
  }

/*  Future<void> setUpdateUser() async {
    var data = {USER_ID: CUR_USERID, OLDPASS: curPass, NEWPASS: newPass};

    Response response =
        await post(getUpdateUserApi, body: data, headers: headers)
            .timeout(Duration(seconds: timeOut));
    if (response.statusCode == 200) {
      var getdata = json.decode(response.body);

      bool error = getdata["error"];
      String? msg = getdata["message"];

      if (!error) {
        setSnackbar(getTranslated(context, 'USER_UPDATE_MSG')!);
      } else {
        setSnackbar(msg!);
      }
    }
  }*/

  setSnackbar(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(new SnackBar(
      content: new Text(
        msg,
        textAlign: TextAlign.center,
        style: TextStyle(color: Theme.of(context).colorScheme.fontColor),
      ),
      backgroundColor: Theme.of(context).colorScheme.lightWhite,
      elevation: 1.0,
    ));
  }

  _getDrawer() {
    return ListView(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      physics: BouncingScrollPhysics(),
      children: <Widget>[
        // CUR_USERID == "" || CUR_USERID == null
        //     ? Container()
        //     : _getDrawerItem(getTranslated(context, 'MY_ORDERS_LBL')!,
        //         'assets/images/pro_myorder.svg'),
        // CUR_USERID == "" || CUR_USERID == null ? Container() : _getDivider(),
        // CUR_USERID == "" || CUR_USERID == null
        //     ? Container()
        //     : _getDrawerItem(getTranslated(context, 'MANAGE_ADD_LBL')!,
        //         'assets/images/pro_address.svg'),
        //CUR_USERID == "" || CUR_USERID == null ? Container() : _getDivider(),
        // CUR_USERID == "" || CUR_USERID == null
        //     ? Container()
        //     : _getDrawerItem(getTranslated(context, 'MY_SITE_VISIT')!,
        //         'assets/images/pro_wh.svg'),
        // CUR_USERID == "" || CUR_USERID == null
        //     ? Container()
        //     : _getDrawerItem(getTranslated(context, 'MYFEEDBACK')!,
        //     'assets/images/pro_th.svg'),
        // CUR_USERID == "" || CUR_USERID == null
        //     ? Container()
        //     : _getDrawerItem(getTranslated(context, 'MYFEEDBACKLIST')!,
        //     'assets/images/pro_th.svg'),
        // CUR_USERID == "" || CUR_USERID == null
        //     ? Container()
        //     : _getDrawerItem(getTranslated(context, 'MYSITEVISITE')!,
        //     'assets/images/pro_th.svg'),
        // CUR_USERID == "" || CUR_USERID == null ? Container() : _getDivider(),
        // CUR_USERID == "" || CUR_USERID == null
        //     ? Container()
        //     : _getDrawerItem(getTranslated(context, 'MYTRANSACTION')!,
        //         'assets/images/pro_th.svg'),
        // CUR_USERID == "" || CUR_USERID == null ? Container() : _getDivider(),
        // _getDrawerItem(getTranslated(context, 'CHANGE_THEME_LBL')!,
        //     'assets/images/pro_theme.svg'),
        // CUR_USERID == "" || CUR_USERID == null
        //     ? Container()
        //     : _getDrawerItem("Request Training",
        //     'assets/images/pro_myorder.svg'),
        // _getDivider(),
        // _getDrawerItem(getTranslated(context, 'CHANGE_LANGUAGE_LBL')!,
        //     'assets/images/pro_language.svg'),
        //  CUR_USERID == "" || CUR_USERID == null ? Container() : _getDivider(),
        // CUR_USERID == "" || CUR_USERID == null
        //     ? Container()
        //     : _getDrawerItem(getTranslated(context, 'CHANGE_PASS_LBL')!,
        //         'assets/images/pro_pass.svg'),
        // _getDivider(),
        // CUR_USERID == "" || CUR_USERID == null || !refer
        //     ? Container()
        //     : _getDrawerItem(getTranslated(context, 'REFEREARN')!,
        //         'assets/images/pro_referral.svg'),
        // CUR_USERID == "" || CUR_USERID == null ? Container() : _getDivider(),
        // _getDrawerItem(getTranslated(context, 'CUSTOMER_SUPPORT')!,
        //     'assets/images/pro_customersupport.svg'),
        // _getDivider(),
        // _getDrawerItem(getTranslated(context, 'ABOUT_LBL')!,
        //     'assets/images/pro_aboutus.svg'),
        // _getDivider(),
        _getDrawerItem(getTranslated(context, 'CONTACT_LBL')!,
            'assets/images/pro_aboutus.svg'),
        _getDrawerItem(getTranslated(context, 'NOTIFICATION')!,
            'assets/images/notification.svg'),
        // _getDivider(),
        _getDrawerItem(
            getTranslated(context, 'FAQS')!, 'assets/images/pro_faq.svg'),
        // _getDivider(),
        _getDrawerItem(
            getTranslated(context, 'PRIVACY')!, 'assets/images/pro_pp.svg'),
        // _getDivider(),
        _getDrawerItem(
            getTranslated(context, 'TERM')!, 'assets/images/pro_tc.svg'),
        // _getDivider(),
        // _getDrawerItem(
        //     getTranslated(context, 'RATE_US')!, 'assets/images/pro_rateus.svg'),
        // _getDivider(),
        // _getDrawerItem(getTranslated(context, 'SHARE_APP')!,
        //     'assets/images/pro_share.svg'),
        // CUR_USERID == "" || CUR_USERID == null ? Container() : _getDivider(),
        CUR_USERID == "" || CUR_USERID == null
            ? Container()
            : _getDrawerItem(
                getTranslated(context, 'DELETE')!, 'assets/images/delete.svg'),
      ],
    );
  }

  deleteAccountDailog() async {
    await dialogAnimate(context,
        StatefulBuilder(builder: (BuildContext context, StateSetter setStater) {
      return StatefulBuilder(
          builder: (BuildContext context, StateSetter setStater) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(5.0))),
          content: Text(getTranslated(context, 'DELETEACCOUNT')!,
              style: TextStyle(color: Colors.black)),
          actions: <Widget>[
            TextButton(
                child: Text(getTranslated(context, 'NO')!,
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold)),
                onPressed: () {
                  Navigator.of(context).pop(false);
                }),
            TextButton(
                child: Text(getTranslated(context, 'YES')!,
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold)),
                onPressed: () {
                  deleteAccount();
                  // Navigator.pop(context);
                })
          ],
        );
      });
    }));
  }

  Future<DeleteAccountModel?> deleteAccount() async {
    var header = headers;
    var request = http.MultipartRequest('POST',
        Uri.parse('https://businesstrack.co.in/app/v1/api/delete_user'));
    request.fields.addAll({'user_id': CUR_USERID.toString()});
    print("User id in delet account ${request.fields}");
    request.headers.addAll(header);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      print("delete accountt responseeeee $response");
      final str = await response.stream.bytesToString();
      var data = DeleteAccountModel.fromJson(json.decode(str));
      // setSnackbar(data.message.toString());
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => LoginPage()));
      return DeleteAccountModel.fromJson(json.decode(str));
    } else {
      return null;
    }
  }

/*  _getDivider() {
    return Divider(
      height: 1,
      color: Theme.of(context).colorScheme.black26,
    );
  }*/

  _getDrawerItem(String title, String img) {
    return Card(
      elevation: 0,
      child: ListTile(
        trailing: Icon(
          Icons.navigate_next,
          color: colors.primary,
        ),
        leading: SvgPicture.asset(
          img,
          height: 25,
          width: 25,
          color: colors.primary,
        ),
        dense: true,
        title: Text(
          title,
          style: TextStyle(
              color: Theme.of(context).colorScheme.lightBlack, fontSize: 15),
        ),
        onTap: () {
          // if (title == getTranslated(context, 'MY_SITE_VISIT')) {
          //   Navigator.push(
          //     context,
          //     MaterialPageRoute(
          //       builder: (context) => MySiteVisite(),
          //     ),
          //   );
          //   //sendAndRetrieveMessage();
          // } else
          if (title == getTranslated(context, 'MYFEEDBACK')) {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Example(),
                ));
          } else if (title == getTranslated(context, 'MYSITEVISITE')) {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SiteVisitForm(),
                ));
          } else if (title == getTranslated(context, 'MY_COMMISSION')) {
            // Navigator.push(
            //     context,
            //     MaterialPageRoute(
            //       builder: (context) => MyLeadsAccounts(),
            //     ));
          } else if (title == getTranslated(context, 'MYFEEDBACKLIST')) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Customer_feedback(),
              ),
            );
          } else if (title == getTranslated(context, 'NOTIFICATION')) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => NotificationList(),
              ),
            );
          } else if (title == getTranslated(context, 'MYEARNINGS')) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => WorkallotmentScreen(),
              ),
            );
          } else if (title == getTranslated(context, 'SETTING')) {
            CUR_USERID == null
                ? Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoginPage(),
                    ))
                : Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Setting(),
                    ));
          } else if (title == getTranslated(context, 'MANAGE_ADD_LBL')) {
            CUR_USERID == null
                ? Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoginPage(),
                    ))
                : Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ManageAddress(
                        home: true,
                      ),
                    ));
          } else if (title == getTranslated(context, 'REFEREARN')) {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ReferEarn(),
                ));
          } else if (title == getTranslated(context, 'CONTACT_LBL')) {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PrivacyPolicy(
                    title: getTranslated(context, 'CONTACT_LBL'),
                  ),
                ));
          } else if (title == getTranslated(context, 'CUSTOMER_SUPPORT')) {
            CUR_USERID == null
                ? Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoginPage(),
                    ))
                : Navigator.push(context,
                    MaterialPageRoute(builder: (context) => CustomerSupport()));
          } else if (title == getTranslated(context, 'TERM')) {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PrivacyPolicy(
                    title: getTranslated(context, 'TERM'),
                  ),
                ));
          } else if (title == getTranslated(context, 'PRIVACY')) {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PrivacyPolicy(
                    title: getTranslated(context, 'PRIVACY'),
                  ),
                ));
          } else if (title == getTranslated(context, 'RATE_US')) {
            _openStoreListing();
          } else if (title == getTranslated(context, 'SHARE_APP')) {
            var str =
                "$appName\n\n${getTranslated(context, 'APPFIND')}$androidLink$packageName\n\n ${getTranslated(context, 'IOSLBL')}\n$iosLink";

            Share.share(str);
          } else if (title == getTranslated(context, 'ABOUT_LBL')) {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PrivacyPolicy(
                    title: getTranslated(context, 'ABOUT_LBL'),
                  ),
                ));
          } else if (title == getTranslated(context, 'FAQS')) {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Faqs(
                    title: getTranslated(context, 'FAQS'),
                  ),
                ));
          } else if (title == getTranslated(context, 'CHANGE_THEME_LBL')) {
            openChangeThemeBottomSheet();
          } else if (title == "Request Training") {
            openRequestTrainingBottomSheet();
          } else if (title == getTranslated(context, 'LOGOUT')) {
            logOutDailog();
          } else if (title == getTranslated(context, 'DELETE')) {
            deleteAccountDailog();
          } else if (title == getTranslated(context, 'CHANGE_PASS_LBL')) {
            openChangePasswordBottomSheet();
          } else if (title == getTranslated(context, 'CHANGE_LANGUAGE_LBL')) {
            openChangeLanguageBottomSheet();
          }
        },
      ),
    );
  }

  List<Widget> themeListView(BuildContext ctx) {
    return themeList
        .asMap()
        .map(
          (index, element) => MapEntry(
              index,
              InkWell(
                onTap: () {
                  _updateState(index, ctx);
                },
                child: Padding(
                  padding: EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 10),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            height: 25.0,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: curTheme == index
                                  ? colors.grad2Color
                                  : Theme.of(context).colorScheme.white,
                              border: Border.all(color: colors.grad2Color),
                            ),
                            child: Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: curTheme == index
                                    ? Icon(
                                        Icons.check,
                                        size: 17.0,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .fontColor,
                                      )
                                    : Icon(
                                        Icons.check_box_outline_blank,
                                        size: 15.0,
                                        color:
                                            Theme.of(context).colorScheme.white,
                                      )),
                          ),
                          Padding(
                              padding: EdgeInsetsDirectional.only(
                                start: 15.0,
                              ),
                              child: Text(
                                themeList[index]!,
                                style: Theme.of(ctx)
                                    .textTheme
                                    .subtitle1!
                                    .copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .lightBlack),
                              ))
                        ],
                      ),
                      // index == themeList.length - 1
                      //     ? Container(
                      //         margin: EdgeInsetsDirectional.only(
                      //           bottom: 10,
                      //         ),
                      //       )
                      //     : Divider(
                      //         color: Theme.of(context).colorScheme.lightBlack,
                      //       )
                    ],
                  ),
                ),
              )),
        )
        .values
        .toList();
  }

  _updateState(int position, BuildContext ctx) {
    curTheme = position;

    onThemeChanged(themeList[position]!, ctx);
  }

  void onThemeChanged(
    String value,
    BuildContext ctx,
  ) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (value == getTranslated(ctx, 'SYSTEM_DEFAULT')) {
      themeNotifier.setThemeMode(ThemeMode.system);
      prefs.setString(APP_THEME, DEFAULT_SYSTEM);

      var brightness = SchedulerBinding.instance!.window.platformBrightness;
      if (mounted)
        setState(() {
          isDark = brightness == Brightness.dark;
          if (isDark)
            SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
          else
            SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
        });
    } else if (value == getTranslated(ctx, 'LIGHT_THEME')) {
      themeNotifier.setThemeMode(ThemeMode.light);
      prefs.setString(APP_THEME, LIGHT);
      if (mounted)
        setState(() {
          isDark = false;
          SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
        });
    } else if (value == getTranslated(ctx, 'DARK_THEME')) {
      themeNotifier.setThemeMode(ThemeMode.dark);
      prefs.setString(APP_THEME, DARK);
      if (mounted)
        setState(() {
          isDark = true;
          SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
        });
    }
    ISDARK = isDark.toString();

    //Provider.of<SettingProvider>(context,listen: false).setPrefrence(APP_THEME, value);
  }

  Future<void> _openStoreListing() => _inAppReview.openStoreListing(
        appStoreId: appStoreId,
        microsoftStoreId: 'microsoftStoreId',
      );

  logOutDailog() async {
    await dialogAnimate(context,
        StatefulBuilder(builder: (BuildContext context, StateSetter setStater) {
      return StatefulBuilder(
          builder: (BuildContext context, StateSetter setStater) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(5.0))),
          content: Text(
            getTranslated(context, 'LOGOUTTXT')!,
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
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  prefs.setString('user_id', '');
                  SettingProvider settingProvider =
                      Provider.of<SettingProvider>(context, listen: false);
                  settingProvider.clearUserSession(context);
                  //favList.clear();
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      '/home', (Route<dynamic> route) => false);
                })
          ],
        );
      });
    }));
  }

  @override
  Widget build(BuildContext context) {
    languageList = [
      getTranslated(context, 'ENGLISH_LAN'),
      getTranslated(context, 'HINDI_LAN'),
      // getTranslated(context, 'CHINESE_LAN'),
      // getTranslated(context, 'SPANISH_LAN'),
      //
      // getTranslated(context, 'ARABIC_LAN'),
      // getTranslated(context, 'RUSSIAN_LAN'),
      // getTranslated(context, 'JAPANISE_LAN'),
      // getTranslated(context, 'GERMAN_LAN')
    ];
    themeList = [
      getTranslated(context, 'SYSTEM_DEFAULT'),
      getTranslated(context, 'LIGHT_THEME'),
      getTranslated(context, 'DARK_THEME')
    ];

    themeNotifier = Provider.of<ThemeNotifier>(context);

    return Scaffold(
      key: scaffoldKey,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _getHeader(),
              _getDrawer(),
            ],
          ),
        ),
      ),
    );
  }

  Widget getUserImage(String profileImage, VoidCallback? onBtnSelected) {
    return Stack(
      children: <Widget>[
        GestureDetector(
          onTap: () {
            if (mounted) {
              onBtnSelected!();
            }
          },
          child: Container(
            margin: EdgeInsetsDirectional.only(end: 20),
            height: 80,
            width: 80,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                    width: 1.0, color: Theme.of(context).colorScheme.white)),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(100.0),
              child:
                  Consumer<UserProvider>(builder: (context, userProvider, _) {
                return userProvider.profilePic != ''
                    ? new FadeInImage(
                        fadeInDuration: Duration(milliseconds: 150),
                        image:
                            CachedNetworkImageProvider(userProvider.profilePic),
                        height: 64.0,
                        width: 64.0,
                        fit: BoxFit.cover,
                        imageErrorBuilder: (context, error, stackTrace) =>
                            erroWidget(64),
                        placeholder: placeHolder(64),
                      )
                    : imagePlaceHolder(62, context);
              }),
            ),
          ),
        ),
        /*CircleAvatar(
      radius: 40,
      backgroundColor: colors.primary,
      child: profileImage != ""
          ? ClipRRect(
              borderRadius: BorderRadius.circular(40),
              child: FadeInImage(
                fadeInDuration: Duration(milliseconds: 150),
                image: NetworkImage(profileImage),
                height: 100.0,
                width: 100.0,
                fit: BoxFit.cover,
                placeholder: placeHolder(100),
                imageErrorBuilder: (context, error, stackTrace) =>
                    erroWidget(100),
              ))
          : Icon(
              Icons.account_circle,
              size: 80,
              color: Theme.of(context).colorScheme.white,
            ),
    ),*/
        if (CUR_USERID != null)
          Positioned.directional(
              textDirection: Directionality.of(context),
              end: 20,
              bottom: 5,
              child: Container(
                height: 20,
                width: 20,
                child: InkWell(
                  child: Icon(
                    Icons.edit,
                    color: Theme.of(context).colorScheme.white,
                    size: 10,
                  ),
                  onTap: () {
                    if (mounted) {
                      onBtnSelected!();
                    }
                  },
                ),
                decoration: BoxDecoration(
                    color: colors.primary,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(20),
                    ),
                    border: Border.all(color: colors.primary)),
              )),
      ],
    );
  }

  StateSetter? checkoutState;
  void openChangeUserDetailsBottomSheet() {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10), topRight: Radius.circular(10))),
        builder: (builder) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            checkoutState = setState;
            return Wrap(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom),
                  child: Form(
                    key: _changeUserDetailsKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        bottomSheetHandle(),
                        bottomsheetLabel("EDIT_PROFILE_LBL"),
                        Selector<UserProvider, String>(
                            selector: (_, provider) => provider.profilePic,
                            builder: (context, profileImage, child) {
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10.0),
                                child:
                                    getUserImage(profileImage, _imgFromGallery),
                              );
                            }),
                        Selector<UserProvider, String>(
                            selector: (_, provider) => provider.curUserName,
                            builder: (context, userName, child) {
                              return setNameField(userName);
                            }),
                        Selector<UserProvider, String>(
                            selector: (_, provider) => provider.email,
                            builder: (context, userEmail, child) {
                              return setEmailField(userEmail);
                            }),
                        saveButton(getTranslated(context, "SAVE_LBL")!, () {
                          validateAndSave(_changeUserDetailsKey);
                        }),
                      ],
                    ),
                  ),
                ),
              ],
            );
          });
        });

    // showModalBottomSheet(
    //   shape: const RoundedRectangleBorder(
    //       borderRadius: BorderRadius.only(
    //           topLeft: Radius.circular(40.0), topRight: Radius.circular(40.0))),
    //   isScrollControlled: true,
    //   context: context,
    //   builder: (context) {
    //     return StatefulBuilder(
    //       child:
    //       Wrap(
    //         children: [
    //           Padding(
    //             padding: EdgeInsets.only(
    //                 bottom: MediaQuery.of(context).viewInsets.bottom),
    //             child: Form(
    //               key: _changeUserDetailsKey,
    //               child: Column(
    //                 mainAxisSize: MainAxisSize.max,
    //                 children: [
    //                   bottomSheetHandle(),
    //                   bottomsheetLabel("EDIT_PROFILE_LBL"),
    //                   Selector<UserProvider, String>(
    //                       selector: (_, provider) => provider.profilePic,
    //                       builder: (context, profileImage, child) {
    //                         return Padding(
    //                           padding:
    //                               const EdgeInsets.symmetric(vertical: 10.0),
    //                           child:
    //                               getUserImage(profileImage, _imgFromGallery),
    //                         );
    //                       }),
    //                   Selector<UserProvider, String>(
    //                       selector: (_, provider) => provider.curUserName,
    //                       builder: (context, userName, child) {
    //                         return setNameField(userName);
    //                       }),
    //                   Selector<UserProvider, String>(
    //                       selector: (_, provider) => provider.email,
    //                       builder: (context, userEmail, child) {
    //                         return setEmailField(userEmail);
    //                       }),
    //                   saveButton(getTranslated(context, "SAVE_LBL")!, () {
    //                     validateAndSave(_changeUserDetailsKey);
    //                   }),
    //                 ],
    //               ),
    //             ),
    //           ),
    //         ],
    //       ),
    //     );
    //   },
    // );
  }

  String? categoryValue;
  void openRequestTrainingBottomSheet() {
    showModalBottomSheet(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(40.0), topRight: Radius.circular(40.0))),
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
          return Wrap(
            alignment: WrapAlignment.center,
            children: [
              Padding(
                  padding: EdgeInsets.all(15),
                  child: Text(
                    "Request Training",
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.fontColor,
                        fontSize: 24,
                        fontWeight: FontWeight.w600),
                  )),
              catList.isNotEmpty
                  ? Padding(
                      padding: const EdgeInsets.all(20),
                      child: Container(
                        padding: EdgeInsets.all(8),
                        height: 50,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.white,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                                color:
                                    Theme.of(context).colorScheme.fontColor)),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton(
                            hint: Text('Select Product type'),
                            // Not necessary for Option 1
                            value: categoryValue,
                            onChanged: (String? newValue) {
                              setState(() {
                                categoryValue = newValue;
                              });
                              print("this is category value $categoryValue");
                            },
                            items: catList.map((item) {
                              return DropdownMenuItem(
                                child: Text(
                                  item.name!,
                                  style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .fontColor),
                                ),
                                value: item.id,
                              );
                            }).toList(),
                          ),
                        ),
                      ))
                  : SizedBox.shrink(),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Container(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.white,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 5.0),
                    child: TextFormField(
                      //initialValue: nameController.text,
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.fontColor,
                          fontWeight: FontWeight.bold),
                      controller: messageController,
                      decoration: InputDecoration(
                          label: Text(
                            "Message",
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                          fillColor: Theme.of(context).colorScheme.primary,
                          border: InputBorder.none),
                      // validator: (val) => validateUserName(
                      //     val!,
                      //     getTranslated(context, 'USER_REQUIRED'),
                      //     getTranslated(context, 'USER_LENGTH')),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20.0, top: 10),
                child: ElevatedButton(
                    onPressed: () {
                      requestTraining();
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: colors.primary,
                        fixedSize:
                            Size(MediaQuery.of(context).size.width - 60, 50),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15))),
                    child: Text(
                      "Submit Request",
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: colors.whiteTemp),
                    )),
              )
              // Padding(
              //   padding: EdgeInsets.only(
              //       bottom: MediaQuery.of(context).viewInsets.bottom),
              //   child: Form(
              //     key: _changeUserDetailsKey,
              //     child: Column(
              //       mainAxisSize: MainAxisSize.max,
              //       children: [
              //         bottomSheetHandle(),
              //         bottomsheetLabel("EDIT_PROFILE_LBL"),
              //         Selector<UserProvider, String>(
              //             selector: (_, provider) => provider.profilePic,
              //             builder: (context, profileImage, child) {
              //               return Padding(
              //                 padding: const EdgeInsets.symmetric(vertical: 10.0),
              //                 child: getUserImage(profileImage, _imgFromGallery),
              //               );
              //             }),
              //         Selector<UserProvider, String>(
              //             selector: (_, provider) => provider.curUserName,
              //             builder: (context, userName, child) {
              //               return setNameField(userName);
              //             }),
              //         Selector<UserProvider, String>(
              //             selector: (_, provider) => provider.email,
              //             builder: (context, userEmail, child) {
              //               return setEmailField(userEmail);
              //             }),
              //         saveButton(getTranslated(context, "SAVE_LBL")!, () {
              //           validateAndSave(_changeUserDetailsKey);
              //         }),
              //       ],
              //     ),
              //   ),
              // ),
            ],
          );
        });
      },
    );
  }

  Widget bottomSheetHandle() {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            color: Theme.of(context).colorScheme.lightBlack),
        height: 5,
        width: MediaQuery.of(context).size.width * 0.3,
      ),
    );
  }

  Widget bottomsheetLabel(String labelName) => Padding(
        padding: const EdgeInsets.only(top: 30.0, bottom: 20),
        child: getHeading(labelName),
      );

  var image;
  void _imgFromGallery() async {
    var result = await FilePicker.platform.pickFiles();
    if (result != null) {
      image = File(result.files.single.path!);
      checkoutState!(() {});
    } else {
      // User canceled the picker
    }
  }

  Future<void> setProfilePic(image) async {
    _isNetworkAvail = await isNetworkAvailable();
    if (_isNetworkAvail) {
      try {
        var request = http.MultipartRequest("POST", (getUpdateUserApi));
        request.headers.addAll(headers);
        request.fields[USER_ID] = CUR_USERID!;
        var pic = await http.MultipartFile.fromPath(IMAGE, image.path);
        request.files.add(pic);
        var response = await request.send();
        var responseData = await response.stream.toBytes();
        var responseString = String.fromCharCodes(responseData);
        var getdata = json.decode(responseString);
        bool error = getdata["error"];
        String? msg = getdata['message'];
        print("msg :$msg");
        print('kkkkkkkkkkkkkkk${request.fields}');
        print(
            " detail : ${pic.field}, ${pic.length} , ${pic.filename} , ${pic.contentType} , ${pic.toString()}");
        if (!error) {
          var data = getdata["data"];
          for (var i in data) {
            image = i[IMAGE];
          }
          var settingProvider =
              Provider.of<SettingProvider>(context, listen: false);
          settingProvider.setPrefrence(IMAGE, image!);
          var userProvider = Provider.of<UserProvider>(context, listen: false);
          userProvider.setProfilePic(image!);
          setSnackbar(getTranslated(context, 'PROFILE_UPDATE_MSG')!);
        } else {
          setSnackbar(msg!);
        }
      } on TimeoutException catch (_) {
        setSnackbar(getTranslated(context, 'somethingMSg')!);
      }
    } else {
      if (mounted) {
        setState(() {
          _isNetworkAvail = false;
        });
      }
    }
  }

  Widget setNameField(String userName) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 15.0),
        child: Container(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.white,
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
            child: TextFormField(
              //initialValue: nameController.text,
              style: TextStyle(
                  color: Theme.of(context).colorScheme.fontColor,
                  fontWeight: FontWeight.bold),
              controller: nameController,
              decoration: InputDecoration(
                  label: Text(
                    getTranslated(
                      context,
                      "NAME_LBL",
                    )!,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  fillColor: Theme.of(context).colorScheme.primary,
                  border: InputBorder.none),
              validator: (val) => validateUserName(
                  val!,
                  getTranslated(context, 'USER_REQUIRED'),
                  getTranslated(context, 'USER_LENGTH')),
            ),
          ),
        ),
      );

  Widget setEmailField(String email) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 15.0),
        child: Container(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.white,
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
            child: TextFormField(
              style: TextStyle(
                  color: Theme.of(context).colorScheme.fontColor,
                  fontWeight: FontWeight.bold),
              controller: emailController,
              decoration: InputDecoration(
                  label: Text(
                    getTranslated(context, "EMAILHINT_LBL")!,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  fillColor: Theme.of(context).colorScheme.primary,
                  border: InputBorder.none),
              validator: (val) => validateEmail(
                  val!,
                  getTranslated(context, 'EMAIL_REQUIRED'),
                  getTranslated(context, 'VALID_EMAIL')),
            ),
          ),
        ),
      );

  Widget saveButton(String title, VoidCallback? onBtnSelected) {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8.0),
            child: MaterialButton(
              height: 45.0,
              textColor: Theme.of(context).colorScheme.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              onPressed: onBtnSelected,
              child: Text(
                title,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.fontColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              color: colors.primary,
            ),
          ),
        ),
      ],
    );
  }

  Future<bool> validateAndSave(GlobalKey<FormState> key) async {
    final form = key.currentState!;
    setProfilePic(image);
    form.save();
    if (form.validate()) {
      if (key == _changePwdKey) {
        await setUpdateUser(CUR_USERID!, passwordController.text,
            newpassController.text, "", "");
        passwordController.clear();
        newpassController.clear();
        passwordController.clear();
        confirmpassController.clear();
      } else if (key == _changeUserDetailsKey) {
        setUpdateUser(
            CUR_USERID!, "", "", nameController.text, emailController.text);
      }
      return true;
    }
    return false;
  }

  Widget getHeading(String title) {
    return Text(
      getTranslated(context, title)!,
      style: Theme.of(context).textTheme.headline6!.copyWith(
          fontWeight: FontWeight.bold,
          color: Theme.of(context).colorScheme.fontColor),
    );
  }

  void openChangePasswordBottomSheet() {
    showModalBottomSheet(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40.0),
                topRight: Radius.circular(40.0))),
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return Wrap(
            children: [
              Padding(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child: Form(
                  key: _changePwdKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      bottomSheetHandle(),
                      bottomsheetLabel("CHANGE_PASS_LBL"),
                      setCurrentPasswordField(),
                      setForgotPwdLable(),
                      newPwdField(),
                      confirmPwdField(),
                      saveButton(getTranslated(context, "SAVE_LBL")!, () {
                        validateAndSave(_changePwdKey);
                      }),
                    ],
                  ),
                ),
              ),
            ],
          );
        });
  }

  void openChangeLanguageBottomSheet() {
    showModalBottomSheet(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40.0),
                topRight: Radius.circular(40.0))),
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return Wrap(
            children: [
              Padding(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child: Form(
                  key: _changePwdKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      bottomSheetHandle(),
                      bottomsheetLabel("CHOOSE_LANGUAGE_LBL"),
                      StatefulBuilder(
                        builder:
                            (BuildContext context, StateSetter setModalState) {
                          return SingleChildScrollView(
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: getLngList(context, setModalState)),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        });
  }

  void openChangeThemeBottomSheet() {
    themeList = [
      getTranslated(context, 'SYSTEM_DEFAULT'),
      getTranslated(context, 'LIGHT_THEME'),
      getTranslated(context, 'DARK_THEME')
    ];

    showModalBottomSheet(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40.0),
                topRight: Radius.circular(40.0))),
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return Wrap(
            children: [
              Padding(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child: Form(
                  key: _changePwdKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      bottomSheetHandle(),
                      bottomsheetLabel("CHOOSE_THEME_LBL"),
                      SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: themeListView(context),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        });
  }

  Widget setCurrentPasswordField() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 15.0),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.white,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
          child: TextFormField(
            controller: passwordController,
            obscureText: true,
            obscuringCharacter: "*",
            style: TextStyle(
              color: Theme.of(context).colorScheme.fontColor,
            ),
            decoration: InputDecoration(
                label: Text(getTranslated(context, "CUR_PASS_LBL")!),
                fillColor: Theme.of(context).colorScheme.white,
                border: InputBorder.none),
            onSaved: (String? value) {
              currentPwd = value;
            },
            validator: (val) => validatePass(
                val!,
                getTranslated(context, 'PWD_REQUIRED'),
                getTranslated(context, 'PWD_LENGTH')),
          ),
        ),
      ),
    );
  }

  Widget setForgotPwdLable() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8.0),
      child: Align(
        alignment: Alignment.centerRight,
        child: InkWell(
          child: Text(getTranslated(context, "FORGOT_PASSWORD_LBL")!),
          onTap: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => LoginPage()));
          },
        ),
      ),
    );
  }

  Widget newPwdField() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 15.0),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.white,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
          child: TextFormField(
            controller: newpassController,
            obscureText: true,
            obscuringCharacter: "*",
            style: TextStyle(
              color: Theme.of(context).colorScheme.fontColor,
            ),
            decoration: InputDecoration(
                label: Text(getTranslated(context, "NEW_PASS_LBL")!),
                fillColor: Theme.of(context).colorScheme.white,
                border: InputBorder.none),
            onSaved: (String? value) {
              newPwd = value;
            },
            validator: (val) => validatePass(
                val!,
                getTranslated(context, 'PWD_REQUIRED'),
                getTranslated(context, 'PWD_LENGTH')),
          ),
        ),
      ),
    );
  }

  Widget confirmPwdField() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 15.0),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.white,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
          child: TextFormField(
            controller: confirmpassController,
            focusNode: confirmPwdFocus,
            obscureText: true,
            obscuringCharacter: "*",
            style: TextStyle(
                color: Theme.of(context).colorScheme.fontColor,
                fontWeight: FontWeight.bold),
            decoration: InputDecoration(
                label: Text(getTranslated(context, "CONFIRMPASSHINT_LBL")!),
                fillColor: Theme.of(context).colorScheme.white,
                border: InputBorder.none),
            validator: (value) {
              if (value!.isEmpty) {
                return getTranslated(context, 'CON_PASS_REQUIRED_MSG');
              }
              if (value != newPwd) {
                confirmpassController.text = "";
                confirmPwdFocus.requestFocus();
                return getTranslated(context, 'CON_PASS_NOT_MATCH_MSG');
              } else {
                return null;
              }
            },
          ),
        ),
      ),
    );
  }
}
