import 'package:flutter/material.dart';
import 'package:flutter_kiosk_ui/constants.dart';
import 'package:flutter_kiosk_ui/models/Menu.dart';
import 'package:flutter_kiosk_ui/screens/details/components/senior/senior_titleWithImage.dart';

import 'package:flutter_kiosk_ui/screens/details/components/add_to_cart.dart';
import 'package:flutter_kiosk_ui/screens/details/components/color_and_size.dart';
import 'package:flutter_kiosk_ui/screens/details/components/counter_with_fav_btn.dart';
import 'package:flutter_kiosk_ui/screens/details/components/description.dart';
import 'package:flutter_kiosk_ui/screens/details/components/product_title_with_image.dart';

class SeniorDetailsBody extends StatefulWidget {
  final Burger burger;

  const SeniorDetailsBody({Key key, this.burger}) : super(key: key);

  @override
  _SeniorDetailsBodyState createState() => _SeniorDetailsBodyState();
}

class _SeniorDetailsBodyState extends State<SeniorDetailsBody> {
  @override
  Widget build(BuildContext context) {
    // It provide us total height and width
    Size size = MediaQuery.of(context).size;
    return Column(
      children: <Widget>[
        Expanded(
          child: SizedBox(
            height: size.height,
            child: Stack(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: size.height * 0.3),
                  padding: EdgeInsets.only(
                    top: size.height * 0.12,
                    left: kDefaultPaddin,
                    right: kDefaultPaddin,
                  ),
                  // height: 500,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(24), // 하얀색 둥글기
                      topRight: Radius.circular(24),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      ColorAndSize(burger: widget.burger),
                      Description(burger: widget.burger),
                      SizedBox(height: 20),
                      Row(
                        children: [
                          CounterWithFavBtn(),
                          SizedBox(
                            width: 20,
                          ),
                          AddToCart(burger: widget.burger),
                        ],
                      ),
                      SizedBox(height: 10)
                    ],
                  ),
                ),
                SeniorProductTitleWithImage(burger: widget.burger)
              ],
            ),
          ),
        )
      ],
    );
  }
}
