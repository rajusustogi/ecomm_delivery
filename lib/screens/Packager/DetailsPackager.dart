import 'dart:async';
import 'dart:convert';
import 'package:ecomm_delivery/Models/PackagerProductModel.dart';
import 'package:ecomm_delivery/helper/Apis.dart';
import 'package:ecomm_delivery/helper/Navigation.dart';
import 'package:ecomm_delivery/helper/colors.dart';
import 'package:ecomm_delivery/screens/Packager/DescriptionPackager.dart';
import 'package:flutter/material.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

Future<List<PackagerProductData>> getProducts(status) async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  String token = pref.getString('token');
  var response = await http.get(PENDINGPICKUPS,
      headers: {"authorization": token});
  List<PackagerProductData> productData = [];
  print(response.body);
  print('hello pending');
  if (response.statusCode == 200) {
    PackagerProductModel productModel =
        PackagerProductModel.fromJson(json.decode(response.body));
    productData = productModel.data;
    print("statiss:::"+productData[0].pickupStatus);
    switch (status) {
      case 'pending':
        return productData
            .where((element) => element.pickupStatus == 'pending')
            .toList();

        break;
      case 'success':
        return productData
            .where((element) => element.pickupStatus == 'success')
            .toList();
        break;
      case 'cancelled':
        return productData
            .where((element) => element.pickupStatus == 'cancelled')
            .toList();
        break;
      default:
    }
  } else {
    return productData;
  }
}

class PickupOrderPackager extends StatefulWidget {
  final status;

  const PickupOrderPackager({Key key, this.status}) : super(key: key);
  @override
  _PickupOrderPackagerState createState() => _PickupOrderPackagerState();
}

class _PickupOrderPackagerState extends State<PickupOrderPackager> {
  String code;

  bool confirm = false;

