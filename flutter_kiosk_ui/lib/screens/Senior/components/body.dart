import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_kiosk_ui/constants.dart';
import 'package:flutter_kiosk_ui/models/Menu.dart';
import 'package:flutter_kiosk_ui/models/Product.dart';
import 'package:flutter_kiosk_ui/models/Product_provider.dart';
import 'package:flutter_kiosk_ui/screens/details/components/senior/senior_details_screen.dart';
import 'package:provider/provider.dart';
import 'package:fluttertoast/fluttertoast.dart';

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
  Color choiceColor = Colors.deepOrange[700];

  @override
  void initState() {
    super.initState();
    _database = FirebaseDatabase(databaseURL: _dataaseURL);
    burgerRef = _database.reference().child("menu_data").limitToFirst(9);

    burgerRef.onChildAdded.listen(_onEntryAdded);
    burgerRef.onChildChanged.listen(_onEntryChanged);
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
            // 메뉴랑 변경된 메뉴의 이름이 같을때
            element.number = cartBurger.number;
            element = cartBurger;

            if ((element.number > 0 && element != cartBurger) ||
                (element.number > 0 &&
                    !burgerCarts.contains(burgers.singleWhere((burgerList) =>
                        burgerList.burger == cartBurger.burger)))) {
              //
              burgerCarts.add(element);
              // 장바구니 상품 추가시 토스트 메세지
              Fluttertoast.showToast(
                  msg: "장바구니에 상품이 추가 되었습니다",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.orange,
                  textColor: Colors.black,
                  fontSize: 15.0);
            } else if (element.number > 0 &&
                !burgerCarts.contains(burgers.singleWhere(
                    (burgerList) => burgerList.burger == cartBurger.burger))) {
              burgerCarts.add(element);
            } // 새로 장바구니에 추가될때
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
          child: Column(
            children: [
              Container(
                child: Column(
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
                                burgerCarts.length == 0
                                    ? "원하는 상품 선택시 \n상세설명 및 수량선택 화면으로 넘어갑니다 "
                                    : "결제를 원하시면 \n 오른쪽 하단에 주문완료 버튼을  눌러주세요",
                                textAlign: TextAlign.center,
                                style:
                                    TextStyle(fontSize: 13, fontFamily: 'fifth', color: Colors.black
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
              ),
              // SizedBox(height: 5),
              Container(
                height: 290,
                color: Colors.white,
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
