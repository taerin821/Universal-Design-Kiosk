import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_kiosk_ui/constants.dart';
import 'package:flutter_kiosk_ui/screens/cart/cart_screen.dart';
import 'package:flutter_kiosk_ui/screens/home/components/body.dart';
import '../home/components/drinkbody.dart';
import '../home/components/sidebody.dart';

import 'package:firebase_database/firebase_database.dart';

import 'components/undercart.dart/cartlistbody.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: DefaultTabController(
          length: 3,
          child: Scaffold(
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(55.0),
              child: AppBar(
                backgroundColor: Color(0xFFFFA726),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '동양미래대점',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20.0,
                          fontFamily: 'fifth'),
                    ),
                  ],
                ),
                bottom: TabBar(
                  indicatorColor: Color(0xFFFFA726), //탭바 밑에 색깔
                  //labelColor: Colors.blue,//탭바 글씨 색깔
                  //indicatorWeight: 2.0, 탭바 밑에 효과
                  tabs: [
                    Container(
                      height: 20.0,
                      child: Tab(
                          child: Text(
                        '햄버거',
                        style:
                            TextStyle(color: Colors.black, fontFamily: 'fifth'),
                      )),
                    ),
                    Container(
                      height: 20.0,
                      child: Tab(
                          child: Text(
                        '음료',
                        style:
                            TextStyle(color: Colors.black, fontFamily: 'fifth'),
                      )),
                    ),
                    Container(
                      height: 20.0,
                      child: Tab(
                          child: Text(
                        '사이드',
                        style:
                            TextStyle(color: Colors.black, fontFamily: 'fifth'),
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
