import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:omega_employee_management/Helper/Color.dart';
import 'package:http/http.dart'as http;
import 'package:omega_employee_management/Helper/Constant.dart';
import 'package:omega_employee_management/Helper/String.dart';
import 'package:omega_employee_management/Model/work_allotment_model.dart';

class WorkallotmentScreen extends StatefulWidget {
  const WorkallotmentScreen({Key? key}) : super(key: key);

  @override
  State<WorkallotmentScreen> createState() => _WorkallotmentScreenState();
}

class _WorkallotmentScreenState extends State<WorkallotmentScreen> {

  WorkallotmentModel?workallotmentModel;
  Future<void> workallotment()async {
    var headers = {
      'Cookie': 'ci_session=7ae8b4f267c403c6776ef6271edd089e3b1a17c4'
    };
    var request = http.MultipartRequest('POST', Uri.parse('${baseUrl}get_user_works'));
    request.fields.addAll({
      'user_id': '${CUR_USERID}'
    });

    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var Result = await response.stream.bytesToString();
      final finalResult = WorkallotmentModel.fromJson(json.decode(Result));
      setState(() {
        workallotmentModel = finalResult;

      });

    }
    else {
    print(response.reasonPhrase);
    }

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    workallotment();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back,color: colors.blackTemp,)),
        backgroundColor: colors.whiteTemp,
        title: Text('Work Allotment',style: TextStyle(color: colors.blackTemp),),
      ),
      body:
      // SingleChildScrollView(
      //   child: Column(
      //     children: [
      //       SizedBox(height: 20,),
      //       workallotmentModel?.data==null||workallotmentModel?.data==''?Center(child: Text('Data not found',style: TextStyle(fontWeight: FontWeight.bold,fontSize:17),)):Container(
      //         height:MediaQuery.of(context).size.height/1,
      //         width:MediaQuery.of(context).size.width/1,
      //         child:
      workallotmentModel?.data==null||workallotmentModel?.data==''?Center(child: Text('Data not found',style: TextStyle(fontWeight: FontWeight.bold,fontSize:17),)):Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: ListView.builder(
                       itemCount:workallotmentModel?.data.length ,
                       physics: ScrollPhysics(),
                       shrinkWrap: true,
                       itemBuilder: (context, index) {
                       return Card(
                         elevation: 4,
                         margin: EdgeInsets.symmetric(horizontal:20,vertical:5),
                         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(11)),
                         child: Container(
                           // height:330,
                           child: Column(
                             crossAxisAlignment: CrossAxisAlignment.start,
                             children: [
                               Container(
                                 width: MediaQuery.of(context).size.width,
                                   decoration: BoxDecoration(
                                     borderRadius: BorderRadius.circular(10)
                                   ),
                                   child:workallotmentModel?.data[index].image==""||workallotmentModel?.data[index].image==null?Text("Image Not Found"): Image.network('${workallotmentModel?.data[index].image}',fit:BoxFit.fill,)),
                               SizedBox(height:15,),
                               // Padding(
                               //   padding: const EdgeInsets.only(left: 10.0,right:10),
                               //   child: Row(
                               //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                               //     children: [
                               //       Text('User Id :',style: TextStyle(color:colors.blackTemp,fontWeight: FontWeight.bold),),
                               //       Text('${workallotmentModel?.data[index].userId}',style: TextStyle(color:colors.blackTemp,fontWeight: FontWeight.bold)),
                               //     ],
                               //   ),
                               // ),

                               Padding(
                                 padding: const EdgeInsets.only(left:10.0,right: 10),
                                 child: Row(
                                   children: [
                                     Column(
                                       crossAxisAlignment: CrossAxisAlignment.start,
                                       children: [
                                         Text('Title :',style: TextStyle(color:colors.blackTemp,fontWeight: FontWeight.bold)),
                                         SizedBox(height:10,),
                                         Text('Address :',style: TextStyle(color:colors.blackTemp,fontWeight: FontWeight.bold)),
                                         SizedBox(height:10,),
                                         Text('Created at :',style: TextStyle(color:colors.blackTemp,fontWeight: FontWeight.bold)),
                                         SizedBox(height:10,),
                                         Container(
                                             height:60,
                                             child: Text('Description :',style: TextStyle(color:colors.blackTemp,fontWeight: FontWeight.bold))),
                                         SizedBox(height:10,),
                                     ],),
                                     SizedBox(width:90,),
                                     Column(
                                       crossAxisAlignment: CrossAxisAlignment.start,
                                       children: [
                                         Container(
                                             width: 150,
                                             child: Text('${workallotmentModel?.data[index].title}',overflow: TextOverflow.ellipsis,maxLines:1,)),
                                         SizedBox(height:10,),
                                         Container(
                                             width:120,
                                             height: 20,
                                             child: Text('${workallotmentModel?.data[index].address}',overflow: TextOverflow.ellipsis,maxLines: 2,)),
                                         SizedBox(height:10,),
                                         Container(
                                             width:120,
                                             height: 20,
                                             child: Text('${workallotmentModel?.data[index].createdAt}',overflow: TextOverflow.ellipsis,maxLines: 2,)),
                                         SizedBox(height:10,),
                                         Container(
                                             width:125,
                                             height:60,
                                             child: Text('${workallotmentModel?.data[index].description}',overflow: TextOverflow.ellipsis,maxLines:3,)),
                                         SizedBox(height:10,),
                                       ],
                                     )
                                   ],
                                 ),
                               ),
                               SizedBox(height: 10,),
                             ],
                           ),
                         ),
                       );
                     },),
              ),
      //       ),
      //     ],
      //   ),
      // )

    );
  }
}
