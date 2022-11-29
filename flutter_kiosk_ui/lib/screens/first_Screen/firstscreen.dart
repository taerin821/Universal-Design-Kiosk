import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_kiosk_ui/screens/selectionScreen/selectionbutton.dart';

import '../home/components/emptyappbar.dart';
import 'bottombutton.dart';

List<CameraDescription> cameras;

class FirstScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: EmptyAppBar(),

      //title: Text('Returning Data Demo'),

      body: Column(
        children: [
          // Image.asset("assets/images/광고.png", height: 400.0, width: 400.0),
          SizedBox(height: 30.0),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // Image.asset('assets/go.png', height: 450.0, width: 600.0)
              Image.asset("assets/images/광고_2.png", height: 400.0, width: 400.0)
            ],
          ),
          SizedBox(
            height: 10.0,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
            child: Center(
              child: Column(children: <Widget>[
                Text(
                  '주문하시려면 주문하기을 눌러주세요.',
                  style: TextStyle(
                      fontSize: 20, color: Colors.black, fontFamily: 'fifth'),
                ),
                SizedBox(
                  height: 10.0,
                ),
                SelectionButton(),
                SizedBox(
                  height: 10.0,
                ),
                BottomButton()
              ]),
            ),
          ),
        ],
      ),
    );
  }
}
