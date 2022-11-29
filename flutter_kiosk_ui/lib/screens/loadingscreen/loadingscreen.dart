import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_kiosk_ui/models/Menu.dart';
import 'package:flutter_kiosk_ui/screens/first_Screen/firstscreen.dart';
import 'package:flutter_kiosk_ui/screens/home/components/emptyappbar.dart';
import 'package:flutter_kiosk_ui/screens/loadingscreen/components/body.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
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
    //     information2 = Information2.fromSanpshot(event.snapshot);
    //   });
    // });
    //임시
    // reference.onChildAdded.listen(_ageDetection);
    reference.onChildChanged.listen(_ageDetection);
  }

  _ageDetection(Event event) {
    if (mounted) {
      setState(() {
        information2 = Information2.fromSanpshot(event.snapshot);
        if (information2.age != 0 && information2.card == 0) {
          print(information2.age);
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => FirstScreen()));
          // return CartScreen();
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white, appBar: EmptyAppBar(), body: Body());
  }
}
