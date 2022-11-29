import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_kiosk_ui/models/Menu.dart';
import 'package:flutter_kiosk_ui/screens/cart/cart_screen.dart';
import 'package:flutter_kiosk_ui/screens/first_Screen/firstscreen.dart';
import 'package:flutter_kiosk_ui/screens/touchscreen/TouchScreen.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_kiosk_ui/models/Cart.dart';
import '../delete.dart';

import '../../../cart/components/cart_card.dart';

class CartListBody extends StatefulWidget {
  const CartListBody({Key key, this.cart, this.burger}) : super(key: key);

  final CartListBody cart;
  final Burger burger;

  @override
  _CartListBodyState createState() => _CartListBodyState();
}

class _CartListBodyState extends State<CartListBody> {
  FirebaseDatabase _database;
  DatabaseReference reference;
  Query burgerRef;
  Query drinkRef;
  Query sideRef;
  String _dataaseURL = 'https://realfood-jqhc-default-rtdb.firebaseio.com/';
  Burger burger;
  Information information;
  Information2 information2;
  List<Burger> burgerCarts = List();
  List<Burger> burgers = List();
  String childString;

  @override
  void initState() {
    super.initState();
    _database = FirebaseDatabase(databaseURL: _dataaseURL);
    burgerRef = _database.reference().child("menu_data").limitToFirst(9);
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
  void dispose() {
    // TODO: implement dispose
    reference.onDisconnect();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    int totalNumber =
        burgerCarts.fold(0, (total, element) => total + element.number);
    int totalPrice = burgerCarts.fold(
        0, (total, element) => total + (element.number * element.price));
    print(totalPrice);
    int numOfItem = 1;

    burgers.forEach((element) {
      print("메뉴버거이름 : ${element.burger}, 메뉴 버거 수량 : ${element.number}");
    });
    burgerCarts.forEach((element) {
      print("버거이름 : ${element.burger}, 버거 수량 : ${element.number}");
    });

    return Column(
      children: <Widget>[
        Expanded(
          flex: 2,
          child: Container(
            color: Color(0xFFFFA726),
            child: Row(
              children: <Widget>[
                SizedBox(
                  width: 20.0,
                ),
                Text(
                  '메뉴',
                  style: TextStyle(fontFamily: 'fifth'),
                ),
                SizedBox(
                  width: 100.0,
                ),
                Text('수량', style: TextStyle(fontFamily: 'fifth')),
                SizedBox(
                  width: 113.0,
                ),
                Text('가격', style: TextStyle(fontFamily: 'fifth')),
              ],
            ),
          ),
        ),
        Expanded(
          flex: 8,
          child: Column(
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: ScrollConfiguration(
                    behavior: MyBehavior(),
                    child: Scrollbar(
                      thickness: 5.0,
                      child: ListView.builder(
                        itemCount: burgerCarts.length,
                        itemBuilder: (context, index) => Padding(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            child: Column(
                              children: [
                                Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        flex: 5,
                                        child: Text(
                                          burgerCarts[index].burger,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 16,
                                              fontFamily: 'fifth'),
                                          maxLines: 2,
                                        ),
                                      ),
                                      Expanded(
                                        flex: 3,
                                        child: Row(
                                          children: [
                                            // buildOutlineButton(
                                            //   icon: Icons.remove,
                                            //   press: () {
                                            //     if (burgerCarts[index].number >
                                            //         1) {
                                            //       // Provider.of<NumCounter>(context, listen: false).minus();
                                            //       // setState(() {
                                            //       //   numOfItem--;
                                            //       // });
                                            //       // setState(() {
                                            //       databaseReference
                                            //           .child("menu_data")
                                            //           .child(burgerCarts[index]
                                            //               .key)
                                            //           .update({
                                            //         "number": burgerCarts[index]
                                            //                 .number -
                                            //             1
                                            //         // });
                                            //       });
                                            //       // .then((_) {
                                            //       //   setState(() {
                                            //       //     burgerCarts.remove(
                                            //       //         burgerCarts[index]);
                                            //       //   });
                                            //       // });
                                            //     }
                                            //   },
                                            // ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 20.0 / 2),
                                              child: Text(
                                                  "${burgerCarts[index].number}",
                                                  // if our item is less  then 10 then  it shows 01 02 like that
                                                  // numOfItem
                                                  //     .toString()
                                                  //     .padLeft(2, "0"),
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .headline6
                                                      .copyWith(
                                                          fontFamily: 'fifth')),
                                            ),
                                            // buildOutlineButton(
                                            //     icon: Icons.add,
                                            //     press: () {
                                            //       databaseReference
                                            //           .child("menu_data")
                                            //           .child(burgerCarts[index]
                                            //               .key)
                                            //           .update({
                                            //         "number": burgerCarts[index]
                                            //                 .number +
                                            //             1
                                            //       });
                                            //       // numOfItem++;
                                            //       // Provider.of<NumCounter>(context, listen: false).puls();
                                            //     }),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        flex: 3,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Text(
                                              "\u20a9${burgerCarts[index].price * burgerCarts[index].number}",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.black,
                                                  fontFamily: 'fifth'),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: SizedBox(
                                          height: 30.0,
                                          width: 30.0,
                                          child: IconButton(
                                              onPressed: () {
                                                setState(() {
                                                  if (burgerCarts[index]
                                                      .key
                                                      .contains("side")) {
                                                    setState(() {
                                                      childString = "side_data";
                                                    });
                                                  } else if (burgerCarts[index]
                                                      .key
                                                      .contains("burger")) {
                                                    setState(() {
                                                      childString = "menu_data";
                                                    });
                                                  } else if (burgerCarts[index]
                                                      .key
                                                      .contains("drink")) {
                                                    setState(() {
                                                      childString =
                                                          "drink_data";
                                                    });
                                                  }
                                                  databaseReference
                                                      .child(childString)
                                                      .child(burgerCarts[index]
                                                          .key)
                                                      .update({"number": 0});
                                                  burgerCarts.removeWhere(
                                                      (element) =>
                                                          element.key ==
                                                          burgerCarts[index]
                                                              .key);
                                                  // burgerCarts.remove(
                                                  //     burgerCarts[index]);
                                                });
                                              },
                                              icon: Icon(
                                                Icons.cancel_presentation,
                                                size: 17.0,
                                              )),
                                        ),
                                      ),
                                      // Container(
                                      //     color: Colors.red,
                                      //     height: 20.0,
                                      //     width: 20.0,
                                      //     child: IconButton(
                                      //       onPressed: () {
                                      //         setState(() {
                                      //           // null safety 필요
                                      //           databaseReference
                                      //               .child("menu_data")
                                      //               .child(burgerCarts[index]
                                      //                   .key)
                                      //               .update({"number": 0});
                                      //           burgerCarts.removeWhere(
                                      //               (element) =>
                                      //                   element.key ==
                                      //                   burgerCarts[index]
                                      //                       .key);
                                      //         });
                                      //       },
                                      //       icon: null,
                                      //     )),
                                    ]),
                                Divider(
                                  thickness: 2.0,
                                  endIndent: 5.0,
                                )
                              ],
                            )),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
            child: Expanded(
                flex: 4, // 하단부, 3등분 나눈거

                child: Container(
                  color: Color(0xFFFFA726),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: Column(
                          children: [
                            SizedBox(
                              height: 12.0,
                            ),
                            Text('주문 수량 :',
                                style: TextStyle(fontFamily: 'fifth')),
                            SizedBox(
                              height: 5.0,
                            ),
                            Text('주문 가격 :',
                                style: TextStyle(fontFamily: 'fifth')),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            SizedBox(
                              height: 12.0,
                            ),
                            Text('${totalNumber}',
                                style: TextStyle(fontFamily: 'fifth')),
                            SizedBox(
                              height: 5.0,
                            ),
                            Text('\u20a9${totalPrice}',
                                style: TextStyle(fontFamily: 'fifth')),
                          ],
                        ),
                      ),
                      Expanded(
                          flex: 6,
                          child: Row(children: [
                            SizedBox(
                              width: 10.0,
                            ),
                            Container(
                              height: 40.0,
                              width: 80.0,
                              child: RaisedButton(
                                elevation: 20.0,
                                color: Colors.grey[850],
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => FirstScreen()));
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
                                      .update({
                                    "pay": 0,
                                    "place": 0,
                                  });
                                  databaseReference
                                      .child("information")
                                      .child("data2")
                                      .update({
                                    "oderNumber": information2.oderNumber + 1,
                                    "age": 0
                                  });
                                },
                                child: Text(
                                  '주문 취소',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 11.0,
                                      fontFamily: 'fifth'),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 5.0,
                            ),
                            Container(
                              height: 40,
                              width: 80,
                              child: RaisedButton(
                                elevation: 20.0,
                                color: Colors.deepOrangeAccent[400],
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => CartScreen()));
                                },
                                child: Text(
                                  '주문 완료',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 11.0,
                                      fontFamily: 'fifth'),
                                ),
                              ),
                            )
                          ]))
                    ],
                  ),
                )))
      ],
    );
  }

  SizedBox buildOutlineButton({IconData icon, Function press}) {
    return SizedBox(
        width: 40,
        height: 32,
        child: RaisedButton(
            elevation: 0.0,
            padding: EdgeInsets.zero,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            onPressed: press,
            child: Icon(icon)));
  }
}
