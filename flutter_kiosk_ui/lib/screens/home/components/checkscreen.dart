import 'package:flutter/material.dart';
import 'package:flutter_kiosk_ui/models/Product.dart';
import 'package:flutter_kiosk_ui/screens/last/components/payment.dart';

class OderCheckScreen extends StatelessWidget {
  const OderCheckScreen({
    Key key,
    this.product,
  }) : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title: Text('주문 확인'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '결제 하시겠습니까?',
              style: TextStyle(fontSize: 26),
            ),
            Container(
              height: 450,
              width: 250,
              decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.all(Radius.circular(18))),
            ),
            SizedBox(
              height: 30.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                RaisedButton(
                  child: Text(
                    '취소하기',
                    style: TextStyle(fontSize: 18),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                RaisedButton(
                  child: Text(
                    '주문하기',
                    style: TextStyle(fontSize: 18),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Payment()),
                    );
                  },
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
