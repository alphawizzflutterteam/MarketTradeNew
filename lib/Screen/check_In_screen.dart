import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:omega_employee_management/Helper/Color.dart';
import 'package:omega_employee_management/Helper/Session.dart';
import 'package:omega_employee_management/Screen/Dashboard.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Helper/String.dart';
import 'package:http/http.dart'as http;
import 'package:flutter_background_service_android/flutter_background_service_android.dart';


import '../Model/GetSettingModel.dart';

var latitude;
var longitude;

class CheckInScreen extends StatefulWidget {
  const CheckInScreen({Key? key}) : super(key: key);

  @override
  State<CheckInScreen> createState() => _CheckInScreenState();
}
Future<void> initializeService() async {
  final service = FlutterBackgroundService();

  /// OPTIONAL, using custom notification channel id
  const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'my_foreground', // id
    'MY FOREGROUND SERVICE', // title
    description:
    'This channel is used for important notifications.', // description
    importance: Importance.low, // importance must be at low or higher level
  );

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  if (Platform.isIOS || Platform.isAndroid) {
    await flutterLocalNotificationsPlugin.initialize(
      const InitializationSettings(
        //iOS: DarwinInitializationSettings(),
        android: AndroidInitializationSettings('ic_bg_service_small'),
      ),
    );
  }

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
      AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  await service.configure(
    androidConfiguration: AndroidConfiguration(
      // this will be executed when app is in foreground or background in separated isolate
      onStart: onStart,

      // auto start service
      autoStart: true,
      isForegroundMode: true,

      notificationChannelId: 'my_foreground',
      initialNotificationTitle: 'AWESOME SERVICE',
      initialNotificationContent: 'Initializing',
      foregroundServiceNotificationId: 888,
    ),
    iosConfiguration: IosConfiguration(
      // auto start service
      autoStart: true,

      // this will be executed when app is in foreground in separated isolate
      onForeground: onStart,

      // you have to enable background fetch capability on xcode project
      onBackground: onIosBackground,
    ),
  );

}

Future<bool> onIosBackground(ServiceInstance service) async {
  WidgetsFlutterBinding.ensureInitialized();
  DartPluginRegistrant.ensureInitialized();

  SharedPreferences preferences = await SharedPreferences.getInstance();
  await preferences.reload();
  final log = preferences.getStringList('log') ?? <String>[];
  log.add(DateTime.now().toIso8601String());
  await preferences.setStringList('log', log);

  return true;
}
updateLocation1(Position position) async {
  final box = GetStorage();
  String? userId = box.read('userid');
  var headers = {
    'Cookie': 'ci_session=62f533d7ea1e427426f49c952c6f72cc384b47c7'
  };
  var request = http.MultipartRequest('POST', Uri.parse(updateLiveLocation.toString()));
  request.fields.addAll({
    'lat': position.latitude.toString(),
    'lng': position.longitude.toString(),
    'user_id': "${userId}"
  });
  print("update location parameter ${request.fields}");
  request.headers.addAll(headers);
  http.StreamedResponse response = await request.send();
  if (response.statusCode == 200) {
    print(await response.stream.bytesToString());
  }
  else {
    print(response.reasonPhrase);
  }
}

// setIsCheckOut() async {
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   prefs.setBool("checkIn", false);
// }
//
// Future<void> checkOutNow(currentAddress) async {
//   var headers = {
//     'Cookie': 'ci_session=3515d88c5cab45d32a201da39275454c5d051af2'
//   };
//   var request = http.MultipartRequest('POST', Uri.parse(checkOutNowApi.toString()));
//   request.fields.addAll({
//     'user_id': CUR_USERID.toString(),
//     'checkout_latitude': '${latitude}',
//     'checkout_longitude': '${longitude}',
//     'address': currentAddress,
//     // 'redings': readingCtr.text
//   });
//
//
//   print("this is my check in request ${request.fields.toString()}");
//   request.headers.addAll(headers);
//   http.StreamedResponse response = await request.send();
//   if (response.statusCode == 200) {
//     var str = await response.stream.bytesToString();
//     var result = json.decode(str);
//
//     if(result['data']['error'] == false) {
//       setIsCheckOut();
//       Fluttertoast.showToast(msg: result['data']['msg']);
//     } else {
//       Fluttertoast.showToast(msg: result['message']);
//     }
//     // var finalResponse = GetUserExpensesModel.fromJson(result);
//     // final finalResponse = CheckInModel.fromJson(json.decode(Response));
//   }
//   else {
//     print(response.reasonPhrase);
//   }
// }

