import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_kiosk_ui/models/Product.dart';
import 'package:flutter_kiosk_ui/screens/last/components/body.dart';
import 'package:flutter_kiosk_ui/screens/home/components/emptyappbar.dart';
import 'package:flutter_kiosk_ui/screens/home/components/emptyappbar.dart';

class PaymentScreen extends StatelessWidget {
  final Product product;

  const PaymentScreen({Key key, this.product}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: EmptyAppBar(),
      body: Body(),
    );
  }
}
