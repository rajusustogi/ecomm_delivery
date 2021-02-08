import 'dart:convert';
import 'package:ecomm_delivery/Models/InvoiceModel.dart';
import 'package:ecomm_delivery/helper/colors.dart';
import 'package:http/http.dart' as http;
import 'package:ecomm_delivery/helper/Apis.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<InvoiceModel> invoice() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  String token = pref.getString('token');
  var response =
      await http.get(PACKAGERINVOICE, headers: {"authorization": token});
  // List<InvoiceData> productData = [];
  print("hello" + response.body);
  if (response.statusCode == 200) {
    InvoiceModel productModel =
        InvoiceModel.fromJson(json.decode(response.body));
    // productData = productModel.data;
    print(productModel.data[0].compactPickups);
    return productModel;
  }
}

class Invoice extends StatefulWidget {
  Invoice({Key key}) : super(key: key);

  @override
  _InvoiceState createState() => _InvoiceState();
}

class _InvoiceState extends State<Invoice> {
  // @override
  // void initState() {
  //   invoice();
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Invoice"),
      ),
      body: FutureBuilder(
        future: invoice(),
        // initialData: InitialData,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          final Size size = MediaQuery.of(context).size;
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Container(
                height: MediaQuery.of(context).size.height,
                child: Center(child: CircularProgressIndicator()),
              );

              break;
            case ConnectionState.done:
              return ListView.separated(
                  itemCount: snapshot.data.data.length,
                  separatorBuilder: (context, index) {
                    return SizedBox(
                      height: 5,
                    );
                  },
                  itemBuilder: (context, index) {
                    // return Container();
                    return SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Column(
                        children: <Widget>[
                          Row(
                            // mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                  width: size.width,
                                  color: amber,
                                  alignment: Alignment.center,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      snapshot.data.data[index].date ?? 'no date',
                                      style: TextStyle(
                                          color: white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ))
                            ],
                          ),
                          DataTable(
                              columnSpacing: size.width*0.05,
                              // horizontalMargin: 15,
                              

                              columns: <DataColumn>[
                                DataColumn(label: Text('Order Id')),
                                DataColumn(label: Text('Wholesaler Name')),
                                DataColumn(label: Text('Item')),
                                DataColumn(label: Text('Pay Amount'),),
                                // DataColumn(label: Text('Date')),
                              ],

                              rows: snapshot.data.data[index].compactPickups
                                  .map<DataRow>((p) => DataRow(
                                    selected: true, cells: [
                                        DataCell(Text(p.pickupId.toString()),
                                            onTap: () {}),
                                        DataCell(
                                          Text(
                                            p.wholesalerName,
                                          ),
                                        ),
                                        DataCell(Text(
                                          p.items.toString()

                                        )),
                                        DataCell(Text(p.paidAmount.toString())),
                                        // DataCell(Text(DateFormat("dd-MM-yyyy")
                                        //     .format(DateTime.parse(p.deliveryDate))
                                        //     .toString()))
                                      ]))
                                  .toList()
                                  ),
                        ],
                      ),
                    );
                  });

              break;
            default:
              return Text('Something Went Wrong');
          }
        },
      ),
    );
  }
}
