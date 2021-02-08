import 'dart:convert';
import 'package:ecomm_delivery/Models/CompletePackager.dart';
import 'package:ecomm_delivery/Models/PendingPackages.dart';
import 'package:ecomm_delivery/helper/Apis.dart';
import 'package:ecomm_delivery/helper/Navigation.dart';
import 'package:ecomm_delivery/helper/colors.dart';
import 'package:ecomm_delivery/screens/Packager/OrderDetails.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class CompletePackageOrder extends StatefulWidget {
  CompletePackageOrder({Key key}) : super(key: key);

  @override
  _CompletePackageOrderState createState() => _CompletePackageOrderState();
}

class _CompletePackageOrderState extends State<CompletePackageOrder> {
  List<PendingPackagesData> list;
  @override
  void initState() {
    super.initState();
    getOrders();
  }

  getColors(CompletePackagerData order) {
    switch (order.orderStatus) {
      case 'cancelled':
        return red;

        break;
      case 'pending':
        return amber;

        break;
      case 'delivered':
        return green;

        break;
      default:
        return red;
    }
  }

  getOrders() async {
    print('packager complete');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');
    var response = await http.get(PENDINGPACKAGES, headers: {
      "Authorization": token,
    });
    print('Response status: ${response.statusCode}');
    if (response.statusCode == 200) {
      PendingPackages orders = PendingPackages.fromJson(json.decode(response.body));
      setState(() {
        list = orders.data.reversed.where((element) => element.orderStatus == 'packed').toList();
      });
    } else {
      print('failed');
      return false;
    }
  }
getAmount(List<Products> pro) {
    dynamic total = 0;
    for (var i in pro) {
      total = total + i.noOfUnits * i.rate;
    }
    return total;
  }
  bool fav = false;
  @override
  Widget build(BuildContext context) {
    return  Container(
            height: MediaQuery.of(context).size.height * 0.8,
            child: list == null
                ? Center(
                    child: Container(
                      height: MediaQuery.of(context).size.height,
                      alignment: Alignment.center,
                      child: CircularProgressIndicator(),
                    ),
                  )
                : list.length == 0
                    ? Center(
                        child: Container(
                          height: MediaQuery.of(context).size.height / 2,
                          child: Image.asset(
                            'images/emptycart.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                      )
                    : ListView.builder(
                        itemCount: list.length,
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: GestureDetector(
                          onTap: () => changeScreen(
                              context,
                              OrderDetails(
                                order: list[index],
                                color: green,
                                type: 'complete',
                                fun: () {
                                  print('hello');
                                  setState(() {});
                                },
                              )),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Card(
                              shadowColor: green,
                              elevation: 5,
                              child: Container(
                                height: 170,
                                padding: EdgeInsets.all(8),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      'Order Id: ${list[index].orderId}',
                                      style: TextStyle(
                                          color: black,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      'OTP: ${list[index].deliveryCode}',
                                      style: TextStyle(
                                          color: black,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      '${list[index].user.name.toUpperCase()}',
                                      style: TextStyle(
                                          color: black,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      list[index].deliveryAddress,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                      style: TextStyle(
                                          color: black,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    
                                    SizedBox(
                                      height: 5,
                                    ),
                                    ListTile(
                                      leading: Padding(
                                        padding:
                                            const EdgeInsets.only(right: 5),
                                        child: Column(
                                          children: <Widget>[
                                            Stack(
                                              children: <Widget>[
                                                Icon(
                                                  Icons.shopping_cart,
                                                  // color: white,
                                                  size: 35,
                                                ),
                                                Positioned(
                                                  top: 0,
                                                  right: 0,
                                                  child: Container(
                                                    height: 15,
                                                    width: 18,
                                                    decoration: BoxDecoration(
                                                        color: white,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20),
                                                        boxShadow: [
                                                          BoxShadow(
                                                              color: Colors
                                                                  .grey,
                                                              offset:
                                                                  Offset(1, 1),
                                                              blurRadius: 2)
                                                        ]),
                                                    child: Center(
                                                      child: Text(
                                                        list[index]
                                                            .products
                                                            .length
                                                            .toString(),
                                                        style: TextStyle(
                                                            fontSize: 10,
                                                            color: black,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600),
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                            Text("₹" +
                                                getAmount(list[index]
                                                        .products)
                                                    .toString())
                                          ],
                                        ),
                                      ),
                                      trailing:  Padding(
                                        padding:
                                            const EdgeInsets.only(right: 5),
                                        child: Column(
                                          children: <Widget>[
                                            Stack(
                                              children: <Widget>[
                                                Icon(
                                                  Icons.shopping_cart,
                                                  // color: white,
                                                  size: 35,
                                                ),
                                                Positioned(
                                                  top: 0,
                                                  right: 0,
                                                  child: Container(
                                                    height: 15,
                                                    width: 18,
                                                    decoration: BoxDecoration(
                                                        color: red,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20),
                                                        boxShadow: [
                                                          BoxShadow(
                                                              color: Colors
                                                                  .grey,
                                                              offset:
                                                                  Offset(1, 1),
                                                              blurRadius: 2)
                                                        ]),
                                                    child: Center(
                                                      child: Text(
                                                        list[index]
                                                            .pendingProducts
                                                            .length
                                                            .toString(),
                                                        style: TextStyle(
                                                            fontSize: 10,
                                                            color: white,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600),
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                            Text("₹" +
                                                getAmount(list[index]
                                                        .pendingProducts)
                                                    .toString())
                                          ],
                                        ),
                                      ),
                                      title: Padding(
                                        padding:
                                            const EdgeInsets.only(right: 5),
                                        child: Column(
                                          children: <Widget>[
                                            Stack(
                                              children: <Widget>[
                                                Icon(
                                                  Icons.shopping_cart,
                                                  // color: white,
                                                  size: 35,
                                                ),
                                                Positioned(
                                                  top: 0,
                                                  right: 0,
                                                  child: Container(
                                                    height: 15,
                                                    width: 18,
                                                    decoration: BoxDecoration(
                                                        color: green,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20),
                                                        boxShadow: [
                                                          BoxShadow(
                                                              color: Colors
                                                                  .lightGreen,
                                                              offset:
                                                                  Offset(2, 2),
                                                              blurRadius: 3)
                                                        ]),
                                                    child: Center(
                                                      child: Text(
                                                        list[index]
                                                            .completeProducts
                                                            .length
                                                            .toString(),
                                                        style: TextStyle(
                                                            fontSize: 10,
                                                            color: white,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Text("₹" +
                                                getAmount(list[index].completeProducts)
                                                    .toString())
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          )
                          
                          ),
                          );
                        }),
          );
  }
}
