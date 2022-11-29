import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_kiosk_ui/models/Cart.dart';
import 'package:flutter_kiosk_ui/models/Menu.dart';
import 'package:flutter_kiosk_ui/screens/last/payment_screen.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:flutter_kiosk_ui/screens/home/components/default_button.dart';
import 'package:flutter_kiosk_ui/screens/card_In/payment.dart';

import 'package:flutter_kiosk_ui/screens/cart/components/body.dart';

import '../../../constants.dart';

class CheckoutCard extends StatefulWidget {
  CheckoutCard({Key key, this.burger}) : super(key: key);
  Burger burger;

  @override
  _CheckoutCardState createState() => _CheckoutCardState();
}

class _CheckoutCardState extends State<CheckoutCard> {
  FirebaseDatabase _database;
  DatabaseReference burgerRef;
  Query drinkRef;
  Query sideRef;
  String _dataaseURL = 'https://realfood-jqhc-default-rtdb.firebaseio.com/';
  Burger burger;
  List<Burger> burgerCarts = List();
  List<Burger> burgers = List();

  @override
  void initState() {
    super.initState();
    _database = FirebaseDatabase(databaseURL: _dataaseURL);
    burgerRef = _database.reference().child("menu_data");
    drinkRef = _database.reference().child("drink_data");
    sideRef = _database.reference().child("side_data");

    burgerRef.onChildAdded.listen(_onEntryAdded);
    burgerRef.onChildChanged.listen(_onEntryChanged);
    drinkRef.onChildAdded.listen(_onEntryAdded);
    drinkRef.onChildChanged.listen(_onEntryChanged);
    sideRef.onChildAdded.listen(_onEntryAdded);
    sideRef.onChildChanged.listen(_onEntryChanged);
  }

  _onEntryAdded(Event event) {
    setState(() {
      burgers.add(Burger.fromSnapshot(event.snapshot));
      burgers.forEach((element) {
        if (element.number > 0 && !burgerCarts.contains(element)) {
          burgerCarts.add(element);
        }
      });
    });
  }

  _onEntryChanged(Event event) {
    Burger cartBurger = Burger.fromSnapshot(event.snapshot);
    setState(() {
      // 지금코드가 메뉴 추가 ok, 삭제 ok, 수량변경 ok, BUT 수량 변경시 리스트 마지막에 추가됨;;;
      burgers.forEach((element) {
        if (element.burger == cartBurger.burger) {
          element.number = cartBurger.number;
          if (element.number > 0) {
            burgerCarts.add(element);
          } else if (element.number == 0) {
            burgerCarts.removeWhere((element) => element.number == 0);
          }
        }
      });
      burgerCarts.forEach((element) {
        if (element.burger == cartBurger.burger &&
            element.number != cartBurger.number) {
          element.number = cartBurger.number;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    //  메뉴추가시 totalPrice 업데이트 안됨
    int totalPrice = burgerCarts.fold(
        0, (total, element) => total + (element.number * element.price));

    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 15,
        horizontal: 30,
      ),
      // height: 174,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, -15),
            blurRadius: 20,
            color: Color(0xFFDADADA).withOpacity(0.15),
          )
        ],
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    color: Color(0xFFF5F6F9),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: SvgPicture.asset("assets/icons/receipt.svg"),
                ),
                Spacer(),
                Text("결제하기을 눌러 주세요", style: TextStyle(fontFamily: 'fifth', color: Colors.black)),
                const SizedBox(width: 10),
                Icon(
                  Icons.keyboard_arrow_down_outlined,
                  size: 25,
                  color: Colors.red,
                )
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text.rich(
                  TextSpan(
                    text: "총 가격:\n",
                    style: TextStyle(fontFamily: 'fifth', color: Colors.black),
                    children: [
                      TextSpan(
                        text: "${totalPrice}원",
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            fontFamily: 'fifth'),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 190,
                  child: DefaultButton(
                    text: "결제하기",
                    
                    press: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => PayScreen()
                              //paymentScreen()
                              ));
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
