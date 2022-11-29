import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_kiosk_ui/constants.dart';
import 'package:flutter_kiosk_ui/models/Menu.dart';
import 'package:flutter_kiosk_ui/models/Product.dart';
import 'package:flutter_kiosk_ui/screens/details/details_screen.dart';
import 'package:provider/provider.dart';

import 'delete.dart';
import 'item_card.dart';

class HomeBody extends StatefulWidget {
  HomeBody({Key key}) : super(key: key);
  @override
  _HomeBodyState createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
 FirebaseDatabase _database;
  DatabaseReference reference;
  Query burgerRef;
  Query drinkRef;
  Query sideRef;
  String _dataaseURL = 'https://realfood-jqhc-default-rtdb.firebaseio.com/';
  Burger burger;
  List<Burger> burgerCarts = List();
  List<Burger> burgers = List();
  String childString;

  @override
  void initState() {
    super.initState();
    _database = FirebaseDatabase(databaseURL: _dataaseURL);
    burgerRef = _database.reference().child("menu_data").limitToFirst(9);
    // drinkRef = _database.reference().child("drink_data");
    // sideRef = _database.reference().child("side_data");

    burgerRef.onChildAdded.listen(_onEntryAdded);
    burgerRef.onChildChanged.listen(_onEntryChanged);
    // drinkRef.onChildAdded.listen(_onEntryAdded);
    // drinkRef.onChildChanged.listen(_onEntryChanged);
    // sideRef.onChildAdded.listen(_onEntryAdded);
    // sideRef.onChildChanged.listen(_onEntryChanged);
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
    if (mounted) {
      setState(() {
        // 지금코드가 메뉴 추가 ok, 삭제 ok, 수량변경 ok, BUT 수량 변경시 리스트 마지막에 추가됨;;;
        burgers.forEach((element) {
          if (element.burger == cartBurger.burger) {
            element.number = cartBurger.number;
            element = cartBurger;
            if ((element.number > 0 && element != cartBurger) ||
                (element.number > 0 &&
                    !burgerCarts.contains(burgers.singleWhere((burgerList) =>
                        burgerList.burger == cartBurger.burger)))) {
              burgerCarts.add(element);
            }
            // else if (element.number > 0 &&
            //     !burgerCarts.contains(burgers.singleWhere(
            //         (burgerList) => burgerList.burger == cartBurger.burger))) {
            //   burgerCarts.add(element);
            // }
          } else if (element.number == 0) {
            databaseReference
                .child("menu_data")
                .child(element.key)
                .update({"number": 0});
            burgerCarts.removeWhere((element) => element.number == 0);
          }
        });
        burgerCarts.forEach((element) {
          if (element.burger == cartBurger.burger &&
              element.number != cartBurger.number) {
            element.number = cartBurger.number;
          }
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          flex: 5,
          child: Padding(
              padding: EdgeInsets.all(20.0),
              //const EdgeInsets.symmetric(horizontal: kDefaultPaddin),
              child: ScrollConfiguration(
                behavior: MyBehavior(),
                child: GridView.builder(
                  physics: new NeverScrollableScrollPhysics(),
                  itemCount: burgers.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 1,
                    crossAxisSpacing: kDefaultPaddin/1.5,
                    childAspectRatio: 0.89
                    ,
                  ),
                  itemBuilder: (context, index) => ItemCard(
                    burger: burgers[index],
                    press: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailsScreen(
                            burger: burgers[index],
                          ),
                        )),
                  ),
                ),
              )),
        ),
      ],
    );
  }
}
