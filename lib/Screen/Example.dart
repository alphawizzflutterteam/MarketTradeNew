import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Example extends StatefulWidget {
  const Example({Key? key}) : super(key: key);

  @override
  State<Example> createState() => _ExampleState();
}

class _ExampleState extends State<Example> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10, top: 70),
        child: Column(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  Table(
                    border: TableBorder.all(
                        color: Colors.black,
                        style: BorderStyle.solid,
                        width: 1),
                    defaultColumnWidth: FixedColumnWidth(MediaQuery.of(context).size.width/4.4),
                    children: [
                   TableRow(
                    children: [
                      Container(
                        // width: MediaQuery.of(context).size.width/2,
                      child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                      SizedBox(
                        width: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(2),
                        child: Text(
                          'Product',
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.black),
                          ),
                         ),
                        ],
                       ),
                      ),
                      Container(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 10,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(2),
                              child:
                              Text(
                                'Consumption',
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11, color: Colors.black),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 10,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(2),
                              child: Text(
                                'Furth',
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Colors.black),
                              ),
                            ),
                          ],
                        ),
                      ),
                        Container(
                          child: Row(
                            crossAxisAlignment:
                            CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 10,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(2),
                                child: Text(
                                  'Price',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12, color: Colors.black),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                     ),
                    ],
                   ),
                  Table(
                    border: TableBorder.all(
                        color: Colors.black,
                        style: BorderStyle.solid,
                        width: 1),
                    defaultColumnWidth: FixedColumnWidth(MediaQuery.of(context).size.width/4.4),
                    children: [
                      TableRow(
                        children: [
                          Container(
                            child: Row(
                              crossAxisAlignment:
                              CrossAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(2),
                                  child: Text(
                                    'Name',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                        color: Colors.black),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            child: Row(
                              crossAxisAlignment:
                              CrossAxisAlignment.center,
                              children: [
                                Container(
                                  height: 30,
                                  width: 80,
                                  color: Colors.red,
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                        hintText: "Enter"
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            child: Row(
                              crossAxisAlignment:
                              CrossAxisAlignment.center,
                              children: [
                                Container(
                                  height: 30,
                                  width: 80,
                                  color: Colors.red,
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                        hintText: "Enter"
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            child: Row(
                              crossAxisAlignment:
                              CrossAxisAlignment.center,
                              children: [
                                Container(
                                  height: 30,
                                  width: 80,
                                  color: Colors.red,
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                        hintText: "Enter"
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Table(
                    border: TableBorder.all(
                        color: Colors.black,
                        style: BorderStyle.solid,
                        width: 1),
                    defaultColumnWidth: FixedColumnWidth(MediaQuery.of(context).size.width/4.4),
                    children: [
                      TableRow(
                        children: [
                          Container(
                            child: Row(
                              crossAxisAlignment:
                              CrossAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(2),
                                  child: Text(
                                    'Name',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                        color: Colors.black),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            child: Row(
                              crossAxisAlignment:
                              CrossAxisAlignment.center,
                              children: [
                                Container(
                                  height: 30,
                                  width: 80,
                                  color: Colors.red,
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                        hintText: "Enter"
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            child: Row(
                              crossAxisAlignment:
                              CrossAxisAlignment.center,
                              children: [
                                Container(
                                  height: 30,
                                  width: 80,
                                  color: Colors.red,
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                        hintText: "Enter"
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            child: Row(
                              crossAxisAlignment:
                              CrossAxisAlignment.center,
                              children: [
                                // SizedBox(
                                //   width: 5,
                                // ),
                                Container(
                                  height: 30,
                                  width: 80,
                                  color: Colors.red,
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                        hintText: "Enter"
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Table(
                    border: TableBorder.all(
                        color: Colors.black,
                        style: BorderStyle.solid,
                        width: 1),
                    defaultColumnWidth: FixedColumnWidth(MediaQuery.of(context).size.width/4.4),
                    children: [
                      TableRow(
                        children: [
                          Container(
                            child: Row(
                              crossAxisAlignment:
                              CrossAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(2),
                                  child: Text(
                                    'Name',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                        color: Colors.black),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            child: Row(
                              crossAxisAlignment:
                              CrossAxisAlignment.center,
                              children: [
                                Container(
                                  height: 30,
                                  width: 80,
                                  color: Colors.red,
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                        hintText: "Enter"
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            child: Row(
                              crossAxisAlignment:
                              CrossAxisAlignment.center,
                              children: [
                                Container(
                                  height: 30,
                                  width: 80,
                                  color: Colors.red,
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                        hintText: "Enter"
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            child: Row(
                              crossAxisAlignment:
                              CrossAxisAlignment.center,
                              children: [
                                Container(
                                  height: 30,
                                  width: 80,
                                  color: Colors.red,
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                        hintText: "Enter"
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
           ),
         ],
        ),
       ),
    );
  }
}
