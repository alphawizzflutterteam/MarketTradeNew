// import 'package:flutter/material.dart';
// import 'package:omega_employee_management/Helper/Color.dart';
// import 'package:omega_employee_management/Screen/Survey.dart';
//
// import '../Model/DealingProductModel.dart';
//
//
//
// class MultiSelect extends StatefulWidget {
//   final List <DealingData>? dealingData;
//   final String? name;
//   final String? email;
//   final String? contact;
//   final String? customerType;
//   final String? creditLimit;
//   final String? time;
//   final String? date;
//   final String? remark;
//   final String? image;
//   final String? clientId;
//   // required this.type
//   MultiSelect({Key? key, this.dealingData, this.name, this.email,this.contact,this.creditLimit, this.customerType,this.time, this.date,this.image, this.remark, this.clientId }) : super(key: key);
//   @override
//   State<StatefulWidget> createState() => _MultiSelectState();
// }
// class _MultiSelectState extends State<MultiSelect> {
//
//    final List <DealingData>? selectedDealingData = [];
//    List <String>_selectedUserItems = [];
//
//
//    void _itemChange(DealingData itemValue, bool isSelected) {
//     setState(() {
//       if (isSelected) {
//         setState(() {
//           _selectedUserItems.add(itemValue.name ?? '');
//           selectedDealingData?.add(itemValue);
//         });
//       } else {
//         setState(() {
//           _selectedUserItems.remove(itemValue.name ?? '');
//           selectedDealingData?.remove(itemValue);
//         });
//       }
//     });
//     print("this is selected values ${_selectedUserItems.toString()}");
//   }
//
//   void _cancel() {
//     Navigator.pop(context);
//   }
//
//   /*void _submit() {
//     List selectedItem = _selectedItems2.map((item) => item).toList();
//     //Navigator.pop(context);
//   }*/
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     //_selectedItems2.clear();
//   }
//   String finalList = '';
//
//   @override
//   Widget build(BuildContext context) {
//     return StatefulBuilder(
//         builder: (context, setState)
//         {
//           return
//             AlertDialog(
//               title: const Text('Select Category'),
//               content: SingleChildScrollView(
//                 child: ListBody(
//                   children: widget.dealingData!
//                       .map((DealingData data) =>
//                       CheckboxListTile(
//                         activeColor: colors.primary,
//                         value: _selectedUserItems.contains(data.name),
//                         title: Text(data.name ?? ''),
//                         controlAffinity: ListTileControlAffinity.leading,
//                         onChanged: (isChecked) => _itemChange(data, isChecked!),
//                       )
//                   ).toList(),
//                 ),
//               ),
//               actions: [
//                 TextButton(
//                   onPressed: _cancel,
//                   child: const Text('Cancel',
//                     style: TextStyle(color: colors.primary)),
//                 ),
//                 ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                         primary: colors.primary
//                     ),
//                     child: const Text('Submit'),
//                     onPressed: () {
//                       //_submit();
//                       Navigator.pop(context, selectedDealingData);
//                       // Navigator.push(context, MaterialPageRoute(builder: (context) => Survey(
//                       //   modelList: selectedDealingData,
//                       //   name: widget.name,
//                       // email: widget.email,
//                       // contact: widget.contact,
//                       //   creditLimit: widget.creditLimit,
//                       //   customerType: widget.customerType,
//                       //   date: widget.date,
//                       //   time: widget.time,
//                       //   image: widget.image,
//                       //   remark: widget.remark,
//                       //   clintId: widget.clientId,
//                       // )));
//                     }
//                 ),
//               ],
//             );
//         }
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:omega_employee_management/Helper/Color.dart';
import 'package:omega_employee_management/Screen/Survey.dart';

import '../Model/DealingProductModel.dart';
import 'SiteSurvey.dart';

class MultiSelect extends StatefulWidget {
  final List <DealingData>? dealingData;
  final String? name;
  final String? email;
  final String? contact;
  final String? customerType;
  final String? creditLimit;
  final String? time;
  final String? date;
  final String? remark;
  final String? image;
  final String? clientId;
  final List<String>? departments;
   List<String>? selectedDepartments;
  // required this.type
  MultiSelect({Key? key,this.selectedDepartments, this.departments,this.dealingData, this.name, this.email,this.contact,this.creditLimit, this.customerType,this.time, this.date,this.image, this.remark, this.clientId }) : super(key: key);
  @override
  State<StatefulWidget> createState() => _MultiSelectState();
}
class _MultiSelectState extends State<MultiSelect> {

