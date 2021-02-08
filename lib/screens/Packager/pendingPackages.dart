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

class PendingPackageOrder extends StatefulWidget {
  PendingPackageOrder({Key key}) : super(key: key);

  @override
  _PendingPackageOrderState createState() => _PendingPackageOrderState();
}

class _PendingPackageOrderState extends State<PendingPackageOrder> {
  List<PendingPackagesData> list;
  @override
  void initState() {
    super.initState();
    getOrders();
  }

  getAmount(List<Products> pro) {
    dynamic total = 0;
    for (var i in pro) {
      total = total + i.noOfUnits * i.rate;
    }
    return total;
  }

  getColors(PendingPackagesData order) {
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
    print('packager pending');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');
    var response = await http.get(PENDINGPACKAGES, headers: {
      "Authorization": token,
    });
    print('Response status: ${response.statusCode}');
    if (response.statusCode == 200) {
      PendingPackages orders =  
          PendingPackages.fromJson(json.decode(response.body));
      setState(() {
        list = orders.data.where((element) => element.orderStatus == 'pending').toList()..sort((a,b)=>b.id.compareTo(a.id));
      });
    } else {
      print('failed');
      return false;
    }
  }

  bool fav = false;
  @override
  Widget build(BuildContext context) {
    return Container(
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
                                color: getColors(list[index]),
                                fun: () {
                                  print('hello');
                                  setState(() {});
                                },
                              )),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Card(
                              shadowColor: getColors(list[index]),
                              elevation: 5,
                              child: Container(
                                height: 150,
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
                                    // Row(
                                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    //   children: <Widget>[
                                    //     // widget.type == 'complete'
                                    //     //     ? Text('')
                                    //         // :
                                    //         Text('${list[index].user.name.toUpperCase()}'),
                                    //         Text(list[index].user.address),
                                    //         //  Text(
                                    //         //     'OrderId: ${list[index].user.address}\n ${list[index].user.name}',
                                    //         //     style: TextStyle(
                                    //         //         color: black,
                                    //         //         fontWeight: FontWeight.bold),
                                    //         //   ),
                                    //         // Text(
                                    //         //     'OrderId: ${list[index].orderId}\nDelivery Date: ${list[index].expectedDate}',
                                    //         //     style: TextStyle(
                                    //         //         color: black,
                                    //         //         fontWeight: FontWeight.bold),
                                    //         //   ),
                                    //     // widget.type == 'complete'
                                    //         // ? Text('')
                                    //         // :
                                    //         Text('OTP: ${list[index].deliveryCode}',
                                    //             style: TextStyle(
                                    //                 color: blue,
                                    //                 fontWeight: FontWeight.bold))
                                    //   ],
                                    // ),
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
                                                        color: amber,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20),
                                                        boxShadow: [
                                                          BoxShadow(
                                                              color: Colors
                                                                  .yellowAccent,
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
                                                        .products)
                                                    .toString())
                                          ],
                                        ),
                                      ),
                                      title:  Padding(
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
                                      trailing: Padding(
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
                                                                  .red,
                                                              offset:
                                                                  Offset(2, 2),
                                                              blurRadius: 3)
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
                                                ),
                                              ],
                                            ),
                                            Text("₹" +
                                                getAmount(list[index].pendingProducts)
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
                          // child: Card(
                          //   elevation: 5,
                          //   shadowColor: getColors(list[index]),borderOnForeground: true,
                          //   child: Padding(
                          //     padding:
                          //         const EdgeInsets.symmetric(vertical: 8.0),
                          //     child: Container(
                          //       height: 120,
                          //       width: MediaQuery.of(context).size.width,
                          //       child: Row(
                          //         mainAxisAlignment:
                          //             MainAxisAlignment.spaceBetween,
                          //         children: [
                          //           Container(
                          //             height: 120,
                          //             width: MediaQuery.of(context)
                          //                     .size
                          //                     .width *
                          //                 .5,
                          //             child: Column(
                          //               mainAxisAlignment:
                          //                   MainAxisAlignment.spaceEvenly,
                          //               children: [
                          //                 RichText(
                          //                   maxLines: 8,
                          //                   overflow: TextOverflow.ellipsis,
                          //                   softWrap: true,
                          //                   text: TextSpan(
                          //                     children: <TextSpan>[
                          //                       // TextSpan(
                          //                       //   text: list[index].seller + "\n",
                          //                       //   style: TextStyle(
                          //                       //     color: grey,
                          //                       //   ),
                          //                       // ),
                          //                       TextSpan(
                          //                         text: "OrderId: ",
                          //                         style: TextStyle(
                          //                             color: black,
                          //                             fontWeight:
                          //                                 FontWeight.bold),
                          //                       ),
                          //                       TextSpan(
                          //                         text:
                          //                             "${list[index].orderId}\n",
                          //                         style: TextStyle(
                          //                           color: black,
                          //                         ),
                          //                       ),
                          //                       TextSpan(
                          //                         text: "Delivery Date: ",
                          //                         style: TextStyle(
                          //                             color: black,
                          //                             fontWeight:
                          //                                 FontWeight.bold),
                          //                       ),
                          //                       TextSpan(
                          //                         text:
                          //                             "${DateFormat('yyyy-MM-dd').format(DateTime.parse(list[index].expectedDate))}\n",
                          //                         style: TextStyle(
                          //                           color: black,
                          //                         ),
                          //                       ),
                          //                       TextSpan(
                          //                         text: "Delivery Status: ",
                          //                         style: TextStyle(
                          //                             color: black,
                          //                             fontWeight:
                          //                                 FontWeight.bold),
                          //                       ),
                          //                       TextSpan(
                          //                         text: list[index]
                          //                                 .orderStatus +
                          //                             "\n",
                          //                         style: TextStyle(
                          //                           color: getColors(
                          //                               list[index]),
                          //                         ),
                          //                       ),
                          //                       TextSpan(
                          //                         text: "Delivery Code: ",
                          //                         style: TextStyle(
                          //                             color: black,
                          //                             fontWeight:
                          //                                 FontWeight.bold),
                          //                       ),
                          //                       TextSpan(
                          //                         text: list[index]
                          //                                 .deliveryCode +
                          //                             "\n",
                          //                         style: TextStyle(
                          //                           color: black,
                          //                         ),
                          //                       ),
                          //                       TextSpan(
                          //                         text: "Total Price: ₹" +
                          //                             list[index]
                          //                                 .amount
                          //                                 .toString(),
                          //                         style: TextStyle(
                          //                           color: black,
                          //                         ),
                          //                       ),
                          //                     ],
                          //                   ),
                          //                 ),
                          //               ],
                          //             ),
                          //           ),
                          //           Container(
                          //             height: 120,
                          //             width: 120,
                          //             child: Image.network(
                          //               list[index].products[0].imageUrl,
                          //               fit: BoxFit.fill,
                          //             ),
                          //           ),
                          //         ],
                          //       ),
                          //     ),
                          //   ),
                          // ),
                          ),
                    );
                  }),
    );
  }
}
