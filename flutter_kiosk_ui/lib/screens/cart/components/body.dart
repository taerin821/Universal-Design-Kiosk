import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_kiosk_ui/models/Menu.dart';
import 'package:flutter_kiosk_ui/screens/home/components/delete.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_kiosk_ui/models/Cart.dart';

import 'cart_card.dart';

class Body extends StatefulWidget {
  Burger burger;
  List<Burger> burgerCarts = List();

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
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
    drinkRef =_database.reference().child("drink_data");
    sideRef =_database.reference().child("side_data");

    burgerRef.onChildAdded.listen(_onEntryAdded);
    burgerRef.onChildChanged.listen(_onEntryChanged);
    drinkRef.onChildAdded.listen(_onEntryAdded);
    drinkRef.onChildChanged.listen(_onEntryChanged);
    sideRef.onChildAdded.listen(_onEntryAdded);
    sideRef.onChildChanged.listen(_onEntryChanged);

    // Future.delayed(const Duration(seconds : 1),(){
    //   databaseReference.child("information").child("data").update({'place' : 3});
    // });
    

    
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
    Burger cartBurger = Burger.fromSnapshot(event.snapshot);
    setState(() {
      // 지금코드가 메뉴 추가 ok, 삭제 ok, 수량변경 ok, BUT 수량 변경시 리스트 마지막에 추가됨;;;
      burgers.forEach((element) {
        if (element.burger == cartBurger.burger) {
          element.number = cartBurger.number;
          if (element.number > 0) {
            burgerCarts.add(element);
          } else if (element.number == 0) {
            databaseReference
                .child("menu_data")
                .child(element.key)
                .update({"number": 0});
            burgerCarts.removeWhere((element) => element.number == 0);
          }
        }
      });
      burgerCarts.forEach((element) {
        // if (element.number == 0) {
        //   databaseReference
        //       .child("menu_data")
        //       .child(element.key)
        //       .update({"number": 0});
        //   burgerCarts.remove(element);
        // }
        if (element.burger == cartBurger.burger &&
            element.number != cartBurger.number) {
          element.number = cartBurger.number;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: ScrollConfiguration(
        behavior: MyBehavior(),
        child: ListView.builder(
          itemCount: burgerCarts.length,
          itemBuilder: (context, index) => Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            
              child: CartCard(burger: burgerCarts[index]),
            ),
          ),
        ));
      
    
  }
}
