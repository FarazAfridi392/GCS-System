import 'package:e_shop/Buyer/Screens/shop/storehome.dart';
import 'package:e_shop/config.dart';
import 'package:e_shop/Buyer/Screens/Authentication/login.dart';
import 'package:e_shop/Buyer/Screens/Orders/myOrders.dart';
import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          Container(
            padding: EdgeInsets.only(top: 25, bottom: 10),
            decoration: new BoxDecoration(
              gradient: new LinearGradient(
                colors: [
                  Colors.pink,
                  Colors.lightGreenAccent,
                ],
                begin: const FractionalOffset(0, 0),
                end: const FractionalOffset(1, 0),
                stops: [0, 1],
                tileMode: TileMode.clamp,
              ),
            ),
            child: Column(
              children: [
                Material(
                  borderRadius: BorderRadius.all(
                    Radius.circular(80.0),
                  ),
                  elevation: 8.0,
                  child: Container(
                    height: 160,
                    width: 160,
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(
                        EcommerceApp.sharedPreferences
                            .getString(EcommerceApp.userAvatarUrl),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Text(
                  EcommerceApp.sharedPreferences.getString(
                    EcommerceApp.userName,
                  ),
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 35,
                      fontFamily: "Signatra"),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 12.0,
          ),
          Container(
            padding: EdgeInsets.only(top: 1),
            decoration: new BoxDecoration(
              gradient: new LinearGradient(
                colors: [
                  Colors.pink,
                  Colors.lightGreenAccent,
                ],
                begin: const FractionalOffset(0, 0),
                end: const FractionalOffset(1, 0),
                stops: [0, 1],
                tileMode: TileMode.clamp,
              ),
            ),
            child: Column(
              children: [
                ListTile(
                  leading: Icon(
                    Icons.home,
                    color: Colors.white,
                  ),
                  title: Text(
                    "Home",
                    style: TextStyle(color: Colors.white),
                  ),
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (_) => StoreHome(),
                      ),
                    );
                  },
                ),
                Divider(
                  height: 10.0,
                  color: Colors.white,
                  thickness: 6.0,
                ),
                ListTile(
                  leading: Icon(
                    Icons.reorder,
                    color: Colors.white,
                  ),
                  title: Text(
                    "My Orders",
                    style: TextStyle(color: Colors.white),
                  ),
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (_) => MyOrders(),
                      ),
                    );
                  },
                ),
                Divider(
                  height: 10.0,
                  color: Colors.white,
                  thickness: 6.0,
                ),
                ListTile(
                  leading: Icon(
                    Icons.shopping_cart,
                    color: Colors.white,
                  ),
                  title: Text(
                    "My Cart",
                    style: TextStyle(color: Colors.white),
                  ),
                  onTap: () {},
                ),
                Divider(
                  height: 10.0,
                  color: Colors.white,
                  thickness: 6.0,
                ),
                ListTile(
                  leading: Icon(
                    Icons.search,
                    color: Colors.white,
                  ),
                  title: Text(
                    "Search",
                    style: TextStyle(color: Colors.white),
                  ),
                  onTap: () {},
                ),
                Divider(
                  height: 10.0,
                  color: Colors.white,
                  thickness: 6.0,
                ),
                ListTile(
                  leading: Icon(
                    Icons.add_location,
                    color: Colors.white,
                  ),
                  title: Text(
                    "Add New Address",
                    style: TextStyle(color: Colors.white),
                  ),
                  onTap: () {},
                ),
                Divider(
                  height: 10.0,
                  color: Colors.white,
                  thickness: 6.0,
                ),
                ListTile(
                  leading: Icon(
                    Icons.logout,
                    color: Colors.white,
                  ),
                  title: Text(
                    "Logout",
                    style: TextStyle(color: Colors.white),
                  ),
                  onTap: () {
                    EcommerceApp.auth.signOut().then(
                      (_) {
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (_) => Login()));
                      },
                    );
                  },
                ),
                Divider(
                  height: 10.0,
                  color: Colors.white,
                  thickness: 6.0,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
