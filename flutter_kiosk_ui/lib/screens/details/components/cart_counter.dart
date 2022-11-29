import 'package:flutter/material.dart';
import 'package:flutter_kiosk_ui/models/Product_provider.dart';
import 'package:provider/provider.dart';

import '../../../constants.dart';

class CartCounter extends StatefulWidget {
  @override
  _CartCounterState createState() => _CartCounterState();
}

class _CartCounterState extends State<CartCounter> {
  // int numOfItem = 1;

  @override
  Widget build(BuildContext context) {
    NumCounter numcount = Provider.of<NumCounter>(context);
    int numOfItem = numcount.numOfItem;

    return Row(
      children: <Widget>[
        buildOutlineButton(
          icon: Icons.remove,
          press: () {
            if (numOfItem > 1) {
              Provider.of<NumCounter>(context, listen: false).minus();
              // setState(() {
              //   numOfItem--;
              // });
            }
          },
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            // if our item is less  then 10 then  it shows 01 02 like that
            numOfItem.toString().padLeft(2, "0"),
            style: Theme.of(context).textTheme.headline6.copyWith(color:Colors.black)
          ),
        ),
        buildOutlineButton(
            icon: Icons.add,
            press: () {
              Provider.of<NumCounter>(context, listen: false).puls();
              // setState(() {
              //   numOfItem++;
              // });
            }),
      ],
    );
  }

  SizedBox buildOutlineButton({IconData icon, Function press}) {
    return SizedBox(
      width: 40,
      height: 32,
      child: OutlineButton(
        padding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(13),
        ),
        onPressed: press,
        child: Icon(icon),
      ),
    );
  }
}