  void _launchMapsUrl(String latitude, String longitude) async {
    print(latitude);
    final url = 'https://www.google.com/maps?q=$latitude,$longitude';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  getQuantity(PackagerProductData data) {
    int total = 0;
    for (var i in data.products) {
      print(i.noOfUnits);
      total = total + i.noOfUnits;
    }
    print(total);
    return total;
  }

  getColor() {
    switch (widget.status) {
      case 'pending':
        return amber;

        break;
      case 'success':
        return green;
        break;
      // case 'cancelled':
      //   return Colors.red;
      //   break;
      default:
    }
  }

  final RoundedLoadingButtonController _btnController =
      new RoundedLoadingButtonController();
  // Widget slideLeftBackground() {
  //   return Container(
  //     color: Colors.red,
  //     child: Align(
  //       child: Row(
  //         mainAxisAlignment: MainAxisAlignment.end,
  //         children: <Widget>[
  //           Icon(
  //             Icons.delete,
  //             color: Colors.white,
  //           ),
  //           Text(
  //             " Delete",
  //             style: TextStyle(
  //               color: Colors.white,
  //               fontWeight: FontWeight.w700,
  //             ),
  //             textAlign: TextAlign.right,
  //           ),
  //           SizedBox(
  //             width: 20,
  //           ),
  //         ],
  //       ),
  //       alignment: Alignment.centerRight,
  //     ),
  //   );
  // }

  Widget slideRightBackground() {
    return Container(
      color: getColor(),
      child: Align(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              width: 20,
            ),
            widget.status == 'pending'
                ? Icon(
                    Icons.edit,
                    color: Colors.white,
                  )
                : Container(),
            Text(
              widget.status == 'pending' ? " Submit OTP" : '',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.left,
            ),
          ],
        ),
        alignment: Alignment.centerLeft,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getProducts(widget.status),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data.length == 0 ? 1 : snapshot.data.length,
            itemBuilder: (BuildContext context, int index) {
              if (snapshot.data.length == 0) {
                return Container(
                  height: MediaQuery.of(context).size.height,
                  child: Center(
                    child: Text('No Order Available'),
                  ),
                );
              }
              return Dismissible(
                key: Key(snapshot.data[index].id.toString()),
                background: slideRightBackground(),
                secondaryBackground: slideRightBackground(),
                confirmDismiss: (direction) async {
                  if (direction == DismissDirection.startToEnd) {
                    widget.status == 'pending'
                        ? await showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                elevation: 20,
                                title: Text('Confirm Delivery'),
                                content: Container(
                                  height: 145,
                                  child: Column(
                                    children: <Widget>[
                                      TextFormField(
                                        maxLength: 6,
                                        keyboardType: TextInputType.phone,
                                        onChanged: (val) {
                                          setState(() {
                                            code = val;
                                          });
                                        },
                                        decoration: InputDecoration(
                                            labelText: 'Enter Otp ',
                                            border: OutlineInputBorder()),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      RoundedLoadingButton(
                                        controller: _btnController,
                                        onPressed: () async {
                                          SharedPreferences pref =
                                              await SharedPreferences
                                                  .getInstance();
                                          var token = pref.getString('token');
                                          var res = await http
                                              .put(CONFIRMDELIVERY+ snapshot.data[index].id.toString(), headers: {
                                            "Authorization": token
                                          }, body: {
                                           
                                            "code": code.toString()
                                          });
                                          print(token);
                                          print(res.body);
                                          if (res.statusCode == 200) {
                                            _btnController.success();
                                            setState(() {
                                              confirm = true;
                                            });
                                            Navigator.pop(context);
                                          } else {
                                            _btnController.error();

                                            Timer(Duration(seconds: 5),
                                                () => _btnController.reset());
                                            setState(() {
                                              confirm = false;
                                            });
                                          }
                                        },
                                        height: 40,
                                        width: 150,
                                        color: green,
                                        child: Text(
                                          "SUBMIT",
                                          style: TextStyle(color: white),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            },
                          )
                        : Container();
                    return confirm;
                  } else {
                    return false;
                  }
                },
                child: GestureDetector(
                  onTap: () => changeScreen(
                      context,
                      DescriptionPackager(
                        order: snapshot.data[index],
                        color: getColor(),
                      )),
                  child: Card(
                    clipBehavior: Clip.hardEdge,
                    elevation: 10,
                    margin: EdgeInsets.all(8),
                    shadowColor: getColor(),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 200,
                        child: SingleChildScrollView(
                          child: Column(
                            children: <Widget>[
                              ListTile(
                                leading: Icon(
                                  Icons.assignment,
                                  color: blue,
                                ),
                                title: Text("ORDER ID : ",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                                trailing: Text(
                                    snapshot.data[index].pickupId.toString()),
                              ),
                              ListTile(
                                leading: InkWell(
                                  onTap: () => launch(
                                      "tel:+91${snapshot.data[index].wholesaler.mobileNo}"),
                                  child: Icon(
                                    Icons.account_box,
                                    color: blue,
                                  ),
                                ),
                                title: Text(
                                    snapshot.data[index].wholesaler.name
                                        .toUpperCase(),
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                                trailing: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    Text(
                                        "₹" +
                                            snapshot.data[index].amount
                                                .toString(),
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 2, horizontal: 10),
                                      decoration: BoxDecoration(
                                        color: getColor(),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Text(
                                        snapshot.data[index].pickupStatus
                                            .toString(),
                                        style: TextStyle(color: white),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              ListTile(
                                leading: InkWell(
                                  onTap: () => _launchMapsUrl(
                                      snapshot.data[index].user.latitude,
                                      snapshot.data[index].user.longitude),
                                  child: Icon(
                                    Icons.location_on,
                                    color: blue,
                                  ),
                                ),
                                title: Text("ADDRESS",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                                subtitle:
                                    Text(snapshot.data[index].pickupAddress),
                                trailing: Stack(
                                  children: <Widget>[
                                    Icon(
                                      Icons.shopping_cart,
                                      color: blue,
                                      size: 30,
                                    ),
                                    Positioned(
                                      top: 0,
                                      right: 0,
                                      child: Container(
                                        height: 17,
                                        width: 17,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            color: getColor()),
                                        alignment: Alignment.center,
                                        padding: EdgeInsets.all(2),
                                        
                                        child: Text(
                                          getQuantity(snapshot.data[index])
                                              .toString(),
                                          style: TextStyle(
                                              color: white,
                                              fontSize: 10,
                                              fontWeight: FontWeight.normal),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),

                              // Padding(
                              //   padding:
                              //       const EdgeInsets.symmetric(horizontal: 15.0),
                              //   child: Row(
                              //     children: <Widget>[
                              //       Text("CUSTOMER NAME:  ",
                              //           style:
                              //               TextStyle(fontWeight: FontWeight.bold)),
                              //       Text(snapshot.data[index].user.name.toString())
                              //     ],
                              //   ),
                              // ),
                              // Padding(
                              //   padding:
                              //       const EdgeInsets.symmetric(horizontal: 15.0),
                              //   child: Row(
                              //     children: <Widget>[
                              //       Text("PAYMENT STATUS:  ",
                              //           style:
                              //               TextStyle(fontWeight: FontWeight.bold)),
                              // Text(snapshot.data[index].paymentStatus
                              //     .toString())
                              //     ],
                              //   ),
                              // ),
                              // Padding(
                              //   padding:
                              //       const EdgeInsets.symmetric(horizontal: 15.0),
                              //   child: Row(
                              //     children: <Widget>[
                              //       Text("ORDER STATUS:  ",
                              //           style:
                              //               TextStyle(fontWeight: FontWeight.bold)),
                              //       Text(
                              //           snapshot.data[index].orderStatus.toString())
                              //     ],
                              //   ),
                              // ),
                              // Padding(
                              //   padding:
                              //       const EdgeInsets.symmetric(horizontal: 15.0),
                              //   child: Row(
                              //     children: <Widget>[
                              //       Text("DATE:  ",
                              //           style:
                              //               TextStyle(fontWeight: FontWeight.bold)),
                              //       Text(DateFormat.yMEd().format(DateTime.parse(
                              //           snapshot.data[index].expectedDate)))
                              //     ],
                              //   ),
                              // ),
                              // Padding(
                              //   padding:
                              //       const EdgeInsets.symmetric(horizontal: 15.0),
                              //   child: Row(
                              //     children: <Widget>[
                              //       Text("ALTERNATE NUMBER:  ",
                              //           style:
                              //               TextStyle(fontWeight: FontWeight.bold)),
                              //       InkWell(
                              //         onTap: () => launch(
                              //             "tel:+91${snapshot.data[index].user.alternateNo}"),
                              //         child: Text(
                              //             snapshot.data[index].user.alternateNo
                              //                 .toString(),
                              //             style: TextStyle(
                              //                 color: blue,
                              //                 fontWeight: FontWeight.bold)),
                              //       )
                              //     ],
                              //   ),
                              // ),
                              // Padding(
                              //     padding:
                              //         const EdgeInsets.symmetric(horizontal: 15.0),
                              //     child: Row(
                              //       mainAxisAlignment:
                              //           MainAxisAlignment.spaceBetween,
                              //       children: <Widget>[
                              //         FlatButton(
                              //           textColor: white,
                              //           child: Text('Contact'),
                              // onPressed: () => launch(
                              //     "tel:+91${snapshot.data[index].user.mobileNo}"),
                              //           color: green,
                              //         ),
                              //         FlatButton(
                              //           color: green,
                              //           textColor: white,
                              //           child: Text('Deliver Order'),
                              //           onPressed: () {
                              //             showDialog(
                              //               context: context,
                              //               builder: (BuildContext context) {
                              //                 return AlertDialog(
                              //                   elevation: 20,
                              //                   title: Text('Confirm Delivery'),
                              //                   content: Container(
                              //                     height: 145,
                              //                     child: Column(
                              //                       children: <Widget>[
                              //                         TextFormField(
                              //                           maxLength: 6,
                              //                           keyboardType:
                              //                               TextInputType.text,
                              //                           onChanged: (val) {
                              //                             setState(() {
                              //                               code = val;
                              //                             });
                              //                           },
                              //                           decoration: InputDecoration(
                              //                               labelText: 'Enter Otp ',
                              //                               border:
                              //                                   OutlineInputBorder()),
                              //                         ),
                              //                         SizedBox(
                              //                           height: 20,
                              //                         ),
                              //                         RoundedLoadingButton(
                              //                           controller: _btnController,
                              //                           onPressed: () async {
                              //                             SharedPreferences pref =
                              //                                 await SharedPreferences
                              //                                     .getInstance();
                              //                             var token = pref
                              //                                 .getString('token');

                              //                             var res = await http.put(
                              //                                 "https://farmtaste.herokuapp.com/deliver-order",
                              //                                 headers: {
                              //                                   "Authorization":
                              //                                       token
                              //                                 },
                              //                                 body: {
                              //                                   "order_id": snapshot
                              //                                       .data[index].id
                              //                                       .toString(),
                              //                                   "code":
                              //                                       code.toString()
                              //                                 });
                              //                             print(token);
                              //                             print(res.body);
                              //                             if (res.statusCode ==
                              //                                 200) {
                              //                               _btnController
                              //                                   .success();
                              //                               Navigator.pop(context);
                              //                             } else {
                              //                               _btnController.error();
                              //                               Timer(
                              //                                   Duration(
                              //                                       seconds: 5),
                              //                                   () => _btnController
                              //                                       .reset());
                              //                             }
                              //                           },
                              //                           height: 40,
                              //                           width: 150,
                              //                           color: green,
                              //                           child: Text(
                              //                             "SUBMIT",
                              //                             style: TextStyle(
                              //                                 color: white),
                              //                           ),
                              //                         )
                              //                       ],
                              //                     ),
                              //                   ),
                              //                 );
                              //               },
                              //             );
                              //           },
                              //         ),
                              //       ],
                              //     )),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        } else {
          return Container(
            child: Center(
              child: Text('LOADING...'),
            ),
          );
        }
      },
    );
  }
}
