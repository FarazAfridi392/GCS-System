import 'package:e_shop/Buyer/Screens/custom_background.dart';
import 'package:e_shop/Seller/Widgets/shop_manage_card.dart';
import 'package:e_shop/app_properties.dart';
import 'package:e_shop/config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MyShop extends StatelessWidget {
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
                padding: EdgeInsets.all(8),
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                  color: kYellow,
                ),
                child: Row(
                  children: [
                    Icon(Icons.edit_location_alt_outlined),
                    SizedBox(
                      width: 4,
                    ),
                    Text(
                      "Edit Location",
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
                padding: EdgeInsets.all(8),
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                  color: Colors.blueGrey.shade200,
                ),
                child: Row(
                  children: [
                    Icon(Icons.edit),
                    SizedBox(
                      width: 4,
                    ),
                    Text(
                      "Edit Shop",
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

    Widget manageShop = Expanded(
        child: Container(
      margin: EdgeInsets.all(12),
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
      child: Row(
        children: [
          Expanded(
            child: Container(
              child: Column(
                children: [
                  ManageCard(
                    color: Color(0xFFE2EDFF),
                    text: "My Products",
                    icon: Icons.shopping_bag_outlined,
                  ),
                  ManageCard(
                    color: Color(0xFFF0E3FF),
                    text: "Ravenue",
                    icon: Icons.attach_money,
                  ),
                  ManageCard(
                    color: Color(0xFFFFE9EA),
                    text: "Compaigns",
                    icon: Icons.card_giftcard_rounded,
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              child: Column(
                children: [
                  ManageCard(
                    color: Color(0xFFFFE9EA),
                    text: "My Orders",
                    image: "assets/icons/note.png",
                  ),
                  ManageCard(
                    color: Color(0xFFF0E3FF),
                    text: "Statistics",
                    icon: Icons.assessment_outlined,
                  ),
                  ManageCard(
                    color: Color(0xFFE2EDFF),
                    text: "Customers",
                    icon: Icons.people_alt_outlined,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    ));
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          profileHeader,
          rowButtons,
          Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: const EdgeInsets.only(top: 20, left: 16),
              child: Text(
                'SHOP MANAGEMENT',
                style: TextStyle(
                    fontSize: 16,
                    fontFamily: "Montserrat",
                    fontStyle: FontStyle.italic),
              ),
            ),
          ),
          manageShop,
        ]),
      ),
    );
  }
}
