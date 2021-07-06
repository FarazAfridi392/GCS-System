import 'dart:async';
import 'package:e_shop/Buyer/Counters/itemQuantity.dart';
import 'package:e_shop/Buyer/Screens/shop/storehome.dart';
import 'package:e_shop/Seller/Screens/SellerHome/mainPage.dart';
import 'package:e_shop/googleMap.dart';
import 'package:e_shop/start_Page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:e_shop/config.dart';
import 'Buyer/Counters/cartitemcounter.dart';
import 'Buyer/Counters/changeAddresss.dart';
import 'Buyer/Counters/totalMoney.dart';
import 'app_properties.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  EcommerceApp.auth = FirebaseAuth.instance;
  EcommerceApp.sharedPreferences = await SharedPreferences.getInstance();
  runApp(GoogleMapWidg());
  // runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (c) => CartItemCounter(),
        ),
        ChangeNotifierProvider(
          create: (c) => ItemQuantity(),
        ),
        ChangeNotifierProvider(
          create: (c) => AddressChanger(),
        ),
        ChangeNotifierProvider(
          create: (c) => TotalAmount(),
        ),
      ],
      child: MaterialApp(
        title: 'e-Shop',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Colors.green,
        ),
        home: SplashScreen(),
      ),
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  Animation<double> opacity;
  AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        duration: Duration(milliseconds: 2500), vsync: this);
    opacity = Tween<double>(begin: 1.0, end: 0.0).animate(controller)
      ..addListener(() {
        setState(() {});
      });
    controller.forward().then((_) {
      displaySplash();
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  displaySplash() {
    Timer(
      Duration(seconds: 5),
      () async {
        if (await EcommerceApp.auth.currentUser != null &&
            EcommerceApp.sharedPreferences.getBool(EcommerceApp.boolSeller) ==
                false) {
          print(
              EcommerceApp.sharedPreferences.getBool(EcommerceApp.boolSeller));
          Route route = MaterialPageRoute(
            builder: (_) => StoreHome(),
          );
          Navigator.pushReplacement(context, route);
        } else if (await EcommerceApp.auth.currentUser != null &&
            EcommerceApp.sharedPreferences.getBool(EcommerceApp.boolSeller) ==
                true) {
          Route route = MaterialPageRoute(
            builder: (_) => SellerHome(),
          );
          Navigator.pushReplacement(context, route);
        } else {
          Route route = MaterialPageRoute(
            builder: (_) => StartPage(),
          );
          Navigator.pushReplacement(context, route);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/background.jpg'), fit: BoxFit.cover)),
        child: SafeArea(
          child: new Scaffold(
            backgroundColor: kTransparentYellow,
            body: Column(
              children: <Widget>[
                Expanded(
                  child: Opacity(
                      opacity: opacity.value,
                      child: new Image.asset('assets/logo.png')),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: RichText(
                    text: TextSpan(
                        style: TextStyle(color: Colors.black),
                        children: [
                          TextSpan(
                              text: 'Galaxy City Shopping System',
                              style: TextStyle(fontWeight: FontWeight.bold))
                        ]),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
