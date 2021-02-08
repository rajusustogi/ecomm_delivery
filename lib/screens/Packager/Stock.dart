import 'dart:convert';
import 'package:ecomm_delivery/helper/Apis.dart';
import 'package:ecomm_delivery/helper/colors.dart';
import 'package:http/http.dart' as http;
import 'package:ecomm_delivery/Models/StockModel.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Stocks extends StatefulWidget {
  Stocks({Key key}) : super(key: key);

  @override
  _StocksState createState() => _StocksState();
}

class _StocksState extends State<Stocks> {
  Future<List<StockData>> getStock() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String token = pref.getString('token');
    var response = await http.get(STOCK, headers: {"authorization": token});
    print(response.body);
    if (response.statusCode == 200) {
      StockModel productModel = StockModel.fromJson(json.decode(response.body));
      return productModel.data;
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
          child: Container(
        height: size.height * 0.8,
        child: FutureBuilder(
          future: getStock(),
          // initialData: InitialData,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return Center(
                  child: CircularProgressIndicator(),
                );
                break;
              case ConnectionState.done:
                if (snapshot.data == null) {
                  return Center(child: Text('no prder'));
                } else {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                              height: 100,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                      color: grey,
                                      blurRadius: 5.0,
                                    ),
                                  ],
                                  color: white),
                              child: Row(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Container(
                                      height: 100,
                                      width: 100,
                                      child: Image.network(
                                          snapshot.data[index].product.imageUrl,
                                          fit: BoxFit.contain),
                                    ),
                                  ),
                                  Container(
                                    height: 120,
                                    width:
                                        MediaQuery.of(context).size.width * .50,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.baseline,
                                      textBaseline: TextBaseline.ideographic,
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        RichText(
                                          maxLines: 6,
                                          overflow: TextOverflow.ellipsis,
                                          textAlign: TextAlign.start,
                                          softWrap: true,
                                          text: TextSpan(
                                            children: <TextSpan>[
                                              TextSpan(
                                                text: snapshot.data[index]
                                                        .product.title +
                                                    "\n",
                                                style: TextStyle(
                                                  color: black,
                                                ),
                                              ),
                                              TextSpan(
                                                text: "₹" +
                                                    snapshot.data[index].product
                                                        .sellingPrice
                                                        .toString() +
                                                    "\n",
                                                style: TextStyle(
                                                  color: black,
                                                ),
                                              ),
                                              // TextSpan(
                                              //     text: "QTY:  ",
                                              //     style: TextStyle(
                                              //         color: black,
                                              //         fontWeight:
                                              //             FontWeight.bold)),
                                              // TextSpan(
                                              //     text:
                                              //         "${snapshot.data[index].noOfUnits.toString()}\n",
                                              //     style: TextStyle(
                                              //         color: black,
                                              //         fontWeight:
                                              //             FontWeight.bold)),
                                              TextSpan(
                                                text: "Mfg: ",
                                                style: TextStyle(
                                                    color: black,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              TextSpan(
                                                text: snapshot.data[index]
                                                        .product.manufacturer +
                                                    "\n",
                                                style: TextStyle(
                                                  color: black,
                                                ),
                                              ),
                                              TextSpan(
                                                text: "Pack Size: ",
                                                style: TextStyle(
                                                    color: black,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              TextSpan(
                                                text: snapshot.data[index]
                                                        .product.packSize
                                                        .toString() +
                                                    '\n',
                                                style: TextStyle(
                                                  color: black,
                                                ),
                                              ),
                                              snapshot.data[index].status ==
                                                      'assigned'
                                                  ? TextSpan(
                                                      text: "OrderId: ",
                                                      style: TextStyle(
                                                          color: black,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    )
                                                  : TextSpan(text: ''),
                                              snapshot.data[index].status ==
                                                      'assigned'
                                                  ? TextSpan(
                                                      text: snapshot.data[index]
                                                          .order.orderId
                                                          .toString(),
                                                      style: TextStyle(
                                                        color: black,
                                                      ),
                                                    )
                                                  : TextSpan(text: '')
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Stack(
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
                                              color: blue),
                                          alignment: Alignment.center,
                                          padding: EdgeInsets.all(2),
                                          child: Text(
                                            snapshot.data[index].noOfUnits
                                                .toString(),
                                            style: TextStyle(
                                                color: white,
                                                fontSize: 10,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              )),
                        );
                      },
                    ),
                  );
                }
                break;
              default:
                return Center(
                  child: Text('Something went wrong'),
                );
            }
          },
        ),
      )),
    );
  }
}
