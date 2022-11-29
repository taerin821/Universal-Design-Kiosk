import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_kiosk_ui/models/Menu.dart';

import 'package:flutter_kiosk_ui/screens/home/home_screen.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_kiosk_ui/constants.dart';
import 'package:flutter_kiosk_ui/models/Product.dart';
import 'package:flutter_kiosk_ui/screens/details/components/body.dart';

import 'components/add_to_cart.dart';

class DetailsScreen extends StatefulWidget {
  final Product product;
  Burger burger;

  DetailsScreen({Key key, this.burger, this.product}) : super(key: key);

  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // each product have a color
      backgroundColor: Color(0xFFFFA726),
      appBar:
          buildAppBar(context) ,
    
      body: DetailsBody(burger: widget.burger),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Color(0xFFFFA726),
      elevation: 0,
      leading: IconButton(
        icon: SvgPicture.asset(
          'assets/icons/back.svg',
          color: Colors.deepOrange,
        ),
        onPressed: () => Navigator.pop(context),
      ),
    );
  }

}
