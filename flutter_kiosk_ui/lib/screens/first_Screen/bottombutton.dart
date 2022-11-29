import 'package:camera/camera.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_kiosk_ui/models/Menu.dart';
import 'package:flutter_kiosk_ui/screens/camera/cameraScreen_.dart';
import 'package:flutter_kiosk_ui/screens/cart/cart_screen.dart';
import 'package:flutter_kiosk_ui/screens/dialogflow/chat.dart';

class BottomButton extends StatefulWidget {
  //시작화면 다른 선택버튼
  @override
  _BottomButtonState createState() => _BottomButtonState();
}

class _BottomButtonState extends State<BottomButton> {
  // List<CameraDescription> cameras;
  // CameraController controller;
  // bool isReady = false;
  // bool hasCart = false;

  // @override
  // void initState() {
  //   super.initState();
  //   setupCameras();
  // }

  FirebaseDatabase _database;
  DatabaseReference reference;
  String _dataaseURL = 'https://realfood-jqhc-default-rtdb.firebaseio.com/';
  Information information;

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
    reference.onChildAdded.listen(_voiceOder);
    reference.onChildChanged.listen(_voiceOder);
  }

  _voiceOder(Event event) {
    setState(() {
      information = Information.fromSanpshot(event.snapshot);
      if (information.chat == 1) {
        print(information.chat);
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => ChatBot()));
        // return CartScreen();
      }
    });
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.blue,
      elevation: 0,
      title: Column(
        children: [
          Text(
            "종이주문서",
            style: TextStyle(color: Colors.black),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            SizedBox(
              height: 50.0,
              width: 100.0,
              child: RaisedButton(
                color: Color(0xFFf6ddbd),
                child: Text(
                  '음성주문',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15.0,
                      fontFamily: 'fifth', color: Colors.black),
                ),
                elevation: 5.0,
                onLongPress: () {
                  Navigator.pop(context);
                },
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ChatBot()));
                },
              ),
            ),
            SizedBox(
              height: 50.0,
              width: 100.0,
              child: RaisedButton(
                color: Color(0xFFf6ddbd),
                child: Text('종이 주문서',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 13.0,
                        fontFamily: 'fifth', color: Colors.black)),
                elevation: 5.0,
                onLongPress: () {
                  Navigator.pop(context);
                },
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => CameraScreen()));
                },
              ),
            )
          ]),
    );
  }

  // Future<void> setupCameras() async {
  //   try {
  //     cameras = await availableCameras();
  //     controller = new CameraController(cameras[0], ResolutionPreset.medium);
  //     await controller.initialize();
  //   } on CameraException catch (_) {
  //     setState(() {
  //       isReady = false;
  //     });
  //   }
  //   setState(() {
  //     isReady = true;
  //   });
  // }

  // Widget camera(BuildContext context) {
  //   if (!isReady && !controller.value.isInitialized) {
  //     return Center(
  //       child: CircularProgressIndicator(),
  //     );
  //   }
  //   return Scaffold(
  //     appBar: buildAppBar(context),
  //     body: Center(
  //       child: Column(
  //         children: <Widget>[
  //           AspectRatio(
  //             aspectRatio: controller.value.aspectRatio,
  //             child: CameraPreview(controller),
  //           ),
  //           RaisedButton(
  //               child: Text("주문 확인"),
  //               elevation: 0.0,
  //               onPressed: () {
  //                 Navigator.push(context,
  //                     MaterialPageRoute(builder: (context) => CartScreen()));
  //               })
  //         ],
  //       ),
  //     ),
  //   );
  // }
}
