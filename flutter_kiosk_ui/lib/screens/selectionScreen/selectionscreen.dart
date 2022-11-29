import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_kiosk_ui/models/Menu.dart';
import 'package:flutter_kiosk_ui/screens/Senior/SeniorHome.dart';
import 'package:flutter_kiosk_ui/screens/cart/cart_screen.dart';
import 'package:flutter_kiosk_ui/screens/dialogflow/chat.dart';
import 'package:flutter_kiosk_ui/screens/Senior/SeniorHome.dart';

import '../home/components/emptyappbar.dart';
import '../home/home_screen.dart';

class SelectionScreen extends StatefulWidget {
  //식사방법 버튼
  @override
  _SelectionScreenState createState() => _SelectionScreenState();
}

class _SelectionScreenState extends State<SelectionScreen> {
  FirebaseDatabase _database;
  DatabaseReference reference;
  String _dataaseURL = 'https://realfood-jqhc-default-rtdb.firebaseio.com/';
  Information2 information2;

  @override
  void initState() {
    super.initState();
    _database = FirebaseDatabase(databaseURL: _dataaseURL);
    reference = _database.reference().child("information");

    reference.onChildAdded.listen((event) {
      setState(() {
        information2 = Information2.fromSanpshot(event.snapshot);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: EmptyAppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              child: Text('주문방법을 선택해주세요.',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20.0,
                      fontFamily: 'fifth')),
            ),
            SizedBox(
              height: 50.0,
            ),
            Container(
              height: 150.0,
              width: 200.0,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: RaisedButton(
                  color: Color(0xFFFFE082),
                  elevation: 0.0,
                  onPressed: () {
                    // 창을 닫고 결과로 "Yep!"을 반환합니다.
                    if (information2.age >= 50) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SeniorScreen()),
                      );
                    } else
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => HomeScreen()),
                      );
                  },
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset("assets/icons/store.png",
                            height: 80.0, width: 80.0),
                        SizedBox(
                          height: 10.0,
                        ),
                        Text(
                          '매장',
                          style: TextStyle(fontSize: 25.0, fontFamily: 'fifth', color: Colors.black),
                        )
                      ]),
                ),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Container(
              height: 150.0,
              width: 200.0,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: RaisedButton(
                  color: Color(0xFFFFE082),
                  elevation: 0.0,
                  onPressed: () {
                    // 창을 닫고 결과로 "Nope!"을 반환합니다.
                    if (information2.age >= 50) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SeniorScreen()),
                      );
                    } else
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => HomeScreen()),
                      );
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset("assets/icons/take out.png",
                          height: 80.0, width: 80.0),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        '포장',
                        style: TextStyle(fontSize: 25.0, fontFamily: 'fifth', color: Colors.black),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