  final List <DealingData>? selectedDealingData = [];
  List <String>_selectedUserItems = [];
  List <String>_selectedDepartments = [];

  void _itemChange(DealingData itemValue, bool isSelected) {
    setState(() {
      if (isSelected) {
        setState(() {
          _selectedUserItems.add(itemValue.name ?? '');
          selectedDealingData?.add(itemValue);
        });
      } else {
        setState(() {
          _selectedUserItems.remove(itemValue.name ?? '');
          selectedDealingData?.remove(itemValue);
        });
      }
    });
    print("this is selected values ${_selectedUserItems.toString()}");
  }

  void _departmentValueChange(String? department, bool isSelected) {
    setState(() {
      if (isSelected) {
        setState(() {
          _selectedDepartments.add(department ?? '');


        });
      } else {
        setState(() {
          _selectedDepartments.remove(department ?? '');
        });
      }
    });
    print("this is selected departments ${_selectedDepartments.toString()}");
  }


  void _cancel() {
    Navigator.pop(context);
  }

  /*void _submit() {
    List selectedItem = _selectedItems2.map((item) => item).toList();
    //Navigator.pop(context);
  }*/

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //_selectedItems2.clear();
  }
  String finalList = '';

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
        builder: (context, setState) {
          return
            widget.departments != null || widget.departments!.isNotEmpty ?
            AlertDialog(
              title: const Text('Select Departments'),
              content: SingleChildScrollView(
                child: ListBody(
                  children: widget.departments!
                      .map((e) =>
                      CheckboxListTile(
                        activeColor: colors.primary,
                        value: _selectedDepartments.contains(e),
                        title: Text(e ?? ''),
                        controlAffinity: ListTileControlAffinity.leading,
                        onChanged: (isSelected) => _departmentValueChange(e, isSelected!),
                      )
                  ).toList(),
                ),
              ),
              actions: [
                TextButton(
                  onPressed: _cancel,
                  child: const Text('Cancel',
                    style: TextStyle(color: colors.primary),
                  ),
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: colors.primary
                    ),
                    child: const Text('Submit'),
                    onPressed: () {
                      //_submit();
                      Navigator.pop(context, _selectedDepartments);
                      /*Navigator.push(context, MaterialPageRoute(builder: (context) => SiteSurvey(
                        modelList: selectedDealingData,
                        name: widget.name,
                        email: widget.email,
                        contact: widget.contact,
                        creditLimit: widget.creditLimit,
                        customerType: widget.customerType,
                        date: widget.date,
                        time: widget.time,
                        image: widget.image,
                        remark: widget.remark,
                        clintId: widget.clientId,
                      )));*/
                    }
                ),
              ],
            ):
            AlertDialog(
              title: const Text('Select Category'),
              content: SingleChildScrollView(
                child: ListBody(
                  children: widget.dealingData!
                      .map((DealingData data) =>
                      CheckboxListTile(
                        activeColor: colors.primary,
                        value: _selectedUserItems.contains(data.name),
                        title: Text(data.name ?? ''),
                        controlAffinity: ListTileControlAffinity.leading,
                        onChanged: (isChecked) => _itemChange(data, isChecked!),
                      )
                  ).toList(),
                ),
              ),
              actions: [
                TextButton(
                  onPressed: _cancel,
                  child: const Text('Cancel',
                      style: TextStyle(color: colors.primary),
                  ),
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: colors.primary
                    ),
                    child: const Text('Submit'),
                    onPressed: () {
                      //_submit();
                      Navigator.pop(context, selectedDealingData);
                      /*Navigator.push(context, MaterialPageRoute(builder: (context) => SiteSurvey(
                        modelList: selectedDealingData,
                        name: widget.name,
                        email: widget.email,
                        contact: widget.contact,
                        creditLimit: widget.creditLimit,
                        customerType: widget.customerType,
                        date: widget.date,
                        time: widget.time,
                        image: widget.image,
                        remark: widget.remark,
                        clintId: widget.clientId,
                      )));*/
                    }
                ),
              ],
            );

        }
    );
  }
}