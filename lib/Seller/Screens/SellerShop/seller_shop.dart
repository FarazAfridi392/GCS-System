import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_shop/Buyer/Screens/custom_background.dart';
import 'package:e_shop/Seller/Screens/SellerShop/edit_location.dart';
import 'package:e_shop/Seller/Screens/edit_product/edit_product_screen.dart';
import 'package:e_shop/Seller/Widgets/shop_manage_card.dart';
import 'package:e_shop/Seller/my_products/my_products_screen.dart';
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

    Widget rowButtons = Container(
      margin: EdgeInsets.all(8),
      padding: EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => EditLocation(),
                  ),
                );
              },
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
                    Expanded(child: Icon(Icons.edit_location_alt_outlined)),
                    Text(
                      "Edit Location",
                      style:
                          // ignore: prefer_const_constructors
                          TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
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
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => EditProductScreen(),
                  ),
                );
              },
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
                    Expanded(child: Icon(Icons.add)),
                    SizedBox(
                      width: 4,
                    ),
                    Text(
                      "Add Product",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
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

    // Widget manageShop = Expanded(
    //     child: Container(
    //   margin: EdgeInsets.all(8),
    //   decoration: BoxDecoration(
    //       borderRadius: BorderRadius.all(Radius.circular(10)),
    //       color: Colors.white,
    //       boxShadow: [
    //         BoxShadow(
    //             color: kTransparentYellow,
    //             blurRadius: 4,
    //             spreadRadius: 1,
    //             offset: Offset(0, 1))
    //       ]),
    //   child: Row(
    //     children: [
    //       Expanded(
    //         child: Container(
    //           child: Column(
    //             children: [
    //               ManageCard(
    //                 onTap: () {
    //                   Navigator.push(
    //                     context,
    //                     MaterialPageRoute(
    //                       builder: (context) => MyProductsScreen(),
    //                     ),
    //                   );
    //                 },
    //                 color: Color(0xFFE2EDFF),
    //                 text: "My Products",
    //                 icon: Icons.shopping_bag_outlined,
    //               ),
    //               ManageCard(
    //                 color: Color(0xFFF0E3FF),
    //                 text: "Ravenue",
    //                 icon: Icons.attach_money,
    //               ),
    //               ManageCard(
    //                 color: Color(0xFFFFE9EA),
    //                 text: "Compaigns",
    //                 icon: Icons.card_giftcard_rounded,
    //               ),
    //             ],
    //           ),
    //         ),
    //       ),
    //       Expanded(
    //         child: Container(
    //           child: Column(
    //             children: [
    //               ManageCard(
    //                 color: Color(0xFFFFE9EA),
    //                 text: "My Orders",
    //                 image: "assets/icons/note.png",
    //               ),
    //               ManageCard(
    //                 color: Color(0xFFF0E3FF),
    //                 text: "Statistics",
    //                 icon: Icons.assessment_outlined,
    //               ),
    //               ManageCard(
    //                 color: Color(0xFFE2EDFF),
    //                 text: "Customers",
    //                 icon: Icons.people_alt_outlined,
    //               ),
    //             ],
    //           ),
    //         ),
    //       )
    //     ],
    //   ),
    // ));
    return Scaffold(
      backgroundColor: Colors.white,
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('Shop').snapshots(),
        // ignore: missing_return
        builder: (context, snapshot) {
          if (snapshot.data == null) return CircularProgressIndicator();
          // ignore: omit_local_variable_types
          for (int i = 0; i < snapshot.data.docs.length; i++) {
            // print(snapshot.data.docs[i]['shopId'].toString() + 'hi');
            // print(EcommerceApp.auth.currentUser.uid.toString());
            if (snapshot.data.docs[i]['shopId'].toString() ==
                EcommerceApp.auth.currentUser.uid.toString()) {
              return SafeArea(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        Container(
                          height: height / 3.2,
                          color: Colors.white,
                          child: Column(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width,
                                height:
                                    MediaQuery.of(context).size.height / 4.5,
                                decoration: const BoxDecoration(
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
                                          MediaQuery.of(context).padding.top +
                                              kToolbarHeight,
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
                          right: width / 3,
                          left: width / 3,
                          top: height / 6.2,
                          child: CircleAvatar(
                            backgroundColor: kYellow,
                            radius: 48,
                            child: CircleAvatar(
                              radius: 46,
                              backgroundImage: NetworkImage(
                                EcommerceApp.sharedPreferences
                                    .getString(EcommerceApp.userAvatarUrl),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      snapshot.data.docs[i]['ShopName'],
                      // ignore: prefer_const_constructors
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          fontFamily: "Montserrat",
                          fontStyle: FontStyle.italic),
                    ),
                    SizedBox(height: 3),
                    rowButtons,
                    Expanded(child: MyProductsScreen()),
                  ],
                ),
              );
            }
          }

          // if (snapshot.data. snapshot.data.docss.contains() == null) {
          //   return createShop();
          // } else {
          //   return MyShop();
          // }
        },
      ),
    );
  }
}
