import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_kiosk_ui/models/Menu.dart';
import 'package:flutter_kiosk_ui/screens/Senior/components/emptyappbar.dart';
import 'package:flutter_kiosk_ui/screens/last/payment_screen.dart';

class PayScreen extends StatefulWidget {
  @override
  _PayScreenState createState() => _PayScreenState();
}

class _PayScreenState extends State<PayScreen> {
  FirebaseDatabase _database;
  DatabaseReference reference;
  String _dataaseURL = 'https://realfood-jqhc-default-rtdb.firebaseio.com/';
  Information2 information2;

  @override
  void initState() {
    super.initState();
    _database = FirebaseDatabase(databaseURL: _dataaseURL);
    reference = _database.reference().child("information");

    // reference.onChildAdded.listen((event) {
    //   setState(() {
    //     information = Information.fromSanpshot(event.snapshot);
    //   });
    // });
    //임시
    reference.onChildAdded.listen(_card);
    reference.onChildChanged.listen(_card);
  }

  _card(Event event) {
    // Information2 information2  = Information2.fromSnapshot(event.snapshot);
    setState(() {
      information2 = Information2.fromSanpshot(event.snapshot);
      if (information2.card == 1) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => PaymentScreen()));
        // return CartScreen();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: EmptyAppBar(),

        //title: Text('Returning Data Demo'),

        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
                height: 150.0,
                width: 150.0,
                child: Image.asset("assets/images/card1.png")),
            SizedBox(
              height: 50.0,
            ),
            Text(
              '카드를 투입구에 넣어주세요.',
              style: TextStyle(
                  fontSize: 20.0, color: Colors.black, fontFamily: 'fifth'),
            )
          ],
        )));
  }
}
//결제완료값 받는곳
//Text('카드를 챙겨주세요.',style: TextStyle(fontSize: 20.0, color: Colors.black),)
