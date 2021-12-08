import 'package:e_shop/Buyer/Screens/Authentication/login.dart';
import 'package:e_shop/Buyer/Screens/shop/shop_details_page.dart';
import 'package:e_shop/Buyer/Screens/shop/shop_product/components/item_card.dart';
import 'package:e_shop/Buyer/Screens/shop/shop_product/home_screen.dart';
import 'package:e_shop/Buyer/Screens/shop/shop_reviews_page.dart';
import 'package:e_shop/Seller/Screens/Auth/seller_login.dart';
import 'package:e_shop/Seller/product_details/product_details_screen.dart';
import 'package:e_shop/Seller/product_short_detail_card.dart';
import 'package:e_shop/app_properties.dart';
import 'package:e_shop/components/nothingtoshow_container.dart';
import 'package:e_shop/components/product_card.dart';
import 'package:e_shop/config.dart';
import 'package:e_shop/constants.dart' as pre;
import 'package:e_shop/home/components/products_section.dart';
import 'package:e_shop/home/components/section_tile.dart';
import 'package:e_shop/models/product.dart';
import 'package:e_shop/services/data_streams/all_products_stream.dart';
import 'package:e_shop/services/data_streams/users_products_stream.dart';
import 'package:e_shop/services/database/product_database_helper.dart';
import 'package:e_shop/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:logger/logger.dart';
import 'package:logger/logger.dart';
import 'package:sizer/sizer.dart';

class ShopPage extends StatefulWidget {
  @override
  _ShopPageState createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage>
    with SingleTickerProviderStateMixin {
  TabController controller;
  final UsersProductsStream usersProductsStream = UsersProductsStream();
  final AllProductsStream allProductsStream = AllProductsStream();

  @override
  void initState() {
    super.initState();
    usersProductsStream.init();
    allProductsStream.init();
  }

  @override
  void dispose() {
    super.dispose();
    usersProductsStream.dispose();
    allProductsStream.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    Widget profileHeader = FutureBuilder(
        future: ProductDatabaseHelper().getShopWithID(
          EcommerceApp.sharedPreferences.getString(EcommerceApp.shopProduct),
        ),
        builder: (context, snapshot) {
          if (snapshot.data == null) {
            Center(
              child: CircularProgressIndicator(),
            );
          }
          return Stack(
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
                            toolbarHeight: MediaQuery.of(context).padding.top +
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
                top: height / 3.4,
                left: width / 3,
                right: width / 3,
                child: const Text(
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
          );
        });
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
    Future<void> refreshPage() {
      allProductsStream.reload();
      return Future<void>.value();
    }

    void onProductCardTapped(String productId) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ProductDetailsScreen(productId: productId),
        ),
      ).then((_) async {
        await refreshPage();
      });
    }

