import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_kiosk_ui/constants.dart';
import 'package:flutter_kiosk_ui/models/Menu.dart';
import 'package:flutter_kiosk_ui/models/Product.dart';
import 'package:flutter_kiosk_ui/screens/details/details_screen.dart';
import 'package:provider/provider.dart';

import 'delete.dart';
import 'item_card.dart';

class DrinkBody extends StatefulWidget {
  DrinkBody({Key key}) : super(key: key);
  @override
  _DrinkBodyState createState() => _DrinkBodyState();
}

class _DrinkBodyState extends State<DrinkBody> {
  FirebaseDatabase _database;
  DatabaseReference reference;
  Query referenceQuery;
  String _dataaseURL = 'https://realfood-jqhc-default-rtdb.firebaseio.com/';
  Burger burger;
  List<Burger> burgers = List();

  @override
  void initState() {
    super.initState();
    _database = FirebaseDatabase(databaseURL: _dataaseURL);
    // reference = _database.reference().child("menu_data");
    // reference.onChildAdded.listen(_onEntryAdded);

    // 데이터 목록필터링 방법 = Query

    referenceQuery = _database.reference().child("drink_data");
    referenceQuery.onChildAdded.listen(_onEntryAdded);
  }

  _onEntryAdded(Event event) {
    setState(() {
      burgers.add(Burger.fromSnapshot(event.snapshot));
    });
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
                  itemCount: burgers.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 1,
                    crossAxisSpacing: kDefaultPaddin/1.5,
                    childAspectRatio: 0.89,
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
