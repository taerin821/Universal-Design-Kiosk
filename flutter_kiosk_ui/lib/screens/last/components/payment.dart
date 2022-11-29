import 'package:flutter/material.dart';
import 'package:flutter_kiosk_ui/models/Product.dart';

import '../../../constants.dart';

class Payment extends StatelessWidget {
  final Product product;

  const Payment({Key key, this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
        child: Column(children: <Widget>[
      SizedBox(
          height: size.height,
          child: Stack(children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: size.height * 0.1),
              padding: EdgeInsets.only(
                top: size.height * 0.12,
                left: kDefaultPaddin,
                right: kDefaultPaddin,
              ),
              // height: 500,
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: Column(
                children: <Widget>[
                  Container(
                    child: Column(
                      children: <Widget>[],
                    ),
                  )
                ],
              ),
            )
          ]))
    ]));
  }
}
