import 'package:flutter/material.dart';
import 'package:flutter_kiosk_ui/models/Menu.dart';
import 'package:flutter_kiosk_ui/models/Product.dart';

import '../../../constants.dart';

class ProductTitleWithImage extends StatelessWidget {
  ProductTitleWithImage({
    Key key,
    this.burger,
  }) : super(key: key);

  final Burger burger;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kDefaultPaddin),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "Menu",
            style: TextStyle(color: Colors.white, fontFamily: 'fifth'),
          ),
          Text(
            burger.burger,
            style: Theme.of(context).textTheme.headline4.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontFamily: 'fifth'),
          ),
          SizedBox(height: kDefaultPaddin),
          Row(
            children: <Widget>[
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                        text: "가격\n", style: TextStyle(fontFamily: 'fifth',color: Colors.black)),
                    TextSpan(
                      text: "${burger.price}원",
                      style: Theme.of(context).textTheme.headline4.copyWith(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'fifth'),
                    )
                  ],
                ),
              ),
              SizedBox(width: kDefaultPaddin),
              Expanded(
                child: Hero(
                  tag: "${burger.id}",
                  child: Image.asset(
                    burger.image,
                    fit: BoxFit.fill,
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
