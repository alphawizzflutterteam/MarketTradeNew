import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:omega_employee_management/Helper/Session.dart';
import 'package:omega_employee_management/Model/new_category_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Helper/Color.dart';
import '../Helper/String.dart';
import '../Model/Section_Model.dart';
import 'package:http/http.dart' as http;

import '../Model/get_user_expenses_model.dart';

class AddExpenseScreen extends StatefulWidget {
  final Product? data;
  final UserExpenses? userExpenses;
  final bool? isUpdate;

  AddExpenseScreen({Key? key, this.data, this.userExpenses, this.isUpdate}) : super(key: key);

  @override
  State<AddExpenseScreen> createState() => _AddExpenseScreenState();
}

class _AddExpenseScreenState extends State<AddExpenseScreen> {
  TextEditingController amountcontroller = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController fromController = TextEditingController();
  TextEditingController toController = TextEditingController();


  File? image;
  String? latitude;
  String? longitude;
  var pinController = TextEditingController();
  var currentAddress = TextEditingController();
bool isLoading =false;
  List<Data> subcategory = [];
  var subCategoryValue;

  getSubCategory() async {
      SharedPreferences pref = await SharedPreferences.getInstance();
      String? cat_id = pref.getString('cat_id');
      print("Categeggegegegegeg${cat_id}");


    var headers = {
      'Cookie': 'ci_session=5b275056e99daf066cd95d54b384b2ccd46f50b1'
    };
    var request =
        http.MultipartRequest('POST', Uri.parse('${getCatApi.toString()}'));
    request.fields.addAll({
      'id': widget.isUpdate == true ?
         widget.userExpenses!.spentType.toString() :
    '${widget.data!.id.toString()}'});
    print("res ${request.fields}");
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var finalResponse = await response.stream.bytesToString();
      final jsonResponse = json.decode(finalResponse);
      print("json response here  ${jsonResponse} and ${jsonResponse}");
      subcategory = NewCategoryModel.fromJson(jsonResponse).data!;
      print('jjjjjjjjjjjjjjjjjj${subcategory}');
      setState(() {

      });
      // setState(() {
      //   subCategoryModel = jsonResponse['data'];
      // });
    } else {
      print(response.reasonPhrase);
    }
  }

  ///MULTI IMAGE PICKER FROM GALLERY CAMERA
  ///
  ///
  ///

  List imagePathList = [];
  bool isImages = false;
  Future<void> getFromGallery() async {
    var result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: true,
      allowCompression: true
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

  Widget uploadMultiImage() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(
          height: 10,
        ),
        InkWell(
            onTap: () async {
              pickImageDialog(context, 1);
              // await pickImages();
            },
            child: Container(
                height: 40,
                width: 150,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: colors.primary),
                child: Center(
                    child: Text(
                  "Upload Pictures",
                  style: TextStyle(color: colors.whiteTemp),
                )))),
        const SizedBox(
          height: 10,
        ),
        Visibility(
            visible: isImages,
            child: imagePathList != null ? buildGridView() : SizedBox.shrink())
      ],
    );
  }

  Widget buildGridView() {
    return Container(
      height: 165,
      child: GridView.builder(
        itemCount: imagePathList.length,
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (BuildContext context, int index) {
          return Stack(
            children: [
              Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15))),
                  child: Container(
                    width: MediaQuery.of(context).size.width / 2,
                    height: MediaQuery.of(context).size.height / 2,
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      child: Image.file(File(imagePathList[index]),
                          fit: BoxFit.cover),
                    ),
                  )),
              Positioned(
                top: 5,
                right: 10,
                child: InkWell(
                  onTap: () {
                    setState(() {
                      imagePathList.remove(imagePathList[index]);
                    });
                  },
                  child: Icon(
                    Icons.remove_circle,
                    size: 30,
                    color: Colors.red.withOpacity(0.7),
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }

  void pickImageDialog(BuildContext context, int i) async {
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
              InkWell(
                onTap: () async {
                  getFromGallery();
                },
                child: Container(
                  child: ListTile(
                      title: Text("Gallery"),
                      leading: Icon(
                        Icons.image,
                        color: colors.primary,
                      )),
                ),
              ),
              Container(
                width: 200,
                height: 1,
                color: Colors.black12,
              ),
              InkWell(
                onTap: () async {
                  // getImage(ImgSource.Camera, context, i);
                },
                child: Container(
                  child: ListTile(
                      title: Text("Camera"),
                      leading: Icon(
                        Icons.camera,
                        color: colors.primary,
                      )),
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
  //     imageQuality: 90,
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
        CropAspectRatioPreset.ratio16x9
      ],
    );
    Navigator.pop(context);
    if (i == 1) {
      imagePathList.add(croppedFile!.path);
      setState(() {
        isImages = true;
        // servicePic = File(result.files.single.path.toString());
      });
      print("this is my camera image $imagePathList");
      // imageFile = File(croppedFile!.path);
    } else if (i == 2) {
      // imageFile2 = File(croppedFile!.path);
    }
    // updateProfile();
    // update();
    back();
  }

  ///MULTI IMAGE PICKER FROM GALLERY CAMERA
  ///
  ///

  @override
  void initState() {
    getCurrentLoc();
    print("lat longgggg ${longitude_Global} ${lattitudee_Global} ");
    print(currentlocation_Global);
    super.initState();
    getSubCategory();
    if(widget.isUpdate == true){
      amountcontroller.text =widget.userExpenses!.amount.toString();
      descriptionController.text = widget.userExpenses!.description.toString();
      fromController.text= widget.userExpenses!.from.toString();
      toController.text = widget.userExpenses!.to.toString();
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: colors.primary,
            )),
        backgroundColor: colors.whiteTemp,
        centerTitle: true,
        title: Text(
          widget.data?.name.toString() ?? "Update expenses",
          style: TextStyle(color: colors.primary),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 15, right: 15),
        child: SingleChildScrollView(
          child: Column(
              children: [
            SizedBox(
              height: 30,
            ),

            Padding(
                padding: const EdgeInsets.only(top: 20, bottom: 10),
                child: Container(
                    padding: EdgeInsets.only(left: 8),
                    height: 50,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                            color: Theme.of(context).colorScheme.fontColor)),
                    child:  subcategory.isNotEmpty?
                    DropdownButton(
                      underline: Container(),
                      value: subCategoryValue,
                       hint:Text("Select Category"),
                      isExpanded: true,
                      icon: Container(
                          alignment: Alignment.centerRight,
                          width: MediaQuery.of(context).size.width / 2.7,
                          child: Icon(Icons.keyboard_arrow_down)),

                      items: subcategory[0].children!.map((items) {
                        return DropdownMenuItem(
                          value: items.id,
                          child: Text(items.name!),
                        );
                      }).toList(),
                      onChanged: (newValue) {
                        setState(() {
                          subCategoryValue = newValue! as String?;
                        });
                      },
                    )
                        : Center(
                          child: Container(
                           width: 30,
                           height: 30,
                            child: CircularProgressIndicator(color: colors.primary,)),
                        )
                )),
                   widget.data?.name.toString() == 'Travel'?
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 10),
                  child: Container(
                    padding: EdgeInsets.all(8),
                    height: 50,
                    decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                            color: Theme.of(context).colorScheme.fontColor)),
                    width: MediaQuery.of(context).size.width,
                    child: TextFormField(
                      maxLines: 1,
                      style:
                      TextStyle(color: Theme.of(context).colorScheme.fontColor),
                      keyboardType: TextInputType.name,
                      // maxLength: 10,
                      controller: fromController,
                      decoration: InputDecoration(
                          counterText: '',
                          border: InputBorder.none,
                          hintText: "From"),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only( bottom: 10),
                  child: Container(
                    padding: EdgeInsets.all(8),
                    height: 50,
                    decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                            color: Theme.of(context).colorScheme.fontColor)),
                    width: MediaQuery.of(context).size.width,
                    child: TextFormField(
                      maxLines: 1,
                      style:
                      TextStyle(color: Theme.of(context).colorScheme.fontColor),
                      keyboardType: TextInputType.name,
                      // maxLength: 10,
                      controller: toController,
                      decoration: InputDecoration(
                          counterText: '',
                          border: InputBorder.none,
                          hintText: "To"),
                    ),
                  ),
                ),
              ],
            )
          : SizedBox.shrink(),
            Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 10),
              child: Container(
                padding: EdgeInsets.only(left: 8),
                height: 50,
                decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                        color: Theme.of(context).colorScheme.fontColor)),
                width: MediaQuery.of(context).size.width,
                child: TextFormField(
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.fontColor),
                  keyboardType: TextInputType.number,
                  maxLength: 10,
                  controller: amountcontroller,
                  decoration: InputDecoration(
                      counterText: '',
                      border: InputBorder.none,
                      hintText: "Enter Amount"),
                ),
              ),
            ),


            Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 10),
              child: Container(
                padding: EdgeInsets.all(8),
                height: 80,
                decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                        color: Theme.of(context).colorScheme.fontColor)),
                width: MediaQuery.of(context).size.width,
                child: TextFormField(
                  maxLines: 3,
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.fontColor),
                  keyboardType: TextInputType.name,
                  // maxLength: 10,
                  controller: descriptionController,
                  decoration: InputDecoration(
                      counterText: '',
                      border: InputBorder.none,
                      hintText: "Description"),
                ),
              ),
            ),
            uploadMultiImage(),
            Padding(
              padding: const EdgeInsets.only(top: 20.0, bottom: 30),
              child: ElevatedButton(
                  onPressed: () {
                    if (amountcontroller.text.isNotEmpty) {
                     // if( imagePathList.isNotEmpty) {
                      setState(() {
                        isLoading=true;
                      });
                       addExpenses();
                     // }else{
                     //   setSnackbar("Please select images first!", context);
                     // }
                    } else {
                      setSnackbar("Please enter amount you had spent!", context);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      primary: colors.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      fixedSize:
                          Size(MediaQuery.of(context).size.width - 40, 50)),
                  child: isLoading?Center(child: CircularProgressIndicator(color:Colors.white,)):Text(
                    widget.userExpenses?.amount==null||widget.userExpenses?.amount==""?"Add Expense":"Update",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  )),
            )
          ]),
        ),
      ),
    );
  }

  Future<void> addExpenses() async {

    SharedPreferences pref = await SharedPreferences.getInstance();
    String? spentType =pref.getString('Spent_type');
    print('--------==------${widget.userExpenses?.spentType}');
    print("this is working here!");
    var headers = {
      'Cookie': 'ci_session=4930e9ab363057c3e0ca5f3657fe6829f8d4c709'
    };
    var request =
        http.MultipartRequest('POST', Uri.parse(addExpenseApi.toString()));
    request.fields.addAll({
      'spent_id': widget.isUpdate == true ? '${widget.userExpenses?.id}' : '',
      'latitude': latitude.toString(),
      'longitude': longitude.toString(),
      'address': currentAddress.text.toString(),
      'user_id': CUR_USERID.toString(),
      'spent_type': widget.isUpdate == false ? widget.data!.id.toString() :  widget.userExpenses!.spentType.toString(),
      'sub_spent_type': subCategoryValue.toString(),
      'amount': amountcontroller.text.toString(),
      'description': descriptionController.text.toString(),
      'from': fromController.text.toString(),
      'to': toController.text.toString()
    });
    for (var i = 0; i < imagePathList.length; i++) {
      imagePathList == null
          ? null
          : request.files.add(await http.MultipartFile.fromPath(
              'images[]', imagePathList[i].toString()));
    }
    print(
        "this is my add expense request ${request.fields.toString()} and ${request.files.toString()}");

    // request.files.add(await http.MultipartFile.fromPath('images[]', ));
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    print("this is mty request ${response.statusCode}");
    if (response.statusCode == 200) {
      String responseData =
          await response.stream.transform(utf8.decoder).join();
      var userData = json.decode(responseData);
      setState(() {
        isLoading=false;
      });
      Fluttertoast.showToast(msg: userData['data']);
      Navigator.pop(context);
    } else {
      setState(() {
        isLoading=false;
      });
      print(response.reasonPhrase);
    }
  }

  // Future<void> gallery() async {
  //   try {
  //
  //     final image = await ImagePicker().pickImage(source: ImageSource.gallery);
  //
  //     if (image == null) return;
  //
  //     final imageTempory = File(image.path);
  //
  //
  //     setState(() {
  //       this.image = imageTempory;
  //     });
  //
  //
  //   } on PlatformException catch (e) {
  //     print('Failed to Pic image : $e');
  //   }
  // }
  //
  // Future<void> fromcamera() async {
  //   try {
  //
  //
  //     final image = await ImagePicker().pickImage(source: ImageSource.camera);
  //
  //
  //     if (image == null) return;
  //
  //     final imageTempory = File(image.path);
  //
  //
  //     setState(() {
  //       this.image = imageTempory;
  //
  //     });
  //
  //
  //   } on PlatformException catch (e) {
  //     print('Failed to pic image : $e');
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
        double.parse(latitude.toString()), double.parse(longitude.toString()),
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
        print('Latitude=============${latitude}');
        print('Longitude*************${longitude}');

        print('Current Addresssssss${currentAddress.text}');
      });
    }
  }
}
