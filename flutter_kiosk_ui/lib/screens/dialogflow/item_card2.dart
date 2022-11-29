import 'package:flutter/material.dart';
import 'package:flutter_kiosk_ui/models/Menu.dart';
import 'package:flutter_kiosk_ui/models/Product.dart';

class ItemCard2 extends StatelessWidget {
  final Burger burger;
  final Function press;

  ItemCard2({
    Key key,
    this.burger,
    this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Column(
            children: [
              Container(
                // For  demo we use fixed height  and width
                // Now we dont need them
                height: 110,
                width: 100,
                decoration: BoxDecoration(
                  color: Colors.grey[300], //메뉴판 색
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Image.asset(burger.image),SizedBox(
            height: 0.0,
          ),
          Text(
            burger.burger,
            semanticsLabel: '${burger.burger}',
            style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontFamily: 'fifth'), //메뉴 버거 이름색
          ),
          Text(
            "${burger.price}원",style: TextStyle(fontFamily: 'fifth',color: Colors.black),
            //style: TextStyle(fontWeight: FontWeight.bold),
          ),
                  ],
                ),
              ),
            ],
          ),
          
        ],
      ),
    );
  }
}
