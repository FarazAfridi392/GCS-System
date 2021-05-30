import 'package:e_shop/Seller/Widgets/dash_card.dart';
import 'package:e_shop/Seller/Widgets/order_card.dart';
import 'package:e_shop/app_properties.dart';
import 'package:flutter/material.dart';

class HomePageData extends StatefulWidget {
  const HomePageData({
    Key key,
  }) : super(key: key);

  @override
  _HomePageDataState createState() => _HomePageDataState();
}

class _HomePageDataState extends State<HomePageData> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 29, top: 25),
            child: Text(
              'Last Month Earnings',
              style: kCommonTextStyle,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 29.0, top: 6),
            child: Text('Rs. 100000', style: kBoldedText),
          ),
          Container(
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
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 29.0),
            child: Text('New Orders', style: TextStyle()),
          ),
          SizedBox(
            height: 20,
          ),
          Center(
            child: Column(
              children: [
                OrderList(
                  date: 'Wed, May 27, 08:20 PM',
                  productname: 'Iphone 11 pro',
                  code: '12432142354',
                  amount: '#49.99',
                  status: 'Pending',
                ),
                OrderList(
                  date: 'Wed, May 27, 08:20 PM',
                  productname: 'Habib Oil 5kg',
                  code: '12432142354',
                  amount: '#49.99',
                  status: 'Pending',
                ),
                OrderList(
                  date: 'Wed, May 27, 08:20 PM',
                  productname: 'Poco F2',
                  code: '12432142354',
                  amount: '#49.99',
                  status: 'Pending',
                ),
                OrderList(
                  date: 'Wed, May 27, 08:20 PM',
                  productname: 'Battery Cells',
                  code: '12432142354',
                  amount: '#49.99',
                  status: 'Pending',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
