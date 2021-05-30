import 'package:e_shop/Buyer/Screens/Authentication/login.dart';
import 'package:e_shop/app_properties.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import 'Seller/Screens/Auth/seller_login.dart';

class StartPage extends StatefulWidget {
  @override
  _StartPageState createState() => _StartPageState();
}

class _StartPageState extends State<StartPage>
    with SingleTickerProviderStateMixin {
  bool signUp = false;
  TabController controller;
  @override
  void initState() {
    super.initState();
    controller = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return Scaffold(
          backgroundColor: kYellow,
          body: CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                backgroundColor: kYellow,
                title: Center(
                  child: Text(
                    'Choose Account Type',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 19.sp,
                        fontFamily: "NunitoReg",
                        fontWeight: FontWeight.w700),
                  ),
                ),
                bottom: PreferredSize(
                  preferredSize: Size.fromHeight(10.h),
                  child: Theme(
                    data: Theme.of(context).copyWith(accentColor: Colors.black),
                    child: Card(
                      shadowColor: kYellow,
                      margin: EdgeInsets.only(left: 13.w, right: 13.w),
                      elevation: 4,
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(10), // Creates border
                            color: Colors.white),
                        height: 6.h,
                        width: 80.w,
                        alignment: Alignment.center,
                        child: TabBar(
                          indicator: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(10), // Creates border
                              color: kDarkYellow),
                          labelColor: Colors.white,
                          unselectedLabelColor: Colors.black,
                          indicatorWeight: 2,
                          labelStyle: TextStyle(
                              fontSize: 14.sp, fontFamily: "NunitoBold"),
                          tabs: [
                            Tab(text: 'Buyer'),
                            Tab(text: 'Seller'),
                          ],
                          controller: controller,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SliverFillRemaining(
                child: TabBarView(
                  controller: controller,
                  children: <Widget>[
                    Center(child: Login()),
                    Center(child: SellerLogin()),
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
