import 'dart:async';
import 'package:ecomm_delivery/Models/UserModel.dart';
import 'package:ecomm_delivery/screens/Delivery_man/Details.dart';
import 'package:ecomm_delivery/helper/Navigation.dart';
import 'package:ecomm_delivery/helper/colors.dart';
import 'package:ecomm_delivery/screens/LoginPage.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'InvoiceDelivery.dart';

class ProductDetails extends StatefulWidget {
  final Data user;

  const ProductDetails({Key key, this.user}) : super(key: key);
  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  Future<Null> _refreshLocalGallery() async {
    await new Future.delayed(const Duration(seconds: 2), () => setState(() {}));
  }

  int _currentIndex = 0;
  final List<Widget> _children = [
    PendingOrderDetails(
      status: 'on the way',
    ),
    PendingOrderDetails(
      status: 'delivered',
    ),
   
    InvoiceDelivery()
  ];
  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          onTap: onTabTapped, // new
          currentIndex: _currentIndex, selectedItemColor: blue,
          unselectedItemColor: grey, showUnselectedLabels: true, elevation: 20,
          items: [
            BottomNavigationBarItem(
              icon: new Icon(Icons.watch_later),
              title: new Text('Pending'),
            ),
            BottomNavigationBarItem(
              icon: new Icon(Icons.playlist_add_check),
              title: new Text('Delivered'),
            ),
         
            BottomNavigationBarItem(
                icon: Icon(Icons.file_download), title: Text('Invoice'))
          ],
        ),
         drawer: Drawer(
          
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Icon(Icons.account_circle,color: white,size: 50,),
                    Text(widget.user.name,style: TextStyle(color: white,fontWeight: FontWeight.bold,fontSize: 20),),
                    Text(widget.user.email,style: TextStyle(color: Colors.white70,fontWeight: FontWeight.normal,fontSize: 15),),
                    Text(widget.user.mobileNo,style: TextStyle(color: Colors.white70,fontWeight: FontWeight.normal,fontSize: 15),),
                    
                  ],
                ),
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
              ),
             
              ListTile(
                title: Text('Logout'),
                trailing: Icon(Icons.exit_to_app),
                onTap: ()async {
                  SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    prefs.clear();
                    changeScreenRepacement(context, LoginPage());
                },
              ),
            ],
          ),
        ),
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: Text('Welcome'),
          centerTitle: false,
         
        ),
        body: RefreshIndicator(
            color: green,
            onRefresh: _refreshLocalGallery,
            child: _children[_currentIndex]));
  }
}
