import 'package:flutter_kiosk_ui/screens/home/components/emptyappbar.dart';
import 'package:flutter_kiosk_ui/screens/loadingscreen/loadingscreen.dart';
import 'package:flutter/material.dart';

class TouchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => LoadingScreen()));
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: EmptyAppBar(),

        //title: Text('Returning Data Demo'),

        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Image.asset("assets/images/엠블럼.jpg", height: 300.0, width: 300.0),
              Text(
                '사용을 원하시면 화면을 터치해 주세요.',
                style: TextStyle(
                    fontSize: 20, color: Colors.black, fontFamily: 'fifth'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
