import 'package:flutter/material.dart';
import 'package:flutter_kiosk_ui/models/Product_provider.dart';

import 'Menu.dart';
import 'Product.dart';

class Cart extends ChangeNotifier {
  Burger burger;
  int numOfItem;

  Cart({@required this.burger, @required this.numOfItem});
}

// Demo data for our cart

// List<Cart> carts = [Cart(burger: burgers[0], numOfItem: 2)];
List<Cart> carts = [];
