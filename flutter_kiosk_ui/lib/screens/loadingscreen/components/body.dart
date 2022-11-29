import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_kiosk_ui/models/Menu.dart';
import 'package:flutter_kiosk_ui/screens/first_Screen/firstscreen.dart';

class Body extends StatefulWidget {
  // final Product product;

  // const Body({Key key, this.product}) : super(key: key);
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    // It provide us total height and width
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: <Widget>[
              // SizedBox(
              //   height: 100.0,
              //   width: 100.0,
              //   child: ImageIcon(AssetImage('assets/icons/user-images.png'))),

              SizedBox(
                width: 150.0,
                height: 150.0,
                child: CircularProgressIndicator(
                  strokeWidth: 10.0,
                  //높이
                  backgroundColor: Colors.white,
                  valueColor:
                      new AlwaysStoppedAnimation<Color>(Color(0xFFFFa726)),
                ),
              ),
              SizedBox(
                height: 100.0,
              ),
              Text(
                '얼굴 인식이 진행중입니다.',
                style: TextStyle(
                    color: Colors.black, fontSize: 25.0, fontFamily: 'fifth'),
              ),
              SizedBox(
                height: 20.0,
              ),
              Text(
                '스위치 사용 금지!',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'fifth'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
