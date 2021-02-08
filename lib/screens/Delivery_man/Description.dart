import 'package:ecomm_delivery/helper/colors.dart';
import 'package:flutter/material.dart';

class Description extends StatefulWidget {
  final dynamic order;
  final String status;
  final Color color;
  Description({this.status, this.order, this.color});

  @override
  _DescriptionState createState() => _DescriptionState();
}

class _DescriptionState extends State<Description> {
  String code;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(widget.order.user.name.toString())),
        body: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Container(
              child: ListView.separated(
                  separatorBuilder: (context, index) {
                    return SizedBox(
                      height: 2,
                    );
                  },
                  itemCount: widget.status == 'on the way'
                      ? widget.order.completeProducts.length
                      : widget.order.products.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      child: Container(
                        height: 120,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10),
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(boxShadow: [
                          BoxShadow(
                            color: widget.color,
                            blurRadius: 5.0,
                          ),
                        ], color: white),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 120,
                              width: 120,
                              child: Image.network(
                                widget.status == 'on the way'
                                    ? widget
                                        .order.completeProducts[index].imageUrl
                                    : widget.order.products[index].imageUrl,
                                fit: BoxFit.fill,
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Container(
                              height: 150,
                              width: MediaQuery.of(context).size.width * .55,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.baseline,
                                textBaseline: TextBaseline.ideographic,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  RichText(
                                    maxLines: 6,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.justify,
                                    softWrap: true,
                                    text: TextSpan(
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: "Product: ",
                                          style: TextStyle(
                                              color: black,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        TextSpan(
                                          text: (widget.status == 'on the way'
                                              ? widget.order
                                                  .completeProducts[index].title
                                              : widget.order.products[index]
                                                      .title) +
                                                  "\n",
                                          style: TextStyle(
                                            color: black,
                                          ),
                                        ),
                                        TextSpan(
                                          text: "Deal Rate: ",
                                          style: TextStyle(
                                              color: black,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        TextSpan(
                                          text: "₹" +
                                              (widget.status == 'on the way'
                                                  ? widget
                                                      .order
                                                      .completeProducts[index]
                                                      .rate
                                                      .toString()
                                                  : widget.order.products[index]
                                                      .rate
                                                      .toString()),
                                          style: TextStyle(
                                            color: black,
                                          ),
                                        ),
                                        TextSpan(
                                            text:
                                                " ₹${widget.status == 'on the way' ? widget.order.completeProducts[index].mrp : widget.order.products[index].mrp} \n",
                                            style: TextStyle(
                                                color: grey,
                                                decoration: TextDecoration
                                                    .lineThrough)),
                                        TextSpan(
                                            text: "QTY:  ",
                                            style: TextStyle(
                                                color: black,
                                                fontWeight: FontWeight.bold)),
                                        TextSpan(
                                            text:
                                                "${widget.status == 'on the way' ? widget.order.completeProducts[index].noOfUnits.toString() : widget.order.products[index].noOfUnits.toString()}\n",
                                            style: TextStyle(
                                                color: black,
                                                fontWeight: FontWeight.bold)),
                                        TextSpan(
                                          text: "Amount: ",
                                          style: TextStyle(
                                              color: black,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        TextSpan(
                                          text: "₹" +
                                            ( widget.status == 'on the way' ?  (widget
                                                          .order
                                                          .completeProducts[
                                                              index]
                                                          .rate *
                                                      widget
                                                          .order
                                                          .completeProducts[
                                                              index]
                                                          .noOfUnits)
                                                  .toString():(widget
                                                          .order
                                                          .products[
                                                              index]
                                                          .rate *
                                                      widget
                                                          .order
                                                          .products[
                                                              index]
                                                          .noOfUnits)
                                                  .toString() )+
                                              "\n",
                                          style: TextStyle(
                                            color: black,
                                          ),
                                        ),
                                        TextSpan(
                                          text: "Mfg: ",
                                          style: TextStyle(
                                              color: black,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        TextSpan(
                                          text: ( widget.status == 'on the way' ? widget
                                                  .order
                                                  .completeProducts[index]
                                                  .manufacturer :widget
                                                  .order
                                                  .products[index]
                                                  .manufacturer) +
                                              "\n",
                                          style: TextStyle(
                                            color: black,
                                          ),
                                        ),
                                        TextSpan(
                                          text: "Pack Size: ",
                                          style: TextStyle(
                                              color: black,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        TextSpan(
                                          text: widget.status=='on the way'?widget.order
                                              .completeProducts[index].packSize:widget.order
                                              .products[index].packSize,
                                          style: TextStyle(
                                            color: black,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
            ),
          ],
        ));
  }
}
