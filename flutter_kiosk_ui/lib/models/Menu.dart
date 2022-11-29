import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';

final DatabaseReference databaseReference =
    FirebaseDatabase.instance.reference();

class Burger {
  String burger, image, description;
  int price, number, id;
  String key;

  Burger({this.burger, this.image, this.number, this.price, this.id});

  Burger.fromSnapshot(DataSnapshot snapshot)
      : key = snapshot.key,
        id = snapshot.value["id"],
        burger = snapshot.value["burger"],
        image = snapshot.value["image"],
        description = snapshot.value["description"],
        number = snapshot.value["number"],
        price = snapshot.value["price"];

  Map<String, dynamic> toJson() => {
        "id": id,
        "burger": burger,
        "image": image,
        "number": number,
        "price": price,
      };
}

class Information {
  String key;
  String pay;
  int place;
  int chat;

  Information({this.pay, this.place, this.chat});

  Information.fromSanpshot(DataSnapshot snapshot)
      : key = snapshot.key,
        pay = snapshot.value['pay'].toString(),
        place = snapshot.value['place'],
        chat = snapshot.value['chat'];

  Map<String, dynamic> toJson() => {"pay": pay, "place": place, "chat": chat};
}

class Information2 {
  String key;
  int oderNumber;
  dynamic age;
  int card;

  Information2({this.oderNumber, this.age});

  Information2.fromSanpshot(DataSnapshot snapshot)
      : key = snapshot.key,
        oderNumber = snapshot.value['oderNumber'],
        age = snapshot.value['age'],
        card = snapshot.value['card'];

  Map<String, dynamic> toJson() =>
      {"oderNumber": oderNumber, "age": age, "card": card};
}

class OderNum {
  int oderNum;
  String key;
  OderNum({this.oderNum});

  OderNum.formSanpshot(DataSnapshot snapshot)
      : key = snapshot.key,
        oderNum = snapshot.value["number"];

  Map<String, dynamic> toJson() => {
        "oderNum": oderNum,
      };
}
