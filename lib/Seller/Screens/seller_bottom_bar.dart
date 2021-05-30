import 'package:e_shop/app_properties.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SellerBottomBar extends StatelessWidget {
  final TabController controller;

  const SellerBottomBar({Key key, this.controller}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          IconButton(
            icon: SvgPicture.asset(
              'assets/icons/home_icon.svg',
              fit: BoxFit.fitWidth,
            ),
            onPressed: () {
              controller.animateTo(0);
            },
          ),
          IconButton(
            icon: SvgPicture.asset(
              'assets/icons/chat.svg',
              fit: BoxFit.fitWidth,
            ),
            onPressed: () {
              controller.animateTo(1);
            },
          ),
          IconButton(
            icon: Image.asset('assets/icons/profile_icon.png'),
            onPressed: () {
              controller.animateTo(2);
            },
          )
        ],
      ),
    );
  }
}
