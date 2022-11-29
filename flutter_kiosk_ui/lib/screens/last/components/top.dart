import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_kiosk_ui/models/Menu.dart';

class Top extends StatefulWidget {
  @override
  _TopState createState() => _TopState();
}

class _TopState extends State<Top> {
  Information2 information2;
  FirebaseDatabase _database;
  DatabaseReference reference;
  DatabaseReference informationRef;

  String _dataaseURL = 'https://realfood-jqhc-default-rtdb.firebaseio.com/';
  @override
  void initState() {
    super.initState();
    _database = FirebaseDatabase(databaseURL: _dataaseURL);
    informationRef = _database.reference().child("information");

    informationRef.onChildAdded.listen((event) {
      setState(() {
        information2 = Information2.fromSanpshot(event.snapshot);
      });
    });
    // reference.onChildChanged.listen(_onEntryChanged);
  }

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.start, children: <
        Widget>[
      Icon(
        Icons.check_circle,
        color: Color(0xFFFFa726),
        size: 40,
      ),
      SizedBox(
        height: 10.0,
      ),
      Text(
        '결제가 완료되었습니다.',
        style:
            TextStyle(fontSize: 20.0, color: Colors.black, fontFamily: 'fifth'),
      ),
      SizedBox(
        height: 10.0,
      ),
      Text(
        '카드를 챙겨주세요.',
        style:
            TextStyle(fontSize: 20.0, color: Colors.black, fontFamily: 'fifth'),
      ),
      SizedBox(
        height: 50.0,
      ),
      Text(
        '주문 번호',
        style:
            TextStyle(fontSize: 15.0, color: Colors.black, fontFamily: 'fifth'),
      ),
      SizedBox(
        height: 20.0,
      ),
      Text(
        // information.oderNum.toString(), //주문 번호
        "${information2.oderNumber}",

        style:
            TextStyle(fontSize: 50.0, color: Colors.black, fontFamily: 'fifth'),
      )
    ]);
  }
}
