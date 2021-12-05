import 'package:e_shop/Buyer/models/product.dart';
import 'package:e_shop/Seller/Widgets/drop_down._button.dart';
import 'package:e_shop/app_properties.dart';
import 'package:flutter/material.dart';

class OrdersProductDetails extends StatelessWidget {
  String productName;
  String productAmount;
  String productImageUrl;
  String status;
  OrdersProductDetails({
    this.productName,
    this.productAmount,
    this.productImageUrl,
    this.status,
    Key key,
  }) : super(key: key);

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
    return Container(
      color: Colors.white,
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height / 4,
      child: Padding(
        padding: const EdgeInsets.only(left: 20.0, top: 25.0),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                    height: 50,
                    width: 50,
                    child: Image.network(
                      productImageUrl,
                      fit: BoxFit.fill,
                    )),
                Padding(
                  padding: const EdgeInsets.only(left: 18.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        productName,
                        style: kDashBoardText.copyWith(fontSize: 14),
                      ),
                      Text(
                        'ID #2422434643',
                        style: kBoldedText.copyWith(fontSize: 10),
                      ),
                      Row(
                        children: [
                          Text(
                            productAmount,
                            style: kDashBoardText.copyWith(
                              fontSize: 15,
                              color: Color(0xFFFF6969),
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 3.9,
                          ),
                          DorpDownButton(),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 20,
            ),
            horizontalLine,
          ],
        ),
      ),
    );
  }
}
