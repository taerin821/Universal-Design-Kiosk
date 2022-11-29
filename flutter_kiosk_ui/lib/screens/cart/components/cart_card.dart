import 'package:flutter/material.dart';
import 'package:flutter_kiosk_ui/models/Cart.dart';
import 'package:flutter_kiosk_ui/models/Menu.dart';

import '../../../constants.dart';

class CartCard extends StatelessWidget {
  const CartCard({Key key, this.cart, this.burger}) : super(key: key);

  final Cart cart;
  final Burger burger;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 88,
          child: AspectRatio(
            aspectRatio: 0.88,
            child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Color(0xFFF5F6F9),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Image.asset(burger.image),
            ),
          ),
        ),
        SizedBox(width: 20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              burger.burger,
              style: TextStyle(
                  color: Colors.black, fontSize: 16, fontFamily: 'fifth'),
              maxLines: 2,
            ),
            SizedBox(height: 10),
            Text.rich(
              TextSpan(
                text: "${burger.price}원",
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                    fontFamily: 'fifth'),
                children: [
                  TextSpan(
                      text: " x${burger.number}",
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1
                          .copyWith(fontFamily: 'fifth', color: Colors.black)),
                ],
              ),
            ),
          ],
        )
      ],
    );
  }
}
