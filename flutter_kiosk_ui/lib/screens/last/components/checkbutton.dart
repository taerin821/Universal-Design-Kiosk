import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_dialogflow/dialogflow_v2.dart';
import 'package:flutter_kiosk_ui/models/Menu.dart';
import 'package:flutter_kiosk_ui/screens/first_Screen/firstscreen.dart';
import 'package:flutter_kiosk_ui/screens/touchscreen/TouchScreen.dart';

class Button extends StatefulWidget {
  @override
  _ButtonState createState() => _ButtonState();
}

class _ButtonState extends State<Button> {
  FirebaseDatabase _database;
  DatabaseReference reference;
  Query drinkRef;
  Query sideRef;
  String _dataaseURL = 'https://realfood-jqhc-default-rtdb.firebaseio.com/';
  Burger burger;
  Information information;
  Information2 information2;
  DatabaseReference informationRef;
  List<Burger> burgerCarts = List();
  List<Burger> burgers = List();
  String childString;

  @override
  void initState() {
    super.initState();
    _database = FirebaseDatabase(databaseURL: _dataaseURL);
    reference = _database.reference().child("menu_data");
    informationRef = _database.reference().child("information");
    drinkRef = _database.reference().child("drink_data");
    sideRef = _database.reference().child("side_data");

    drinkRef.onChildAdded.listen(_onEntryAdded);
    drinkRef.onChildChanged.listen(_onEntryChanged);
    sideRef.onChildAdded.listen(_onEntryAdded);
    sideRef.onChildChanged.listen(_onEntryChanged);

    reference.onChildAdded.listen(_onEntryAdded);
    informationRef.onChildAdded.listen((event) {
      setState(() {
        information = Information.fromSanpshot(event.snapshot);
        information2 = Information2.fromSanpshot(event.snapshot);
      });
    });
    reference.onChildChanged.listen(_onEntryChanged);
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
    return RaisedButton(
      elevation: 20.0,
      onPressed: () {
        burgers.forEach((element) {
          if (element.key.contains("side")) {
            setState(() {
              childString = "side_data";
            });
          } else if (element.key.contains("burger")) {
            setState(() {
              childString = "menu_data";
            });
          } else if (element.key.contains("drink")) {
            setState(() {
              childString = "drink_data";
            });
          }
          databaseReference
              .child(childString)
              .child(element.key)
              .update({"number": 0}).then((_) {
            burgerCarts.remove(element);
          });
        });
        databaseReference
            .child("information")
            .child("data")
            .update({"pay": 0, "place": 0, "chat": 0});
        databaseReference.child("information").child("data2").update(
            {"oderNumber": information2.oderNumber + 1, "age": 0, "card": 0});
        print(information2.oderNumber);
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => TouchScreen()));
      },
      color: Color(0xFFFFa726),
      child: Container(
        width: 300.0,
        height: 30.0,
        alignment: Alignment.center,
        child: Text(
          '확인',
          style: TextStyle(
              color: Colors.white, fontSize: 20.0, fontFamily: 'fifth'),
        ),
      ),
    );
  }
}
