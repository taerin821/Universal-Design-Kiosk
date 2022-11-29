import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class NumCounter with ChangeNotifier {
  int _numOfItem = 1;
  int get numOfItem => _numOfItem;
  set numOfItem(int numOfItem) => _numOfItem = numOfItem;

  void puls() {
    _numOfItem++;
    notifyListeners();
  }

  void minus() {
    _numOfItem--;
    notifyListeners();
  }

  int _explainNum;
  int get explainNum => _explainNum;
  set explainNum(int explainNum) => _explainNum = explainNum;

  String _explain = "원하는 상품 선택시 \n상세설명 및 수량선택 화면으로 넘어갑니다";
  String get explain => _explain;
  set explain(String text) => _explain = text;

  void switchText() {
    switch (_explainNum) {
      case 1:
        _explain = "장구니에 상품이 추가되습니다";
        break;
      case 2:
        _explain = "결제를 원하시면 ";
        break;
    }
    notifyListeners();
  }

  Void changeText() {
    _explain = "장바구니에 상품이 추가 되었습니다.";

    print("changeText1");
    notifyListeners();
  }

  Void changeText2() {
    _explain = "결제를 원하시면 ";

    print("changeText2");
    notifyListeners();
  }

  // int _totalPrice;
  // int get totalPrice => _totalPrice;
  // set totalPrice(int totalPrice) => _totalPrice = totalPrice;

  // int _totalNum;
  // int get totalNum => _totalNum;
  // set totalNum(int totalNum) => _totalNum = totalNum;
}