@pragma('vm:entry-point')
void onStart(ServiceInstance service) async {
  // Only available for flutter 3.0.0 and later
  DartPluginRegistrant.ensureInitialized();

  // For flutter prior to version 3.0.0
  // We have to register the plugin manually

  SharedPreferences preferences = await SharedPreferences.getInstance();
  await preferences.setString("hello", "world");

  /// OPTIONAL when use custom notification
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  if (service is AndroidServiceInstance) {
    service.on('setAsForeground').listen((event) {
      service.setAsForegroundService();
    });

    service.on('setAsBackground').listen((event) {
      service.setAsBackgroundService();
    });
  }

  service.on('stopService').listen((event) {
    service.stopSelf();
  });

  // bring to foreground
  Timer.periodic(const Duration(seconds: 1), (timer) async {
    if (service is AndroidServiceInstance) {
      if (await service.isForegroundService()) {
        /// OPTIONAL for use custom notification
        /// the notification id must be equals with AndroidConfiguration when you call configure() method.
        flutterLocalNotificationsPlugin.show(
          888,
          'COOL SERVICE',
          'Awesome ${DateTime.now()}',
          const NotificationDetails(
            android: AndroidNotificationDetails(
              'my_foreground',
              'MY FOREGROUND SERVICE',
              icon: 'ic_bg_service_small',
              ongoing: true,
            ),
          ),
        );

        // if you don't using custom notification, uncomment this
        service.setForegroundNotificationInfo(
          title: "My App Service",
          content: "Updated at ${DateTime.now()}",
        );
      }
    }
   Position position= await Geolocator.getCurrentPosition();
     updateLocation1(position);
    //
    // List<Placemark> placemark = await placemarkFromCoordinates(
    //     double.parse(position.latitude.toString()), double.parse(position.longitude.toString()),
    //     localeIdentifier: "en");
    // String currentAddress = "${placemark[0].street}, ${placemark[0].subLocality}, ${placemark[0].locality}";
    // // if(DateTime.now().hour == "21" &&DateTime.now().minute == "1"){
    // var prefs = await SharedPreferences.getInstance();
    // bool? isCheckIn = prefs.getBool("checkIn");
    // if(isCheckIn ?? false){
    //   checkOutNow(currentAddress);
    // }

    // }

    /// you can see this log in logcat
    print('FLUTTER BACKGROUND SERVICE: ${DateTime.now()}  ${position.latitude}  ${position.longitude}');

    // test using external plugin

    final deviceInfo = DeviceInfoPlugin();
    String? device;
    if (Platform.isAndroid) {
      final androidInfo = await deviceInfo.androidInfo;
      device = androidInfo.model;
    }

    if (Platform.isIOS) {
      final iosInfo = await deviceInfo.iosInfo;
      device = iosInfo.model;
    }

    service.invoke(
      'update',
      {
        "current_date": DateTime.now().toIso8601String(),
        "device": device,
      },
    );
  });
}
class _CheckInScreenState extends State<CheckInScreen> {

  var pinController = TextEditingController();
  var currentAddress = TextEditingController();
  var readingCtr = TextEditingController();

  bool isLoading = false;
  var finalResult;

  File? _imageFile;

