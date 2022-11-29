import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_kiosk_ui/models/Menu.dart';

import 'package:flutter_kiosk_ui/screens/home/home_screen.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_kiosk_ui/constants.dart';
import 'package:flutter_kiosk_ui/models/Product.dart';
import 'package:flutter_kiosk_ui/screens/details/components/senior/senior_Details_body.dart';

import 'package:flutter_kiosk_ui/screens/details/components/add_to_cart.dart';

class SeniorDetailsScreen extends StatefulWidget {
  final Product product;
  Burger burger;

  SeniorDetailsScreen({Key key, this.burger, this.product}) : super(key: key);

  @override
  _SeniorDetailsScreenState createState() => _SeniorDetailsScreenState();
}

class _SeniorDetailsScreenState extends State<SeniorDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // each product have a color
      backgroundColor: Color(0xFFFFA726),
      appBar: seniarAppbar(context),
      body: SeniorDetailsBody(burger: widget.burger),
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

  Widget seniarAppbar(BuildContext context) {
    return AppBar(
      backgroundColor: Color(0xFFFFA726),
      elevation: 0,
      // title: Text("주문확인" ,)
      // Row(
      //   crossAxisAlignment: CrossAxisAlignment.center,
      //   mainAxisAlignment: MainAxisAlignment.start,
      //   children: [
      //     IconButton(
      //       icon: Image.asset(
      //         "assets/icons/fish.png",
      //         color: Colors.black,
      //       ),
      //       onPressed: () {},
      //     ),
      //     Padding(
      //       padding: const EdgeInsets.all(8.0),
      //       child: Container(
      //           child: Padding(
      //               padding: const EdgeInsets.all(3.0),
      //               child: Text(
      //                   "바로 주문을 원하시면 결제하기 버튼을,\n 다른 상품을 더 추가하고 싶으시면 장바구니 버튼을 눌러주세요",
      //                   textAlign: TextAlign.center,
      //                   style: TextStyle(fontSize: 12, color: Colors.black))),
      //           height: 40,
      //           width: 200,
      //           decoration: BoxDecoration(
      //             color: Colors.grey[300], //메뉴판 색
      //             borderRadius: BorderRadius.circular(10),
      //           )),
      //     ),
      // ],
      // ),
    );
  }
}
