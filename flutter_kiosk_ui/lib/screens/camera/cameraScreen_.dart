import 'dart:async';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:flutter_kiosk_ui/models/Menu.dart';
import 'package:flutter_kiosk_ui/screens/cart/cart_screen.dart';
import 'package:provider/provider.dart';
import 'cartlistbody.dart';

// List<CameraDescription> cameras;

class CameraScreen extends StatefulWidget {
  @override
  CameraState createState() => CameraState();
}

class CameraState extends State<CameraScreen> {
  List<CameraDescription> cameras;
  CameraController controller;
  bool isReady = false;

  // Firebase
  FirebaseDatabase _database;
  DatabaseReference reference;
  String _dataaseURL = 'https://realfood-jqhc-default-rtdb.firebaseio.com/';
  Burger burger;
  List<Burger> burgerCarts = List();
  List<Burger> burgers = List();
  bool hasOder = false;

  @override
  void initState() {
    super.initState();
    setupCameras();

    _database = FirebaseDatabase(databaseURL: _dataaseURL);
    reference = _database.reference().child("menu_data");

    // reference.onChildChanged.listen(_paperOder);
  }

  _paperOder(Event event) {
    Burger oder = Burger.fromSnapshot(event.snapshot);
    setState(() {
      if (oder.number > 0) {
        hasOder = true;
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => CartScreen()));
        // return CartScreen();
      }
    });
  }

  Future<void> setupCameras() async {
    try {
      cameras = await availableCameras();
      controller = new CameraController(cameras[0], ResolutionPreset.medium);
      await controller.initialize();
    } on CameraException catch (_) {
      setState(() {
        isReady = false;
      });
    }
    setState(() {
      isReady = true;
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  void deactivate() {
    controller.dispose();
    super.deactivate();
  }

  Widget build(BuildContext context) {
    if (!isReady) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    return Scaffold(
      appBar: buildAppBar(context),
      body: Center(

          // AspectRatio(
          // aspectRatio: 1 / 5,
          // child:

          child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        // crossAxisAlignment: CrossAxisAlignment.end,
        children: [
           SizedBox(height: 30.0),
          Container(
            decoration: BoxDecoration(border: Border.all(width:5, color:Color(0xFFFFA726))),
            child: CameraPreview(controller),
            height: 400,
            width: 300,
          ),
          SizedBox(height: 10.0),
          Text(
            "종이주문서 투입 후 '인식하기' 버튼을 클릭해 주세요",
            style: TextStyle(fontWeight: FontWeight.bold,fontFamily: 'fifth',color: Colors.black),
          ),
          SizedBox(height: 10.0),
          RaisedButton(
              child: Text(
                "인식 하기",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,fontFamily: 'fifth'),
              ),
              color: Color(0xFFFFA726).withAlpha(200),
              elevation: 0.0,
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(
                    context, "cart", (route) => false);
                Future.delayed(const Duration(seconds: 1), () {
                  databaseReference
                      .child("information")
                      .child("data")
                      .update({"place": 3});
                  print('종이주문서 인식 시작');
                });
              }),
          // Expanded(child: CartListBody()),
          // Container(height: 128, width: 400, child:

          // )
        ],
      )),
      // ),
      // CartListBody()
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Color(0xFFFFA726),
      elevation: 0,
      title: Column(
        children: [
          Text(
            "종이주문서",
            style: TextStyle(color: Colors.black,fontFamily: 'fifth'),
          ),
        ],
      ),
    );
  }
}
