import 'package:flutter/material.dart';
import 'package:flutter_kiosk_ui/models/Menu.dart';
import 'package:flutter_kiosk_ui/screens/Senior/components/drinkbody.dart';
import 'package:flutter_kiosk_ui/screens/Senior/components/sideBody.dart';

import 'package:flutter_svg/svg.dart';
import 'package:flutter_kiosk_ui/constants.dart';
import 'package:flutter_kiosk_ui/screens/cart/cart_screen.dart';
import 'package:flutter_kiosk_ui/screens/Senior/components/body.dart';

import 'package:flutter_kiosk_ui/screens/Senior/components/undercart.dart/cartlistbody.dart';
import 'package:firebase_database/firebase_database.dart';

class SeniorScreen extends StatefulWidget {
  @override
  _SeniorScreenState createState() => _SeniorScreenState();
}

class _SeniorScreenState extends State<SeniorScreen> {
  FirebaseDatabase _database;
  DatabaseReference reference;

  String _dataaseURL = 'https://realfood-jqhc-default-rtdb.firebaseio.com/';
  Information2 information2;
  Burger burger;
  List<Burger> burgerCarts = List();
  List<Burger> burgers = List();

  String manualText = "원하는 상품을 선택하면 상세설명 및 수량선택 페이지로 넘어갑니다";
  List<String> manual = [
    '원하는 상품을 선택하면 상세설명 및 수량선택 페이지로 넘어갑니다',
    '바로 주문을 원하시면 결제하기 버튼을,\n 다른 상품을 더 추가하고 싶으시면 장바구니 아이콘을 눌러주세요',
    '장바구니에 상품이 추가 되었습니다.',
    ''
  ];

  @override
  void initState() {
    super.initState();
    _database = FirebaseDatabase(databaseURL: _dataaseURL);
    reference = _database.reference().child("information");

    reference.onChildAdded.listen(_onEntryAdded);
    reference.onChildChanged.listen(_onEntryAdded);
    // for (int i = 0; i <= 3; i++) {
    // Future.delayed(Duration(seconds: 1), () {
    //   setState(() {
    //     maualNum++;
    //   });
    // }

    // }
  }

  /// 처음 데이터 읽어올때 1번 실행됨
  _onEntryAdded(Event event) {
    setState(() {
      information2 = Information2.fromSanpshot(event.snapshot);
    });
  }

  // _changeManual() {
  //   burgerCarts.isEmpty
  //       ? manualText = "원하는 상품을 선택하면 상세설명 및\n 수량선택 페이지로 넘어갑니다"
  //       : {
  //           manualText = "장바구니에 상품이 추가 되었습니다.",
  //           Future.delayed(Duration(seconds: 2), () {
  //             manualText = "원하는 상품을 선택하면 상세설명 및\n 수량선택 페이지로 넘어갑니다";
  //           })
  //         };
  // }

  @override
  Widget build(BuildContext context) {
    // _changeManual();
    // print(manualText);
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: DefaultTabController(
          length: 3,
          child: Scaffold(
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(70.0),
              child: AppBar(
                backgroundColor:Color(0xFFFFA726),
                title: Column(
                  children: [
                    SizedBox(height: 10),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   crossAxisAlignment: CrossAxisAlignment.center,
                    //   children: [
                    Text(
                      '동양미래대점',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 25.0,
                          fontFamily: 'fifth'),
                    ),
                    // IconButton(
                    //   icon: Image.asset(
                    //     "assets/icons/fish.png",
                    //     color: Colors.black,
                    //   ),
                    //   onPressed: () {},
                    // ),
                    //     Image.asset(
                    //       "assets/images/user.png",
                    //       height: 45,
                    //     ),
                    //     SizedBox(
                    //       width: 20,
                    //     ),
                    //     Container(
                    //         child: Padding(
                    //             padding: const EdgeInsets.all(3.0),
                    //             child: Text(manualText,
                    //                 textAlign: TextAlign.center,
                    //                 style: TextStyle(
                    //                     fontSize: 12, color: Colors.black))),
                    //         height: 45,
                    //         width: 250,
                    //         decoration: BoxDecoration(
                    //           color: Colors.grey[300], //메뉴판 색
                    //           borderRadius: BorderRadius.circular(10),
                    //         )),
                    //   ],
                    // ),
                  ],
                ),
                bottom: TabBar(
                  
                  indicatorColor: Colors.red, //탭바 밑에 색깔
                  //labelColor: Colors.blue,//탭바 글씨 색깔
                  //indicatorWeight: 2.0, 탭바 밑에 효과
                  tabs: [
                    Container(
                      height: 30.0,
                      child: Tab(
                          child: Text(
                        '햄버거',
                        style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.black,
                            fontFamily: 'fifth'),
                      )),
                    ),
                    Container(
                      height: 30.0,
                      child: Tab(
                          child: Text(
                        '음료',
                        style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.black,
                            fontFamily: 'fifth'),
                      )),
                    ),
                    Container(
                      height: 30.0,
                      child: Tab(
                          child: Text(
                        '사이드',
                        style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.black,
                            fontFamily: 'fifth'),
                      )),
                    ),
                  ],
                ),
              ),
            ),
            body: Column(
              children: <Widget>[
                Expanded(
                    flex: 5,
                    child: TabBarView(
                        children: [HomeBody(), DrinkBody(), SideBody()])),
                Expanded(flex: 3, child: CartListBody())
              ],
            ),
          ),
        ));
  }

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: IconButton(
        icon: SvgPicture.asset("assets/icons/back.svg"),
        onPressed: () {},
      ),
      actions: <Widget>[
        IconButton(
          icon: SvgPicture.asset(
            "assets/icons/search.svg",
            // By default our  icon color is white
            color: kTextColor,
          ),
          onPressed: () {},
        ),
        IconButton(
            icon: SvgPicture.asset(
              "assets/icons/cart.svg",
              // By default our  icon color is white
              color: kTextColor,
            ),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => CartScreen()));
            }),
        SizedBox(width: kDefaultPaddin / 2)
      ],
    );
  }
}
