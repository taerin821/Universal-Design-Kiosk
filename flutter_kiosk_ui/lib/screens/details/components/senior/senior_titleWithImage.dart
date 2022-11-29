import 'package:flutter/material.dart';
import 'package:flutter_kiosk_ui/models/Menu.dart';
import 'package:flutter_kiosk_ui/models/Product.dart';
import 'package:flutter_kiosk_ui/models/Product_provider.dart';

import 'package:provider/provider.dart';

import 'package:flutter_kiosk_ui/constants.dart';

class SeniorProductTitleWithImage extends StatelessWidget {
  SeniorProductTitleWithImage({
    Key key,
    this.burger,
  }) : super(key: key);

  final Burger burger;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      // height: ,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Image.asset(
                          "assets/images/cashier.png",
                          height: 40,
                        ),
                        //  Icon(
                        //   Icons.support_agent,
                        //   size: 45,
                        //   color: Colors.black.withAlpha(200),
                        // ),
                      ),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Container(
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Text(
                            "수량을 선택한 후 \n장바구니 담기 버튼을 눌러 주세요",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 13.5, fontFamily: 'fifth'
                                // fontWeight: FontWeight.bold
                                ),
                          ),
                        ),
                        height: 50,
                        width: 270,
                        decoration: BoxDecoration(
                          color: Colors
                              .white, //설명 배경 색 Colors.deepOrange[500]Colors.grey[300],
                          borderRadius: BorderRadius.circular(8),
                        )),
                  ],
                ),
                // SizedBox(height: 50),

                SizedBox(height: 180),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    RichText(
                      text: TextSpan(children: [
                        TextSpan(
                            text: "Menu \n",
                            style: Theme.of(context)
                                .textTheme
                                .subtitle1
                                .copyWith(
                                    color: Colors.black, fontFamily: 'fifth')),
                        TextSpan(
                          text: burger.burger,
                          style: Theme.of(context).textTheme.headline4.copyWith(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'fifth'),
                        ),
                      ]),
                    ),
                    SizedBox(width: 50),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                              text: "가격\n",
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle1
                                  .copyWith(
                                      color: Colors.black,
                                      fontFamily: 'fifth')),
                          TextSpan(
                            text: "${burger.price}원",
                            style: Theme.of(context)
                                .textTheme
                                .headline4
                                .copyWith(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'fifth'),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                // SizedBox(width: kDefaultPaddin),
              ],
            )),
        Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(160, 80, 1, 350),
                child: Hero(
                  tag: "${burger.id}",
                  child: Image.asset(
                    burger.image,
                    height: 60,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
