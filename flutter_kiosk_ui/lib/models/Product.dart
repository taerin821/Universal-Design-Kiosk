import 'dart:collection';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

class Product {
  String image, title, description;
  int price, size, id, number;
  Color color;
  String key;

  Product({
    this.id,
    this.image,
    this.title,
    this.price,
    this.description,
    this.size,
    this.color,
    this.number,
  });
}

List<Product> products = [
  Product(
      id: 1,
      title: "자동화버거",
      price: 5400,
      size: 12,
      description: dummyText,
      image: "assets/images/버거_1.png",
      color: Color(0xFF3D82AE),
      number: 0),
  Product(
      id: 2,
      title: "동양버거",
      price: 4800,
      size: 12,
      description: dummyText,
      image: "assets/images/버거_2.png",
      color: Color(0xFFD3A984),
      number: 0),
  Product(
      id: 3,
      title: "공학버거",
      price: 6000,
      size: 12,
      description: dummyText,
      image: "assets/images/버거_3.png",
      color: Color(0xFF989493),
      number: 0),
  Product(
      id: 4,
      title: "구로버거",
      price: 5800,
      size: 11,
      description: dummyText,
      image: "assets/images/버거_4.png",
      color: Color(0xFFE6B398),
      number: 0),
  Product(
      id: 5,
      title: "미래버거",
      price: 5000,
      size: 12,
      description: dummyText,
      image: "assets/images/버거_5.png",
      color: Color(0xFFFB7883),
      number: 0),
  Product(
      id: 6,
      title: "로봇버거",
      price: 5400,
      size: 12,
      description: dummyText,
      image: "assets/images/버거_6.png",
      color: Color(0xFFAEAEAE),
      number: 0),
  Product(
      id: 7,
      title: "스마트버거",
      price: 5500,
      size: 12,
      description: dummyText,
      image: "assets/images/버거_7.png",
      color: Color(0xFFAEAEAE),
      number: 0),
  Product(
      id: 8,
      title: "대학버거",
      price: 5200,
      size: 12,
      description: dummyText,
      image: "assets/images/버거_9.png",
      color: Color(0xFFAEAEAE),
      number: 0),
];

String dummyText =
    "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since. When an unknown printer took a galley.";

List<MenuData> menu = [];

class UserChoice {
  UserChoice({
    this.menuData,
    this.payData,
    this.placeData,
  });

  final MenuData menuData;
  final PayData payData;
  final PlaceData placeData;

  factory UserChoice.fromRawJson(String str) =>
      UserChoice.fromSnapshot(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserChoice.fromSnapshot(Map<String, dynamic> json) => UserChoice(
        menuData: MenuData.fromSnapshot(json["menu_data"]),
        payData: PayData.fromSnapshot(json["pay_data"]),
        placeData: PlaceData.fromSnapshot(json["place_data"]),
      );

  Map<String, dynamic> toJson() => {
        "menu_data": menuData.toJson(),
        "pay_data": payData.toJson(),
        "place_data": placeData.toJson(),
      };
}

class MenuDataList {
  MenuDataList({
    this.auto,
    this.c,
    this.d,
    this.engin,
    this.guro,
    this.m,
    this.robot,
    this.smart,
    this.total,
    this.uni,
  });

  final MenuData auto;
  final MenuData c;
  final MenuData d;
  final MenuData engin;
  final MenuData guro;
  final MenuData m;
  final MenuData robot;
  final MenuData smart;
  final int total;
  final MenuData uni;

  factory MenuDataList.fromRawJson(String str) =>
      MenuDataList.fromSnapshot(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory MenuDataList.fromSnapshot(Map<String, dynamic> json) => MenuDataList(
        auto: MenuData.fromSnapshot(json["auto"]),
        c: MenuData.fromSnapshot(json["c"]),
        d: MenuData.fromSnapshot(json["d"]),
        engin: MenuData.fromSnapshot(json["engin"]),
        guro: MenuData.fromSnapshot(json["guro"]),
        m: MenuData.fromSnapshot(json["m"]),
        robot: MenuData.fromSnapshot(json["robot"]),
        smart: MenuData.fromSnapshot(json["smart"]),
        total: json["total"],
        uni: MenuData.fromSnapshot(json["uni"]),
      );

  Map<String, dynamic> toJson() => {
        "auto": auto.toJson(),
        "c": c.toJson(),
        "d": d.toJson(),
        "engin": engin.toJson(),
        "guro": guro.toJson(),
        "m": m.toJson(),
        "robot": robot.toJson(),
        "smart": smart.toJson(),
        "total": total,
        "uni": uni.toJson(),
      };
}

class MenuData {
  MenuData({
    this.burger,
    this.number,
    this.price,
  });

  final String burger;
  final int number;
  final int price;

  factory MenuData.fromRawJson(String str) =>
      MenuData.fromSnapshot(json.decode(str));

  get key => null;

  String toRawJson() => json.encode(toJson());

  factory MenuData.fromSnapshot(DataSnapshot snapshot) => MenuData(
        burger: snapshot.value["burger"],
        number: snapshot.value["number"],
        price: snapshot.value["price"],
      );

  Map<String, dynamic> toJson() => {
        "burger": burger,
        "number": number,
        "price": price,
      };
}

class PayData {
  PayData({
    this.pay,
  });

  final String pay;

  factory PayData.fromRawJson(String str) =>
      PayData.fromSnapshot(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PayData.fromSnapshot(Map<String, dynamic> json) => PayData(
        pay: json["pay"],
      );

  Map<String, dynamic> toJson() => {
        "pay": pay,
      };
}

class PlaceData {
  PlaceData({
    this.place,
  });

  final int place;

  factory PlaceData.fromRawJson(String str) =>
      PlaceData.fromSnapshot(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PlaceData.fromSnapshot(Map<String, dynamic> json) => PlaceData(
        place: json["place"],
      );

  Map<String, dynamic> toJson() => {
        "place": place,
      };
}
