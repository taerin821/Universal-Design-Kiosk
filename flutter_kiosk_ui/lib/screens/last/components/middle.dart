import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_kiosk_ui/models/Menu.dart';
import 'package:flutter_kiosk_ui/models/Product.dart';

class Middle extends StatefulWidget {
  final Product product;

  const Middle({Key key, this.product}) : super(key: key);

  @override
  _MiddleState createState() => _MiddleState();
}

class _MiddleState extends State<Middle> {
  FirebaseDatabase _database;
  DatabaseReference burgerRef;
  Query drinkRef;
  Query sideRef;
  String _dataaseURL = 'https://realfood-jqhc-default-rtdb.firebaseio.com/';
  Burger burger;
  List<Burger> burgerCarts = List();
  List<Burger> burgers = List();

  @override
  void initState() {
    super.initState();
    _database = FirebaseDatabase(databaseURL: _dataaseURL);
    burgerRef = _database.reference().child("menu_data");
    drinkRef = _database.reference().child("drink_data");
    sideRef = _database.reference().child("side_data");

    burgerRef.onChildAdded.listen(_onEntryAdded);
    burgerRef.onChildChanged.listen(_onEntryChanged);
    drinkRef.onChildAdded.listen(_onEntryAdded);
    drinkRef.onChildChanged.listen(_onEntryChanged);
    sideRef.onChildAdded.listen(_onEntryAdded);
    sideRef.onChildChanged.listen(_onEntryChanged);
  }

  _onEntryAdded(Event event) {
    setState(() {
      burgers.add(Burger.fromSnapshot(event.snapshot));
      burgers.forEach((element) {
        if (element.number > 0 && !burgerCarts.contains(element)) {
          burgerCarts.add(element);
        }
      });
    });
  }

  _onEntryChanged(Event event) {
    setState(() {
      burgers.add(Burger.fromSnapshot(event.snapshot));
      burgers.forEach((element) {
        if (element.number != 0 && !burgerCarts.contains(element)) {
          burgerCarts.add(element);
        } else if (element.number == 0 && burgerCarts.contains(element)) {
          databaseReference
              .child("menu_data")
              .child(element.key)
              .update({"number": 0}).then((_) {
            burgerCarts.remove(element);
          });
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    int totalPrice = burgerCarts.fold(
        0, (total, element) => total + (element.number * element.price));
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        Text(
          '총 결제금액',
          style: TextStyle(
              fontSize: 25.0,
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontFamily: 'fifth'),
        ),
        Text(
          '${totalPrice}원', //총 금액 값
          style: TextStyle(
              fontSize: 25.0,
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontFamily: 'fifth'),
        ),
      ],
    );
  }
}
