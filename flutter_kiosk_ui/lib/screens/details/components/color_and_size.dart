import 'package:flutter/material.dart';
import 'package:flutter_kiosk_ui/models/Menu.dart';
import 'package:flutter_kiosk_ui/models/Product.dart';
import 'package:flutter_kiosk_ui/screens/Senior/components/delete.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../constants.dart';

class ColorAndSize extends StatelessWidget {
  const ColorAndSize({
    Key key,
    this.burger,
  }) : super(key: key);

  final Burger burger;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          flex: 2 ,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "원산지",
                style: TextStyle(fontFamily: 'fifth',color: Colors.black),
              ),
              Container(
                height: 50.0,
                width: 200,
                child: ScrollConfiguration(
                  behavior: MyBehavior(),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: <Widget>[
                        // IconButton(
                        //   icon: Image.asset(
                        //     "assets/icons/cow.png",
                        //     color: Colors.black,
                        //   ),
                        //   onPressed: () {
                        //     description(context);
                        //   },
                        // ),
                        IconButton(
                          icon: Image.asset(
                            "assets/icons/pig.png",
                            color: Colors.black,
                          ),
                          onPressed: () {
                            description(context);
                          },
                        ),
                        // IconButton(
                        //   icon: Image.asset(
                        //     "assets/icons/chicken.png",
                        //     color: Colors.black,
                        //   ),
                        //   onPressed: () {
                        //     description(context);
                        //   },
                        // ),
                        // IconButton(
                        //   icon: Image.asset(
                        //     "assets/icons/shrimp.png",
                        //     color: Colors.black,
                        //   ),
                        //   onPressed: () {
                        //     description(context);
                        //   },
                        // ),
                        // IconButton(
                        //   icon: Image.asset(
                        //     "assets/icons/fish.png",
                        //     color: Colors.black,
                        //   ),
                        //   onPressed: () {
                        //     description(context);
                        //   },
                        // ),
                        // ColorDot(
                        //   color: Color(0xFF356C95),
                        //   isSelected: true,
                        // ),
                        // ColorDot(color: Color(0xFFF8C078)),
                        // ColorDot(color: Color(0xFFA29B9B)),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 1,
          child: RichText(
            text: TextSpan(
              style: TextStyle(color: kTextColor),
              children: [
                TextSpan(
                  text: "열량\n",
                  style: TextStyle(fontFamily: 'fifth',color: Colors.black),
                ),
                
                TextSpan(
                  text: "630 kcal",
                  //"${burger.key} kcal",571 466 459 764 778 511 499
                  style: Theme.of(context).textTheme.headline5.copyWith(
                      fontWeight: FontWeight.bold,
                       fontFamily: 'fifth',color: Colors.black,fontSize:22.0),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}

void description(BuildContext context) async {
  String result = await showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0))),
        title: Text(
          '원산지',
          style: TextStyle(fontFamily: 'fifth', color: Colors.black),
        ),
        content: Builder(builder: (context) {
          var height = MediaQuery.of(context).size.height;
          var width = MediaQuery.of(context).size.width;
          return Container(
            height: 270.0,
            width: 400.0,
            child: Text(
              '쇠고기-[호주산과 뉴질랜드산 섞음] 동양버거,구로버거,미래버거 \n\n돼지고기-[미국산] 자동화버거, 공학버거\n\n닭고기-[브라질산] 로봇버거,스마트버거,대학버거 \n\n새우-[베트남산] 동양버거 \n\n생선-[말레이시아산] 동양버거 ',
              style: TextStyle(fontFamily: 'fifth', color: Colors.black),
            ),
          );
        }),
        actions: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () {
                  Navigator.pop(context, "취소");
                },
                icon: Icon(Icons.cancel_outlined),
              ),
            ],
          ),
        ],
      );
    },
  );
}
