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
    // debugPrint("photos ${widget.model?.photos}");
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

                  Center(
                    child: Container(
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
                      clipBehavior: Clip.hardEdge,
                      height: 150,
                      width: 200,
                      child: ClipRRect(
                          child: widget.model?.photos?.first == null || widget.model!.photos!.first.isEmpty ?
                              Image.asset("assets/images/placeholder.png"):
                          Image.network("${widget.model?.photos?.first}",fit: BoxFit.fill,)),
                    ),
                  ),
                  SizedBox(height: 10),
                  Text("Name:   ${widget.model?.name}",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w800)),
                  SizedBox(height: MediaQuery.of(context).size.height*.02),
                  Text("Address:   ${widget.model?.address}",style: TextStyle(fontSize: 15, fontWeight: FontWeight.w800)),
                  SizedBox(height: MediaQuery.of(context).size.height*.02),
                  Text("Date & Time:   ${widget.model?.date} ${widget.model?.time}",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w800)),
                  SizedBox(height: MediaQuery.of(context).size.height*.02),
                  widget.model?.contractorName == null || widget.model?.contractorName == "" ? Text("Contractor Name:  NA", style: TextStyle(fontSize: 15)):
                  Text("Contractor Name:   ${widget.model?.contractorName}",style: TextStyle(fontSize: 15)),
                  SizedBox(height: MediaQuery.of(context).size.height*.02),
                  widget.model?.contractorMobile == null || widget.model?.contractorMobile == "" ? Text("Contractor Mobile:  NA", style: TextStyle(fontSize: 15)):
                  Text("Contractor Mobile:   ${widget.model?.contractorMobile}",style: TextStyle(fontSize: 15)),
                  SizedBox(height: MediaQuery.of(context).size.height*.02),
                  widget.model?.contractorAddress == null || widget.model?.contractorAddress == "" ? Text("Contractor Address:  NA", style: TextStyle(fontSize: 15)):
                  Text("Contractor Address:   ${widget.model?.contractorAddress}",style: TextStyle(fontSize: 15)),
                  SizedBox(height: MediaQuery.of(context).size.height*.02),
                  widget.model?.engineerName == null || widget.model?.engineerName == "" ? Text("Engineer Name:  NA", style: TextStyle(fontSize: 15)):
                  Text("Engineer Name:   ${widget.model?.engineerName}",style: TextStyle(fontSize: 15)),
                  SizedBox(height: MediaQuery.of(context).size.height*.02),
                  widget.model?.engineerMobile == null || widget.model?.engineerMobile == "" ? Text("Engineer Mobile:  NA", style: TextStyle(fontSize: 15)):
                  Text("Engineer Mobile:   ${widget.model?.engineerMobile}",style: TextStyle(fontSize: 15)),
                  SizedBox(height: MediaQuery.of(context).size.height*.02),
                  widget.model?.engineerAddress == null || widget.model?.engineerAddress == "" ? Text("Engineer Address:  NA", style: TextStyle(fontSize: 15)):
                  Text("Engineer Address:   ${widget.model?.engineerAddress}",style: TextStyle(fontSize: 15)),
                  SizedBox(height: MediaQuery.of(context).size.height*.02),
                  widget.model?.architectName == null || widget.model?.architectName == "" ? Text("Arti-tech Name:  NA", style: TextStyle(fontSize: 15)):
                  Text("Arti-tech Name:   ${widget.model?.architectName}",style: TextStyle(fontSize: 15)),
                  SizedBox(height: MediaQuery.of(context).size.height*.02),
                  widget.model?.artitechMobile == null || widget.model?.artitechMobile == "" ? Text("Arti-tech Mobile:  NA", style: TextStyle(fontSize: 15)):
                  Text("Arti-tech Mobile:   ${widget.model?.artitechMobile}",style: TextStyle(fontSize: 15)),
                  SizedBox(height: MediaQuery.of(context).size.height*.02),
                  widget.model?.architectAddress == null || widget.model?.architectAddress == "" ? Text("Arti-tech Address:  NA", style: TextStyle(fontSize: 15)):
                  Text("Arti-tech Address:   ${widget.model?.architectAddress}",style: TextStyle(fontSize: 15)),
                  SizedBox(height: MediaQuery.of(context).size.height*.02),
                  widget.model?.massionName == null || widget.model?.massionName == "" ? Text("Mission Name:  NA", style: TextStyle(fontSize: 15)):
                  Text("Mission Name:   ${widget.model?.massionName}",style: TextStyle(fontSize: 15)),
                  SizedBox(height: MediaQuery.of(context).size.height*.02),
                  widget.model?.massionMobile == null || widget.model?.massionMobile == "" ? Text("Mission Mobile:  NA", style: TextStyle(fontSize: 15)):
                  Text("Mission Mobile:   ${widget.model?.massionMobile}",style: TextStyle(fontSize: 15)),
                  SizedBox(height: MediaQuery.of(context).size.height*.02),
                  widget.model?.massionAddress == null || widget.model?.massionAddress == "" ? Text("Mission Address:  NA", style: TextStyle(fontSize: 15)):
                  Text("Mission Address:   ${widget.model?.massionAddress}",style: TextStyle(fontSize: 15)),
                  SizedBox(height: MediaQuery.of(context).size.height*.02),
                  widget.model?.expectedOrders == null || widget.model?.expectedOrders == "" ? Text("Expected Orders:  NA", style: TextStyle(fontSize: 15)):
                  Text("Expected Orders:   ${widget.model?.expectedOrders}",style: TextStyle(fontSize: 15)),
                  SizedBox(height: MediaQuery.of(context).size.height*.02),
                  widget.model?.pincode == null || widget.model?.pincode == "" ? Text("Pin code:  NA", style: TextStyle(fontSize: 15)):
                  Text("Pin code:   ${widget.model?.pincode}",style: TextStyle(fontSize: 15)),
                  SizedBox(height: MediaQuery.of(context).size.height*.03),
                  Text("Survey Details:- ",style: TextStyle(fontSize: 17, fontWeight: FontWeight.w900, color: Colors.black)),
                  SizedBox(height: MediaQuery.of(context).size.height*.03),
                  SizedBox(
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount:widget.model?.survey?.length ,
                        itemBuilder: (_,i){
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              widget.model?.survey?[i].brandName == null || widget.model?.survey?[i].brandName == "" ? Text("Product Name:  NA", style: TextStyle(fontSize: 15)):
                              Text("Product Name:   ${widget.model?.survey?[0].brandName}",style: TextStyle(fontSize: 15)),
                              SizedBox(height: MediaQuery.of(context).size.height*.02),
                              widget.model?.survey?[i].totalConsumption == null || widget.model?.survey?[i].totalConsumption == "" ? Text("Total Consumption:  NA", style: TextStyle(fontSize: 15)):
                              Text("Total Consumption:   ${widget.model?.survey?[0].totalConsumption}",style: TextStyle(fontSize: 15)),
                              SizedBox(height: MediaQuery.of(context).size.height*.02),
                              widget.model?.survey?[i].furtherConsumption == null || widget.model?.survey?[i].furtherConsumption == "" ? Text("Further Consumption:  NA", style: TextStyle(fontSize: 15)):
                              Text("Further Consumption:   ${widget.model?.survey?[0].furtherConsumption}",style: TextStyle(fontSize: 15)),
                              SizedBox(height: MediaQuery.of(context).size.height*.02),
                              widget.model?.survey?[i].purchasePrice == null || widget.model?.survey?[i].purchasePrice == "" ? Text("Purchase Price:  NA", style: TextStyle(fontSize: 15)):
                              Text("Purchase Price:   ${widget.model?.survey?[0].purchasePrice}",style: TextStyle(fontSize: 15)),
                              SizedBox(height: MediaQuery.of(context).size.height*.02),
                              widget.model?.survey?[i].purchasingFrom == null || widget.model?.survey?[i].purchasingFrom == "" ? Text("Purchasing From:  NA", style: TextStyle(fontSize: 15)):
                              Text("Purchasing From:   ${widget.model?.survey?[0].purchasingFrom}",style: TextStyle(fontSize: 15)),
                              SizedBox(height: MediaQuery.of(context).size.height*.02),
                              widget.model?.survey?[i].lastPurchaseDate == null || widget.model?.survey?[i].lastPurchaseDate == "" ? Text("Last Purchase Date:  NA", style: TextStyle(fontSize: 15)):
                              Text("Last Purchase Date:   ${widget.model?.survey?[0].lastPurchaseDate}",style: TextStyle(fontSize: 15)),
                            ],
                          );
                        }),
                  )
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
