import 'package:e_shop/Buyer/Screens/Authentication/login.dart';
import 'package:e_shop/Buyer/Screens/shop/shop_details_page.dart';
import 'package:e_shop/Buyer/Screens/shop/shop_product/home_screen.dart';
import 'package:e_shop/Buyer/Screens/shop/shop_reviews_page.dart';
import 'package:e_shop/Seller/Screens/Auth/seller_login.dart';
import 'package:e_shop/app_properties.dart';
import 'package:e_shop/config.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class ShopPage extends StatefulWidget {
  @override
  _ShopPageState createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage>
    with SingleTickerProviderStateMixin {
  TabController controller;
  @override
  void initState() {
    super.initState();
    controller = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    Widget profileHeader = Stack(
      children: [
        Container(
          height: height / 3.5,
          color: Colors.white,
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 4.5,
                decoration: BoxDecoration(
                  color: kYellow,
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage('assets/Store.jpg'),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    AppBar(
                      toolbarHeight:
                          MediaQuery.of(context).padding.top + kToolbarHeight,
                      elevation: 0,
                      backgroundColor: Colors.transparent,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Positioned(
          top: height / 3.4,
          left: width / 3,
          right: width / 3,
          child: Text(
            'Khan Store',
            style: TextStyle(
                color: Colors.black,
                fontSize: 22,
                fontWeight: FontWeight.bold,
                fontFamily: "Montserrat",
                fontStyle: FontStyle.italic),
          ),
        ),
        Positioned(
          right: width / 3,
          left: width / 3,
          top: height / 6.2,
          child: CircleAvatar(
            backgroundColor: kYellow,
            radius: 52,
            child: CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(
                EcommerceApp.sharedPreferences
                    .getString(EcommerceApp.userAvatarUrl),
              ),
            ),
          ),
        ),
      ],
    );
    Widget rowButtons = Container(
      margin: EdgeInsets.all(8),
      padding: EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {},
              child: Container(
                padding: EdgeInsets.only(left: 25),
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                  color: kYellow,
                ),
                child: Row(
                  children: [
                    Icon(Icons.location_on),
                    SizedBox(
                      width: 4,
                    ),
                    Text(
                      "Find Us",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    )
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            width: 14,
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {},
              child: Container(
                padding: EdgeInsets.only(left: 25),
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                  color: Colors.blueGrey.shade200,
                ),
                child: Row(
                  children: [
                    Icon(Icons.chat),
                    SizedBox(
                      width: 4,
                    ),
                    Text(
                      "Message",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    )
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            width: 14,
          ),
          GestureDetector(
            onTap: () {},
            child: Container(
              padding: EdgeInsets.all(8),
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
                color: Colors.blueGrey.shade200,
              ),
              child: Icon(Icons.menu),
            ),
          )
        ],
      ),
    );

    return Sizer(
      builder: (context, orientation, deviceType) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: CustomScrollView(
            slivers: <Widget>[
              SliverToBoxAdapter(
                child: profileHeader,
              ),
              SliverToBoxAdapter(
                child: rowButtons,
              ),
              SliverAppBar(
                backgroundColor: Colors.white,
                bottom: PreferredSize(
                  preferredSize: Size.fromHeight(0.h),
                  child: Theme(
                    data: Theme.of(context).copyWith(accentColor: Colors.black),
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 8),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                                color: kTransparentYellow,
                                blurRadius: 4,
                                spreadRadius: 1,
                                offset: Offset(0, 1))
                          ]),
                      height: 6.h,
                      width: double.infinity,
                      alignment: Alignment.center,
                      child: TabBar(
                        indicator: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(10), // Creates border
                            color: kYellow),
                        labelColor: Colors.white,
                        unselectedLabelColor: Colors.black,
                        indicatorWeight: 2,
                        labelStyle: TextStyle(
                            fontSize: 14.sp, fontFamily: "NunitoBold"),
                        tabs: [
                          Tab(text: 'Details'),
                          Tab(text: 'Products'),
                          Tab(text: 'Reviews'),
                        ],
                        controller: controller,
                      ),
                    ),
                  ),
                ),
              ),
              SliverFillRemaining(
                child: TabBarView(
                  controller: controller,
                  children: <Widget>[
                    ShopDetailsPage(),
                    HomeScreen(),
                    ShopReviewsPage()
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
