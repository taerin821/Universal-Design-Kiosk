import 'package:flutter/material.dart';
import 'package:flutter_kiosk_ui/models/Cart.dart';
import 'package:flutter_kiosk_ui/models/Menu.dart';
import 'package:flutter_kiosk_ui/models/Product_provider.dart';
import 'package:flutter_kiosk_ui/screens/cart/cart_screen.dart';
import 'package:flutter_kiosk_ui/screens/details/components/cart_counter.dart';
import 'package:flutter_kiosk_ui/screens/home/components/body.dart';
import 'package:flutter_kiosk_ui/screens/details/components/body.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_kiosk_ui/models/Product.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../../../constants.dart';

class AddToCart extends StatefulWidget {
  AddToCart({Key key, this.product, this.burger}) : super(key: key);

  final Product product;
  Burger burger;

  @override
  _AddToCartState createState() => _AddToCartState();
}

class _AddToCartState extends State<AddToCart> {
  String childString;

  /// 경로 설정
  Widget updateRef() {
    if (widget.burger.key.contains("side")) {
      setState(() {
        childString = "side_data";
      });
    } else if (widget.burger.key.contains("burger")) {
      setState(() {
        childString = "menu_data";
      });
    } else if (widget.burger.key.contains("drink")) {
      setState(() {
        childString = "drink_data";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    NumCounter numCounter = Provider.of<NumCounter>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Stack(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
              // margin: EdgeInsets.only(right: kDefaultPaddin),
              // color: Colors.deepOrangeAccent[400],
              height: 50,
              width: 175,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                border: Border.all(
                  color: Colors.deepOrangeAccent[400],
                ),
              ),
              child: TextButton.icon(
                onPressed: () {
                  updateRef();
                  Navigator.pop(context);
                  databaseReference
                      .child(childString)
                      .child(widget.burger.key)
                      .update({
                    "number": numCounter.numOfItem,
                  });
                  numCounter.numOfItem = 1;
                  Fluttertoast.showToast(
                      msg: "장바구니에 상품이 추가 되었습니다",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.orange,
                      textColor: Colors.black,
                      fontSize: 15.0);
                },
                icon: SvgPicture.asset(
                  "assets/icons/add_to_cart.svg",
                  color: Colors.deepOrangeAccent[400],
                ),
                label: Text("장바구니 담기",
                    style: Theme.of(context)
                        .textTheme
                        .subtitle2
                        .copyWith(fontFamily: 'fifth', color: Colors.black)),
              )),
        ],
      ),
    );
  }
}
