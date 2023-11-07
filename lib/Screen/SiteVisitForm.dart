import 'dart:convert';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:omega_employee_management/Model/DelearRetailerModel1.dart';
import 'package:omega_employee_management/Screen/SiteSurvey.dart';
import '../Helper/Color.dart';
import '../Helper/String.dart';
import '../Model/DealingProductModel.dart';
import '../Model/DelearRetailerModel.dart';
import '../Model/GedClientDataModel.dart';
import '../Model/GetListModel.dart';
import 'MultiSelect.dart';
import 'MultiSelectTwo.dart';
import 'Survey.dart';

class SiteVisitForm extends StatefulWidget {
  const SiteVisitForm({Key? key}) : super(key: key);

  @override
  State<SiteVisitForm> createState() => _SiteVisitFormState();
}

class _SiteVisitFormState extends State<SiteVisitForm> {
  void initState() {
    super.initState();
    convertDateTimeDispla();
    date();
    getData();
    getState();
    dealingProduct();
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController namecn = TextEditingController();
  TextEditingController mobileCtr = TextEditingController();
  TextEditingController petTypeCtr = TextEditingController();
  TextEditingController mobilecn = TextEditingController();
  TextEditingController timeCtr = TextEditingController();
  TextEditingController addressCtr = TextEditingController();
  TextEditingController dateCtr = TextEditingController();
  TextEditingController remarkCtr = TextEditingController();
  TextEditingController execteddateCtr = TextEditingController();
  TextEditingController siteSizeCtr = TextEditingController();
  TextEditingController startDateController = TextEditingController();

  String _dateValue = '';
  var dateFormate;
  String? formattedDate;
  String? timeData;
  String? messionMobile, contractorMobile, architecMobile, enaginnerMobile;

  convertDateTimeDispla() {
    var now = new DateTime.now();
    var formatter = new DateFormat('yyyy-MM-dd');
    formattedDate = formatter.format(now);
    print("datedetet${formattedDate}"); // 2016-01-25
    timeData = DateFormat("hh:mm:ss a").format(DateTime.now());
    print("timeeeeeeeeee${timeData}");
  }

  date() async {
    dateCtr.text = formattedDate.toString();
    timeCtr.text = timeData.toString();
  }

  List<String> statusString = ["Pending", "Cancel", "Progress"];
  String? selectedContractor;
  String? selectedStatus;
  String? selectedEngineer;
  String? selectedArchitec;
  String? selectedMession;
  String? selectedState;
  String? selectedDistrict;
  int nwIndex = 0;
  int contractorIndex = 0;
  int engineerIndex = 0;
  int messionIndex = 0;
  int architectIndex = 0;
  int stateindex = 0;
  var currentIndex;
  final picker = ImagePicker();
  File? _imageFile;
  bool showTextField = false;

  DealingProductModel? dealingProductModel;

  dealingProduct() async {
    var headers = {
      'Cookie': 'ci_session=4f8360fd4e4e40e498783ef6638c6f55e6bc9fca'
    };
    var request =
        http.MultipartRequest('POST', Uri.parse(GetDealingProduct.toString()));
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var result = await response.stream.bytesToString();
      var finalresult = DealingProductModel.fromJson(json.decode(result));
      setState(() {
        dealingProductModel = finalresult;
      });
    } else {
      print(response.reasonPhrase);
    }
  }

