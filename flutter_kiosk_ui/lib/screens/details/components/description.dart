import 'package:flutter/material.dart';
import 'package:flutter_kiosk_ui/models/Menu.dart';
import 'package:flutter_kiosk_ui/models/Product.dart';

import '../../../constants.dart';

class Description extends StatelessWidget {
  const Description({
    Key key,
    this.burger,
  }) : super(key: key);

  final Burger burger;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: kDefaultPaddin),
      child: Text(
        burger.description,
        style: TextStyle(height: 1.5, fontFamily: 'fifth',color: Colors.black),
      ),
    );
  }
}