  _getFromCamera() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera,
    );
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
        imagePathList.add(_imageFile?.path ?? "");
        isImages = true;
      });
      //Navigator.pop(context);
    }
  }

  String? addClient;
  String? viewClient;
  String? getTag;
  String? addPhoto;
  String? feedbackAdd;
  String? feedbackView;
  String? serveyAdd;
  String? serveyView;

  // updateLocationPeriodically() {
  //   Timer.periodic(Duration(minutes: updateTime), (timer) async {
  //     Position position =  await getCurrentLoc();
  //     if (position != null) {
  //       // Do something with the updated location, e.g., send it to a server.
  //       print("Updated Location: ${position.latitude}, ${position.longitude}");
  //     }
  //     updateLocation();
  //   });
  // }

  // latLongUpdate() async {
  //   Timer.periodic(Duration(minutes: 1), (timer) async {
  //     updateLocation();
  //     // Update your UI or perform any necessary operations with the new latitude and longitude values.
  //   });
  // }

  String? updateTime;

  GetSettingModel? setting;
  getSetting() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var headers = {
      'Cookie': 'ci_session=44b4255b3a85f9bd283902547862274a907e9997'
    };
    var request = http.MultipartRequest('POST', Uri.parse(getSettingApi.toString()));
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      print("get setting apiiii wokinggg");
      String str = await response.stream.bytesToString();
      var result = json.decode(str);
      var finalResponse = GetSettingModel.fromJson(result);
      updateTime = setting?.data?.systemSettings?[0].updateLocationTime ?? "";
      print("update time issss ${updateTime}");
      setState(() {
        setting = finalResponse;
      });
    }
    else {
      print(response.reasonPhrase);
    }
  }

  // updateLocation() async {
  //   final box = GetStorage();
  //   String? userId = box.read('userid');
  //   print('_________this${userId}_______');
  //  // print("User id"+prefs.getString("userid").toString()??"");
  //   var headers = {
  //     'Cookie': 'ci_session=62f533d7ea1e427426f49c952c6f72cc384b47c7'
  //   };
  //   var request = http.MultipartRequest('POST', Uri.parse(updateLiveLocation.toString()));
  //   request.fields.addAll({
  //     'lat': latitude.toString(),
  //     'lng': longitude.toString(),
  //     'user_id': userId.toString(),
  //   });
  //   print("update location parameter ${request.fields}");
  //   request.headers.addAll(headers);
  //   http.StreamedResponse response = await request.send();
  //   if (response.statusCode == 200) {
  //     print(await response.stream.bytesToString());
  //   }
  //   else {
  //     print(response.reasonPhrase);
  //   }
  // }

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
    setState(() {
      longitude_Global=latitude;
      lattitudee_Global=longitude;
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
          currentlocation_Global=currentAddress.text.toString();
        });
        print('Latitude=============${latitude}');
        print('Longitude*************${longitude}');

        print('Current Addresssssss${currentAddress.text}');
      });
      if (currentAddress.text == "" || currentAddress.text == null) {
      } else {
        setState(() {
          // navigateToPage();
        });
      }
    }
  }
