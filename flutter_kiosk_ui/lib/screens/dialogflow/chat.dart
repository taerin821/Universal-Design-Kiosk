import 'package:bubble/bubble.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dialogflow/dialogflow_v2.dart';
import 'package:flutter_kiosk_ui/models/Menu.dart';
import 'package:flutter_kiosk_ui/screens/cart/cart_screen.dart';
import 'package:flutter_kiosk_ui/screens/details/details_screen.dart';
import 'package:flutter_kiosk_ui/screens/home/components/delete.dart';
import '../dialogflow/item_card2.dart';

// void main() {
//   runApp(MaterialApp(
//     home: MyApp(),
//     debugShowCheckedModeBanner: false,
//   ));
// }

class ChatBot extends StatefulWidget {
  @override
  _ChatBotState createState() => _ChatBotState();
}

class _ChatBotState extends State<ChatBot> {
  FirebaseDatabase _database;
  Query reference;
  String _dataaseURL = 'https://realfood-jqhc-default-rtdb.firebaseio.com/';
  Burger burger;
  List<Burger> burgerCarts = List();
  List<Burger> burgers = List();

  DatabaseReference informationRef;

  @override
  void initState() {
    super.initState();
    _database = FirebaseDatabase(databaseURL: _dataaseURL);
    reference = _database.reference().child("menu_data").limitToFirst(9);
    informationRef = _database.reference().child("information");

    reference.onChildAdded.listen(_onEntryAdded);
    // reference.onChildChanged.listen(_oder);

    /// information노드의 데이터 변경시 _oder 실행
    informationRef.onChildChanged.listen(_oder);
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

  /// 챗봇에서 결제 데이터 업데이트시 CartScreen 으로 이동
  _oder(Event event) {
    Information information = Information.fromSanpshot(event.snapshot);
    setState(() {
      if (information.pay == '결제') {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => CartScreen()));
      }
    });
  }

  // _onEntryChanged(Event event) {
  //   setState(() {
  //     burgers.add(Burger.fromSnapshot(event.snapshot));
  //     burgers.forEach((element) {
  //       if (element.number != 0 && !burgerCarts.contains(element)) {
  //         burgerCarts.add(element);
  //       } else if (element.number == 0 && burgerCarts.contains(element)) {
  //         databaseReference
  //             .child("menu")
  //             .child(element.key)
  //             .update({"number": 0}).then((_) {
  //           burgerCarts.remove(element);
  //         });
  //       }
  //     });
  //   });
  // }

  void response(query) async {
    AuthGoogle authGoogle = await AuthGoogle(
            fileJson: "assets/cupcakesbot-qlrcih-9c82160e9e70.json")
        .build();
    Dialogflow dialogflow =
        Dialogflow(authGoogle: authGoogle, language: Language.korean);
    AIResponse aiResponse = await dialogflow.detectIntent(query);
    setState(() {
      messsages.insert(0, {
        "data": 0,
        "message": aiResponse.getListMessage()[0]["text"]["text"][0].toString()
      });
    });
  }

  final messageInsert = TextEditingController();
  List<Map> messsages = List();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "음성주문",style: TextStyle(fontFamily: 'fifth'),
        ),
        backgroundColor: Color(0xFFFFA726),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 5,
            ),
            Flexible(
              child: ScrollConfiguration(
                behavior: MyBehavior(),
                child: GridView.builder(
                  itemCount: burgers.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 1,
                    crossAxisSpacing: 2.0,
                    childAspectRatio: 1.32,
                  ),
                  itemBuilder: (context, index) => ItemCard2(
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
              ),
            ),
            Divider(
              thickness: 3.0,
              color: Color(0xFFFFA726),
            ),
            Flexible(
                child: ListView.builder(
                    reverse: true,
                    itemCount: messsages.length,
                    itemBuilder: (context, index) => chat(
                        messsages[index]["message"].toString(),
                        messsages[index]["data"]))),
            Divider(
              height: 5.0,
              color: Colors.deepOrange,
            ),
            Container(
              padding: EdgeInsets.only(left: 15.0, right: 15.0),
              margin: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                children: <Widget>[
                  Flexible(
                      child: TextField(
                    controller: messageInsert,
                    decoration: InputDecoration.collapsed(
                        hintText: "시작시 | 주문하기 |를 입력해주세요",
                        hintStyle: TextStyle(fontSize: 14.0,fontFamily: 'fifth')),
                  )),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 4.0),
                    child: IconButton(
                        icon: Icon(
                          Icons.send,
                          size: 30.0,
                          color: Color(0xFFFFA726),
                        ),
                        onPressed: () {
                          if (messageInsert.text.isEmpty) {
                            print("empty message");
                          } else {
                            setState(() {
                              messsages.insert(0,
                                  {"data": 1, "message": messageInsert.text});
                            });
                            response(messageInsert.text);
                            messageInsert.clear();
                          }
                        }),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 15.0,
            )
          ],
        ),
      ),
    );
  }

  //for better one i have use the bubble package check out the pubspec.yaml

  Widget chat(String message, int data) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Bubble(
          radius: Radius.circular(15.0),
          color: data == 0 ? Colors.deepOrange[700] : Colors.orangeAccent,
          elevation: 0.0,
          alignment: data == 0 ? Alignment.topLeft : Alignment.topRight,
          nip: data == 0 ? BubbleNip.leftBottom : BubbleNip.rightTop,
          child: Padding(
            padding: EdgeInsets.all(2.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                CircleAvatar(
                  backgroundImage: AssetImage(data == 0
                      ? "assets/images/bot.png"
                      : "assets/images/user.png"),
                ),
                SizedBox(
                  width: 10.0,
                ),
                Flexible(
                    child: Text(
                  message,
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold,fontFamily: 'fifth'),
                ))
              ],
            ),
          )),
    );
  }
}
