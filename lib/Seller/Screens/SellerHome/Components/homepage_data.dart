import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_shop/Seller/Screens/order_detail._page.dart';
import 'package:e_shop/Seller/Widgets/dash_card.dart';
import 'package:e_shop/Seller/Widgets/order_card.dart';
import 'package:e_shop/Seller/Widgets/order_products_detail.dart';
import 'package:e_shop/app_properties.dart';
import 'package:e_shop/components/nothingtoshow_container.dart';
import 'package:e_shop/components/product_short_detail_card.dart';
import 'package:e_shop/config.dart';
import 'package:e_shop/models/address.dart';
import 'package:e_shop/models/orderedProduct.dart';
import 'package:e_shop/models/orderedProduct.dart';
import 'package:e_shop/models/product.dart';
import 'package:e_shop/models/reeview.dart';
import 'package:e_shop/my_orders/components/product_review_dialog.dart';
import 'package:e_shop/product_details/product_details_screen.dart';
import 'package:e_shop/services/authentification/authentification_service.dart';
import 'package:e_shop/services/data_streams/ordered_products_stream.dart';
import 'package:e_shop/services/database/product_database_helper.dart';
import 'package:e_shop/services/database/user_database_helper.dart';
import 'package:e_shop/size_config.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

import '../../../../constants.dart' as cons;

class HomePageData extends StatefulWidget {
  const HomePageData({
    Key key,
  }) : super(key: key);

  @override
  _HomePageDataState createState() => _HomePageDataState();
}

class _HomePageDataState extends State<HomePageData> {
  final OrderedProductsStream orderedProductsStream = OrderedProductsStream();

  String a1;
  String a2;
  String a3;
  String a4;
  String a5;
  String a6;
  String noOrder = 'fjdlfjdlfj';

  Future addAddressForCurrentUser(String uid) async {
    List<String> addressIds =
        await UserDatabaseHelper().addressesListofOrderer(uid);

    Address address = await UserDatabaseHelper()
        .getAddressofOrdererFromId(addressIds[0], uid);
    a1 = address.addresLine1;
    a2 = address.title;
    a3 = address.addressLine2;
    a4 = address.phone;
    a5 = address.receiver;
    a6 = address.state;
  }

  @override
  void initState() {
    super.initState();

    orderedProductsStream.init();
  }
  @override
  void setState(VoidCallback fn) {
    // TODO: implement setState
    super.setState(fn);
  }

