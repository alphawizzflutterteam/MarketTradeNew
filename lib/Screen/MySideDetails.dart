import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Helper/Color.dart';
import '../Model/MySiteVisitModel.dart';

class MySiteDetails extends StatefulWidget {
  final SiteVisitData? model;
  const MySiteDetails({Key? key, this.model}) : super(key: key);

  @override
  State<MySiteDetails> createState() => _MySiteDetailsState();
}

class _MySiteDetailsState extends State<MySiteDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        backgroundColor: colors.primary,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back_ios),
        ),
        centerTitle: true,
        title: Text("Site Visit Details", style: TextStyle(fontSize: 17, color: Colors.white, fontWeight: FontWeight.w800)),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 15,right: 15,top: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Text("User Name",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
                  // SizedBox(height: MediaQuery.of(context).size.height*.03,),
                  // TextFormField(
                  //     keyboardType: TextInputType.text,
                  //     controller: namecn,
                  //     decoration: InputDecoration(
                  //         hintText: 'hfg',
                  //         border: OutlineInputBorder(
                  //             borderRadius:  BorderRadius.circular(15)))),
                  // SizedBox(height: MediaQuery.of(context).size.height*.03,),
                  // Text("Date",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
                  // SizedBox(height: MediaQuery.of(context).size.height*.03,),
                  // TextFormField(
                  //     keyboardType: TextInputType.text,
                  //     controller: datecn,
                  //     decoration: InputDecoration(
                  //         border: OutlineInputBorder(
                  //             borderRadius:  BorderRadius.circular(15)))),
                  // SizedBox(height: MediaQuery.of(context).size.height*.03,),
                  //
                  // Text("Time",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
                  // SizedBox(height: MediaQuery.of(context).size.height*.03,),
                  // TextFormField(
                  //     keyboardType: TextInputType.text,
                  //     controller: timecn,
                  //     decoration: InputDecoration(
                  //         border: OutlineInputBorder(
                  //             borderRadius:  BorderRadius.circular(15)))),
                  // SizedBox(height: MediaQuery.of(context).size.height*.03,),
                  // Text("Firm Name",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
                  // SizedBox(height: MediaQuery.of(context).size.height*.03,),
                  // TextFormField(
                  //     keyboardType: TextInputType.text,
                  //     controller: firmnamecn,
                  //     decoration: InputDecoration(
                  //         border: OutlineInputBorder(
                  //             borderRadius:  BorderRadius.circular(15)))),
                  // SizedBox(height: MediaQuery.of(context).size.height*.03,),
                  // Text("Remark",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
                  // SizedBox(height: MediaQuery.of(context).size.height*.03,),
                  // TextFormField(
                  //     keyboardType: TextInputType.text,
                  //     controller: remarkcn,
                  //     decoration: InputDecoration(
                  //         border: OutlineInputBorder(
                  //             borderRadius:  BorderRadius.circular(15)))),
                  // SizedBox(height: MediaQuery.of(context).size.height*.03,),
                  // Text("Survey:",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
                  // SizedBox(height: MediaQuery.of(context).size.height*.03,),
                  // Text("Name:${widget.model.?.data[0].basicDetail.name}",style: TextStyle(fontSize: 15),),
                  SizedBox(height: MediaQuery.of(context).size.height*.02),
                  Text("Contractor Mobile:   ${widget.model?.contractorMobile}",style: TextStyle(fontSize: 15)),
                  SizedBox(height: MediaQuery.of(context).size.height*.02),
                  Text("Engineer Mobile:   ${widget.model?.engineerMobile}",style: TextStyle(fontSize: 15)),
                  SizedBox(height: MediaQuery.of(context).size.height*.02),
                  Text("Arti-tech Mobile:   ${widget.model?.artitechMobile}",style: TextStyle(fontSize: 15)),
                  SizedBox(height: MediaQuery.of(context).size.height*.02),
                  Text("Mission Mobile:   ${widget.model?.massionMobile}",style: TextStyle(fontSize: 15)),
                  SizedBox(height: MediaQuery.of(context).size.height*.02),
                  Text("Expected Orders:   ${widget.model?.expectedOrders}",style: TextStyle(fontSize: 15)),
                  SizedBox(height: MediaQuery.of(context).size.height*.02),
                  Text("Pin code:   ${widget.model?.pincode}",style: TextStyle(fontSize: 15)),
                  SizedBox(height: MediaQuery.of(context).size.height*.03),
                  Text("Survey Details:- ",style: TextStyle(fontSize: 17, fontWeight: FontWeight.w900, color: Colors.black)),
                  SizedBox(height: MediaQuery.of(context).size.height*.03),
                  Text("Product Name:   ${widget.model?.survey?[0].brandName}",style: TextStyle(fontSize: 15)),
                  SizedBox(height: MediaQuery.of(context).size.height*.02),
                  Text("Total Consumption:   ${widget.model?.survey?[0].totalConsumption}",style: TextStyle(fontSize: 15)),
                  SizedBox(height: MediaQuery.of(context).size.height*.02),
                  Text("Further Consumption:   ${widget.model?.survey?[0].furtherConsumption}",style: TextStyle(fontSize: 15)),
                  SizedBox(height: MediaQuery.of(context).size.height*.02),
                  Text("Purchase Price:   ${widget.model?.survey?[0].purchasePrice}",style: TextStyle(fontSize: 15)),
                  SizedBox(height: MediaQuery.of(context).size.height*.02),
                  Text("Purchasing From:   ${widget.model?.survey?[0].purchasingFrom}",style: TextStyle(fontSize: 15)),
                  SizedBox(height: MediaQuery.of(context).size.height*.02),
                  Text("Last Purchase Date:   ${widget.model?.survey?[0].lastPurchaseDate}",style: TextStyle(fontSize: 15)),
                  // Text("Credit_Limit:${getdata?.data[0].basicDetail.creditLimit}",style: TextStyle(fontSize: 15),),
                  // SizedBox(height: MediaQuery.of(context).size.height*.03,),
                  // Text("Customer Dealing:",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
                  // Text("ID Name",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
                  // SizedBox(height: MediaQuery.of(context).size.height*.02,),
                  // Text("1  ${getdata?.data[0].customerDealingIn[0].name}",style: TextStyle(fontSize: 15),),
                  // Text("2  ${getdata?.data[0].customerDealingIn[1].name}",style: TextStyle(fontSize: 15),),
                  // SizedBox(height: MediaQuery.of(context).size.height*.03,),
                  // Text("Survey:",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
                  // SizedBox(height: MediaQuery.of(context).size.height*.03,),
                  // Text("Brand Name:",style: TextStyle(fontSize: 14,),),
                  // SizedBox(height: MediaQuery.of(context).size.height*.02,),
                  // Text("Monthly Sale:",style: TextStyle(fontSize: 14,),),
                  // SizedBox(height: MediaQuery.of(context).size.height*.02,),
                  // Text("Current Stock:",style: TextStyle(fontSize: 14,),),
                  // SizedBox(height: MediaQuery.of(context).size.height*.02,),
                  // Text("WPS:",style: TextStyle(fontSize: 14,),),
                  // SizedBox(height: MediaQuery.of(context).size.height*.02,),
                  // Text("RSP:",style: TextStyle(fontSize: 14,),),
                  // SizedBox(height: MediaQuery.of(context).size.height*.02,),
                  // Text("purchasing_from:${getdata?.data[0].survey[0].purchasingFrom}",style: TextStyle(fontSize: 15),),
                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.height*.03),
            ],
          ),
        ),
      ),
    );
  }
}
