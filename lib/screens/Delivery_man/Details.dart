import 'dart:async';
import 'dart:convert';
import 'package:ecomm_delivery/Models/PendingPackages.dart';
import 'package:ecomm_delivery/Models/delivered.dart';
import 'package:ecomm_delivery/helper/Apis.dart';
import 'package:ecomm_delivery/helper/Navigation.dart';
import 'package:ecomm_delivery/helper/colors.dart';
import 'package:ecomm_delivery/screens/Delivery_man/Description.dart';
import 'package:flutter/material.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

Future<List<dynamic>> getProducts(status) async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  String token = pref.getString('token');
  var response = await http.get(status == 'on the way' ? ORDERS : HISTORY,
      headers: {"authorization": token});
  List<PendingPackagesData> productData = [];
  print(response.body);
  if (response.statusCode == 200 && status == 'on the way') {
    PendingPackages productModel =
        PendingPackages.fromJson(json.decode(response.body));
    switch (status) {
      case 'on the way':
        return productModel.data
            .where((element) =>
                element.orderStatus == 'packed' ||
                element.orderStatus == 'pending')
            .toList()..sort((a,b)=>b.id.compareTo(a.id));
        break;
      // case 'delivered':
      //   return productData;
      //   break;
      // case 'cancelled':
      //   return productData
      //       .where((element) => element.orderStatus == 'cancelled')
      //       .toList();
      //   break;
      default:
        return productData;
    }
  }
  if (response.statusCode == 200 && status == 'delivered') {
    Delivered product = Delivered.fromJson(json.decode(response.body));
    print(product.data[0].orderStatus);

    return product.data
        .where((element) => element.orderStatus == 'delivered')
        .toList()..sort((a,b)=>b.id.compareTo(a.id));
  } else {
    return productData;
  }
}

class PendingOrderDetails extends StatefulWidget {
  final status;

  const PendingOrderDetails({Key key, this.status}) : super(key: key);
  @override
  _PendingOrderDetailsState createState() => _PendingOrderDetailsState();
}

class _PendingOrderDetailsState extends State<PendingOrderDetails> {
  String code;

  bool confirm = false;

  void _launchMapsUrl(String address) async {
    final url = 'https://www.google.com/maps?q=$address';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  getQuantity(dynamic data) {
    int total = 0;
    for (int i = 0; i < data.completeProducts.length; i++) {
      total++;
    }
    return total;
  }

  getColor() {
    switch (widget.status) {
      case 'on the way':
        return amber;

        break;
      case 'delivered':
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
            widget.status == 'on the way'
                ? Icon(
                    Icons.edit,
                    color: Colors.white,
                  )
                : Container(),
            Text(
              widget.status == 'on the way' ? " Submit OTP" : '',
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
        print(snapshot.data);
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
                key: Key(snapshot.data[index].orderId.toString()),
                background: slideRightBackground(),
                secondaryBackground: slideRightBackground(),
                confirmDismiss: (direction) async {
                  if (direction == DismissDirection.startToEnd) {
                    widget.status == 'on the way'
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
                                              .put(DELIVERYMAN, headers: {
                                            "Authorization": token
                                          }, body: {
                                            "order_id": snapshot.data[index].id
                                                .toString(),
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
                      Description(
                        order: snapshot.data[index],
                        color: getColor(),
                        status: widget.status
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
                                subtitle: widget.status=='on the way'?Text(''):Text(
                                    'Delivery Time: ${DateFormat.jm().format(DateTime.parse(snapshot.data[index].createdAt).toLocal())}',style: TextStyle(color: blue),),
                                trailing: Text(
                                    snapshot.data[index].orderId.toString()),
                              ),
                              ListTile(
                                leading: InkWell(
                                  onTap: () => launch(
                                      "tel:+91${snapshot.data[index].user.mobileNo}"),
                                  child: Icon(
                                    Icons.account_box,
                                    color: blue,
                                  ),
                                ),
                                title: Text(
                                    snapshot.data[index].user.name
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
                                        snapshot.data[index].orderStatus
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
                                      snapshot.data[index].deliveryAddress),
                                  child: Icon(
                                    Icons.location_on,
                                    color: blue,
                                  ),
                                ),
                                title: Text("ADDRESS",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                                subtitle:
                                    Text(snapshot.data[index].deliveryAddress),
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
                                        widget.status=='on the way'? snapshot.data[index].completeProducts.length
                                              .toString(): snapshot.data[index].products.length.toString(),
                                          style: TextStyle(
                                              color: white,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
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
