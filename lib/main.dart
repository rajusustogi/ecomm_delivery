import 'dart:convert';

import 'package:ecomm_delivery/Models/UserModel.dart';
import 'package:ecomm_delivery/screens/LoginPage.dart';
import 'package:ecomm_delivery/screens/Delivery_man/ProductDetails.dart';
import 'package:ecomm_delivery/screens/Packager/ProductDetailsPackager.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'GetPharma',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: SController());
  }
}

class SController extends StatefulWidget {
  @override
  _SControllerState createState() => _SControllerState();
}

class _SControllerState extends State<SController> {
  String p;
  Data user;
  isLoggedin() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var token = pref.getString('token');
    user = Data.fromJson(json.decode(pref.getString('user')));
    print(token);
    if (token == null) {
      setState(() {
        p = 'login';
      });
    } else {
      if (user.categoryId == 'packager') {
        setState(() {
          p = 'packager';
        });
      } else {
        setState(() {
          p = 'delivery';
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    isLoggedin();
  }

  @override
  Widget build(BuildContext context) {
    switch (p) {
      case 'login':
        return LoginPage();
      case 'delivery':
        return ProductDetails(user: user,);
      case 'packager':
        return ProductDetailsPackager(user: user,);
      default:
        return LoginPage();
    }
  }
}
