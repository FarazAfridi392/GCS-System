import 'package:e_shop/app_properties.dart';
import 'package:flutter/material.dart';

class ShopDetailsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Widget horizontalLine = Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      child: Container(
        height: 1.0,
        width: 300,
        color: Colors.grey[200],
      ),
    );
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Container(
            color: Colors.white,
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text(
                      'Shop Name: Khan Store',
                      style: kOrderCodeTextStyle,
                    ),
                  ),
                  horizontalLine,
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text(
                      'Owner Name: Hanzla Ahmed',
                      style: kOrderCodeTextStyle,
                    ),
                  ),
                  horizontalLine,
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text(
                      'Email : owner@example.com',
                      style: kCommonTextStyle,
                    ),
                  ),
                  horizontalLine,
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text(
                      'Address : Shop # 30, Kamal Plaza, Islamabad',
                      style: kCommonTextStyle,
                    ),
                  ),
                  horizontalLine,
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text(
                      'Contact : 0313 4534567',
                      style: kCommonTextStyle,
                    ),
                  ),
                  horizontalLine,
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text(
                      'Date Created : 5-27-2021',
                      style: kCommonTextStyle,
                    ),
                  ),
                  horizontalLine,
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text(
                      'Shop Description: Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
                      style: kCommonTextStyle,
                    ),
                  ),
                  horizontalLine,
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
