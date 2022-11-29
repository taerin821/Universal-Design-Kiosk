import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_kiosk_ui/models/Cart.dart';
import 'package:flutter_kiosk_ui/screens/card_In/payment.dart';
import 'package:flutter_kiosk_ui/screens/home/home_screen.dart';

import 'components/body.dart';
import 'components/check_out_card.dart';

class CartScreen extends StatelessWidget {
  static String routeName = "/cart";
  DatabaseReference databaseReference;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: Body(),
      bottomNavigationBar: CheckoutCard(),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Color(0xFFFFA726),
      automaticallyImplyLeading: false,
      elevation: 0,
      title: Row(
        children: [
          IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HomeScreen()
                        //paymentScreen()
                        ));
                // Navigator.pop(context);
              }),
          Text(
            "주문확인",
            style: TextStyle(
                color: Colors.white, fontSize: 25.0, fontFamily: 'fifth'),
          ),
          //Text(
          //"${carts.length} items",
          //style: Theme.of(context).textTheme.caption,
          //),
        ],
      ),
    );
  }
}
