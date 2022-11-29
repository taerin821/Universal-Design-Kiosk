import 'package:flutter/material.dart';
import 'package:flutter_kiosk_ui/models/Product.dart';
import '../components/middle.dart';
import 'package:flutter_kiosk_ui/screens/details/components/add_to_cart.dart';
import 'package:flutter_kiosk_ui/screens/details/components/color_and_size.dart';
import 'package:flutter_kiosk_ui/screens/details/components/counter_with_fav_btn.dart';
import 'package:flutter_kiosk_ui/screens/details/components/description.dart';
import 'package:flutter_kiosk_ui/screens/details/components/product_title_with_image.dart';

import '../../../constants.dart';
import '../components/top.dart';
import 'checkbutton.dart';

class Body extends StatelessWidget {
  final Product product;

  const Body({Key key, this.product}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // It provide us total height and width

    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 80.0, 0.0, 0.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Top(),
          SizedBox(
            height: 20.0,
          ),
          Divider(
            color: Colors.black,
            thickness: 1.8,
            indent: 40.0,
            endIndent: 40.0,
          ),
          SizedBox(
            height: 15.0,
          ),
          Middle(),
          SizedBox(height: 100.0),
          Button()
        ],
      ),
    );
  }
}
