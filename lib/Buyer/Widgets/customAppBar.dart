import 'package:e_shop/Buyer/Counters/cartitemcounter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyAppBar extends StatelessWidget with PreferredSizeWidget {
  final PreferredSizeWidget bottom;
  MyAppBar({this.bottom});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      iconTheme: IconThemeData(
        color: Colors.white,
      ),
      flexibleSpace: Container(
        decoration: new BoxDecoration(
          gradient: new LinearGradient(
              colors: [Colors.pink, Colors.lightGreenAccent],
              begin: new FractionalOffset(0.0, 0.0),
              end: new FractionalOffset(1.0, 0.0),
              stops: [0.0, 1.0],
              tileMode: TileMode.clamp),
        ),
      ),
      title: Text(
        'e-Shop',
        style: TextStyle(
          fontSize: 55.0,
          color: Colors.white,
          fontFamily: "Signatra",
        ),
      ),
      centerTitle: true,
      actions: [
        Stack(
          children: [
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(),
                );
              },
              icon: Icon(
                Icons.shopping_cart,
                color: Colors.pink,
              ),
            ),
            Positioned(
              child: Stack(
                children: [
                  Icon(
                    Icons.brightness_1,
                    size: 20.0,
                    color: Colors.green,
                  ),
                  Positioned(
                    child: Consumer<CartItemCounter>(
                      builder: (context, counter, _) {
                        return Text(
                          counter.count.toString(),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12.0,
                            fontWeight: FontWeight.w500,
                          ),
                        );
                      },
                    ),
                    top: 3.0,
                    bottom: 4.0,
                    left: 6,
                  )
                ],
              ),
            ),
          ],
        )
      ],
      bottom: bottom,
    );
  }

  Size get preferredSize => bottom == null
      ? Size(56, AppBar().preferredSize.height)
      : Size(56, 80 + AppBar().preferredSize.height);
}
