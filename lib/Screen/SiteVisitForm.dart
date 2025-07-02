import 'dart:convert';
import 'dart:io';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:omega_employee_management/Model/DelearRetailerModel1.dart';
import 'package:omega_employee_management/Screen/SiteSurvey.dart';

import '../Helper/Color.dart';
import '../Helper/String.dart';
import '../Model/DealingProductModel.dart';
import '../Model/GetListModel.dart';
import 'MultiSelectTwo.dart';

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

  Cities? temp_select_district;
  States? temp_selected_State;
  final TextEditingController searchController = TextEditingController();

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
  TextEditingController statusSiteCtr = TextEditingController();
  TextEditingController startDateController = TextEditingController();

  String _dateValue = '';
  var dateFormate;
  String? formattedDate;
  String? timeData;
  String? messionMobile, contractorMobile, architecMobile, enaginnerMobile;
  String? messionaddress, contractoraddress, architecaddress, enaginneraddress;

  convertDateTimeDispla() {
    var now = new DateTime.now();
    var formatter = new DateFormat('dd-MM-yyyy');
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
  Dealers1? contractorType;
  Dealers1? engineerType;
  Dealers1? artitechType;
  Dealers1? massionype;
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
    var request = http.Request('POST', Uri.parse("${GetDealingProduct}"));
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var result = await response.stream.bytesToString();
      var finalresult = DealingProductModel.fromJson(json.decode(result));
      setState(() {
        dealingProductModel = finalresult;
        print(
            "========dealingg is herrerre=======${dealingProductModel} ${finalresult}  ${results}===========");
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
        isImages = true;
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

  List<String> imagePathList = [];
  bool isImages = false;

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
        Visibility(visible: isImages, child: buildGridView()),
      ],
    );
  }

  Widget buildGridView() {
    return Container(
      height: 200,
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
                top: 7,
                right: 10,
                child: Column(
                  children: [
                    Text(
                      "${formattedDate}",
                      style: TextStyle(fontSize: 10, color: Colors.white),
                    ),
                    Text(
                      "${timeData}",
                      style: TextStyle(fontSize: 10, color: Colors.white),
                    )
                  ],
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

  TextEditingController contractorNameCtr = TextEditingController();
  TextEditingController contractorAddressCtr = TextEditingController();
  TextEditingController engineerAddressCtr = TextEditingController();
  TextEditingController engineerNameCtr = TextEditingController();
  TextEditingController missionAddressCtr = TextEditingController();
  TextEditingController artitechAddressCtr = TextEditingController();
  TextEditingController artitechNameCtr = TextEditingController();
  TextEditingController missionNameCtr = TextEditingController();
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
    var request = http.Request(
      'POST',
      Uri.parse('https://businesstrack.co.in/app/v1/api/get_client_type1'),
    );
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var result = await response.stream.bytesToString();
      var finalresult = DelearRetailerModel1.fromJson(json.decode(result));
      setState(() {
        delearRetailerModel = finalresult;
        delearRetailerModel?.data?.contractor
            ?.add(Dealers1(ownerName: "Other", id: "9091"));
        delearRetailerModel?.data?.contractor
            ?.add(Dealers1(ownerName: "NotApplicable", id: "9090"));
        delearRetailerModel?.data?.engineer
            ?.add(Dealers1(ownerName: "Other", id: "909"));
        delearRetailerModel?.data?.engineer
            ?.add(Dealers1(ownerName: "NotApplicable", id: "907"));
        delearRetailerModel?.data?.artitech
            ?.add(Dealers1(ownerName: "Other", id: "900"));
        delearRetailerModel?.data?.artitech
            ?.add(Dealers1(ownerName: "NotApplicable", id: "906"));
        delearRetailerModel?.data?.massion
            ?.add(Dealers1(ownerName: "Other", id: "904"));
        delearRetailerModel?.data?.massion
            ?.add(Dealers1(ownerName: "NotApplicable", id: "902"));
      });
    } else {
      print(response.reasonPhrase);
    }
  }

  GetListModel? getListModel;

  getState() async {
    print("adssssssssss");
    var headers = {
      'Cookie': 'ci_session=81cd74eabcb3683af924161dd1dcd833b8da1ff6'
    };
    var request = http.Request('GET', Uri.parse(getListsApi.toString()));
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      String str = await response.stream.bytesToString();
      var result = json.decode(str);
      var finalResponse = GetListModel.fromJson(result);
      setState(() {
        getListModel = finalResponse;
        print("list data is ${getListModel?.data?.states}");
      });
    } else {
      print(response.reasonPhrase);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: true,
      top: false,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 1,
          leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back_ios, color: Colors.white),
          ),
          centerTitle: true,
          backgroundColor: colors.primary,
          title: Text(
            "Customer Survey Form",
            style: TextStyle(fontSize: 15, color: Colors.white),
          ),
        ),
        body: delearRetailerModel == null
            ? Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
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
                                  contentPadding:
                                      EdgeInsets.only(bottom: 5, left: 5),
                                  // hintText: '',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                ),
                                validator: (val) {
                                  if (val == null || val.isEmpty) {
                                    return "please enter Name";
                                  }
                                  return null;
                                },
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
                                  counterText: "",
                                  contentPadding:
                                      EdgeInsets.only(bottom: 5, left: 5),
                                  // hintText: '',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                ),
                              ),
                            ),
                            // const Text(
                            //   "Date",
                            //   style: TextStyle(
                            //       fontSize: 14, fontWeight: FontWeight.bold),
                            // ),
                            // SizedBox(
                            //   height: MediaQuery.of(context).size.height * .01,
                            // ),
                            // Container(
                            //   height: 50,
                            //   child: TextFormField(
                            //       readOnly: true,
                            //       controller: dateCtr,
                            //       decoration: InputDecoration(
                            //           // hintText: '',
                            //           border: OutlineInputBorder(
                            //               borderRadius:
                            //                   BorderRadius.circular(10)))),
                            // ),
                            // SizedBox(
                            //   height: MediaQuery.of(context).size.height * .01,
                            // ),
                            // const Text(
                            //   "Time",
                            //   style: TextStyle(
                            //       fontSize: 14, fontWeight: FontWeight.bold),
                            // ),
                            // SizedBox(
                            //   height: MediaQuery.of(context).size.height * .01,
                            // ),
                            // Container(
                            //   height: 50,
                            //   child: TextFormField(
                            //     readOnly: true,
                            //     maxLength: 10,
                            //     controller: timeCtr,
                            //     decoration: InputDecoration(
                            //       hintText: '',
                            //       counterText: "",
                            //       border: OutlineInputBorder(
                            //         borderRadius: BorderRadius.circular(10),
                            //       ),
                            //     ),
                            //   ),
                            // ),
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
                                  contentPadding:
                                      EdgeInsets.only(bottom: 5, left: 5),
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
                            SizedBox(
                              height: 10,
                            ),

                            Row(
                              children: [
                                Expanded(
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton2<States>(
                                      isExpanded: true,

                                      hint: Text(
                                        'Select state',
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Theme.of(context).hintColor,
                                        ),
                                      ),
                                      items: getListModel?.data?.states
                                          ?.map((item) => DropdownMenuItem(
                                                value: item,
                                                child: Text(
                                                  item.name ?? '',
                                                  style: const TextStyle(
                                                    fontSize: 14,
                                                  ),
                                                ),
                                              ))
                                          .toList(),
                                      value: temp_selected_State,
                                      onChanged: (value) {
                                        temp_selected_State = value;
                                        // selected_State = value?.id ?? '';
                                        setState(() {
                                          selectedState = value?.id;
                                          // print("current indexxx ${selected}");
                                          stateindex = getListModel!
                                              .data!.states!
                                              .indexWhere((element) =>
                                                  element.id == selectedState);
                                          // currentIndex = selected;
                                          // showTextField = true;
                                        });
                                      },
                                      buttonStyleData: ButtonStyleData(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 16, vertical: 5),
                                          height: 50,
                                          // width: 200,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              border: Border.all(
                                                color: Colors.black,
                                              ))),
                                      dropdownStyleData: DropdownStyleData(
                                          maxHeight: 200,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              border: Border.all(
                                                  color: Colors.black))),
                                      menuItemStyleData:
                                          const MenuItemStyleData(
                                        height: 40,
                                      ),
                                      dropdownSearchData: DropdownSearchData(
                                        searchController: searchController,
                                        searchInnerWidgetHeight: 50,
                                        searchInnerWidget: Container(
                                          height: 55,
                                          padding: const EdgeInsets.only(
                                            top: 8,
                                            bottom: 4,
                                            right: 8,
                                            left: 8,
                                          ),
                                          child: Column(
                                            children: [
                                              Expanded(
                                                child: TextFormField(
                                                  // keyboardType: TextInputType.number,
                                                  expands: true,
                                                  maxLines: null,
                                                  maxLength: 6,
                                                  controller: searchController,
                                                  decoration: InputDecoration(
                                                    isDense: true,
                                                    contentPadding:
                                                        const EdgeInsets
                                                            .symmetric(
                                                      horizontal: 10,
                                                      vertical: 8,
                                                    ),
                                                    hintText: 'Search  ...',
                                                    hintStyle: const TextStyle(
                                                        fontSize: 12),
                                                    counterText: '',
                                                    counterStyle:
                                                        TextStyle(fontSize: 0),
                                                    border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        searchMatchFn: (item, searchValue) {
                                          return item.value?.name
                                                  .toString()
                                                  .toLowerCase()
                                                  .contains(searchValue) ??
                                              false;
                                        },
                                      ),
                                      //This to clear the search value when you close the menu
                                      onMenuStateChange: (isOpen) {
                                        if (!isOpen) {
                                          searchController.clear();
                                        }
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            // Container(
                            //   height: 60,
                            //   child: Card(
                            //     elevation: 2,
                            //     shape: OutlineInputBorder(
                            //         borderRadius: BorderRadius.circular(10)),
                            //     child: DropdownButtonFormField<String>(
                            //       value: selectedState,
                            //       onChanged: (newValue) {
                            //         setState(() {
                            //           selectedState = newValue;
                            //           // print("current indexxx ${selected}");
                            //           stateindex = getListModel!.data!.states!
                            //               .indexWhere((element) =>
                            //                   element.id == selectedState);
                            //           // currentIndex = selected;
                            //           // showTextField = true;
                            //         });
                            //       },
                            //       items:
                            //           getListModel?.data?.states?.map((items) {
                            //         return DropdownMenuItem(
                            //           value: items.id,
                            //           child: Text(items.name.toString()),
                            //         );
                            //       }).toList(),
                            //       decoration: InputDecoration(
                            //         contentPadding:
                            //             EdgeInsets.only(top: 5, left: 10),
                            //         border: InputBorder.none,
                            //         hintText: 'Select State',
                            //       ),
                            //     ),
                            //   ),
                            // ),
                            SizedBox(
                              height: 10,
                            ),

                            const Text(
                              "District",
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 10,
                            ),

                            Row(
                              children: [
                                Expanded(
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton2<Cities>(
                                      isExpanded: true,

                                      hint: Text(
                                        'Select District',
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Theme.of(context).hintColor,
                                        ),
                                      ),
                                      items: getListModel
                                          ?.data?.states?[stateindex].cities
                                          ?.map((item) => DropdownMenuItem(
                                                value: item,
                                                child: Text(
                                                  item.city ?? '',
                                                  style: const TextStyle(
                                                    fontSize: 14,
                                                  ),
                                                ),
                                              ))
                                          .toList(),
                                      value: temp_select_district,
                                      onChanged: (value) {
                                        temp_select_district = value;
                                        selectedDistrict = value?.id ?? '';
                                        setState(() {});
                                        print('id------${value}');

                                        setState(() {
                                          // selectedDistrict = newValue;
                                          // print("current indexxx ${selected}");
                                          nwIndex = getListModel!
                                              .data!.states![stateindex].cities!
                                              .indexWhere((element) =>
                                                  element.id ==
                                                  selectedDistrict);
                                          // currentIndex = selected;
                                          // showTextField = true;
                                        });
                                      },
                                      buttonStyleData: ButtonStyleData(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 16, vertical: 5),
                                          height: 50,
                                          // width: 200,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              border: Border.all(
                                                color: Colors.black,
                                              ))),
                                      dropdownStyleData: DropdownStyleData(
                                          maxHeight: 200,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              border: Border.all(
                                                  color: Colors.black))),
                                      menuItemStyleData:
                                          const MenuItemStyleData(
                                        height: 40,
                                      ),
                                      dropdownSearchData: DropdownSearchData(
                                        searchController: searchController,
                                        searchInnerWidgetHeight: 50,
                                        searchInnerWidget: Container(
                                          height: 55,
                                          padding: const EdgeInsets.only(
                                            top: 8,
                                            bottom: 4,
                                            right: 8,
                                            left: 8,
                                          ),
                                          child: Column(
                                            children: [
                                              Expanded(
                                                child: TextFormField(
                                                  // keyboardType: TextInputType.number,
                                                  expands: true,
                                                  maxLines: null,
                                                  maxLength: 6,
                                                  controller: searchController,
                                                  decoration: InputDecoration(
                                                    isDense: true,
                                                    contentPadding:
                                                        const EdgeInsets
                                                            .symmetric(
                                                      horizontal: 10,
                                                      vertical: 8,
                                                    ),
                                                    hintText: 'Search  ...',
                                                    hintStyle: const TextStyle(
                                                        fontSize: 12),
                                                    counterText: '',
                                                    counterStyle:
                                                        TextStyle(fontSize: 0),
                                                    border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        searchMatchFn: (item, searchValue) {
                                          return item.value?.city
                                                  .toString()
                                                  .toLowerCase()
                                                  .contains(searchValue) ??
                                              false;
                                        },
                                      ),
                                      //This to clear the search value when you close the menu
                                      onMenuStateChange: (isOpen) {
                                        if (!isOpen) {
                                          searchController.clear();
                                        }
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            // Container(
                            //   height: 60,
                            //   child: Card(
                            //     elevation: 2,
                            //     shape: OutlineInputBorder(
                            //         borderRadius: BorderRadius.circular(10)),
                            //     child: DropdownButtonFormField<String>(
                            //       value: selectedDistrict,
                            //       onChanged: (newValue) {
                            //         setState(() {
                            //           selectedDistrict = newValue;
                            //           // print("current indexxx ${selected}");
                            //           nwIndex = getListModel!
                            //               .data!.states![stateindex].cities!
                            //               .indexWhere((element) =>
                            //                   element.id == selectedDistrict);
                            //           // currentIndex = selected;
                            //           // showTextField = true;
                            //         });
                            //       },
                            //       items: getListModel
                            //           ?.data?.states?[stateindex].cities
                            //           ?.map((items) {
                            //         return DropdownMenuItem(
                            //           value: items.id,
                            //           child: Text(items.city.toString()),
                            //         );
                            //       }).toList(),
                            //       decoration: InputDecoration(
                            //         contentPadding:
                            //             EdgeInsets.only(top: 5, left: 10),
                            //         border: InputBorder.none,
                            //         hintText: 'Select District',
                            //       ),
                            //     ),
                            //   ),
                            // ),
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
                                maxLength: 6,
                                keyboardType: TextInputType.number,
                                // readOnly: true,
                                controller: pinCodeController,
                                decoration: InputDecoration(
                                  counterText: "",
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

                            Row(
                              children: [
                                Expanded(
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton2<Dealers1>(
                                      isExpanded: true,

                                      hint: Text(
                                        'Select',
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Theme.of(context).hintColor,
                                        ),
                                      ),
                                      items:
                                          delearRetailerModel?.data?.contractor
                                              ?.map((item) => DropdownMenuItem(
                                                    value: item,
                                                    child: Text(
                                                      item.nameOfFirm ?? '',
                                                      style: const TextStyle(
                                                        fontSize: 14,
                                                      ),
                                                    ),
                                                  ))
                                              .toList(),
                                      value: contractorType,
                                      onChanged: (value) {
                                        contractorType = value;
                                        setState(() {
                                          selectedContractor = value?.id;
                                          contractorIndex = delearRetailerModel!
                                              .data!.contractor!
                                              .indexWhere((element) =>
                                                  element.id ==
                                                  selectedContractor);
                                          // currentIndex = selected;
                                          showTextField = true;
                                        });
                                      },
                                      buttonStyleData: ButtonStyleData(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 16, vertical: 5),
                                          height: 50,
                                          // width: 200,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              border: Border.all(
                                                color: Colors.black,
                                              ))),
                                      dropdownStyleData: DropdownStyleData(
                                          maxHeight: 200,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              border: Border.all(
                                                  color: Colors.black))),
                                      menuItemStyleData:
                                          const MenuItemStyleData(
                                        height: 40,
                                      ),
                                      dropdownSearchData: DropdownSearchData(
                                        searchController: searchController,
                                        searchInnerWidgetHeight: 50,
                                        searchInnerWidget: Container(
                                          height: 55,
                                          padding: const EdgeInsets.only(
                                            top: 8,
                                            bottom: 4,
                                            right: 8,
                                            left: 8,
                                          ),
                                          child: Column(
                                            children: [
                                              Expanded(
                                                child: TextFormField(
                                                  // keyboardType: TextInputType.number,
                                                  expands: true,
                                                  maxLines: null,
                                                  maxLength: 6,
                                                  controller: searchController,
                                                  decoration: InputDecoration(
                                                    isDense: true,
                                                    contentPadding:
                                                        const EdgeInsets
                                                            .symmetric(
                                                      horizontal: 10,
                                                      vertical: 8,
                                                    ),
                                                    hintText: 'Search  ...',
                                                    hintStyle: const TextStyle(
                                                        fontSize: 12),
                                                    counterText: '',
                                                    counterStyle:
                                                        TextStyle(fontSize: 0),
                                                    border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        searchMatchFn: (item, searchValue) {
                                          return item.value?.nameOfFirm
                                                  .toString()
                                                  .toLowerCase()
                                                  .contains(searchValue) ??
                                              false;
                                        },
                                      ),
                                      //This to clear the search value when you close the menu
                                      onMenuStateChange: (isOpen) {
                                        if (!isOpen) {
                                          searchController.clear();
                                        }
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            // Container(
                            //   height: 60,
                            //   child: Card(
                            //     elevation: 2,
                            //     shape: OutlineInputBorder(
                            //         borderRadius: BorderRadius.circular(10)),
                            //     child: DropdownButtonFormField<String>(
                            //       value: selectedContractor,
                            //       onChanged: (newValue) {
                            //         setState(() {
                            //           selectedContractor = newValue;
                            //           contractorIndex = delearRetailerModel!
                            //               .data!.contractor!
                            //               .indexWhere((element) =>
                            //                   element.id == selectedContractor);
                            //           // currentIndex = selected;
                            //           showTextField = true;
                            //         });
                            //       },
                            //       items: delearRetailerModel?.data?.contractor
                            //           ?.map((items) {
                            //         return DropdownMenuItem(
                            //           value: items.id,
                            //           child: Text(items.ownerName.toString()),
                            //         );
                            //       }).toList(),
                            //       decoration: InputDecoration(
                            //         contentPadding:
                            //             EdgeInsets.only(top: 5, left: 10),
                            //         border: InputBorder.none,
                            //         hintText: '',
                            //       ),
                            //     ),
                            //   ),
                            // ),
                            SizedBox(height: 5),
                            selectedContractor != null
                                ? selectedContractor == "9090"
                                    ? SizedBox()
                                    : Column(
                                        children: [
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    .01,
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 10),
                                                child: Text(
                                                  "Mobile:",
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w800),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 15,
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
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width /
                                                              2.2,
                                                      child: TextFormField(
                                                        maxLength: 10,
                                                        keyboardType:
                                                            TextInputType
                                                                .number,
                                                        onChanged: (value) {
                                                          // String mobileContractor = value ;
                                                          contractorMobile =
                                                              value;
                                                          print(
                                                              "seeeeeeeeeee ${contractorMobile}");
                                                        },
                                                        // readOnly: true,
                                                        //controller: mobilecn,
                                                        decoration:
                                                            InputDecoration(
                                                          counterText: "",
                                                          contentPadding:
                                                              EdgeInsets.only(
                                                                  bottom: 4,
                                                                  left: 3),
                                                          // hintText: '',
                                                          border: OutlineInputBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10)),
                                                        ),
                                                      ),
                                                    )
                                                  : Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Container(
                                                          height: 40,
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width /
                                                              2.2,
                                                          decoration: BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10),
                                                              color:
                                                                  Colors.white,
                                                              border: Border.all(
                                                                  color: Colors
                                                                      .black)),
                                                          child: Center(
                                                            child: Text(
                                                              "${delearRetailerModel?.data?.contractor?[contractorIndex].mobileOne}",
                                                              style: TextStyle(
                                                                  fontSize: 12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w800),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                              SizedBox(height: 10),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          selectedContractor == "9091"
                                              ? Column(
                                                  children: [
                                                    Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        SizedBox(
                                                          height: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .height *
                                                              .01,
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  top: 10),
                                                          child: Text(
                                                            "Name:",
                                                            style: TextStyle(
                                                                fontSize: 12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w800),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: 20,
                                                        ),
                                                        Container(
                                                          height: 40,
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width /
                                                              2.2,
                                                          child: TextFormField(
                                                            controller:
                                                                contractorNameCtr,
                                                            // onChanged: (value) {
                                                            //   // String mobileContractor = value ;
                                                            //   contractorMobile = value;
                                                            // },
                                                            // readOnly: true,
                                                            //controller: mobilecn,
                                                            decoration:
                                                                InputDecoration(
                                                              contentPadding:
                                                                  EdgeInsets.only(
                                                                      bottom: 4,
                                                                      left: 3),
                                                              // hintText: '',
                                                              border: OutlineInputBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10)),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 8,
                                                    ),
                                                    Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        SizedBox(
                                                          height: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .height *
                                                              .01,
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  top: 10),
                                                          child: Text(
                                                            "Address:",
                                                            style: TextStyle(
                                                                fontSize: 12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w800),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: 10,
                                                        ),
                                                        Container(
                                                          height: 40,
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width /
                                                              2.2,
                                                          child: TextFormField(
                                                            controller:
                                                                contractorAddressCtr,
                                                            // onChanged: (value) {
                                                            //   // String mobileContractor = value ;
                                                            //   contractorMobile = value;
                                                            // },
                                                            //controller: mobilecn,
                                                            decoration:
                                                                InputDecoration(
                                                              contentPadding:
                                                                  EdgeInsets.only(
                                                                      bottom: 4,
                                                                      left: 3),
                                                              // hintText: '',
                                                              border:
                                                                  OutlineInputBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                )
                                              : SizedBox(),
                                        ],
                                      )
                                : SizedBox(),
                            selectedContractor != null
                                ? selectedContractor == "9090" ||
                                        selectedContractor == "9091"
                                    ? SizedBox()
                                    : Column(
                                        children: [
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    .01,
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 10),
                                                child: Text(
                                                  "Address:",
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w800),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              delearRetailerModel
                                                              ?.data
                                                              ?.contractor?[
                                                                  contractorIndex]
                                                              .address ==
                                                          null ||
                                                      delearRetailerModel
                                                              ?.data
                                                              ?.contractor?[
                                                                  contractorIndex]
                                                              .address ==
                                                          " "
                                                  ? Container(
                                                      height: 40,
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width /
                                                              2.2,
                                                      child: TextFormField(
                                                        keyboardType:
                                                            TextInputType
                                                                .number,
                                                        onChanged: (value) {
                                                          // String mobileContractor = value ;
                                                          contractoraddress =
                                                              value;
                                                        },
                                                        // readOnly: true,
                                                        //controller: mobilecn,
                                                        decoration:
                                                            InputDecoration(
                                                          contentPadding:
                                                              EdgeInsets.only(
                                                                  bottom: 4,
                                                                  left: 3),
                                                          // hintText: '',
                                                          border: OutlineInputBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10)),
                                                        ),
                                                      ),
                                                    )
                                                  : Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Container(
                                                          height: 40,
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width /
                                                              2.2,
                                                          decoration: BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10),
                                                              color:
                                                                  Colors.white,
                                                              border: Border.all(
                                                                  color: Colors
                                                                      .black)),
                                                          child: Center(
                                                            child: Text(
                                                              "${delearRetailerModel?.data?.contractor?[contractorIndex].address} Madhya Pradesh",
                                                              style: TextStyle(
                                                                  fontSize: 12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w800),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                              SizedBox(height: 10),
                                            ],
                                          ),
                                          // SizedBox(
                                          //   height: 10,
                                          // ),
                                          // selectedContractor == "9091"
                                          //     ? Column(
                                          //   children: [
                                          //     Row(
                                          //       crossAxisAlignment:
                                          //       CrossAxisAlignment
                                          //           .start,
                                          //       children: [
                                          //         SizedBox(
                                          //           height: MediaQuery.of(
                                          //               context)
                                          //               .size
                                          //               .height *
                                          //               .01,
                                          //         ),
                                          //         Padding(
                                          //           padding:
                                          //           const EdgeInsets
                                          //               .only(top: 10),
                                          //           child: Text(
                                          //             "Name:",
                                          //             style: TextStyle(
                                          //                 fontSize: 12,
                                          //                 fontWeight:
                                          //                 FontWeight
                                          //                     .w800),
                                          //           ),
                                          //         ),
                                          //         SizedBox(
                                          //           width: 20,
                                          //         ),
                                          //         Container(
                                          //           height: 40,
                                          //           width: MediaQuery.of(
                                          //               context)
                                          //               .size
                                          //               .width /
                                          //               2.2,
                                          //           child: TextFormField(
                                          //             controller:
                                          //             contractorNameCtr,
                                          //             // onChanged: (value) {
                                          //             //   // String mobileContractor = value ;
                                          //             //   contractorMobile = value;
                                          //             // },
                                          //             // readOnly: true,
                                          //             //controller: mobilecn,
                                          //             decoration:
                                          //             InputDecoration(
                                          //               contentPadding:
                                          //               EdgeInsets.only(
                                          //                   bottom: 4,
                                          //                   left: 3),
                                          //               // hintText: '',
                                          //               border: OutlineInputBorder(
                                          //                   borderRadius:
                                          //                   BorderRadius
                                          //                       .circular(
                                          //                       10)),
                                          //             ),
                                          //           ),
                                          //         ),
                                          //       ],
                                          //     ),
                                          //     SizedBox(
                                          //       height: 8,
                                          //     ),
                                          //     Row(
                                          //       crossAxisAlignment:
                                          //       CrossAxisAlignment
                                          //           .start,
                                          //       children: [
                                          //         SizedBox(
                                          //           height: MediaQuery.of(
                                          //               context)
                                          //               .size
                                          //               .height *
                                          //               .01,
                                          //         ),
                                          //         Padding(
                                          //           padding:
                                          //           const EdgeInsets
                                          //               .only(top: 10),
                                          //           child: Text(
                                          //             "Address:",
                                          //             style: TextStyle(
                                          //                 fontSize: 12,
                                          //                 fontWeight:
                                          //                 FontWeight
                                          //                     .w800),
                                          //           ),
                                          //         ),
                                          //         SizedBox(
                                          //           width: 10,
                                          //         ),
                                          //         Container(
                                          //           height: 40,
                                          //           width: MediaQuery.of(
                                          //               context)
                                          //               .size
                                          //               .width /
                                          //               2.2,
                                          //           child: TextFormField(
                                          //             controller:
                                          //             contractorAddressCtr,
                                          //             // onChanged: (value) {
                                          //             //   // String mobileContractor = value ;
                                          //             //   contractorMobile = value;
                                          //             // },
                                          //             //controller: mobilecn,
                                          //             decoration:
                                          //             InputDecoration(
                                          //               contentPadding:
                                          //               EdgeInsets.only(
                                          //                   bottom: 4,
                                          //                   left: 3),
                                          //               // hintText: '',
                                          //               border: OutlineInputBorder(
                                          //                   borderRadius:
                                          //                   BorderRadius
                                          //                       .circular(
                                          //                       10),
                                          //               ),
                                          //             ),
                                          //           ),
                                          //         ),
                                          //       ],
                                          //     ),
                                          //   ],
                                          // ): SizedBox(),
                                        ],
                                      )
                                : SizedBox(),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * .02,
                            ),
                            const Text(
                              "Name Of Engineer",
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * .01,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton2<Dealers1>(
                                      isExpanded: true,

                                      hint: Text(
                                        'Select',
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Theme.of(context).hintColor,
                                        ),
                                      ),
                                      items: delearRetailerModel?.data?.engineer
                                          ?.map((item) => DropdownMenuItem(
                                                value: item,
                                                child: Text(
                                                  item.ownerName ?? '',
                                                  style: const TextStyle(
                                                    fontSize: 14,
                                                  ),
                                                ),
                                              ))
                                          .toList(),
                                      value: engineerType,
                                      onChanged: (value) {
                                        engineerType = value;
                                        setState(() {
                                          selectedEngineer = value?.id;
                                          engineerIndex = delearRetailerModel!
                                              .data!.engineer!
                                              .indexWhere((element) =>
                                                  element.id ==
                                                  selectedEngineer);
                                          // currentIndex = selected;
                                          showTextField = true;
                                        });
                                      },
                                      buttonStyleData: ButtonStyleData(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 16, vertical: 5),
                                          height: 50,
                                          // width: 200,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              border: Border.all(
                                                color: Colors.black,
                                              ))),
                                      dropdownStyleData: DropdownStyleData(
                                          maxHeight: 200,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              border: Border.all(
                                                  color: Colors.black))),
                                      menuItemStyleData:
                                          const MenuItemStyleData(
                                        height: 40,
                                      ),
                                      dropdownSearchData: DropdownSearchData(
                                        searchController: searchController,
                                        searchInnerWidgetHeight: 50,
                                        searchInnerWidget: Container(
                                          height: 55,
                                          padding: const EdgeInsets.only(
                                            top: 8,
                                            bottom: 4,
                                            right: 8,
                                            left: 8,
                                          ),
                                          child: Column(
                                            children: [
                                              Expanded(
                                                child: TextFormField(
                                                  // keyboardType: TextInputType.number,
                                                  expands: true,
                                                  maxLines: null,
                                                  maxLength: 6,
                                                  controller: searchController,
                                                  decoration: InputDecoration(
                                                    isDense: true,
                                                    contentPadding:
                                                        const EdgeInsets
                                                            .symmetric(
                                                      horizontal: 10,
                                                      vertical: 8,
                                                    ),
                                                    hintText: 'Search  ...',
                                                    hintStyle: const TextStyle(
                                                        fontSize: 12),
                                                    counterText: '',
                                                    counterStyle:
                                                        TextStyle(fontSize: 0),
                                                    border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        searchMatchFn: (item, searchValue) {
                                          return item.value?.ownerName
                                                  .toString()
                                                  .toLowerCase()
                                                  .contains(searchValue) ??
                                              false;
                                        },
                                      ),
                                      //This to clear the search value when you close the menu
                                      onMenuStateChange: (isOpen) {
                                        if (!isOpen) {
                                          searchController.clear();
                                        }
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            // Container(
                            //   height: 60,
                            //   child: Card(
                            //     elevation: 2,
                            //     shape: OutlineInputBorder(
                            //         borderRadius: BorderRadius.circular(10)),
                            //     child: DropdownButtonFormField<String>(
                            //       value: selectedEngineer,
                            //       onChanged: (newValue) {
                            //         setState(() {
                            //           selectedEngineer = newValue;
                            //           engineerIndex = delearRetailerModel!
                            //               .data!.engineer!
                            //               .indexWhere((element) =>
                            //                   element.id == selectedEngineer);
                            //           // currentIndex = selected;
                            //           showTextField = true;
                            //         });
                            //       },
                            //       items: delearRetailerModel?.data?.engineer
                            //           ?.map((items) {
                            //         return DropdownMenuItem(
                            //           value: items.id,
                            //           child: Text(items.ownerName.toString()),
                            //         );
                            //       }).toList(),
                            //       decoration: InputDecoration(
                            //         contentPadding:
                            //             EdgeInsets.only(top: 5, left: 10),
                            //         border: InputBorder.none,
                            //         hintText: '',
                            //       ),
                            //     ),
                            //   ),
                            // ),
                            SizedBox(height: 10),
                            selectedEngineer != null
                                ? selectedEngineer == "907"
                                    ? SizedBox()
                                    : Column(
                                        children: [
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    .01,
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 10),
                                                child: Text(
                                                  "Mobile:",
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w800),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 15,
                                              ),
                                              delearRetailerModel!
                                                              .data!
                                                              .engineer?[
                                                                  engineerIndex]
                                                              .mobileOne ==
                                                          null ||
                                                      delearRetailerModel!
                                                              .data!
                                                              .engineer?[
                                                                  engineerIndex]
                                                              .mobileOne ==
                                                          " "
                                                  ? Container(
                                                      height: 40,
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width /
                                                              2.2,
                                                      child: TextFormField(
                                                        maxLength: 10,
                                                        keyboardType:
                                                            TextInputType
                                                                .number,
                                                        onChanged: (value) {
                                                          enaginnerMobile =
                                                              value;
                                                          print(
                                                              "kdksskjsdkf ${enaginnerMobile}");
                                                        },
                                                        // controller: ownerNameCtr,
                                                        decoration:
                                                            InputDecoration(
                                                          counterText: "",
                                                          // hintText: '',
                                                          border:
                                                              OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                          ),
                                                        ),
                                                      ),
                                                    )
                                                  : Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Container(
                                                          height: 40,
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width /
                                                              2.2,
                                                          decoration: BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10),
                                                              color:
                                                                  Colors.white,
                                                              border: Border.all(
                                                                  color: Colors
                                                                      .black)),
                                                          child: Center(
                                                            child: Text(
                                                              "${delearRetailerModel!.data!.engineer?[engineerIndex].mobileOne}",
                                                              style: TextStyle(
                                                                  fontSize: 12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w800),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                              SizedBox(height: 10),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 8,
                                          ),
                                          selectedEngineer == "909"
                                              ? Column(
                                                  children: [
                                                    Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        SizedBox(
                                                          height: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .height *
                                                              .01,
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  top: 10),
                                                          child: Text(
                                                            "Name:",
                                                            style: TextStyle(
                                                                fontSize: 12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w800),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: 20,
                                                        ),
                                                        Container(
                                                          height: 40,
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width /
                                                              2.2,
                                                          child: TextFormField(
                                                            controller:
                                                                engineerNameCtr,
                                                            // onChanged: (value) {
                                                            //   // String mobileContractor = value ;
                                                            //   contractorMobile = value;
                                                            // },
                                                            // readOnly: true,
                                                            //controller: mobilecn,
                                                            decoration:
                                                                InputDecoration(
                                                              contentPadding:
                                                                  EdgeInsets.only(
                                                                      bottom: 4,
                                                                      left: 3),
                                                              // hintText: '',
                                                              border: OutlineInputBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10)),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 8,
                                                    ),
                                                    Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        SizedBox(
                                                          height: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .height *
                                                              .01,
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  top: 10),
                                                          child: Text(
                                                            "Address:",
                                                            style: TextStyle(
                                                                fontSize: 12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w800),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: 10,
                                                        ),
                                                        Container(
                                                          height: 40,
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width /
                                                              2.2,
                                                          child: TextFormField(
                                                            controller:
                                                                engineerAddressCtr,
                                                            // onChanged: (value) {
                                                            //   // String mobileContractor = value ;
                                                            //   contractorMobile = value;
                                                            // },
                                                            //controller: mobilecn,
                                                            decoration:
                                                                InputDecoration(
                                                              contentPadding:
                                                                  EdgeInsets.only(
                                                                      bottom: 4,
                                                                      left: 3),
                                                              // hintText: '',
                                                              border: OutlineInputBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10)),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                )
                                              : SizedBox(),
                                        ],
                                      )
                                : SizedBox(),
                            selectedEngineer != null
                                ? selectedEngineer == "907" ||
                                        selectedEngineer == '909'
                                    ? SizedBox()
                                    : Column(
                                        children: [
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    .01,
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 10),
                                                child: Text(
                                                  "Address:",
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w800),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              delearRetailerModel!
                                                              .data!
                                                              .engineer?[
                                                                  engineerIndex]
                                                              .address ==
                                                          null ||
                                                      delearRetailerModel!
                                                              .data!
                                                              .engineer?[
                                                                  engineerIndex]
                                                              .address ==
                                                          " "
                                                  ? Container(
                                                      height: 40,
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width /
                                                              2.2,
                                                      child: TextFormField(
                                                        onChanged: (value) {
                                                          enaginneraddress =
                                                              value;
                                                        },
                                                        // controller: ownerNameCtr,
                                                        decoration:
                                                            InputDecoration(
                                                          // hintText: '',
                                                          border: OutlineInputBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10)),
                                                        ),
                                                      ),
                                                    )
                                                  : Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Container(
                                                          height: 40,
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width /
                                                              2.2,
                                                          decoration: BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10),
                                                              color:
                                                                  Colors.white,
                                                              border: Border.all(
                                                                  color: Colors
                                                                      .black)),
                                                          child: Center(
                                                            child: Text(
                                                              "${delearRetailerModel!.data!.engineer?[engineerIndex].address} Madhya Pradesh",
                                                              style: TextStyle(
                                                                  fontSize: 12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w800),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                              SizedBox(height: 10),
                                            ],
                                          ),
                                          // SizedBox(
                                          //   height: 8,
                                          // ),
                                          // selectedEngineer == "909"
                                          //     ? Column(
                                          //   children: [
                                          //     Row(
                                          //       crossAxisAlignment:
                                          //       CrossAxisAlignment
                                          //           .start,
                                          //       children: [
                                          //         SizedBox(
                                          //           height: MediaQuery.of(
                                          //               context)
                                          //               .size
                                          //               .height *
                                          //               .01,
                                          //         ),
                                          //         Padding(
                                          //           padding:
                                          //           const EdgeInsets
                                          //               .only(top: 10),
                                          //           child: Text(
                                          //             "Name:",
                                          //             style: TextStyle(
                                          //                 fontSize: 12,
                                          //                 fontWeight:
                                          //                 FontWeight
                                          //                     .w800),
                                          //           ),
                                          //         ),
                                          //         SizedBox(
                                          //           width: 20,
                                          //         ),
                                          //         Container(
                                          //           height: 40,
                                          //           width: MediaQuery.of(
                                          //               context)
                                          //               .size
                                          //               .width /
                                          //               2.2,
                                          //           child: TextFormField(
                                          //             controller:
                                          //             engineerNameCtr,
                                          //             // onChanged: (value) {
                                          //             //   // String mobileContractor = value ;
                                          //             //   contractorMobile = value;
                                          //             // },
                                          //             // readOnly: true,
                                          //             //controller: mobilecn,
                                          //             decoration:
                                          //             InputDecoration(
                                          //               contentPadding:
                                          //               EdgeInsets.only(
                                          //                   bottom: 4,
                                          //                   left: 3),
                                          //               // hintText: '',
                                          //               border: OutlineInputBorder(
                                          //                   borderRadius:
                                          //                   BorderRadius
                                          //                       .circular(
                                          //                       10)),
                                          //             ),
                                          //           ),
                                          //         ),
                                          //       ],
                                          //     ),
                                          //     SizedBox(
                                          //       height: 8,
                                          //     ),
                                          //     Row(
                                          //       crossAxisAlignment:
                                          //       CrossAxisAlignment
                                          //           .start,
                                          //       children: [
                                          //         SizedBox(
                                          //           height: MediaQuery.of(
                                          //               context)
                                          //               .size
                                          //               .height *
                                          //               .01,
                                          //         ),
                                          //         Padding(
                                          //           padding:
                                          //           const EdgeInsets
                                          //               .only(top: 10),
                                          //           child: Text(
                                          //             "Address:",
                                          //             style: TextStyle(
                                          //                 fontSize: 12,
                                          //                 fontWeight:
                                          //                 FontWeight
                                          //                     .w800),
                                          //           ),
                                          //         ),
                                          //         SizedBox(
                                          //           width: 10,
                                          //         ),
                                          //         Container(
                                          //           height: 40,
                                          //           width: MediaQuery.of(
                                          //               context)
                                          //               .size
                                          //               .width /
                                          //               2.2,
                                          //           child: TextFormField(
                                          //             controller:
                                          //             engineerAddressCtr,
                                          //             // onChanged: (value) {
                                          //             //   // String mobileContractor = value ;
                                          //             //   contractorMobile = value;
                                          //             // },
                                          //             //controller: mobilecn,
                                          //             decoration:
                                          //             InputDecoration(
                                          //               contentPadding:
                                          //               EdgeInsets.only(
                                          //                   bottom: 4,
                                          //                   left: 3),
                                          //               // hintText: '',
                                          //               border: OutlineInputBorder(
                                          //                   borderRadius:
                                          //                   BorderRadius
                                          //                       .circular(
                                          //                       10)),
                                          //             ),
                                          //           ),
                                          //         ),
                                          //       ],
                                          //     ),
                                          //   ],
                                          // )
                                          //     : SizedBox(),
                                        ],
                                      )
                                : SizedBox(),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * .02,
                            ),
                            const Text(
                              "Name Of Arti-tech",
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * .01,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton2<Dealers1>(
                                      isExpanded: true,

                                      hint: Text(
                                        'Select',
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Theme.of(context).hintColor,
                                        ),
                                      ),
                                      items: delearRetailerModel?.data?.artitech
                                          ?.map((item) => DropdownMenuItem(
                                                value: item,
                                                child: Text(
                                                  item.ownerName ?? '',
                                                  style: const TextStyle(
                                                    fontSize: 14,
                                                  ),
                                                ),
                                              ))
                                          .toList(),
                                      value: artitechType,
                                      onChanged: (value) {
                                        artitechType = value;
                                        setState(() {
                                          selectedArchitec = value?.id;
                                          architectIndex = delearRetailerModel!
                                              .data!.artitech!
                                              .indexWhere((element) =>
                                                  element.id ==
                                                  selectedArchitec);
                                          // currentIndex = selected;
                                          showTextField = true;
                                        });
                                      },
                                      buttonStyleData: ButtonStyleData(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 16, vertical: 5),
                                          height: 50,
                                          // width: 200,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              border: Border.all(
                                                color: Colors.black,
                                              ))),
                                      dropdownStyleData: DropdownStyleData(
                                          maxHeight: 200,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              border: Border.all(
                                                  color: Colors.black))),
                                      menuItemStyleData:
                                          const MenuItemStyleData(
                                        height: 40,
                                      ),
                                      dropdownSearchData: DropdownSearchData(
                                        searchController: searchController,
                                        searchInnerWidgetHeight: 50,
                                        searchInnerWidget: Container(
                                          height: 55,
                                          padding: const EdgeInsets.only(
                                            top: 8,
                                            bottom: 4,
                                            right: 8,
                                            left: 8,
                                          ),
                                          child: Column(
                                            children: [
                                              Expanded(
                                                child: TextFormField(
                                                  // keyboardType: TextInputType.number,
                                                  expands: true,
                                                  maxLines: null,
                                                  maxLength: 6,
                                                  controller: searchController,
                                                  decoration: InputDecoration(
                                                    isDense: true,
                                                    contentPadding:
                                                        const EdgeInsets
                                                            .symmetric(
                                                      horizontal: 10,
                                                      vertical: 8,
                                                    ),
                                                    hintText: 'Search  ...',
                                                    hintStyle: const TextStyle(
                                                        fontSize: 12),
                                                    counterText: '',
                                                    counterStyle:
                                                        TextStyle(fontSize: 0),
                                                    border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        searchMatchFn: (item, searchValue) {
                                          return item.value?.ownerName
                                                  .toString()
                                                  .toLowerCase()
                                                  .contains(searchValue) ??
                                              false;
                                        },
                                      ),
                                      //This to clear the search value when you close the menu
                                      onMenuStateChange: (isOpen) {
                                        if (!isOpen) {
                                          searchController.clear();
                                        }
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            // Container(
                            //   height: 60,
                            //   child: Card(
                            //     elevation: 2,
                            //     shape: OutlineInputBorder(
                            //         borderRadius: BorderRadius.circular(10)),
                            //     child: DropdownButtonFormField<String>(
                            //       value: selectedArchitec,
                            //       onChanged: (newValue) {
                            //         setState(() {
                            //           selectedArchitec = newValue;
                            //           architectIndex = delearRetailerModel!
                            //               .data!.artitech!
                            //               .indexWhere((element) =>
                            //                   element.id == selectedArchitec);
                            //           // currentIndex = selected;
                            //           showTextField = true;
                            //         });
                            //       },
                            //       items: delearRetailerModel?.data?.artitech
                            //           ?.map((items) {
                            //         return DropdownMenuItem(
                            //           value: items.id,
                            //           child: Text(items.ownerName.toString()),
                            //         );
                            //       }).toList(),
                            //       decoration: InputDecoration(
                            //         contentPadding:
                            //             EdgeInsets.only(top: 5, left: 10),
                            //         border: InputBorder.none,
                            //         hintText: '',
                            //       ),
                            //     ),
                            //   ),
                            // ),
                            SizedBox(height: 5),
                            selectedArchitec != null
                                ? selectedArchitec == "906"
                                    ? SizedBox()
                                    : Column(
                                        children: [
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    .01,
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 10),
                                                child: Text("Mobile:",
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w800)),
                                              ),
                                              SizedBox(
                                                width: 15,
                                              ),
                                              delearRetailerModel
                                                              ?.data
                                                              ?.artitech?[
                                                                  architectIndex]
                                                              .mobileOne ==
                                                          null ||
                                                      delearRetailerModel
                                                              ?.data
                                                              ?.artitech?[
                                                                  architectIndex]
                                                              .mobileOne ==
                                                          " "
                                                  ? Container(
                                                      height: 40,
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width /
                                                              2.2,
                                                      child: TextFormField(
                                                        maxLength: 10,
                                                        keyboardType:
                                                            TextInputType
                                                                .number,
                                                        onChanged: (value) {
                                                          architecMobile =
                                                              value;
                                                        },
                                                        // controller: ownerNameCtr,
                                                        decoration:
                                                            InputDecoration(
                                                          counterText: "",
                                                          // hintText: '',
                                                          border: OutlineInputBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10)),
                                                        ),
                                                      ),
                                                    )
                                                  : Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Container(
                                                          height: 40,
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width /
                                                              2.2,
                                                          decoration: BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10),
                                                              color:
                                                                  Colors.white,
                                                              border: Border.all(
                                                                  color: Colors
                                                                      .black)),
                                                          child: Center(
                                                              child: Text(
                                                                  "${delearRetailerModel?.data?.artitech?[architectIndex].mobileOne}",
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          12,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w800))),
                                                        ),
                                                      ],
                                                    ),
                                              SizedBox(height: 10),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 8,
                                          ),
                                          selectedArchitec == "900"
                                              ? Column(
                                                  children: [
                                                    Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        SizedBox(
                                                          height: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .height *
                                                              .01,
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  top: 10),
                                                          child: Text(
                                                            "Name:",
                                                            style: TextStyle(
                                                                fontSize: 12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w800),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: 20,
                                                        ),
                                                        Container(
                                                          height: 40,
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width /
                                                              2.2,
                                                          child: TextFormField(
                                                            controller:
                                                                artitechNameCtr,
                                                            // onChanged: (value) {
                                                            //   // String mobileContractor = value ;
                                                            //   contractorMobile = value;
                                                            // },
                                                            // readOnly: true,
                                                            //controller: mobilecn,
                                                            decoration:
                                                                InputDecoration(
                                                              contentPadding:
                                                                  EdgeInsets.only(
                                                                      bottom: 4,
                                                                      left: 3),
                                                              // hintText: '',
                                                              border: OutlineInputBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10)),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 8,
                                                    ),
                                                    Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        SizedBox(
                                                          height: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .height *
                                                              .01,
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  top: 10),
                                                          child: Text(
                                                            "Address:",
                                                            style: TextStyle(
                                                                fontSize: 12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w800),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: 10,
                                                        ),
                                                        Container(
                                                          height: 40,
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width /
                                                              2.2,
                                                          child: TextFormField(
                                                            controller:
                                                                artitechAddressCtr,
                                                            // onChanged: (value) {
                                                            //   // String mobileContractor = value ;
                                                            //   contractorMobile = value;
                                                            // },
                                                            //controller: mobilecn,
                                                            decoration:
                                                                InputDecoration(
                                                              contentPadding:
                                                                  EdgeInsets.only(
                                                                      bottom: 4,
                                                                      left: 3),
                                                              // hintText: '',
                                                              border: OutlineInputBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10)),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                )
                                              : SizedBox(),
                                        ],
                                      )
                                : SizedBox(),
                            selectedArchitec != null
                                ? selectedArchitec == "906" ||
                                        selectedArchitec == "900"
                                    ? SizedBox()
                                    : Column(
                                        children: [
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    .01,
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 10),
                                                child: Text("Address:",
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w800)),
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              delearRetailerModel
                                                              ?.data
                                                              ?.artitech?[
                                                                  architectIndex]
                                                              .address ==
                                                          null ||
                                                      delearRetailerModel
                                                              ?.data
                                                              ?.artitech?[
                                                                  architectIndex]
                                                              .address ==
                                                          " "
                                                  ? Container(
                                                      height: 40,
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width /
                                                              2.2,
                                                      child: TextFormField(
                                                        onChanged: (value) {
                                                          architecaddress =
                                                              value;
                                                        },
                                                        readOnly: true,
                                                        // controller: ownerNameCtr,
                                                        decoration:
                                                            InputDecoration(
                                                          // hintText: '',
                                                          border:
                                                              OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                          ),
                                                        ),
                                                      ),
                                                    )
                                                  : Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Container(
                                                          height: 40,
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width /
                                                              2.2,
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                            color: Colors.white,
                                                            border: Border.all(
                                                                color: Colors
                                                                    .black),
                                                          ),
                                                          child: Center(
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      left: 3),
                                                              child: Text(
                                                                "${delearRetailerModel?.data?.artitech?[architectIndex].address} Madhya Pradesh",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        12,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w800),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                              SizedBox(height: 10),
                                            ],
                                          ),
                                          // SizedBox(
                                          //   height: 8,
                                          // ),
                                          // selectedArchitec == "900"
                                          //     ? Column(
                                          //   children: [
                                          //     Row(
                                          //       crossAxisAlignment:
                                          //       CrossAxisAlignment
                                          //           .start,
                                          //       children: [
                                          //         SizedBox(
                                          //           height: MediaQuery.of(
                                          //               context)
                                          //               .size
                                          //               .height *
                                          //               .01,
                                          //         ),
                                          //         Padding(
                                          //           padding:
                                          //           const EdgeInsets
                                          //               .only(top: 10),
                                          //           child: Text(
                                          //             "Name:",
                                          //             style: TextStyle(
                                          //                 fontSize: 12,
                                          //                 fontWeight:
                                          //                 FontWeight
                                          //                     .w800),
                                          //           ),
                                          //         ),
                                          //         SizedBox(
                                          //           width: 20,
                                          //         ),
                                          //         Container(
                                          //           height: 40,
                                          //           width: MediaQuery.of(
                                          //               context)
                                          //               .size
                                          //               .width /
                                          //               2.2,
                                          //           child: TextFormField(
                                          //             controller:
                                          //             artitechNameCtr,
                                          //             // onChanged: (value) {
                                          //             //   // String mobileContractor = value ;
                                          //             //   contractorMobile = value;
                                          //             // },
                                          //             // readOnly: true,
                                          //             //controller: mobilecn,
                                          //             decoration:
                                          //             InputDecoration(
                                          //               contentPadding:
                                          //               EdgeInsets.only(
                                          //                   bottom: 4,
                                          //                   left: 3),
                                          //               // hintText: '',
                                          //               border: OutlineInputBorder(
                                          //                   borderRadius:
                                          //                   BorderRadius
                                          //                       .circular(
                                          //                       10)),
                                          //             ),
                                          //           ),
                                          //         ),
                                          //       ],
                                          //     ),
                                          //     SizedBox(
                                          //       height: 8,
                                          //     ),
                                          //     Row(
                                          //       crossAxisAlignment:
                                          //       CrossAxisAlignment
                                          //           .start,
                                          //       children: [
                                          //         SizedBox(
                                          //           height: MediaQuery.of(
                                          //               context)
                                          //               .size
                                          //               .height *
                                          //               .01,
                                          //         ),
                                          //         Padding(
                                          //           padding:
                                          //           const EdgeInsets
                                          //               .only(top: 10),
                                          //           child: Text(
                                          //             "Address:",
                                          //             style: TextStyle(
                                          //                 fontSize: 12,
                                          //                 fontWeight:
                                          //                 FontWeight
                                          //                     .w800),
                                          //           ),
                                          //         ),
                                          //         SizedBox(
                                          //           width: 10,
                                          //         ),
                                          //         Container(
                                          //           height: 40,
                                          //           width: MediaQuery.of(
                                          //               context)
                                          //               .size
                                          //               .width /
                                          //               2.2,
                                          //           child: TextFormField(
                                          //             controller:
                                          //             artitechAddressCtr,
                                          //             // onChanged: (value) {
                                          //             //   // String mobileContractor = value ;
                                          //             //   contractorMobile = value;
                                          //             // },
                                          //             //controller: mobilecn,
                                          //             decoration:
                                          //             InputDecoration(
                                          //               contentPadding:
                                          //               EdgeInsets.only(
                                          //                   bottom: 4,
                                          //                   left: 3),
                                          //               // hintText: '',
                                          //               border: OutlineInputBorder(
                                          //                   borderRadius:
                                          //                   BorderRadius
                                          //                       .circular(
                                          //                       10)),
                                          //             ),
                                          //           ),
                                          //         ),
                                          //       ],
                                          //     ),
                                          //   ],
                                          // )
                                          //     : SizedBox(),
                                        ],
                                      )
                                : SizedBox(),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * .02,
                            ),
                            const Text(
                              "Name Of Mason",
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * .01,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton2<Dealers1>(
                                      isExpanded: true,

                                      hint: Text(
                                        'Select',
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Theme.of(context).hintColor,
                                        ),
                                      ),
                                      items: delearRetailerModel?.data?.massion
                                          ?.map((item) => DropdownMenuItem(
                                                value: item,
                                                child: Text(
                                                  item.ownerName ?? '',
                                                  style: const TextStyle(
                                                    fontSize: 14,
                                                  ),
                                                ),
                                              ))
                                          .toList(),
                                      value: massionype,
                                      onChanged: (value) {
                                        massionype = value;
                                        setState(() {
                                          selectedMession = value?.id;
                                          messionIndex = delearRetailerModel!
                                              .data!.massion!
                                              .indexWhere((element) =>
                                                  element.id ==
                                                  selectedMession);
                                          // currentIndex = selected;
                                          showTextField = true;
                                        });
                                      },
                                      buttonStyleData: ButtonStyleData(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 16, vertical: 5),
                                          height: 50,
                                          // width: 200,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              border: Border.all(
                                                color: Colors.black,
                                              ))),
                                      dropdownStyleData: DropdownStyleData(
                                          maxHeight: 200,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              border: Border.all(
                                                  color: Colors.black))),
                                      menuItemStyleData:
                                          const MenuItemStyleData(
                                        height: 40,
                                      ),
                                      dropdownSearchData: DropdownSearchData(
                                        searchController: searchController,
                                        searchInnerWidgetHeight: 50,
                                        searchInnerWidget: Container(
                                          height: 55,
                                          padding: const EdgeInsets.only(
                                            top: 8,
                                            bottom: 4,
                                            right: 8,
                                            left: 8,
                                          ),
                                          child: Column(
                                            children: [
                                              Expanded(
                                                child: TextFormField(
                                                  // keyboardType: TextInputType.number,
                                                  expands: true,
                                                  maxLines: null,
                                                  maxLength: 6,
                                                  controller: searchController,
                                                  decoration: InputDecoration(
                                                    isDense: true,
                                                    contentPadding:
                                                        const EdgeInsets
                                                            .symmetric(
                                                      horizontal: 10,
                                                      vertical: 8,
                                                    ),
                                                    hintText: 'Search  ...',
                                                    hintStyle: const TextStyle(
                                                        fontSize: 12),
                                                    counterText: '',
                                                    counterStyle:
                                                        TextStyle(fontSize: 0),
                                                    border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        searchMatchFn: (item, searchValue) {
                                          return item.value?.ownerName
                                                  .toString()
                                                  .toLowerCase()
                                                  .contains(searchValue) ??
                                              false;
                                        },
                                      ),
                                      //This to clear the search value when you close the menu
                                      onMenuStateChange: (isOpen) {
                                        if (!isOpen) {
                                          searchController.clear();
                                        }
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            // Container(
                            //   height: 60,
                            //   child: Card(
                            //     elevation: 2,
                            //     shape: OutlineInputBorder(
                            //         borderRadius: BorderRadius.circular(10)),
                            //     child: DropdownButtonFormField<String>(
                            //       value: selectedMession,
                            //       onChanged: (newValue) {
                            //         setState(() {
                            //           selectedMession = newValue;
                            //           messionIndex = delearRetailerModel!
                            //               .data!.massion!
                            //               .indexWhere((element) =>
                            //                   element.id == selectedMession);
                            //           // currentIndex = selected;
                            //           showTextField = true;
                            //         });
                            //       },
                            //       items: delearRetailerModel?.data?.massion
                            //           ?.map((items) {
                            //         return DropdownMenuItem(
                            //           value: items.id,
                            //           child: Text(items.ownerName.toString()),
                            //         );
                            //       }).toList(),
                            //       decoration: InputDecoration(
                            //         contentPadding:
                            //             EdgeInsets.only(top: 5, left: 10),
                            //         border: InputBorder.none,
                            //         hintText: '',
                            //       ),
                            //     ),
                            //   ),
                            // ),
                            SizedBox(height: 5),
                            selectedMession != null
                                ? selectedMession == "902"
                                    ? SizedBox()
                                    : Column(
                                        children: [
                                          Row(
                                            //  mainAxisSize: MainAxisSize.min,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 10),
                                                child: Text("Mobile:",
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w800)),
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              delearRetailerModel
                                                              ?.data
                                                              ?.massion?[
                                                                  messionIndex]
                                                              .mobileOne ==
                                                          null ||
                                                      delearRetailerModel
                                                              ?.data
                                                              ?.massion?[
                                                                  messionIndex]
                                                              .mobileOne ==
                                                          " "
                                                  ? Container(
                                                      height: 40,
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width /
                                                              2.2,
                                                      child: TextFormField(
                                                        maxLength: 10,
                                                        keyboardType:
                                                            TextInputType
                                                                .number,
                                                        onChanged: (value) {
                                                          messionMobile = value;
                                                        },
                                                        // controller: TextEditingController(),
                                                        decoration:
                                                            InputDecoration(
                                                          counterText: "",
                                                          // hintText: '',
                                                          border: OutlineInputBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10)),
                                                        ),
                                                      ),
                                                    )
                                                  : Container(
                                                      height: 40,
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width /
                                                              2.2,
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                          color: Colors.white,
                                                          border: Border.all(
                                                              color: Colors
                                                                  .black)),
                                                      child: Center(
                                                        child: Text(
                                                          "${delearRetailerModel?.data?.massion?[messionIndex].mobileOne}",
                                                          style: TextStyle(
                                                              fontSize: 12,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w800),
                                                        ),
                                                      ),
                                                    ),
                                              SizedBox(height: 10),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 8,
                                          ),
                                          selectedMession == "904"
                                              ? Column(
                                                  children: [
                                                    Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        SizedBox(
                                                          height: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .height *
                                                              .01,
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  top: 10),
                                                          child: Text(
                                                            "Name:",
                                                            style: TextStyle(
                                                                fontSize: 12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w800),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: 20,
                                                        ),
                                                        Container(
                                                          height: 40,
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width /
                                                              2.2,
                                                          child: TextFormField(
                                                            controller:
                                                                missionNameCtr,
                                                            // onChanged: (value) {
                                                            //   // String mobileContractor = value ;
                                                            //   contractorMobile = value;
                                                            // },
                                                            // readOnly: true,
                                                            //controller: mobilecn,
                                                            decoration:
                                                                InputDecoration(
                                                              contentPadding:
                                                                  EdgeInsets.only(
                                                                      bottom: 4,
                                                                      left: 3),
                                                              // hintText: '',
                                                              border: OutlineInputBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10)),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 8,
                                                    ),
                                                    Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        SizedBox(
                                                          height: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .height *
                                                              .01,
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  top: 10),
                                                          child: Text(
                                                            "Address:",
                                                            style: TextStyle(
                                                                fontSize: 12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w800),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: 10,
                                                        ),
                                                        Container(
                                                          height: 40,
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width /
                                                              2.2,
                                                          child: TextFormField(
                                                            controller:
                                                                missionAddressCtr,
                                                            // onChanged: (value) {
                                                            //   // String mobileContractor = value ;
                                                            //   contractorMobile = value;
                                                            // },
                                                            //controller: mobilecn,
                                                            decoration:
                                                                InputDecoration(
                                                              contentPadding:
                                                                  EdgeInsets.only(
                                                                      bottom: 4,
                                                                      left: 3),
                                                              // hintText: '',
                                                              border: OutlineInputBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10)),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                )
                                              : SizedBox(),
                                        ],
                                      )
                                : SizedBox(),
                            selectedMession != null
                                ? selectedMession == "902" ||
                                        selectedMession == "904"
                                    ? SizedBox()
                                    : Column(
                                        children: [
                                          Row(
                                            mainAxisSize: MainAxisSize.min,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 10),
                                                child: Text("Address:",
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w800)),
                                              ),
                                              SizedBox(
                                                width: 6,
                                              ),
                                              delearRetailerModel
                                                              ?.data
                                                              ?.massion?[
                                                                  messionIndex]
                                                              .address ==
                                                          null ||
                                                      delearRetailerModel
                                                              ?.data
                                                              ?.massion?[
                                                                  messionIndex]
                                                              .address ==
                                                          " "
                                                  ? Container(
                                                      height: 40,
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width /
                                                              2.2,
                                                      child: TextFormField(
                                                        onChanged: (value) {
                                                          messionaddress =
                                                              value;
                                                        },
                                                        controller:
                                                            TextEditingController(),
                                                        decoration:
                                                            InputDecoration(
                                                          // hintText: '',
                                                          border: OutlineInputBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10)),
                                                        ),
                                                      ),
                                                    )
                                                  : Container(
                                                      height: 40,
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width /
                                                              2.2,
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                          color: Colors.white,
                                                          border: Border.all(
                                                              color: Colors
                                                                  .black)),
                                                      child: Center(
                                                        child: Text(
                                                          "${delearRetailerModel?.data?.massion?[messionIndex].address} Madhya Pradesh",
                                                          style: TextStyle(
                                                              fontSize: 12,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w800),
                                                        ),
                                                      ),
                                                    ),
                                              SizedBox(height: 10),
                                            ],
                                          ),
                                          // SizedBox(
                                          //   height: 8,
                                          // ),
                                          // selectedMession == "904"
                                          //     ? Column(
                                          //   children: [
                                          //     Row(
                                          //       crossAxisAlignment:
                                          //       CrossAxisAlignment
                                          //           .start,
                                          //       children: [
                                          //         SizedBox(
                                          //           height: MediaQuery.of(
                                          //               context)
                                          //               .size
                                          //               .height *
                                          //               .01,
                                          //         ),
                                          //         Padding(
                                          //           padding:
                                          //           const EdgeInsets
                                          //               .only(top: 10),
                                          //           child: Text(
                                          //             "Name:",
                                          //             style: TextStyle(
                                          //                 fontSize: 12,
                                          //                 fontWeight:
                                          //                 FontWeight
                                          //                     .w800),
                                          //           ),
                                          //         ),
                                          //         SizedBox(
                                          //           width: 20,
                                          //         ),
                                          //         Container(
                                          //           height: 40,
                                          //           width: MediaQuery.of(
                                          //               context)
                                          //               .size
                                          //               .width /
                                          //               2.2,
                                          //           child: TextFormField(
                                          //             controller:
                                          //             missionNameCtr,
                                          //             // onChanged: (value) {
                                          //             //   // String mobileContractor = value ;
                                          //             //   contractorMobile = value;
                                          //             // },
                                          //             // readOnly: true,
                                          //             //controller: mobilecn,
                                          //             decoration:
                                          //             InputDecoration(
                                          //               contentPadding:
                                          //               EdgeInsets.only(
                                          //                   bottom: 4,
                                          //                   left: 3),
                                          //               // hintText: '',
                                          //               border: OutlineInputBorder(
                                          //                   borderRadius:
                                          //                   BorderRadius
                                          //                       .circular(
                                          //                       10)),
                                          //             ),
                                          //           ),
                                          //         ),
                                          //       ],
                                          //     ),
                                          //     SizedBox(
                                          //       height: 8,
                                          //     ),
                                          //     Row(
                                          //       crossAxisAlignment:
                                          //       CrossAxisAlignment
                                          //           .start,
                                          //       children: [
                                          //         SizedBox(
                                          //           height: MediaQuery.of(
                                          //               context)
                                          //               .size
                                          //               .height *
                                          //               .01,
                                          //         ),
                                          //         Padding(
                                          //           padding:
                                          //           const EdgeInsets
                                          //               .only(top: 10),
                                          //           child: Text(
                                          //             "Address:",
                                          //             style: TextStyle(
                                          //                 fontSize: 12,
                                          //                 fontWeight:
                                          //                 FontWeight
                                          //                     .w800),
                                          //           ),
                                          //         ),
                                          //         SizedBox(
                                          //           width: 10,
                                          //         ),
                                          //         Container(
                                          //           height: 40,
                                          //           width: MediaQuery.of(
                                          //               context)
                                          //               .size
                                          //               .width /
                                          //               2.2,
                                          //           child: TextFormField(
                                          //             controller:
                                          //             missionAddressCtr,
                                          //             // onChanged: (value) {
                                          //             //   // String mobileContractor = value ;
                                          //             //   contractorMobile = value;
                                          //             // },
                                          //             //controller: mobilecn,
                                          //             decoration:
                                          //             InputDecoration(
                                          //               contentPadding:
                                          //               EdgeInsets.only(
                                          //                   bottom: 4,
                                          //                   left: 3),
                                          //               // hintText: '',
                                          //               border: OutlineInputBorder(
                                          //                   borderRadius:
                                          //                   BorderRadius
                                          //                       .circular(
                                          //                       10)),
                                          //             ),
                                          //           ),
                                          //         ),
                                          //       ],
                                          //     ),
                                          //   ],
                                          // )
                                          //     : SizedBox(),
                                        ],
                                      )
                                : SizedBox(),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * .01,
                            ),
                            const Text("Status Of Site",
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.bold)),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * .01,
                            ),
                            Container(
                              height: 50,
                              child: TextFormField(
                                keyboardType: TextInputType.text,
                                controller: statusSiteCtr,
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
                              "Site Size (in sqr. ft.)",
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * .01,
                            ),
                            Container(
                              height: 50,
                              child: TextFormField(
                                keyboardType: TextInputType.number,
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
                                  border: Border.all(color: Colors.black),
                                ),
                                height: 45,
                                width: MediaQuery.of(context).size.width / 1.1,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 0, left: 10, bottom: 2, right: 10),
                                  child: select(),
                                ),
                              ),
                            ),
                            // SizedBox(
                            //   height: MediaQuery.of(context).size.height * .01,
                            // ),
                            // const Text(
                            //   "Remark",
                            //   style: TextStyle(
                            //       fontSize: 14, fontWeight: FontWeight.bold),
                            // ),
                            // SizedBox(
                            //   height: MediaQuery.of(context).size.height * .01,
                            // ),
                            // Container(
                            //   height: 65,
                            //   child: TextFormField(
                            //       keyboardType: TextInputType.text,
                            //       controller: remarkCtr,
                            //       decoration: InputDecoration(
                            //           hintText: '',
                            //           border: OutlineInputBorder(
                            //               borderRadius:
                            //                   BorderRadius.circular(10)))),
                            // ),
                            // SizedBox(
                            //   height: MediaQuery.of(context).size.height * .01,
                            // ),
                            // const Text(
                            //   "Expected Date",
                            //   style: TextStyle(
                            //       fontSize: 14, fontWeight: FontWeight.bold),
                            // ),
                            // SizedBox(
                            //   height: MediaQuery.of(context).size.height * .01,
                            // ),
                            // Container(
                            //   height: 50,
                            //   // width: MediaQuery.of(context).size.width / 2.9,
                            //   child: TextField(
                            //     controller: execteddateCtr,
                            //     decoration: InputDecoration(
                            //         hintText: 'Select Expected Date',
                            //         border: OutlineInputBorder(
                            //             borderRadius: BorderRadius.circular(10))),
                            //      onTap: () async {
                            //       DateTime? pickedDate = await showDatePicker(
                            //           context: context,
                            //           initialDate: DateTime.now(),
                            //           firstDate: DateTime(1950),
                            //           lastDate: DateTime(2100),
                            //           builder: (context, child) {
                            //             return Theme(
                            //                 data: Theme.of(context).copyWith(
                            //                   colorScheme:
                            //                       const ColorScheme.light(
                            //                           primary: colors.primary),
                            //                 ),
                            //                 child: child!);
                            //           });
                            //       if (pickedDate != null) {
                            //         String formattedDate = DateFormat('dd-MM-yyyy').format(pickedDate);
                            //         setState(() {
                            //           execteddateCtr.text = formattedDate;
                            //         });
                            //       }
                            //     },
                            //   ),
                            // ),
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
                            //       String formattedDate = DateFormat('dd-MM-yyyy').format(pickedDate);
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
                            // SizedBox(
                            //   height: MediaQuery.of(context).size.height * .01,
                            // ),
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
                            // uploadMultiImage(),
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
                          if (namecn.text.isEmpty || namecn.text == "") {
                            Fluttertoast.showToast(msg: "Please enter Name");
                          } else if (mobileCtr.text.isEmpty ||
                              mobileCtr.text == "") {
                            Fluttertoast.showToast(msg: "Please enter number");
                          } else if (addressCtr.text.isEmpty ||
                              addressCtr.text == "") {
                            Fluttertoast.showToast(msg: "Please enter address");
                          } else if (selectedState == null) {
                            Fluttertoast.showToast(msg: "Please select State");
                          } else if (selectedDistrict == null) {
                            Fluttertoast.showToast(
                                msg: "Please select district");
                          } else if (results.isEmpty) {
                            Fluttertoast.showToast(
                                msg: "Please select product being used");
                          } else {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SiteSurvey(
                                  modelList: results,
                                  name: namecn.text,
                                  contact: mobileCtr.text,
                                  address: addressCtr.text,
                                  state: getListModel
                                      ?.data?.states?[stateindex].id,
                                  district: getListModel!.data!
                                      .states![stateindex].cities?[nwIndex].id,
                                  pincode: pinCodeController.text,
                                  sitesize: siteSizeCtr.text,
                                  expectedDate: execteddateCtr.text,
                                  missionName: missionNameCtr.text,
                                  missionAddress:
                                      missionAddressCtr.text == null ||
                                              missionAddressCtr.text == ""
                                          ? missionAddressCtr.text
                                          : delearRetailerModel?.data
                                              ?.massion?[messionIndex].address,
                                  mession: selectedMession,
                                  messionMobile: delearRetailerModel
                                                  ?.data
                                                  ?.massion?[messionIndex]
                                                  .mobileOne ==
                                              "" ||
                                          delearRetailerModel
                                                  ?.data
                                                  ?.massion?[messionIndex]
                                                  .mobileOne ==
                                              null
                                      ? messionMobile
                                      : delearRetailerModel?.data
                                          ?.massion?[messionIndex].mobileOne,
                                  contractor: selectedContractor,
                                  contractorMobile: delearRetailerModel
                                                  ?.data
                                                  ?.contractor?[contractorIndex]
                                                  .mobileOne ==
                                              "" ||
                                          delearRetailerModel
                                                  ?.data
                                                  ?.contractor?[contractorIndex]
                                                  .mobileOne ==
                                              null
                                      ? contractorMobile
                                      : delearRetailerModel
                                          ?.data
                                          ?.contractor?[contractorIndex]
                                          .mobileOne,
                                  contractorName: contractorNameCtr.text,
                                  contractorAddress:
                                      contractorAddressCtr.text == null ||
                                              contractorAddressCtr.text == ""
                                          ? contractorAddressCtr.text
                                          : delearRetailerModel
                                              ?.data
                                              ?.contractor?[contractorIndex]
                                              .address,
                                  engineer: selectedEngineer,
                                  engineerMobile: delearRetailerModel
                                                  ?.data
                                                  ?.engineer?[engineerIndex]
                                                  .mobileOne ==
                                              "" ||
                                          delearRetailerModel
                                                  ?.data
                                                  ?.engineer?[engineerIndex]
                                                  .mobileOne ==
                                              null
                                      ? enaginnerMobile
                                      : delearRetailerModel?.data
                                          ?.engineer?[engineerIndex].mobileOne,
                                  engineerName: engineerNameCtr.text,
                                  engineerAddress:
                                      engineerAddressCtr.text == null ||
                                              engineerAddressCtr.text == ""
                                          ? engineerAddressCtr.text
                                          : delearRetailerModel
                                              ?.data
                                              ?.engineer?[engineerIndex]
                                              .address,
                                  architec: selectedArchitec,
                                  architecMobile: delearRetailerModel
                                                  ?.data
                                                  ?.artitech?[architectIndex]
                                                  .mobileOne ==
                                              "" ||
                                          delearRetailerModel
                                                  ?.data
                                                  ?.artitech?[architectIndex]
                                                  .mobileOne ==
                                              null
                                      ? architecMobile
                                      : delearRetailerModel?.data
                                          ?.artitech?[architectIndex].mobileOne,
                                  architecName: artitechNameCtr.text,
                                  architecAddress:
                                      artitechAddressCtr.text == null ||
                                              artitechAddressCtr.text == ""
                                          ? artitechAddressCtr.text
                                          : delearRetailerModel
                                              ?.data
                                              ?.artitech?[architectIndex]
                                              .address,
                                  // creditLimit: widget.creditLimit,
                                  //customerType: widget.customerType,
                                  // date: dateCtr.text,
                                  status: statusSiteCtr.text,
                                  time: timeCtr.text,
                                  // image: imagePathList,
                                  // remark: remarkCtr.text,
                                  // clintId: cl,
                                ),
                              ),
                            );

                            // if(namecn.text.isEmpty || siteSizeCtr.text.isEmpty || selectedStatus!.isEmpty || mobileCtr.text.isEmpty || _imageFile!.path.isEmpty) {
                            //   Fluttertoast.showToast(msg: "All Fields Required");
                            // } else{
                            //
                            // }
                          }
                        },
                        child: Center(
                          child: Container(
                            height: 40,
                            width: MediaQuery.of(context).size.width / 1.8,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: colors.primary),
                            child: const Center(
                              child: Text(
                                "Save & Next",
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
      ),
    );
  }
}
