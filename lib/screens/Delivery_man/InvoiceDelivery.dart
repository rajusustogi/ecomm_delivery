import 'dart:convert';

import 'package:ecomm_delivery/Models/InvoiceDeliveryModel.dart';
import 'package:ecomm_delivery/helper/Apis.dart';
import 'package:ecomm_delivery/helper/colors.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class InvoiceDelivery extends StatefulWidget {
  InvoiceDelivery({Key key}) : super(key: key);

  @override
  _InvoiceDeliveryState createState() => _InvoiceDeliveryState();
}

Future<InvoiceDeliveryModel> invoice() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  String token = pref.getString('token');
  var response = await http.get(INVOICE, headers: {"authorization": token});
  // List<InvoiceData> productData = [];
  print("hello" + response.body);
  if (response.statusCode == 200) {
    InvoiceDeliveryModel productModel =
        InvoiceDeliveryModel.fromJson(json.decode(response.body));
        print(productModel.data[0].compactHistory[0]);
    return productModel;
  }
}

class _InvoiceDeliveryState extends State<InvoiceDelivery> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.8,
      child: FutureBuilder(
        future: invoice(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Center(
                child: CircularProgressIndicator(),
              );
              break;
            case ConnectionState.done:
              return ListView.builder(
                itemCount: snapshot.data.data.length,
                itemBuilder: (BuildContext context, int index) {
                  return SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Column(
                      children: <Widget>[
                        Row(
                          // mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                                width: size.width,
                                color: amber,
                                alignment: Alignment.center,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "Date: ${snapshot.data.data[index].date.toString()}",
                                    style: TextStyle(
                                        color: white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ))
                          ],
                        ),
                        Container(
                          width: size.width,
                          child: DataTable(
                              // columnSpacing: size.width * 0.15,
                              columnSpacing: 10,

                              columns: <DataColumn>[
                                DataColumn(label: Text('Order Id')),
                                DataColumn(label: Text('Customer')),
                                DataColumn(label: Text('Address'),),
                                DataColumn(label: Text('Amount')),
                              ],
                              rows: snapshot.data.data[index].compactHistory
                                  .map<DataRow>(
                                      (p) => DataRow(selected: true, cells: [
                                            DataCell(Text(p.orderId.toString()),
                                                onTap: () {}),
                                            DataCell(
                                              Text(
                                                p.retailerName.toString(),
                                              ),
                                            ),
                                            DataCell(Text(p.address.toString()),),
                                            DataCell(Text(p.amount.toString())),
                                          ])).toList()),
                        ),
                        Container(
                          width: size.width,
                          height: 30,
                          color: green,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 25),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                                Text(
                                  'Total Product: ${snapshot.data.data[index].totalOrders}',
                                  style: TextStyle(color: white),
                                ),
                                Text(
                                  'Total amount : ₹${snapshot.data.data[index].totalAmount} ',
                                  style: TextStyle(color: white),
                                ),
                              ],
                            ),
                          ),
                        ),
                        // Container(
                        //   width: size.width,
                        //   height: 30,
                        //   color: amber,
                        //   child: Row(
                        //     mainAxisAlignment: MainAxisAlignment.center,
                        //     children: <Widget>[
                        //       snapshot.data.data[index].pickupDate == null
                        //           ? Text(
                        //               'OTP : ${snapshot.data.data[index].deliveryCode}',
                        //               style: TextStyle(color: white),
                        //             )
                        //           : Text(
                        //               'Picked by  ${snapshot.data.data[index].employeeName} on ${snapshot.data.data[index].pickupDate}',
                        //               style: TextStyle(color: white))
                        //     ],
                        //   ),
                        // )
                      ],
                    ),
                  );
                },
              );
              break;
            // return  SingleChildScrollView(
            //         scrollDirection: Axis.horizontal,
            //         child: DataTable(
            //             columnSpacing: size.width*0.05,
            //             columns: <DataColumn>[
            //               DataColumn(label: Text('Order Id')),
            //               DataColumn(label: Text('Customer Name')),
            //               DataColumn(label: Text('Address')),
            //               DataColumn(label: Text('Amount'),),
            //             ],
            //             rows: snapshot.data.data
            //                 .map<DataRow>((p) => DataRow(
            //                   selected: true, cells: [
            //                       DataCell(Text(p.orderId.toString()),
            //                           onTap: () {}),
            //                       DataCell(
            //                         Text(
            //                           p.user.name,
            //                         ),
            //                       ),
            //                       DataCell(Text(
            //                         p.deliveryAddress.toString()

            //                       ),),
            //                       DataCell(Text(p.amount.toString())),
            //                       // DataCell(Text(DateFormat("dd-MM-yyyy")
            //                       //     .format(DateTime.parse(p.deliveryDate))
            //                       //     .toString()))
            //                     ]))
            //                 .toList()
            //                 ),
            //       );
            // break;
            default:
              return Center(
                child: Image.asset('images/emptycart.png'),
              );
              break;
          }
        },
      ),
    );
  }
}
