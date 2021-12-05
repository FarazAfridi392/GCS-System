import 'package:e_shop/Seller/Widgets/order_products_detail.dart';
import 'package:e_shop/app_properties.dart';
import 'package:e_shop/models/product.dart';
import 'package:e_shop/services/database/product_database_helper.dart';
import 'package:e_shop/services/database/user_database_helper.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

import '../../utils.dart';

class OrderDetailspage extends StatefulWidget {
  final String orderedProductDate;
  String ordererName;
  String phoneNo;
  String ordererAdressType;
  String ordererAdress;
  final String orderId;
  final String productId;
  OrderDetailspage(
      {this.productId,
      this.orderedProductDate,
      this.ordererName,
      this.phoneNo,
      this.ordererAdressType,
      this.ordererAdress,
      this.orderId});
  @override
  _OrderDetailspageState createState() => _OrderDetailspageState();
}

class _OrderDetailspageState extends State<OrderDetailspage> {
  String dropdownValue = 'Pending';
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
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: kYellow,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
            size: 18,
          ),
        ),
        title: Text(
          'Order Details',
          style: kBoldedText.copyWith(
            fontSize: 14,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () async {
              final confirmation = await showConfirmationDialog(
                context,
                "Do you really want to proceed for completing the order of this Product?",
              );
              if (confirmation == false) {
                return;
              }
              await UserDatabaseHelper()
                  .deleteOrderForCurrentSeller(widget.orderId);
              Navigator.pop(context);
            },
            child: Text(
              'Mark Completed',
              style: kBoldedText.copyWith(fontSize: 14, color: Colors.red),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: FutureBuilder<Product>(
          future: ProductDatabaseHelper().getProductWithID(widget.productId),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final product = snapshot.data;
              return Column(
                children: [
                  Container(
                    color: Colors.white,
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 1.4,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Text(
                              'Order Id: ' + widget.orderId,
                              style: kOrderCodeTextStyle,
                            ),
                          ),
                          horizontalLine,
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Text(
                              'Customer Name: ' + widget.ordererName,
                              style: kOrderCodeTextStyle,
                            ),
                          ),
                          horizontalLine,
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Text(
                              'Order date : ' + widget.orderedProductDate,
                              style: kCommonTextStyle,
                            ),
                          ),
                          horizontalLine,
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Text(
                              'Order status : $dropdownValue',
                              style: kCommonTextStyle,
                            ),
                          ),
                          horizontalLine,
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Text(
                              'Total order amount : ' +
                                  product.discountPrice.toString(),
                              style: kCommonTextStyle,
                            ),
                          ),
                          horizontalLine,
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Text(
                              'Contact : ' + widget.phoneNo,
                              style: kCommonTextStyle,
                            ),
                          ),
                          horizontalLine,
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Text(
                              'Payment method : Credit Card',
                              style: kCommonTextStyle,
                            ),
                          ),
                          horizontalLine,
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  OrdersProductDetails(
                    productName: product.title,
                    productAmount: product.discountPrice.toString(),
                    productImageUrl: product.images[0],
                    status: dropdownValue,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    color: Colors.white,
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 5,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20.0, top: 22.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'ADRESS',
                            style: kCommonTextStyle,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: Text(
                              widget.ordererAdressType,
                              style: kBoldedText.copyWith(fontSize: 15),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 5.0),
                            child: Text(
                              widget.ordererAdress,
                              style: kOrderDetailsText,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    color: Colors.white,
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 3,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20.0, top: 22.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Order Amount',
                            style: kCommonTextStyle,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 10.0, right: 40.0, bottom: 10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Subtotal',
                                  style: kOrderDetailsText,
                                ),
                                Text(
                                  product.discountPrice.toString(),
                                  style: kOrderDetailsText,
                                ),
                              ],
                            ),
                          ),
                          horizontalLine,
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 10.0, right: 40.0, bottom: 10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Shipping Charge',
                                  style: kOrderDetailsText,
                                ),
                                Text(
                                  'Rs. 25.00',
                                  style: kOrderDetailsText,
                                ),
                              ],
                            ),
                          ),
                          horizontalLine,
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 10.0, right: 40.0, bottom: 10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Tax.',
                                  style: kOrderDetailsText,
                                ),
                                Text(
                                  'Rs.0.000',
                                  style: kOrderDetailsText,
                                ),
                              ],
                            ),
                          ),
                          horizontalLine,
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 10.0, right: 40.0, bottom: 10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Total',
                                  style:
                                      kOrderDetailsText.copyWith(fontSize: 15),
                                ),
                                Text(
                                  (product.discountPrice + 25).toString(),
                                  style:
                                      kOrderDetailsText.copyWith(fontSize: 15),
                                ),
                              ],
                            ),
                          ),
                          horizontalLine,
                        ],
                      ),
                    ),
                  ),
                ],
              );
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              final error = snapshot.error.toString();
              Logger().e(error);
            }
            return Center(
              child: Icon(
                Icons.error,
                color: kTextColor,
                size: 60,
              ),
            );
          },
        ),
      ),
    );
  }
}
