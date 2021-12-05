import 'package:e_shop/Buyer/Screens/Chat/chat_page.dart';

import 'package:e_shop/Seller/Screens/SellerHome/Components/homepage_data.dart';
import 'package:e_shop/Seller/Screens/seller_notification_page.dart';
import 'package:e_shop/Seller/Screens/seller_profile_page.dart';
import 'package:e_shop/size_config.dart';
import 'package:flutter/material.dart';
import '../seller_bottom_bar.dart';

class SellerHome extends StatefulWidget {
  @override
  _SellerHomeState createState() => _SellerHomeState();
}

class _SellerHomeState extends State<SellerHome>
    with TickerProviderStateMixin<SellerHome> {
  TabController bottomTabController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    bottomTabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    Widget appBar = Container(
      height: kToolbarHeight + MediaQuery.of(context).padding.top,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          IconButton(
              onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => SellerNotificationsPage())),
              icon: Icon(Icons.notifications)),
          Spacer(),
        ],
      ),
    );
    SizeConfig().init(context);
    return Scaffold(
      bottomNavigationBar: SellerBottomBar(controller: bottomTabController),
      body: CustomPaint(
        child: TabBarView(
          controller: bottomTabController,
          physics: NeverScrollableScrollPhysics(),
          children: <Widget>[
            Scaffold(
              body: SafeArea(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 12),
                    child: Column(
                      children: [
                        appBar,
                        HomePageData(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            ChatPage(),
            SellerProfile(),
          ],
        ),
      ),
    );
  }
}
