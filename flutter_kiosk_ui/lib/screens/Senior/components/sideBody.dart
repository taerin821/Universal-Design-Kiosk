import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_kiosk_ui/constants.dart';
import 'package:flutter_kiosk_ui/models/Menu.dart';
import 'package:flutter_kiosk_ui/models/Product.dart';
import 'package:flutter_kiosk_ui/screens/details/components/senior/senior_details_screen.dart';
import 'package:flutter_kiosk_ui/screens/details/details_screen.dart';
import 'package:provider/provider.dart';

import 'delete.dart';
import 'item_card.dart';

class SideBody extends StatefulWidget {
  SideBody({Key key}) : super(key: key);
  @override
  _SideBodyState createState() => _SideBodyState();
}

class _SideBodyState extends State<SideBody> {
  FirebaseDatabase _database;
  DatabaseReference reference;
  Query referenceQuery;
  String _dataaseURL = 'https://realfood-jqhc-default-rtdb.firebaseio.com/';
  Burger burger;
  List<Burger> burgers = List();

  String manualText = "원하는 상품을 선택하면 상세설명 및 수량선택 페이지로 넘어갑니다";

  @override
  void initState() {
    super.initState();
    _database = FirebaseDatabase(databaseURL: _dataaseURL);
    // reference = _database.reference().child("menu_data");
    // reference.onChildAdded.listen(_onEntryAdded);

    // 데이터 목록필터링 방법 = Query

    referenceQuery = _database.reference().child("side_data");
    referenceQuery.onChildAdded.listen(_onEntryAdded);
  }

  _onEntryAdded(Event event) {
    print("burgers : ${burgers}");
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
          child: Column(
            children: [
              Column(
                children: [
                  SizedBox(height: 8),
                  //  ROW = 주문과정 설명
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        // height: ,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Image.asset(
                            "assets/images/cashier.png",
                            height: 40,
                          ),
                          // child: Icon(
                          //   Icons.support_agent,
                          //   size: 30,
                          //   color: Colors.black.withAlpha(200),
                          // ),
                        ),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Container(
                          child: Padding(
                            padding: const EdgeInsets.all(5),
                            child: Text(
                              "원하는 상품을 선택하면 \n상세설명 및 수량선택 페이지로 넘어갑니다",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 13,fontFamily: 'fifth', color: Colors.black
                                // fontWeight: FontWeight.bold
                              ),
                            ),
                          ),
                          height: 55,
                          width: 270,
                          decoration: BoxDecoration(
                            color: Colors.grey[
                                300], //설명 배경 색 Colors.deepOrange[500]Colors.grey[300],
                            borderRadius: BorderRadius.circular(10),
                          )),
                    ],
                  ),
                ],
              ),
              // SizedBox(height: 5),
              Container(
                height: 290,
                child: Padding(
                    padding: EdgeInsets.fromLTRB(16.0, 8.0, 15.0, 0),
                    //const EdgeInsets.symmetric(horizontal: kDefaultPaddin),
                    child: ScrollConfiguration(
                      behavior: MyBehavior(),
                      child: SizedBox(
                        height: 267,
                        child: GridView.builder(
                          itemCount: burgers.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 0,
                            crossAxisSpacing: 15,
                            childAspectRatio: 0.95,
                          ),
                          itemBuilder: (context, index) => ItemCard(
                              burger: burgers[index],
                              press: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => SeniorDetailsScreen(
                                        burger: burgers[index],
                                      ),
                                    ));
                              }),
                        ),
                      ),
                    )),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
