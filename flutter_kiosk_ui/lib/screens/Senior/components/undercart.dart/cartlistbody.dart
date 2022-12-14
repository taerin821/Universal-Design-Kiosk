import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_kiosk_ui/models/Menu.dart';
import 'package:flutter_kiosk_ui/models/Product_provider.dart';
import 'package:flutter_kiosk_ui/screens/cart/cart_screen.dart';
import 'package:flutter_kiosk_ui/screens/first_Screen/firstscreen.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_kiosk_ui/models/Cart.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
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
        // ??????????????? ?????? ?????? ok, ?????? ok, ???????????? ok, BUT ?????? ????????? ????????? ???????????? ?????????;;;
        burgers.forEach((element) {
          if (element.burger == cartBurger.burger) {
            // ????????? ????????? ????????? ????????? ?????????
            element.number = cartBurger.number;
            element = cartBurger;

            if ((element.number > 0 && element != cartBurger) ||
                (element.number > 0 &&
                    !burgerCarts.contains(burgers.singleWhere((burgerList) =>
                        burgerList.burger == cartBurger.burger)))) {
              //
              burgerCarts.add(element);
            } else if (element.number > 0 &&
                !burgerCarts.contains(burgers.singleWhere(
                    (burgerList) => burgerList.burger == cartBurger.burger))) {
              burgerCarts.add(element);
            } // ?????? ??????????????? ????????????
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

  _cart() {}

  Widget updateRef() {
    if (widget.burger.key.contains("side")) {
      setState(() {
        childString = "side_data";
      });
    } else if (widget.burger.key.contains("burger")) {
      setState(() {
        childString = "menu_data";
      });
    } else if (widget.burger.key.contains("drink")) {
      setState(() {
        childString = "drink_data";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    int totalNumber =
        burgerCarts.fold(0, (total, element) => total + element.number);
    int totalPrice = burgerCarts.fold(
        0, (total, element) => total + (element.number * element.price));
    print(totalPrice);

    // NumCounter color = Provider.of<NumCounter>(context, listen: false);
    // burgerCarts.isEmpty ? color.changeWhite() : color.changeRed();

    burgers.forEach((element) {
      print("???????????? : ${element.burger}, ?????? ?????? : ${element.number}");
    });
    burgerCarts.forEach((element) {
      print("???????????? : ${element.burger}, ?????? ?????? : ${element.number}");
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
                  '??????',
                  style: TextStyle(fontFamily: 'fifth', color: Colors.black),
                ),
                SizedBox(
                  width: 100.0,
                ),
                Text(
                  '??????',
                  style: TextStyle(fontFamily: 'fifth', color: Colors.black),
                ),
                SizedBox(
                  width: 113.0,
                ),
                Text(
                  '??????',
                  style: TextStyle(fontFamily: 'fifth', color: Colors.black),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          flex: 8,
          child: Column(
            children: [
              Expanded(
                child: Container(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: ScrollConfiguration(
                      behavior: MyBehavior(),
                      child: Scrollbar(
                        thickness: 3.0,
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
                                              //     if (burgerCarts[index]
                                              //             .number >
                                              //         1) {
                                              //       // Provider.of<NumCounter>(context, listen: false).minus();
                                              //       // setState(() {
                                              //       //   numOfItem--;
                                              //       // });
                                              //       // setState(() {
                                              //       databaseReference
                                              //           .child("menu_data")
                                              //           .child(
                                              //               burgerCarts[index]
                                              //                   .key)
                                              //           .update({
                                              //         "number":
                                              //             burgerCarts[index]
                                              //                     .number -
                                              //                 1
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
                                                        .headline6.copyWith( color: Colors.black))
                                              ),
                                              // buildOutlineButton(
                                              //     icon: Icons.add,
                                              //     press: () {
                                              //       databaseReference
                                              //           .child("menu_data")
                                              //           .child(
                                              //               burgerCarts[index]
                                              //                   .key)
                                              //           .update({
                                              //         "number":
                                              //             burgerCarts[index]
                                              //                     .number +
                                              //                 1
                                              //       });
                                              //       // numOfItem++;
                                              //       // Provider.of<NumCounter>(context, listen: false).puls();
                                              //     }),
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          flex: 4,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              Text(
                                                "${burgerCarts[index].price * burgerCarts[index].number}???",
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
                                                        childString =
                                                            "side_data";
                                                      });
                                                    } else if (burgerCarts[
                                                            index]
                                                        .key
                                                        .contains("burger")) {
                                                      setState(() {
                                                        childString =
                                                            "menu_data";
                                                      });
                                                    } else if (burgerCarts[
                                                            index]
                                                        .key
                                                        .contains("drink")) {
                                                      setState(() {
                                                        childString =
                                                            "drink_data";
                                                      });
                                                    }
                                                    databaseReference
                                                        .child(childString)
                                                        .child(
                                                            burgerCarts[index]
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
                                                  Fluttertoast.showToast(
                                                    msg: "??????????????? ????????? ?????? ???????????????",
                                                    toastLength:
                                                        Toast.LENGTH_SHORT,
                                                    gravity:
                                                        ToastGravity.CENTER,
                                                    timeInSecForIosWeb: 1,
                                                    backgroundColor:
                                                        Colors.orange,
                                                    textColor: Colors.black,
                                                    fontSize: 15.0,
                                                  );
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
                                        //           // null safety ??????
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
                                    endIndent: 0.0,
                                  )
                                ],
                              )),
                        ),
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
                flex: 4, // ?????????, 3?????? ?????????

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
                            Text('?????? ?????? :',
                                style: TextStyle(fontFamily: 'fifth', color: Colors.black)),
                            SizedBox(
                              height: 5.0,
                            ),
                            Text('?????? ?????? :',
                                style: TextStyle(fontFamily: 'fifth', color: Colors.black)),
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
                            Text(
                              '${totalNumber}',
                              style: TextStyle(fontFamily: 'fifth', color: Colors.black),
                            ),
                            SizedBox(
                              height: 5.0,
                            ),
                            Text(
                              '${totalPrice}???',
                              style: TextStyle(fontFamily: 'fifth', color: Colors.black),
                            ),
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
                                },
                                child: Text(
                                  '?????? ??????',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'fifth',fontSize: 11.0),
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
                                  '?????? ??????',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'fifth',
                                      fontSize: 11.0),
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