setCheckIn() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setBool("CheckIn", true);
  prefs.setString("CheckInTime", DateTime.now().toString());
}
  Future<void> checkInNow() async {
    debugPrint("checkin");
    SharedPreferences prefs = await SharedPreferences.getInstance();
   String? uid = prefs.getString("user_id");
    var headers = {
      'Cookie': 'ci_session=3515d88c5cab45d32a201da39275454c5d051af2'
    };
    var request = http.MultipartRequest('POST', Uri.parse(checkInNowApi.toString()));
    request.fields.addAll({
      'user_id':   uid?? "",
      // CUR_USERID.toString(),
      'checkin_latitude': '${latitude}',
      'checkin_longitude': '${longitude}',
      'address': currentAddress.text,
      'redings': readingCtr.text
    });
    for (var i = 0; i < (imagePathList.length ?? 0); i++) {
      print('Imageeeeeeeeeeee ${imagePathList}');
      imagePathList[i] == ""
          ? null
          : request.files.add(await http.MultipartFile.fromPath(
          'checkinimages[]', imagePathList[i].toString()));
    }
    print("this is my check in request ${request.fields.toString()}");
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var str = await response.stream.bytesToString();
      var result = json.decode(str);
      finalResult = result['data'];
      setState(() {
        isLoading = false;
      });
      if(result['data']['error'] == false) {
        await setCheckIn();

        Fluttertoast.showToast(msg: result['data']['msg']);
        // Navigator.pop(context, true);
        Navigator.push(context, MaterialPageRoute(builder: (context) => Dashboard()));
      } else {
        setState(() {
          isLoading = false;
        });
        Fluttertoast.showToast(msg: result['data']['msg']);
      }
      // var finalResponse = GetUserExpensesModel.fromJson(result);
      // final finalResponse = CheckInModel.fromJson(json.decode(Response));
    }
    else {
      print(response.reasonPhrase);
    }
  }

  navigateToPage() async {
    Future.delayed(Duration(milliseconds: 800), () {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => Dashboard()),
          (route) => false);
    });
  }

  ///MULTI IMAGE PICKER FROM GALLERY CAMERA
  ///
  ///
  ///
  ///
  ///
  List imagePathList = [];
  bool isImages = false;
  Future<void> getFromGallery() async {
    var result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: true,
      allowCompression: true,
    );
    if (result != null) {
      setState(() {
        isImages = true;
        // servicePic = File(result.files.single.path.toString());
      });
      imagePathList = result.paths.toList();
      // imagePathList.add(result.paths.toString()).toList();
      print("SERVICE PIC === ${imagePathList}");
      Navigator.pop(context);
    } else {
      Navigator.pop(context);
      // User canceled the picker
    }
  }

  Widget uploadMultiImmage() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(
          height: 10,
        ),
        InkWell(
            onTap: () async {
              _getFromCamera();
              // pickImageDialog(context, 1);
              // await pickImages();
            },
            child: Container(
                height: 40,
                width: 125,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: colors.primary),
                child: Center(
                    child: Text(
                      "Upload Images",
                      style: TextStyle(color: colors.whiteTemp, fontWeight: FontWeight.bold, fontSize: 12),
                    ),
                ),
             ),
          ),
          const SizedBox(height: 10),
         Visibility(
            visible: isImages,
            child:  buildGridView()),
      ],
    );
  }

  Widget buildGridView() {
    return Container(
      height: 170,
      child: GridView.builder(
        itemCount: imagePathList.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (BuildContext context, int index) {
          return Stack(
            children: [
              Container(
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
                border: Border.all(color: colors.primary)
                ),
                width: MediaQuery.of(context).size.width/2.8,
                height: 170,
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  child: Image.file(
                      File(imagePathList[index]), fit: BoxFit.cover),
                ),
              ),
              Positioned(
               bottom: 10,
                child: Container(
                 decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
                 border: Border.all(color: colors.primary),),
                width:MediaQuery.of(context).size.width/2.8,
                  height: 70,
                  child: Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Date: ${formattedDate}", style: TextStyle(fontSize: 10, color: Colors.white),),
                        Text("Time: ${timeData}", style: TextStyle(fontSize: 10, color: Colors.white),),
                        Text("Location: ${currentAddress.text}", style: TextStyle(fontSize: 10, color: Colors.white),overflow: TextOverflow.ellipsis,maxLines: 2,)
                      ],
                    ),
                  ),
                ),
                // InkWell(
                //   onTap: () {
                //     setState(() {
                //       imagePathList.remove(imagePathList[index]);
                //     });
                //   },
                //   child: Icon(
                //     Icons.remove_circle,
                //     size: 30,
                //     color: Colors.red.withOpacity(0.7),
                //   ),
                // ),
              ),
            ],
          );
        },
      ),
    );
  }

  void pickImageDialog(BuildContext context,int i) async {
    return await showDialog<void>(
      context: context,
      // barrierDismissible: barrierDismissible, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(6))),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              // InkWell(
              //   onTap: () async {
              //     getFromGallery();
              //   },
              //   child:  Container(
              //     child: ListTile(
              //         title:  Text("Gallery"),
              //         leading: Icon(
              //           Icons.image,
              //           color: colors.primary,
              //         ),
              //     ),
              //   ),
              // ),
              Container(
                width: 200,
                height: 1,
                color: Colors.black12,
              ),
              InkWell(
                onTap: () async {
                  _getFromCamera();
                  // getImage(ImgSource.Camera, context, i);
                },
                child: Container(
                  child: ListTile(
                      title: Text("Camera"),
                      leading: Icon(
                        Icons.camera,
                        color: colors.primary,
                      ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // Future getImage(ImgSource source, BuildContext context, int i) async {
  //   var image = await ImagePickerGC.pickImage(
  //     imageQuality:40,
  //     context: context,
  //     source: source,
  //     cameraIcon: const Icon(
  //       Icons.add,
  //       color: Colors.red,
  //     ), //cameraIcon and galleryIcon can change. If no icon provided default icon will be present
  //   );
  //   getCropImage(context, i, image);
  //   // back();
  // }

  void getCropImage(BuildContext context, int i, var image) async {
    CroppedFile? croppedFile = await ImageCropper.platform.cropImage(
      sourcePath: image.path,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9,
      ],
    );
    Navigator.pop(context);
    if (i == 1) {
      imagePathList.add(croppedFile!.path);
      setState(() {
        isImages = true;
      });
      print("this is my camera image $imagePathList");
      // imageFile = File(croppedFile!.path);
    }
    back();
  }

  ///MULTI IMAGE PICKER FROM GALLERY CAMERA
  ///
  ///

  @override
void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentLoc();
    getSetting();
    //latLongUpdate();
    convertDateTimeDispla();
    FlutterBackgroundService().invoke("setAsForeground");
  }

  var dateFormate;
  String? formattedDate;
  String? timeData;

  convertDateTimeDispla() {
    var now = new DateTime.now();
    var formatter = new DateFormat('yyyy-MM-dd');
    formattedDate = formatter.format(now);
    print("datedetet$formattedDate"); // 2016-01-25
    timeData = DateFormat("hh:mm:ss a").format(DateTime.now());
    print("timeeeeeeeeee$timeData");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors.white70,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.transparent,
        // leading: IconButton(onPressed: (){
        //   Navigator.pop(context);
        // }, icon: Icon(Icons.arrow_back_ios, color: Colors.white,)),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 200,
                width: 200,
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      "assets/images/checkin.png",
                      fit: BoxFit.cover,
                    )),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Checking in.....",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: colors.whiteTemp),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 10,
              ),
              currentAddress.text == "" || currentAddress.text == null
                  ? Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: Text(
                        "Locating...",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                    )
                    :Text(
                      "${currentAddress.text}",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                      ),
                    ),
              SizedBox(height: 15),
              uploadMultiImmage(),
              // uploadMultiImage()
              SizedBox(height: 10),
              Container(
                height: 40,
                width: 145,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: colors.primary),
                child: TextFormField(
                  maxLength: 6,
                  controller: readingCtr,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(left: 10, bottom: 10),
                    counterText: "",
                    border: InputBorder.none,
                    hintText: "Add Odometer Start Reading",
                    hintStyle: TextStyle(fontSize: 12, color: colors.whiteTemp),
                  ),

                ),
              ),
              SizedBox(height: 20),
              Container(
                  height: 45,
                  width: 220,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          elevation: 0,
                          shape: StadiumBorder(),
                          fixedSize: Size(350, 40),
                          backgroundColor: colors.primary.withOpacity(0.8)
                      ),
                      onPressed: () {
                        // Navigator.push(context, MaterialPageRoute(builder: (context) => Dashboard()));
                        if(latitude == null || longitude == null ||  _imageFile == null ) {
                          setSnackbar("Please select a image", context);
                        }
                        else if(readingCtr.text.isEmpty){
                          setSnackbar("Please enter Odometer start reading", context);
                        }
                        else {
                          setState(() {
                            isLoading = true;
                          });
                          checkInNow();

                        }
                     },
                      child: isLoading? Center(
                        child: CircularProgressIndicator(color: Colors.white,),
                      ): Text('CHECK IN NOW'),
                  ),
              ),
               SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
