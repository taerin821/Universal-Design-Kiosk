import 'package:flutter/material.dart';
import 'package:flutter_kiosk_ui/models/Product_provider.dart';
import 'package:flutter_kiosk_ui/screens/camera/cameraScreen_.dart';
import 'package:flutter_kiosk_ui/screens/cart/cart_screen.dart';
import 'package:flutter_kiosk_ui/screens/touchscreen/TouchScreen.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';

import 'constants.dart';
import 'screens/home/home_screen.dart';
import 'screens/first_Screen/firstscreen.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => NumCounter()),
    // ChangeNotifierProxyProvider<Product, CartModel>(
    //     create: (context) => CartModel(),
    //     update: (context, product, cart) {
    //       if (cart = null) throw ArgumentError.notNull('cart');
    //       cart.menu = product;
    //       return cart;
    //     })
  ], child: MyApp()));
}

// void main() {
//   runApp(MyApp());
// }

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'KIOSK ODER',
      theme: ThemeData(
        textTheme: Theme.of(context).textTheme.apply(bodyColor: kTextColor),
        visualDensity: VisualDensity.adaptivePlatformDensity,
        // fontFamily: 'fifth'
        // fontFamily: GoogleFonts.getFont("NoteSansKR"),
        // primarySwatch: Colors.blue,
        // primaryColor: Colors.white,
        // accentColor: Colors.black,
      ),
      home: TouchScreen(),
      routes: {
        'camera': (BuildContext) => CameraScreen(),
        'cart': (BuildContext) => CartScreen()
      },
    );
  }
}
