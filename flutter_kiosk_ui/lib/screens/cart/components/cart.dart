import 'package:flutter/material.dart';

class Cart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.fromLTRB(15.0, 5.0, 0.0, 0.0),
        child: Stack(children: <Widget>[
          Positioned(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
              child: Container(
                width: 380.0,
                height: 80.0,
                decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.all(Radius.circular(18))),
              ),
            ),
          ),
          Positioned(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(300.0, 5.0, 0.0, 0.0),
              child: Container(
                height: 70.0,
                width: 70.0,
                child: RaisedButton(
                    child: Text(
                      '결제하기',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15.0,
                        //fontWeight: FontWeight.w300),
                      ),
                      textAlign: TextAlign.center,
                    ),
                    color: Colors.redAccent[700],
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    onPressed: () {
                      //            Navigator.push(
                      //              context,
                      //            MaterialPageRoute(
                      //              builder: (context) =>
                      //                OderCheckScreen()));
                    }),
              ),
            ),
          ),
          Positioned(
              child: Padding(
            padding: const EdgeInsets.fromLTRB(13.0, 12.0, 0.0, 0.0),
            child: Icon(
              Icons.shopping_cart_outlined,
              size: 60.0,
            ),
          )),
          //ListView.separated()
        ]));
  }
}
