import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_kiosk_ui/models/Menu.dart';
import 'package:flutter_kiosk_ui/screens/selectionScreen/selectionscreen.dart';
import 'package:flutter_kiosk_ui/screens/home/home_screen.dart';

class SelectionButton extends StatefulWidget {
  //주문하기 선택 버튼
  @override
  _SelectionButtonState createState() => _SelectionButtonState();
}

class _SelectionButtonState extends State<SelectionButton> {
  // FirebaseDatabase _database;
  // DatabaseReference reference;
  // String _dataaseURL = 'https://realfood-jqhc-default-rtdb.firebaseio.com/';
  // Information2 information2;

  //  @override
  // void initState() {
  //   super.initState();
  //   _database = FirebaseDatabase(databaseURL: _dataaseURL);
  //   reference = _database.reference().child("information");

  //   reference.onChildChanged.listen((event) {
  //     setState(() {
  //       information2 = Information2.fromSanpshot(event.snapshot);
  //     });
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      width: 254,
      child: RaisedButton(
        color: Colors.deepOrange[500],
        onPressed: () {
          // age 업데이트 후 주문진행가능
          // if(information2.age != 0){
          // print(information2.age);
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SelectionScreen()),
          );
          // }
        },
        child: Container(
          width: 300,
          height: 80,
          alignment: Alignment.center,
          child: Text(
            '주문하기',
            style: TextStyle(
                fontSize: 35.0, color: Colors.white, fontFamily: 'fifth'),
          ),
        ),
      ),
    );
  }
}
