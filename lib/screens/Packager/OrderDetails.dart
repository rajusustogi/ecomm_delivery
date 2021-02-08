import 'dart:convert';

import 'package:ecomm_delivery/Models/CompletePackager.dart';
import 'package:ecomm_delivery/helper/Apis.dart';
import 'package:ecomm_delivery/helper/colors.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class OrderDetails extends StatefulWidget {
  final dynamic order;
  final Color color;
  final String type;
  final VoidCallback fun;
  const OrderDetails({this.order, this.color, this.type, this.fun});
  @override
  _OrderDetailsState createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  List<Products> list = [];
  final RoundedLoadingButtonController _btnController =
      new RoundedLoadingButtonController();
  @override
  void initState() {
    widget.type == 'complete'
        ? list = widget.order.products
        : list = widget.order.pendingProducts + widget.order.products;
    super.initState();
  }

  getAmount(List<Products> pro) {
    dynamic total = 0;
    for (var i in pro) {
      total = total + i.noOfUnits * i.rate;
    }
    return total;
  }

  Widget slideRightBackground() {
    return Container(
      color: green,
      child: Align(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              width: 20,
            ),
            // widget.status == 'pending'
            //     ? Icon(
            //         Icons.edit,
            //         color: Colors.white,
            //       )
            //     : Container(),
            Text(
              "Quantity",
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
    Size size = MediaQuery.of(context).size;
    print(list.length);
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
          appBar: AppBar(
            title: Text('Order Details'),
            automaticallyImplyLeading: true,
            leading: IconButton(
                icon: Icon(Icons.arrow_back_ios),
                onPressed: () {
                  widget.fun();
                  Navigator.pop(context);
                }),
          ),
          body: DefaultTabController(
            length: 3,
            child: Container(
              height: size.height,
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(0.0),
                      child: Container(
                        height: 80,
                        padding: EdgeInsets.all(8),
                        child: Column(
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.7,
                                  child: Text(
                                    '${widget.order.user.name.toUpperCase()}\n${widget.order.deliveryAddress}',
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 3,
                                    style: TextStyle(
                                        color: black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                widget.type == 'complete'
                                    ? Text('')
                                    : IconButton(
                                        icon: Icon(
                                          Icons.assignment_turned_in,
                                          color: green,
                                        ),
                                        onPressed: () async {
                                          SharedPreferences pref =
                                              await SharedPreferences
                                                  .getInstance();
                                          var token = pref.getString('token');
                                          showDialog(
                                            context: context,
                                            builder: (context) => AlertDialog(
                                              title: Text('Are you sure?'),
                                              content: Text(
                                                  'Do you want to Pack This Order'),
                                              actions: <Widget>[
                                                FlatButton(
                                                  onPressed: () =>
                                                      Navigator.of(context)
                                                          .pop(false),
                                                  child: Text('No'),
                                                ),
                                                FlatButton(
                                                  onPressed: () async {
                                                    var res = await http.put(
                                                        PACKORDER +
                                                            widget.order.id
                                                                .toString(),
                                                        headers: {
                                                          "authorization": token
                                                        });
                                                    print(res.body);
                                                    if (res.statusCode == 200) {
                                                      Navigator.pop(context);
                                                      Fluttertoast.showToast(
                                                          msg: "Order Packed",
                                                          toastLength:
                                                              Toast.LENGTH_LONG,
                                                          gravity: ToastGravity
                                                              .CENTER,
                                                          timeInSecForIosWeb: 1,
                                                          backgroundColor:
                                                              green,
                                                          textColor:
                                                              Colors.white,
                                                          fontSize: 16.0);
                                                    } else {
                                                      Navigator.pop(context);
                                                      Fluttertoast.showToast(
                                                          msg: json.decode(res
                                                              .body)['message'],
                                                          toastLength:
                                                              Toast.LENGTH_LONG,
                                                          gravity: ToastGravity
                                                              .BOTTOM,
                                                          timeInSecForIosWeb: 1,
                                                          backgroundColor: red,
                                                          textColor: white,
                                                          fontSize: 16.0);
                                                      // print(res.body);
                                                    }
                                                  },
                                                  child: Text('Yes'),
                                                ),
                                              ],
                                            ),
                                          );
                                        })
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    TabBar(
                      labelColor: black,
                      tabs: [
                        Tab(
                          child: Stack(
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
                                      borderRadius: BorderRadius.circular(20),
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.green,
                                            offset: Offset(1, 1),
                                            blurRadius: 2)
                                      ]),
                                  child: Center(
                                    child: Text(
                                      widget.order.products.length.toString(),
                                      style: TextStyle(
                                          fontSize: 10,
                                          color: black,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        Tab(
                          child: Stack(
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
                                      borderRadius: BorderRadius.circular(20),
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.green,
                                            offset: Offset(1, 1),
                                            blurRadius: 2)
                                      ]),
                                  child: Center(
                                    child: Text(
                                      widget.order.completeProducts.length
                                          .toString(),
                                      style: TextStyle(
                                          fontSize: 10,
                                          color: white,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        Tab(
                          child: Stack(
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
                                      borderRadius: BorderRadius.circular(20),
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.red,
                                            offset: Offset(1, 1),
                                            blurRadius: 2)
                                      ]),
                                  child: Center(
                                    child: Text(
                                      widget.order.pendingProducts.length
                                          .toString(),
                                      style: TextStyle(
                                          fontSize: 10,
                                          color: white,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    Container(
                      height: size.height * 0.7,
                      child: TabBarView(
                        children: <Widget>[
                          Container(
                            height: size.height * 0.7,
                            child: ListView.builder(
                              itemCount: widget.order.products.length,
                              itemBuilder: (BuildContext context, int index) {
                                String code = widget
                                    .order.products[index].noOfUnits
                                    .toString();

                                return Dismissible(
                                  key: Key(widget
                                      .order.products[index].productId
                                      .toString()),
                                  background: slideRightBackground(),
                                  confirmDismiss: widget.type == 'complete'
                                      ? (direction) async => false
                                      : (direction) async {
                                          if (direction ==
                                              DismissDirection.endToStart) {
                                            await showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                  elevation: 20,
                                                  title: Text(
                                                      'Enter the Quanity you have'),
                                                  content: Container(
                                                    height: 145,
                                                    child: Column(
                                                      children: <Widget>[
                                                        TextFormField(
                                                          initialValue: widget
                                                              .order
                                                              .products[index]
                                                              .noOfUnits
                                                              .toString(),
                                                          keyboardType:
                                                              TextInputType
                                                                  .phone,
                                                          onChanged: (val) {
                                                            setState(() {
                                                              code = val;
                                                            });
                                                          },
                                                          decoration: InputDecoration(
                                                              labelText:
                                                                  'Quantity ',
                                                              border:
                                                                  OutlineInputBorder()),
                                                        ),
                                                        SizedBox(
                                                          height: 20,
                                                        ),
                                                        RoundedLoadingButton(
                                                          controller:
                                                              _btnController,
                                                          onPressed: () async {
                                                            var product = widget
                                                                    .order
                                                                    .products[
                                                                index];
                                                            var id = product
                                                                .productId
                                                                .toString();
                                                            var rem = product
                                                                    .noOfUnits -
                                                                int.parse(code);
                                                            SharedPreferences
                                                                pref =
                                                                await SharedPreferences
                                                                    .getInstance();
                                                            var token =
                                                                pref.getString(
                                                                    'token');
                                                           
                                                            var res = await http.put(
                                                                OUTOFSTOCK +
                                                                    widget.order
                                                                        .id
                                                                        .toString(),
                                                                headers: {
                                                                  "Authorization":
                                                                      token
                                                                },
                                                                body: {
                                                                  "product_id":
                                                                      id,
                                                                  "no_of_units":
                                                                      rem.toString(),
                                                                  "available":
                                                                      "false"
                                                                });
                                                            print(res.body);
                                                            if (res.statusCode ==
                                                                200) {
                                                              _btnController
                                                                  .success();
                                                                   if (int.parse(
                                                                    code) ==
                                                                0) {
                                                              setState(() {
                                                                widget.order
                                                                    .pendingProducts
                                                                    .add(
                                                                        product);
                                                                widget.order
                                                                    .products
                                                                    .remove(
                                                                        product);
                                                              });
                                                            } else {
                                                              setState(() {
                                                                
                                                                widget.order
                                                                    .pendingProducts
                                                                    .add(product.copyWith(
                                                                        noOfUnits:
                                                                            rem));
                                                                widget.order
                                                                    .completeProducts
                                                                    .add(product.copyWith(
                                                                        noOfUnits:
                                                                            int.parse(code)));
                                                              widget.order
                                                                    .products
                                                                    .remove(
                                                                        product);
                                                              });
                                                            }
                                                              Navigator.pop(
                                                                  context);
                                                            } else {
                                                              Navigator.pop(
                                                                  context);
                                                              Fluttertoast.showToast(
                                                                  msg: json.decode(res
                                                                          .body)[
                                                                      'message'],
                                                                  toastLength: Toast
                                                                      .LENGTH_LONG,
                                                                  gravity:
                                                                      ToastGravity
                                                                          .BOTTOM,
                                                                  timeInSecForIosWeb:
                                                                      1,
                                                                  backgroundColor:
                                                                      Colors
                                                                          .red,
                                                                  textColor:
                                                                      Colors
                                                                          .white,
                                                                  fontSize:
                                                                      16.0);
                                                            }
                                                            
                                                          },
                                                          height: 40,
                                                          width: 150,
                                                          color: green,
                                                          child: Text(
                                                            "SUBMIT",
                                                            style: TextStyle(
                                                                color: white),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              },
                                            );
                                          } else if (direction ==
                                              DismissDirection.startToEnd) {
                                            var id = widget
                                                .order.products[index].productId
                                                .toString();

                                            SharedPreferences pref =
                                                await SharedPreferences
                                                    .getInstance();
                                            var token = pref.getString('token');
                                            var res = await http.put(
                                                OUTOFSTOCK +
                                                    widget.order.id.toString(),
                                                headers: {
                                                  "Authorization": token
                                                },
                                                body: {
                                                  "product_id": id,
                                                  "available": 'true'
                                                });
                                            print(res.statusCode);
                                            if (res.statusCode == 200) {
                                              setState(() {
                                                widget.order.completeProducts
                                                    .add(widget
                                                        .order.products[index]);
                                                widget.order.products.remove(
                                                    widget
                                                        .order.products[index]);
                                              });
                                              return true;
                                            } else {
                                              Fluttertoast.showToast(
                                                  msg: json.decode(
                                                      res.body)['message'],
                                                  toastLength:
                                                      Toast.LENGTH_LONG,
                                                  gravity: ToastGravity.BOTTOM,
                                                  timeInSecForIosWeb: 1,
                                                  backgroundColor: Colors.red,
                                                  textColor: Colors.white,
                                                  fontSize: 16.0);
                                              return false;
                                            }
                                          }
                                        },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0, vertical: 5),
                                    child: Container(
                                      height: 100,
                                      width: MediaQuery.of(context).size.width,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Stack(
                                            children: [
                                              Container(
                                                height: 80,
                                                width: 80,
                                                child: Image.network(
                                                  widget.order.products[index]
                                                      .imageUrl,
                                                  fit: BoxFit.fill,
                                                ),
                                              ),
                                            ],
                                          ),
                                          // SizedBox(
                                          //   width: 10,
                                          // ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                              height: 120,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  .5,
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  RichText(
                                                    maxLines: 5,
                                                    textAlign: TextAlign.left,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    softWrap: true,
                                                    text: TextSpan(
                                                      children: <TextSpan>[
                                                        TextSpan(
                                                          text: widget
                                                                  .order
                                                                  .products[
                                                                      index]
                                                                  .title +
                                                              "\n",
                                                          style: TextStyle(
                                                            color: black,
                                                          ),
                                                        ),
                                                        TextSpan(
                                                          text:
                                                              "${widget.order.products[index].manufacturer}\n",
                                                          style: TextStyle(
                                                            color: grey,
                                                          ),
                                                        ),
                                                        TextSpan(
                                                          text:
                                                              "${widget.order.products[index].packSize}\n",
                                                          style: TextStyle(
                                                            color: grey,
                                                          ),
                                                        ),
                                                        TextSpan(
                                                          text: "₹" +
                                                              widget
                                                                  .order
                                                                  .products[
                                                                      index]
                                                                  .rate
                                                                  .toString(),
                                                          style: TextStyle(
                                                            color: black,
                                                          ),
                                                        ),
                                                        TextSpan(
                                                            text: " ₹" +
                                                                widget
                                                                    .order
                                                                    .products[
                                                                        index]
                                                                    .mrp
                                                                    .toString() +
                                                                "\t",
                                                            style: TextStyle(
                                                                color: grey,
                                                                decoration:
                                                                    TextDecoration
                                                                        .lineThrough)),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Container(
                                            height: 30,
                                            width: 30,
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: widget.order.products
                                                            .contains(widget
                                                                    .order
                                                                    .products[
                                                                index]) ==
                                                        true
                                                    ? green
                                                    : amber),
                                            alignment: Alignment.center,
                                            child: Text(
                                              widget.order.products[index]
                                                  .noOfUnits
                                                  .toString(),
                                              style: TextStyle(
                                                  color: white,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          Container(
                            height: size.height * 0.7,
                            child: ListView.builder(
                              itemCount: widget.order.completeProducts.length,
                              itemBuilder: (BuildContext context, int index) {
                                String code = widget
                                    .order.completeProducts[index].noOfUnits
                                    .toString();

                                return Dismissible(
                                  key: Key(widget
                                      .order.completeProducts[index].productId
                                      .toString()),
                                  background: slideRightBackground(),
                                  confirmDismiss: (direction) async => false,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0, vertical: 5),
                                    child: Container(
                                      height: 100,
                                      width: MediaQuery.of(context).size.width,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Stack(
                                            children: [
                                              Container(
                                                height: 100,
                                                width: 80,
                                                child: Image.network(
                                                  widget
                                                      .order
                                                      .completeProducts[index]
                                                      .imageUrl,
                                                  fit: BoxFit.fill,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                              height: 140,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  .5,
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  RichText(
                                                    maxLines: 5,
                                                    textAlign: TextAlign.left,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    softWrap: true,
                                                    text: TextSpan(
                                                      children: <TextSpan>[
                                                        TextSpan(
                                                          text: widget
                                                                  .order
                                                                  .completeProducts[
                                                                      index]
                                                                  .title +
                                                              "\n",
                                                          style: TextStyle(
                                                            color: black,
                                                          ),
                                                        ),
                                                        TextSpan(
                                                          text:
                                                              "${widget.order.completeProducts[index].manufacturer}\n",
                                                          style: TextStyle(
                                                            color: grey,
                                                          ),
                                                        ),
                                                        TextSpan(
                                                          text:
                                                              "${widget.order.completeProducts[index].packSize}\n",
                                                          style: TextStyle(
                                                            color: grey,
                                                          ),
                                                        ),
                                                        TextSpan(
                                                          text: "₹" +
                                                              widget
                                                                  .order
                                                                  .completeProducts[
                                                                      index]
                                                                  .rate
                                                                  .toString(),
                                                          style: TextStyle(
                                                            color: black,
                                                          ),
                                                        ),
                                                        TextSpan(
                                                            text: " ₹" +
                                                                widget
                                                                    .order
                                                                    .completeProducts[
                                                                        index]
                                                                    .mrp
                                                                    .toString() +
                                                                "\t",
                                                            style: TextStyle(
                                                                color: grey,
                                                                decoration:
                                                                    TextDecoration
                                                                        .lineThrough)),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Container(
                                            height: 30,
                                            width: 30,
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: widget.order
                                                            .completeProducts
                                                            .contains(widget
                                                                    .order
                                                                    .completeProducts[
                                                                index]) ==
                                                        true
                                                    ? green
                                                    : amber),
                                            alignment: Alignment.center,
                                            child: Text(
                                              widget
                                                  .order
                                                  .completeProducts[index]
                                                  .noOfUnits
                                                  .toString(),
                                              style: TextStyle(
                                                  color: white,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          Container(
                            height: size.height * 0.7,
                            child: ListView.builder(
                              itemCount: widget.order.pendingProducts.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0, vertical: 5),
                                  child: Container(
                                    height: 120,
                                    width: MediaQuery.of(context).size.width,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Stack(
                                          children: [
                                            Container(
                                              height: 80,
                                              width: 80,
                                              child: Image.network(
                                                widget
                                                    .order
                                                    .pendingProducts[index]
                                                    .imageUrl,
                                                fit: BoxFit.fill,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                            height: 120,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                .5,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                RichText(
                                                  maxLines: 5,
                                                  textAlign: TextAlign.left,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  softWrap: true,
                                                  text: TextSpan(
                                                    children: <TextSpan>[
                                                      TextSpan(
                                                        text: widget
                                                                .order
                                                                .pendingProducts[
                                                                    index]
                                                                .title +
                                                            "\n",
                                                        style: TextStyle(
                                                          color: black,
                                                        ),
                                                      ),
                                                      TextSpan(
                                                        text:
                                                            "${widget.order.pendingProducts[index].manufacturer}\n",
                                                        style: TextStyle(
                                                          color: grey,
                                                        ),
                                                      ),
                                                      TextSpan(
                                                        text:
                                                            "${widget.order.pendingProducts[index].packSize}\n",
                                                        style: TextStyle(
                                                          color: grey,
                                                        ),
                                                      ),
                                                      TextSpan(
                                                        text: "₹" +
                                                            widget
                                                                .order
                                                                .pendingProducts[
                                                                    index]
                                                                .rate
                                                                .toString(),
                                                        style: TextStyle(
                                                          color: black,
                                                        ),
                                                      ),
                                                      TextSpan(
                                                          text: " ₹" +
                                                              widget
                                                                  .order
                                                                  .pendingProducts[
                                                                      index]
                                                                  .mrp
                                                                  .toString() +
                                                              "\t",
                                                          style: TextStyle(
                                                              color: grey,
                                                              decoration:
                                                                  TextDecoration
                                                                      .lineThrough)),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Container(
                                          height: 30,
                                          width: 30,
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: widget.order.products
                                                          .contains(widget.order
                                                                  .pendingProducts[
                                                              index]) ==
                                                      true
                                                  ? green
                                                  : amber),
                                          alignment: Alignment.center,
                                          child: Text(
                                            widget.order.pendingProducts[index]
                                                .noOfUnits
                                                .toString(),
                                            style: TextStyle(
                                                color: white,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