  _getFromGallery() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
      Navigator.pop(context);
    }
  }

  _getFromCamera() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera,
    );
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
        imagePathList.add(_imageFile?.path ?? "");
        isImages = true ;
      });
      //Navigator.pop(context);
    }
  }

  List<DealingData> results = [];

  Widget select() {
    return InkWell(
      onTap: () {
        setState(() {
          _showMultiSelect();
        });
      },
      child: Container(
        height: 50,
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.only(left: 10),
        decoration: BoxDecoration(
            color: colors.white70,
            border: Border(
                bottom: BorderSide(color: colors.blackTemp.withOpacity(0.5)))),
        child: results.isEmpty
            ? const Padding(
                padding: EdgeInsets.only(left: 10, top: 10, bottom: 10),
                child: Text(
                  'Select Product',
                  style: TextStyle(
                    fontSize: 15,
                    color: colors.blackTemp,
                    fontWeight: FontWeight.normal,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              )
            : SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: results.map((e) {
                    return Padding(
                      padding:
                          const EdgeInsets.only(top: 10, left: 1, right: 1),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        height: 30,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: colors.primary),
                        child: Center(
                          child: Text(
                            "${e.name}",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
      ),
    );
  }

  void _showMultiSelect() async {
    results = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (context, setState) {
          return MultiSelectTwo(
            dealingData: dealingProductModel?.data,
            // name:delearRetailerModel?.data?[nwIndex].ownerName,
            //  email:delearRetailerModel?.data?[nwIndex].email,
            // contact: delearRetailerModel?.data?[nwIndex].mobileOne,
            // creditLimit: delearRetailerModel?.data?[nwIndex].creditLimit,
            // customerType: delearRetailerModel?.data?[nwIndex].customerType,
            date: dateCtr.text,
            time: timeCtr.text,
            image: _imageFile?.path,
            remark: remarkCtr.text, //clientId: selected,
          );
        });
      },
    );
    setState(() {});
  }

  List<String> imagePathList = [];
  bool isImages = false;

  // Future<void> getFromGallery() async {
  //   var result = await FilePicker.platform.pickFiles(
  //     type: FileType.image,
  //     allowMultiple: true,
  //     allowCompression: true,
  //   );
  //   if (result != null) {
  //     setState(() {
  //       isImages = true;
  //       // servicePic = File(result.files.single.path.toString());
  //     });
  //     imagePathList = result.paths.toList();
  //     // imagePathList.add(result.paths.toString()).toList();
  //     print("SERVICE PIC === ${imagePathList}");
  //     Navigator.pop(context);
  //   } else {
  //     Navigator.pop(context);
  //     // User canceled the picker
  //   }
  // }

  Widget uploadMultiImage() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(
          height: 10,
        ),
        InkWell(
          onTap: () async {
           // pickImageDialog(context, 1);
            // await pickImages();
            _getFromCamera();
          },
          child: Container(
            height: 40,
            width: 165,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10), color: colors.primary),
            child: Center(
              child: Text(
                "Upload Image",
                style: TextStyle(color: colors.whiteTemp),
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Visibility(
            visible: isImages,
            child:  buildGridView()),
      ],
    );
  }

  Widget buildGridView() {
    return Container(
      height: 200,
      child: GridView.builder(
        itemCount: imagePathList.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
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
                  child: Icon(Icons.remove_circle,
                      size: 30, color: Colors.red.withOpacity(0.7)),
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
            borderRadius: BorderRadius.all(
              Radius.circular(6),
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              // InkWell(
              //   onTap: () async {
              //     _getFromGallery();
              //   },
              //   child: Container(
              //     child: ListTile(
              //       title: Text("Gallery"),
              //       leading: Icon(
              //         Icons.image,
              //         color: colors.primary,
              //       ),
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

  TextEditingController address1Controller = TextEditingController();
  TextEditingController address2Controller = TextEditingController();
  TextEditingController landmarkController = TextEditingController();
  TextEditingController pinCodeController = TextEditingController();

  List<String> contractorList = ["contractor1", "contractor2"];
  List<String> engineerList = ["engineer1", "engineer2"];
  String contractor = "contractor1";
  String engineer = "engineer1";
  List<String> artitechList = ["artitech1", "artitech2"];
  String artitech = "artitech1";
  List<String> missionList = ["mission1", "mission2"];
  String mission = "mission1";
  List<String> currentStatusList = ["pending", "cancel"];
  String currentStatus = "currentStatus1";
  List<String> expectedOrderList = ["expectedOrder1", "expectedOrder2"];
  String expectedOrder = "expectedOrder1";

  DelearRetailerModel1? delearRetailerModel;

  getData() async {
    var headers = {
      'Cookie': 'ci_session=ef29e61acfe01ba495d2b60947f70ae0b26cc807'
    };
    var request = http.MultipartRequest(
        'POST',
        Uri.parse(
            'https://developmentalphawizz.com/market_track/app/v1/api/get_client_type1'));

    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var result = await response.stream.bytesToString();
      var finalresult = DelearRetailerModel1.fromJson(json.decode(result));
      setState(() {
        delearRetailerModel = finalresult;
      });
    } else {
      print(response.reasonPhrase);
    }
  }

  GetListModel? getListModel;

  getState() async {
    var headers = {
      'Cookie': 'ci_session=81cd74eabcb3683af924161dd1dcd833b8da1ff6'
    };
    var request = http.MultipartRequest(
        'GET',
        Uri.parse(
            'https://developmentalphawizz.com/market_track/app/v1/api/get_lists'));
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      String str = await response.stream.bytesToString();
      var result = json.decode(str);
      var finalResponse = GetListModel.fromJson(result);
      setState(() {
        getListModel = finalResponse;
      });
    } else {
      print(response.reasonPhrase);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 1,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child:  Icon(Icons.arrow_back_ios, color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: colors.primary,
        title: Text("Servey Form", style: TextStyle(fontSize: 15, color: Colors.white)),
      ),
       body: delearRetailerModel == null
          ? Center(
        child: CircularProgressIndicator(),
        ): SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(left: 15, right: 15, top: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Name",
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * .01,
                          ),
                          Container(
                            height: 40,
                            child: TextFormField(
                                // readOnly: true,
                                controller: namecn,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.only(bottom: 5, left: 5),
                                    // hintText: '',
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(5),
                                    ),
                                ),
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * .01,
                          ),
                          const Text(
                            "Mobile",
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * .01,
                          ),
                          Container(
                            height: 65,
                            child: TextFormField(
                              keyboardType: TextInputType.number,
                              maxLength: 10,
                              // readOnly: true,
                              controller: mobileCtr,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(bottom: 5, left: 5),
                                // hintText: '',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * .01,
                          ),
                          const Text(
                            "Date",
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * .01,
                          ),
                          Container(
                            height: 50,
                            child: TextFormField(
                                readOnly: true,
                                controller: dateCtr,
                                decoration: InputDecoration(
                                    // hintText: '',
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)))),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * .01,
                          ),
                          const Text(
                            "Time",
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * .01,
                          ),
                          Container(
                            height: 50,
                            child: TextFormField(
                              readOnly: true,
                              maxLength: 10,
                              controller: timeCtr,
                              decoration: InputDecoration(
                                hintText: '',
                                counterText: "",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * .01,
                          ),
                          const Text(
                            "Address",
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * .01,
                          ),
                          Container(
                            height: 40,
                            child: TextFormField(
                              // readOnly: true,
                              controller: addressCtr,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(bottom: 5, left: 5),
                                // hintText: '',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * .01,
                          ),
                          const Text(
                            "State",
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * .01,
                          ),
                          Container(
                            height: 60,
                            child: Card(
                              elevation: 2,
                              shape: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              child: DropdownButtonFormField<String>(
                                value: selectedState,
                                onChanged: (newValue) {
                                  setState(() {
                                    selectedState = newValue;
                                    // print("current indexxx ${selected}");
                                    stateindex = getListModel!.data!.states!
                                        .indexWhere((element) =>
                                            element.id == selectedState);
                                    // currentIndex = selected;
                                    // showTextField = true;
                                  });
                                },
                                items: getListModel?.data?.states?.map((items) {
                                  return DropdownMenuItem(
                                    value: items.id,
                                    child: Text(items.name.toString()),
                                  );
                                }).toList(),
                                decoration: InputDecoration(
                                  contentPadding:
                                      EdgeInsets.only(top: 5, left: 10),
                                  border: InputBorder.none,
                                  hintText: 'Select State',
                                ),
                              ),
                            ),
                          ),
                          const Text(
                            "District",
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                          Container(
                            height: 60,
                            child: Card(
                              elevation: 2,
                              shape: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              child: DropdownButtonFormField<String>(
                                value: selectedDistrict,
                                onChanged: (newValue) {
                                  setState(() {
                                    selectedDistrict = newValue;
                                    // print("current indexxx ${selected}");
                                    nwIndex = getListModel!
                                        .data!.states![stateindex].cities!
                                        .indexWhere((element) =>
                                            element.id == selectedDistrict)!;
                                    // currentIndex = selected;
                                    // showTextField = true;
                                  });
                                },
                                items: getListModel
                                    ?.data?.states?[stateindex].cities
                                    ?.map((items) {
                                  return DropdownMenuItem(
                                    value: items.id,
                                    child: Text(items.city.toString()),
                                  );
                                }).toList(),
                                decoration: InputDecoration(
                                  contentPadding:
                                      EdgeInsets.only(top: 5, left: 10),
                                  border: InputBorder.none,
                                  hintText: 'Select District',
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * .01,
                          ),
                          const Text(
                            "Pin Code",
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * .01,
                          ),
                          Container(
                            height: 40,
                            child: TextFormField(
                              // readOnly: true,
                              controller: pinCodeController,
                              decoration: InputDecoration(
                                // hintText: '',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * .01,
                          ),
                          const Text(
                            "Name Of Contractor",
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * .01,
                          ),
                          Container(
                            height: 60,
                            child: Card(
                              elevation: 2,
                              shape: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              child: DropdownButtonFormField<String>(
                                value: selectedContractor,
                                onChanged: (newValue) {
                                  setState(() {
                                    selectedContractor = newValue;
                                    contractorIndex = delearRetailerModel!
                                        .data!.contractor!
                                        .indexWhere((element) =>
                                            element.id == selectedContractor);
                                    // currentIndex = selected;
                                    showTextField = true;
                                  });
                                },
                                items: delearRetailerModel?.data?.contractor
                                    ?.map((items) {
                                  return DropdownMenuItem(
                                    value: items.id,
                                    child: Text(items.ownerName.toString()),
                                  );
                                }).toList(),
                                decoration: InputDecoration(
                                  contentPadding:
                                      EdgeInsets.only(top: 5, left: 10),
                                  border: InputBorder.none,
                                  hintText: '',
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 5),
                          selectedContractor != null
                              ? Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *.01,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 10),
                                      child: Text("Mobile:",
                                          style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w800)),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    delearRetailerModel
                                                    ?.data
                                                    ?.contractor?[
                                                        contractorIndex]
                                                    .mobileOne ==
                                                null ||
                                            delearRetailerModel
                                                    ?.data
                                                    ?.contractor?[
                                                        contractorIndex]
                                                    .mobileOne ==
                                                " "
                                        ? Container(
                                            height: 40,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                2.2,
                                            child: TextFormField(
                                              onChanged: (value) {
                                                // String mobileContractor = value ;
                                                contractorMobile = value;
                                              },
                                              readOnly: true,
                                              //controller: mobilecn,
                                              decoration: InputDecoration(
                                                // hintText: '',
                                                border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
                                              ),
                                            ),
                                          )
                                        : Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                height: 40,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    2.2,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    color: Colors.white,
                                                    border: Border.all(
                                                        color: Colors.black)),
                                                child: Center(
                                                    child: Text(
                                                        "${delearRetailerModel?.data?.contractor?[contractorIndex].mobileOne}",
                                                        style: TextStyle(
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w800))),
                                              ),
                                            ],
                                          ),
                                    SizedBox(height: 10),
                                  ],
                                )
                              : SizedBox(),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * .01,
                          ),
                          const Text(
                            "Name Of Engineer",
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * .01,
                          ),
                          Container(
                            height: 60,
                            child: Card(
                              elevation: 2,
                              shape: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              child: DropdownButtonFormField<String>(
                                value: selectedEngineer,
                                onChanged: (newValue) {
                                  setState(() {
                                    selectedEngineer = newValue;
                                    engineerIndex = delearRetailerModel!
                                        .data!.engineer!
                                        .indexWhere((element) =>
                                            element.id == selectedEngineer);
                                    // currentIndex = selected;
                                    showTextField = true;
                                  });
                                },
                                items: delearRetailerModel?.data?.engineer
                                    ?.map((items) {
                                  return DropdownMenuItem(
                                    value: items.id,
                                    child: Text(items.ownerName.toString()),
                                  );
                                }).toList(),
                                decoration: InputDecoration(
                                  contentPadding:
                                      EdgeInsets.only(top: 5, left: 10),
                                  border: InputBorder.none,
                                  hintText: '',
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 5),
                          selectedEngineer != null
                              ? Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              .01,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 10),
                                      child: Text("Mobile:",
                                          style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w800)),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    delearRetailerModel!
                                                    .data!
                                                    .engineer?[engineerIndex]
                                                    .mobileOne ==
                                                null ||
                                            delearRetailerModel!
                                                    .data!
                                                    .engineer?[engineerIndex]
                                                    .mobileOne ==
                                                " "
                                        ? Container(
                                            height: 40,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                2.2,
                                            child: TextFormField(
                                              onChanged: (value) {
                                                enaginnerMobile = value;
                                              },

                                              // controller: ownerNameCtr,
                                              decoration: InputDecoration(
                                                // hintText: '',
                                                border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
                                              ),
                                            ),
                                          )
                                        : Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                height: 40,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    2.2,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    color: Colors.white,
                                                    border: Border.all(
                                                        color: Colors.black)),
                                                child: Center(
                                                    child: Text(
                                                        "${delearRetailerModel!.data!.engineer?[engineerIndex].mobileOne}",
                                                        style: TextStyle(
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w800))),
                                              ),
                                            ],
                                          ),
                                    SizedBox(height: 10),
                                  ],
                                )
                              : SizedBox(),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * .01,
                          ),
                          const Text(
                            "Name Of Arti-tech",
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * .01,
                          ),
                          Container(
                            height: 60,
                            child: Card(
                              elevation: 2,
                              shape: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              child: DropdownButtonFormField<String>(
                                value: selectedArchitec,
                                onChanged: (newValue) {
                                  setState(() {
                                    selectedArchitec = newValue;
                                    architectIndex = delearRetailerModel!
                                        .data!.artitech!
                                        .indexWhere((element) =>
                                            element.id == selectedArchitec);
                                    // currentIndex = selected;
                                    showTextField = true;
                                  });
                                },
                                items: delearRetailerModel?.data?.artitech
                                    ?.map((items) {
                                  return DropdownMenuItem(
                                    value: items.id,
                                    child: Text(items.ownerName.toString()),
                                  );
                                }).toList(),
                                decoration: InputDecoration(
                                  contentPadding:
                                      EdgeInsets.only(top: 5, left: 10),
                                  border: InputBorder.none,
                                  hintText: '',
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 5),
                          selectedArchitec != null
                              ? Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              .01,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 10),
                                      child: Text("Mobile:",
                                          style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w800)),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    delearRetailerModel
                                                    ?.data
                                                    ?.artitech?[architectIndex]
                                                    .mobileOne ==
                                                null ||
                                            delearRetailerModel
                                                    ?.data
                                                    ?.artitech?[architectIndex]
                                                    .mobileOne ==
                                                " "
                                        ? Container(
                                            height: 40,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                2.2,
                                            child: TextFormField(
                                              onChanged: (value) {
                                                architecMobile = value;
                                              },
                                              readOnly: true,
                                              // controller: ownerNameCtr,
                                              decoration: InputDecoration(
                                                // hintText: '',
                                                border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
                                              ),
                                            ),
                                          )
                                        : Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                height: 40,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    2.2,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    color: Colors.white,
                                                    border: Border.all(
                                                        color: Colors.black)),
                                                child: Center(
                                                    child: Text(
                                                        "${delearRetailerModel?.data?.artitech?[architectIndex].mobileOne}",
                                                        style: TextStyle(
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w800))),
                                              ),
                                            ],
                                          ),
                                    SizedBox(height: 10),
                                  ],
                                )
                              : SizedBox(),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * .01,
                          ),
                          const Text(
                            "Name Of Massion",
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * .01,
                          ),
                          Container(
                            height: 60,
                            child: Card(
                              elevation: 2,
                              shape: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              child: DropdownButtonFormField<String>(
                                value: selectedMession,
                                onChanged: (newValue) {
                                  setState(() {
                                    selectedMession = newValue;
                                    messionIndex = delearRetailerModel!
                                        .data!.massion!
                                        .indexWhere((element) =>
                                            element.id == selectedMession);
                                    // currentIndex = selected;
                                    showTextField = true;
                                  });
                                },
                                items: delearRetailerModel?.data?.massion
                                    ?.map((items) {
                                  return DropdownMenuItem(
                                    value: items.id,
                                    child: Text(items.ownerName.toString()),
                                  );
                                }).toList(),
                                decoration: InputDecoration(
                                  contentPadding:
                                      EdgeInsets.only(top: 5, left: 10),
                                  border: InputBorder.none,
                                  hintText: '',
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 5),
                          selectedMession != null
                              ? Row(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 10),
                                      child: Text("Mobile:",
                                          style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w800)),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    delearRetailerModel
                                                    ?.data
                                                    ?.massion?[messionIndex]
                                                    .mobileOne ==
                                                null ||
                                            delearRetailerModel
                                                    ?.data
                                                    ?.massion?[messionIndex]
                                                    .mobileOne ==
                                                " "
                                        ? Container(
                                            height: 40,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                2.2,
                                            child: TextFormField(
                                              onChanged: (value) {
                                                messionMobile = value;
                                              },
                                              controller:
                                                  TextEditingController(),
                                              decoration: InputDecoration(
                                                // hintText: '',
                                                border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
                                              ),
                                            ),
                                          )
                                        : Container(
                                            height: 40,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                2.2,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                color: Colors.white,
                                                border: Border.all(
                                                    color: Colors.black)),
                                            child: Center(
                                                child: Text(
                                                    "${delearRetailerModel?.data?.massion?[messionIndex].mobileOne}",
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w800))),
                                          ),
                                    SizedBox(height: 10),
                                  ],
                                )
                              : SizedBox(),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * .01,
                          ),
                          const Text(
                            "Status",
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * .01,
                          ),
                          Container(
                            height: 60,
                            child: Card(
                              elevation: 2,
                              shape: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              child: DropdownButtonFormField<String>(
                                value: selectedStatus,
                                onChanged: (newValue) {
                                  setState(() {
                                    selectedStatus = newValue;
                                  });
                                },
                                items: statusString.map((items) {
                                  return DropdownMenuItem(
                                    value: items,
                                    child: Text(items.toString()),
                                  );
                                }).toList(),
                                decoration: InputDecoration(
                                  contentPadding:
                                      EdgeInsets.only(top: 5, left: 10),
                                  border: InputBorder.none,
                                  hintText: 'Select Status',
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * .01,
                          ),
                          const Text(
                            "Product Being Used",
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * .01,
                          ),
                          Card(
                            elevation: 3,
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Colors.white,
                                  border: Border.all(color: Colors.black)),
                              height: 45,
                              width: MediaQuery.of(context).size.width / 1.1,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    top: 0, left: 10, bottom: 2, right: 10),
                                child: select(),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * .01,
                          ),
                          const Text(
                            "Site Size",
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * .01,
                          ),
                          Container(
                            height: 50,
                            child: TextFormField(
                              keyboardType: TextInputType.text,
                              controller: siteSizeCtr,
                              decoration: InputDecoration(
                                hintText: '',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * .01,
                          ),
                          const Text(
                            "Remark",
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * .01,
                          ),
                          Container(
                            height: 65,
                            child: TextFormField(
                                keyboardType: TextInputType.text,
                                controller: remarkCtr,
                                decoration: InputDecoration(
                                    hintText: '',
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)))),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * .01,
                          ),
                          const Text(
                            "Expected Date",
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * .01,
                          ),
                          Container(
                            height: 50,
                            // width: MediaQuery.of(context).size.width / 2.9,
                            child: TextField(
                              controller: execteddateCtr,
                              decoration: InputDecoration(
                                  hintText: 'Select Expected Date',
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10))),
                              onTap: () async {
                                DateTime? pickedDate = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(1950),
                                    lastDate: DateTime(2100),
                                    builder: (context, child) {
                                      return Theme(
                                          data: Theme.of(context).copyWith(
                                            colorScheme:
                                                const ColorScheme.light(
                                                    primary: colors.primary),
                                          ),
                                          child: child!);
                                    });
                                if (pickedDate != null) {
                                  String formattedDate =
                                      DateFormat('yyyy-MM-dd')
                                          .format(pickedDate);
                                  setState(() {
                                    execteddateCtr.text = formattedDate;
                                  });
                                }
                              },
                            ),
                          ),
                          // InkWell(
                          //   onTap:
                          //       () async {
                          //     DateTime?pickedDate =
                          //     await showDatePicker(context:
                          //     context, initialDate: DateTime.now(),
                          //         firstDate: DateTime(
                          //             1950),
                          //         lastDate: DateTime(
                          //             2100),
                          //         builder:
                          //             (context, child) {
                          //           return Theme(
                          //               data: Theme.of(context).copyWith(
                          //                 colorScheme: const ColorScheme.light(primary: colors.primary),
                          //               ),
                          //               child: child!);
                          //         });
                          //     if (pickedDate !=
                          //         null) {
                          //       String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
                          //       setState(
                          //               () {
                          //             execteddateCtr.text = formattedDate;
                          //           });
                          //     }
                          //   },
                          //   child: Container(
                          //     height: 65,
                          //     child: TextFormField(
                          //         keyboardType: TextInputType.text,
                          //         controller: execteddateCtr,
                          //         decoration: InputDecoration(
                          //             hintText: '',
                          //             border: OutlineInputBorder(borderRadius: BorderRadius.circular(15),
                          //             ),
                          //         ),
                          //     ),
                          //   ),
                          // ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * .01,
                          ),
                          // InkWell(
                          //   onTap: () {
                          //     pickImageDialog(context, 1);
                          //   },
                          //   child: Container(
                          //       height: 35,
                          //       width: MediaQuery.of(context).size.width/3,
                          //       decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: colors.primary),
                          //       child: const Center(
                          //           child: Text("Select Image", style: TextStyle(fontSize: 15, color: Colors.white, fontWeight: FontWeight.w400)))
                          //   ),
                          // ),
                          uploadMultiImage(),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * .01,
                          ),
                          // Center(
                          //   child: Container(
                          //     height: 150,
                          //     width: 150,
                          //     decoration: BoxDecoration(
                          //         border: Border.all(color: Colors.black)),
                          //     child: _imageFile != null
                          //         ? Image.file(
                          //             _imageFile!.absolute,
                          //             fit: BoxFit.fill,
                          //           )
                          //         : Center(
                          //             child: Image.asset('assets/img.png')),
                          //   ),
                          // ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * .01,
                          ),
                          //    const Text("Select Payment", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                          //    ),
                          // Column(
                          //   crossAxisAlignment: CrossAxisAlignment.start,
                          //    children: [
                          //      Row(
                          //        children: [
                          //          Row(
                          //            children: <Widget>[
                          //              Text('Subscription: ${getPlansModel?.data?[0].amount}', style: const TextStyle(fontSize: 12),),
                          //              Radio(
                          //                value: 'Subscription',
                          //                groupValue: selectedSubscription,
                          //                onChanged: (value) {
                          //                  setState(() {
                          //                    selectedSubscription = value;
                          //                  });
                          //                },
                          //              ),
                          //              const Text('Wallet', style: TextStyle(fontSize: 12)),
                          //              Radio(
                          //                value: 'Wallet',
                          //                groupValue: selectedWallet,
                          //                onChanged: (value) {
                          //                  setState(() {
                          //                    selectedWallet = value;
                          //                  });
                          //                },
                          //              ),
                          //            ],
                          //          ),
                          //          // Radio buttons for Wallet
                          //          // Row(
                          //          //   children: <Widget>[
                          //          //     Text('Online', style: TextStyle(fontSize: 12)),
                          //          //     Radio(
                          //          //       value: 'Online',
                          //          //       groupValue: selectedOnlinePayment,
                          //          //       onChanged: (value) {
                          //          //         setState(() {
                          //          //           selectedOnlinePayment = value;
                          //          //         });
                          //          //       },
                          //          //     ),
                          //          //   ],
                          //          // ),
                          //        ],
                          //      ),
                          // //     RadioListTile(
                          // //     title: const Text('Subscription', style: TextStyle(fontSize: 14)),
                          // //    value: 'Subscription',
                          // //    groupValue: selecteSubscription,
                          // //    onChanged: (value) {
                          // //     setState(() {
                          // //       selecteSubscription = value;
                          // //     });
                          // //   },
                          // // ),
                          // //      Text("${getPlansModel?.data?[0].amount}", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: colors.black),
                          // //      ),
                          // // // RadioListTile(
                          // // //   title: Text('Wallet'),
                          // // //   value: 'Wallet',
                          // // //   groupValue: selecteWallet,
                          // // //   onChanged: (value) {
                          // // //     setState(() {
                          // // //       selecteWallet = value;
                          // // //     });
                          // // //   },
                          // // // ),
                          // // RadioListTile(
                          // //   title: Text('Online Payment'),
                          // //   value: 'Online Payment',
                          // //   groupValue: selecteOnline,
                          // //   onChanged: (value) {
                          // //     setState(() {
                          // //       selecteOnline = value;
                          // //     });
                          // //   },
                          // //     ),
                          //   ],
                          // ),
                          //    SizedBox(
                          //      height: MediaQuery.of(context).size.height *.02,
                          //    ),
                          // ElevatedButton(
                          //   style: ElevatedButton.styleFrom(primary: colors.primary),
                          //   onPressed: () {
                          //     showExitPopup();
                          //   },
                          //   child: const Text("Upload Report"),
                          // ),
                          // const SizedBox(height: 10),
                          // imageFile == null ? const SizedBox.shrink(): InkWell(
                          //   onTap: () {
                          //     showExitPopup();
                          //   },
                          //   child: Container(
                          //     height: 100,
                          //     width: double.infinity,
                          //     margin: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                          //     child: Image.file(imageFile!,fit: BoxFit.fill,),
                          //   ),
                          // ),
                          // SizedBox(
                          //   height: MediaQuery.of(context).size.height * .02,
                          // ),
                          // ElevatedButton(
                          //     style: ElevatedButton.styleFrom(primary: colors.primary),
                          //     onPressed: () {
                          //       showExitPopup1();
                          //     },
                          //     child: const Text("Upload Pet Image")),
                          // SizedBox(height: 10,),
                          // petImage == null ? SizedBox.shrink() :  InkWell(
                          //   onTap: () {
                          //     showExitPopup1();
                          //   },
                          //   child: Container(
                          //     height: 100,
                          //     width: double.infinity,
                          //     margin: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                          //     child: Image.file(petImage!,fit: BoxFit.fill,),
                          //   ),
                          // ),
                          // SizedBox(
                          //   height: MediaQuery.of(context).size.height * .02,
                          // ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .02,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SiteSurvey(
                              modelList: results,
                              name: namecn.text,
                              contact: mobileCtr.text,
                              address: addressCtr.text,
                              state: getListModel
                                  ?.data?.states?[stateindex].name,
                              district: getListModel!
                                  .data!
                                  .states![stateindex]
                                  .cities?[nwIndex]
                                  .city,
                              pincode: pinCodeController.text,
                              sitesize: siteSizeCtr.text,
                              expectedDate: execteddateCtr.text,
                              mession: selectedMession,
                              messionMobile: delearRetailerModel
                                  ?.data
                                  ?.massion?[
                              messionIndex]
                                  .mobileOne ==
                                  "" ||
                                  delearRetailerModel
                                      ?.data
                                      ?.massion?[
                                  messionIndex]
                                      .mobileOne ==
                                      null
                                  ? messionMobile
                                  : delearRetailerModel
                                  ?.data
                                  ?.massion?[messionIndex]
                                  .mobileOne,
                              contractor: selectedContractor,
                              contractorMobile: delearRetailerModel
                                  ?.data
                                  ?.contractor?[
                              contractorIndex]
                                  .mobileOne ==
                                  "" ||
                                  delearRetailerModel
                                      ?.data
                                      ?.contractor?[
                                  contractorIndex]
                                      .mobileOne ==
                                      null
                                  ? contractorMobile
                                  : delearRetailerModel
                                  ?.data
                                  ?.contractor?[contractorIndex]
                                  .mobileOne,
                              engineer: selectedEngineer,
                              engineerMobile: delearRetailerModel
                                  ?.data
                                  ?.engineer?[
                              engineerIndex]
                                  .mobileOne ==
                                  "" ||
                                  delearRetailerModel
                                      ?.data
                                      ?.engineer?[
                                  engineerIndex]
                                      .mobileOne ==
                                      null
                                  ? enaginnerMobile
                                  : delearRetailerModel
                                  ?.data
                                  ?.engineer?[engineerIndex]
                                  .mobileOne,
                              architec: selectedArchitec,
                              architecMobile: delearRetailerModel
                                  ?.data
                                  ?.artitech?[
                              architectIndex]
                                  .mobileOne ==
                                  "" ||
                                  delearRetailerModel
                                      ?.data
                                      ?.artitech?[
                                  architectIndex]
                                      .mobileOne ==
                                      null
                                  ? architecMobile
                                  : delearRetailerModel
                                  ?.data
                                  ?.artitech?[architectIndex]
                                  .mobileOne,
                              // creditLimit: widget.creditLimit,
                              //customerType: widget.customerType,
                              date: dateCtr.text,
                              // status:
                              time: timeCtr.text,
                              image: imagePathList,
                              remark: remarkCtr.text,
                              // clintId: cl,
                            ),
                          ),
                        );
                        // if(namecn.text.isEmpty || siteSizeCtr.text.isEmpty || selectedStatus!.isEmpty || mobileCtr.text.isEmpty || _imageFile!.path.isEmpty) {
                        //   Fluttertoast.showToast(msg: "All Fields Required");
                        // } else{
                        //
                        // }
                      },
                      child: Center(
                          child: Container(
                              height: 40,
                              width: MediaQuery.of(context).size.width / 1.8,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: colors.primary),
                              child: const Center(
                                  child: Text("Save",
                                      style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w400),
                                  ),
                              ),
                          ),
                      ),
                    ),
                    SizedBox(height: 10)
                  ],
                ),
              ),
            ),
    );
  }
}
