import 'dart:async';
import 'dart:convert';
import 'package:ecomm_delivery/Models/UserModel.dart';
import 'package:ecomm_delivery/helper/Apis.dart';
import 'package:ecomm_delivery/helper/Navigation.dart';
import 'package:ecomm_delivery/helper/colors.dart';
import 'package:ecomm_delivery/screens/Delivery_man/ProductDetails.dart';
import 'package:ecomm_delivery/screens/Packager/ProductDetailsPackager.dart';
import 'package:flutter/material.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  login(String id, String pass) async {
    var response = await http
        .post(LOGINEMPLOYEE, body: {"emailOrPhone": id, "password": pass});
    print(response.body);
    if (response.statusCode == 200) {
      User user = User.fromJson(json.decode(response.body));
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('token', user.token);
      prefs.setString('user', json.encode(user.data));
      print(user.data.categoryId);
      switch (user.data.categoryId) {
        case 'packager':
          Timer(Duration(seconds: 1), () {
            _btnController.success();
            changeScreenRepacement(context, ProductDetailsPackager(user:user.data));
          });
          break;
        case 'delivery_man':
          Timer(Duration(seconds: 1), () {
            _btnController.success();
            changeScreenRepacement(context, ProductDetails(user: user.data,));
          });
          break;
         default:   setState(() {
        error = 'something went wrong';
      });
      _btnController.reset();
      }
      return 'success';
    } else {
      setState(() {
        error = json.decode(response.body)['message'];
      });
      _btnController.reset();
    }
  }

  String id;
  String password;
  final RoundedLoadingButtonController _btnController =
      new RoundedLoadingButtonController();
  final _formkey = GlobalKey<FormState>();
  String error = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('images/intro.jpg'),
                fit: BoxFit.cover,
                alignment: Alignment.center)),
        child: Form(
          key: _formkey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  height: 300,
                  decoration: BoxDecoration(
                      color: white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey,
                            blurRadius: 5.0,
                            offset: Offset(-2, 3)),
                      ]),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Welcome',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          child: TextFormField(
                            onSaved: (val) {
                              setState(() {
                                id = val;
                              });
                            },
                            validator: (val) {
                              if (val.length != 10) {
                                return 'invalid number';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                labelText: 'Enter Mobile Number',
                                border: OutlineInputBorder()),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          child: TextFormField(
                            onSaved: (val) {
                              setState(() {
                                password = val;
                              });
                            },
                            validator: (val) {
                              if (val.isEmpty) {
                                return 'Cannot be empty';
                              }
                              return null;
                            },
                            obscureText: true,
                            decoration: InputDecoration(
                                fillColor: white,
                                labelText: 'Enter Password',
                                border: OutlineInputBorder()),
                          ),
                        ),
                        // SizedBox(
                        //   height: 10,
                        // ),
                        Text(
                          error,
                          style: TextStyle(color: Colors.red),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        RoundedLoadingButton(
                            color: Colors.green,
                            controller: _btnController,
                            onPressed: () async {
                              if (_formkey.currentState.validate()) {
                                _formkey.currentState.save();
                                await login(id, password);
                              } else {
                                _btnController.reset();
                              }
                            },
                            child: Text(
                              'LOGIN',
                              style: TextStyle(color: Colors.white),
                            ))
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