    Column buildProductCardItems(Product product) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.network(
                product.images[0],
                fit: BoxFit.contain,
              ),
            ),
          ),
          SizedBox(height: 10),
          Flexible(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  flex: 1,
                  child: Text(
                    "${product.title}\n",
                    style: TextStyle(
                      color: kTextColor,
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                SizedBox(height: 5),
                Flexible(
                  flex: 1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        flex: 5,
                        child: Text.rich(
                          TextSpan(
                            text: "\Rs. ${product.discountPrice}\n",
                            style: TextStyle(
                              color: pre.kPrimaryColor,
                              fontWeight: FontWeight.w700,
                              fontSize: 12,
                            ),
                            children: [
                              TextSpan(
                                text: "\Rs. ${product.originalPrice}",
                                style: TextStyle(
                                  color: kTextColor,
                                  decoration: TextDecoration.lineThrough,
                                  fontWeight: FontWeight.normal,
                                  fontSize: 11,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Flexible(
                        flex: 3,
                        child: Stack(
                          children: [
                            SvgPicture.asset(
                              "assets/icons/DiscountTag.svg",
                              color: pre.kPrimaryColor,
                            ),
                            Center(
                              child: Text(
                                "${product.calculatePercentageDiscount()}%\nOff",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 8,
                                  fontWeight: FontWeight.w900,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    }

    Widget buildProductGrid(List<String> productsId) {
      return GridView.builder(
        shrinkWrap: true,
        physics: BouncingScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.7,
          crossAxisSpacing: 4,
          mainAxisSpacing: 4,
        ),
        itemCount: productsId.length,
        itemBuilder: (context, index) {
          return FutureBuilder<Product>(
            future: ProductDatabaseHelper().getProductWithID(productsId[index]),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final Product product = snapshot.data;

                if (product.owner ==
                    EcommerceApp.sharedPreferences
                        .getString(EcommerceApp.shopProduct)) {
                  return GestureDetector(
                    onTap: () {
                      onProductCardTapped.call(productsId[index]);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: kTextColor.withOpacity(0.15)),
                        borderRadius: BorderRadius.all(
                          Radius.circular(16),
                        ),
                      ),
                      child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 10),
                          child: buildProductCardItems(product)),
                    ),
                  );
                }
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: Center(child: CircularProgressIndicator()),
                );
              } else if (snapshot.hasError) {
                final error = snapshot.error.toString();
                Logger().e(error);
              }
              return SizedBox(height: 0, width: 0);
            },
          );
        },
      );
    }

    Widget buildProductsList() {
      return StreamBuilder<List<String>>(
        stream: ProductDatabaseHelper()
            .SellerProductsList(EcommerceApp.sharedPreferences
                .getString(EcommerceApp.shopProduct))
            .asStream(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data.length == 0) {
              return Center(
                child: NothingToShowContainer(
                  secondaryMessage: "Looks like this store is closed",
                ),
              );
            }
            return buildProductGrid(snapshot.data);
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            final error = snapshot.error;
            Logger().w(error.toString());
          }
          return Center(
            child: NothingToShowContainer(
              iconPath: "assets/icons/network_error.svg",
              primaryMessage: "Something went wrong",
              secondaryMessage: "Unable to connect to Database",
            ),
          );
        },
      );
    }

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
              SliverFillRemaining(
                child: SizedBox(
                    height: SizeConfig.screenHeight * 0.8,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 16,
                      ),
                      decoration: BoxDecoration(
                        color: Color(0xFFF5F6F9),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Column(
                        children: [
                          SectionTile(
                            title: "This Shop Products",
                            press: () {},
                          ),
                          SizedBox(height: getProportionateScreenHeight(15)),
                          Expanded(
                            child: buildProductsList(),
                          ),
                        ],
                      ),
                    )),
                // child: StreamBuilder<List<String>>(
                //   stream: usersProductsStream.stream,
                //   builder: (context, snapshot) {
                //     if (snapshot.hasData) {
                //       print(snapshot.data);
                //       final productsIds = snapshot.data;
                //       if (productsIds.length == 0) {
                //         return Center(
                //           child: NothingToShowContainer(
                //             secondaryMessage: "No products to show",
                //           ),
                //         );
                //       }
                //       return ListView.builder(
                //         physics: BouncingScrollPhysics(),
                //         itemCount: productsIds.length,
                //         itemBuilder: (context, index) {
                //           return FutureBuilder<Product>(
                //             future: ProductDatabaseHelper()
                //                 .getProductWithID(productsIds[index]),
                //             builder: (context, snapshot) {
                //               if (snapshot.hasData) {
                //                 final product = snapshot.data;
                //                 return GestureDetector(
                //                     onTap: () {
                //                       Navigator.push(
                //                         context,
                //                         MaterialPageRoute(
                //                           builder: (context) =>
                //                               ProductDetailsScreen(
                //                             productId: product.id,
                //                           ),
                //                         ),
                //                       );
                //                     },
                //                     child: Expanded(
                //                         child: ProductShortDetailCard(
                //                       productId: product.id,
                //                       onPressed: () {
                //                         Navigator.push(
                //                           context,
                //                           MaterialPageRoute(
                //                             builder: (context) =>
                //                                 ProductDetailsScreen(
                //                               productId: product.id,
                //                             ),
                //                           ),
                //                         );
                //                       },
                //                     )));
                //               } else if (snapshot.connectionState ==
                //                   ConnectionState.waiting) {
                //                 return Center(
                //                     child: CircularProgressIndicator());
                //               } else if (snapshot.hasError) {
                //                 final error = snapshot.error.toString();
                //                 Logger().e(error);
                //               }
                //               return Center(
                //                 child: Icon(
                //                   Icons.error,
                //                   color: kTextColor,
                //                   size: 60,
                //                 ),
                //               );
                //             },
                //           );
                //         },
                //       );
                //     } else if (snapshot.connectionState ==
                //         ConnectionState.waiting) {
                //       return Center(
                //         child: CircularProgressIndicator(),
                //       );
                //     } else if (snapshot.hasError) {
                //       final error = snapshot.error;
                //       Logger().w(error.toString());
                //     }
                //     return Center(
                //       child: NothingToShowContainer(
                //         iconPath: "assets/icons/network_error.svg",
                //         primaryMessage: "Something went wrong",
                //         secondaryMessage: "Unable to connect to Database",
                //       ),
                //     );
                //   },
                // ),
              ),
            ],
          ),
        );
      },
    );
  }
}
