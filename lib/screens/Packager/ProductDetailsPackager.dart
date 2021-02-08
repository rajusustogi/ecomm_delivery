import 'dart:async';
import 'package:ecomm_delivery/Models/UserModel.dart';
import 'package:ecomm_delivery/helper/Navigation.dart';
import 'package:ecomm_delivery/helper/colors.dart';
import 'package:ecomm_delivery/screens/Packager/Invoice.dart';
import 'package:ecomm_delivery/screens/LoginPage.dart';
import 'package:ecomm_delivery/screens/Packager/DetailsPackager.dart';
import 'package:ecomm_delivery/screens/Packager/Inventory.dart';
import 'package:ecomm_delivery/screens/Packager/Stock.dart';
import 'package:ecomm_delivery/screens/Packager/pendingPackages.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'CompletedPackages.dart';

class ProductDetailsPackager extends StatefulWidget {
  final Data user;

  const ProductDetailsPackager({Key key, this.user}) : super(key: key);
  @override
  _ProductDetailsPackagerState createState() => _ProductDetailsPackagerState();
}

class _ProductDetailsPackagerState extends State<ProductDetailsPackager> {
  Future<Null> _refreshLocalGallery() async {
    await new Future.delayed(const Duration(seconds: 2), () => setState(() {}));
  }

  int _currentIndex = 0;
  final List<Widget> packages = [
    PendingPackageOrder(),
    CompletePackageOrder(),
    Stocks(),
    Inventory()
  ];
  final List<Widget> pickups = [
    PickupOrderPackager(
      status: 'pending',
    ),
    PickupOrderPackager(
      status: 'success',
    ),
    Stocks(),
    Inventory()
  ];
  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  bool pack = false;
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
              title: pack ? Text('Packed') : Text('Delivered'),
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.store_mall_directory), title: Text('Stock')),
            BottomNavigationBarItem(
                icon: Icon(Icons.library_books), title: Text('Inventory'))
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
                title: pack ? Text("Pickups") : Text("Package"),
                trailing: Icon(Icons.card_giftcard),
                onTap: () {
                   setState(() {
                      pack = !pack;
                    });
                    Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text("Invoice"),
                trailing: Icon(Icons.library_books),
                onTap: () {
                  changeScreen(context, Invoice());
                },
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
          
          title: !pack ? Text("Pending Pickups") : Text("Pending Packages"),
          centerTitle: false,
         
        ),
        body: RefreshIndicator(
            color: green,
            onRefresh: _refreshLocalGallery,
            child: pack ? packages[_currentIndex] : pickups[_currentIndex]));
  }
}