  @override
  void dispose() {
    super.dispose();
    orderedProductsStream.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // ignore: avoid_unnecessary_containers

    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 29, top: 25),
            child: Text(
              'Last Month Earnings',
              style: kCommonTextStyle,
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 29.0, top: 6),
            child: Text('Rs. 100000', style: kBoldedText),
          ),
          Container(
            margin: const EdgeInsets.all(12),
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      color: kTransparentYellow,
                      blurRadius: 4,
                      spreadRadius: 1,
                      offset: Offset(0, 1))
                ]),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    top: 19,
                    bottom: 14,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      DashCard(
                        colour: Color(0xFFFFE9EA),
                        images: Image.asset('assets/products.png'),
                        numbers: '04',
                        names: 'Products',
                      ),
                      DashCard(
                        colour: Color(0xFFE2EDFF),
                        images: Image.asset('assets/cart.png'),
                        numbers: '10',
                        names: 'Total Sale',
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 19),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      DashCard(
                        colour: Color(0xFFF0E3FF),
                        images: Image.asset('assets/earning.png'),
                        numbers: '1000',
                        names: 'Totla Earnings',
                      ),
                      DashCard(
                        colour: Color(0xFFFFE9EA),
                        images: Image.asset('assets/sucess.png'),
                        numbers: '26',
                        names: 'Successful Orders',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const Padding(
            padding: const EdgeInsets.only(left: 29.0),
            child: Text('New Orders', style: TextStyle()),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15.0, right: 15),
            child: SizedBox(
              height: SizeConfig.screenHeight * 0.75,
              child: Column(
                children: [
                  Expanded(child: buildOrderedProductsList()),
                  noOrder == 'this user has no order'
                      ? Container(
                          height: MediaQuery.of(context).size.height * 0.7,
                          child: const Center(
                            child: NothingToShowContainer(
                              iconPath: 'assets/icons/empty_bag.svg',
                              secondaryMessage:
                                  'You have no orders to show here',
                            ),
                          ),
                        )
                      : const SizedBox(
                          height: 1,
                        )
                ],
              ),
            ),
          ),
          // Center(
          //   child: Column(
          //     children: [
          // OrderList(
          //   date: 'Wed, May 27, 08:20 PM',
          //   productname: 'Iphone 11 pro',
          //   code: '12432142354',
          //   amount: '#49.99',
          //   status: 'Pending',
          // ),
          //       OrderList(
          //         date: 'Wed, May 27, 08:20 PM',
          //         productname: 'Habib Oil 5kg',
          //         code: '12432142354',
          //         amount: '#49.99',
          //         status: 'Pending',
          //       ),
          //       OrderList(
          //         date: 'Wed, May 27, 08:20 PM',
          //         productname: 'Poco F2',
          //         code: '12432142354',
          //         amount: '#49.99',
          //         status: 'Pending',
          //       ),
          //       OrderList(
          //         date: 'Wed, May 27, 08:20 PM',
          //         productname: 'Battery Cells',
          //         code: '12432142354',
          //         amount: '#49.99',
          //         status: 'Pending',
          //       ),
          //     ],
          //   ),
          // ),
        ],
      ),
    );
  }

  Future<void> refreshPage() {
    orderedProductsStream.reload();
    return Future<void>.value();
  }

  Widget buildOrderedProductsList() {
    
    return StreamBuilder<List<String>>(
      stream: UserDatabaseHelper().orderedProductsListFromOrder.asStream(),
      builder: (context, snapshot) {
        noOrder = 'this user has no order';
        if (snapshot.hasData) {
          final orderedProductsIds = snapshot.data;
          if (orderedProductsIds.length == 0) {
            return const Center(
              child: NothingToShowContainer(
                iconPath: 'assets/icons/empty_bag.svg',
                secondaryMessage: 'You have no orders to show here',
              ),
            );
          }
          return ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: orderedProductsIds.length,
            itemBuilder: (context, index) {
              return FutureBuilder<OrderedProduct>(
                future: UserDatabaseHelper()
                    .getOrderedProductFromOrder(orderedProductsIds[index]),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final orderedProduct = snapshot.data;

                    print(noOrder);
                    return buildOrderedProductItem(orderedProduct);
                  } else if (snapshot.connectionState ==
                      ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    final error = snapshot.error.toString();
                    Logger().e(error);
                  }
                  return const Icon(
                    Icons.error,
                    size: 60,
                    color: kTextColor,
                  );
                },
              );
            },
          );
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          final error = snapshot.error;
          Logger().w(error.toString());
        }

        return const Center(
          child: NothingToShowContainer(
            iconPath: 'assets/icons/network_error.svg',
            primaryMessage: 'Something went wrong',
            secondaryMessage: 'Unable to connect to Database',
          ),
        );
      },
    );
  }

  Widget buildOrderedProductItem(OrderedProduct orderedProduct) {
    return FutureBuilder<Product>(
      future:
          ProductDatabaseHelper().getProductWithID(orderedProduct.productUid),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final product = snapshot.data;

          if (product.owner == EcommerceApp.auth.currentUser.uid) {
            addAddressForCurrentUser(orderedProduct.currentUserUid);
            noOrder = 'this user has orders';
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 6),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 12,
                      horizontal: 16,
                    ),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: kTextColor.withOpacity(0.12),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(16),
                        topRight: Radius.circular(16),
                      ),
                    ),
                    child: Text.rich(
                      TextSpan(
                        text: 'Ordered on:  ',
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                        ),
                        children: [
                          TextSpan(
                            text: orderedProduct.orderDate,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 4,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      border: Border.symmetric(
                        vertical: BorderSide(
                          color: kTextColor.withOpacity(0.15),
                        ),
                      ),
                    ),
                    child: ProductShortDetailCard(
                      productId: product.id,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => OrderDetailspage(
                                orderId: orderedProduct.id,
                                orderedProductDate: orderedProduct.orderDate,
                                productId: product.id,
                                ordererName: a5,
                                phoneNo: a4,
                                ordererAdressType: a2,
                                ordererAdress: '$a1 $a3 $a6'),
                          ),
                        ).then((_) async {
                          await refreshPage();
                        });
                      },
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 2,
                    ),
                    decoration: const BoxDecoration(
                      color: cons.kPrimaryColor,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(16),
                        bottomRight: Radius.circular(16),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          final error = snapshot.error.toString();
          Logger().e(error);
        }

        return const SizedBox();
      },
    );
  }
}
