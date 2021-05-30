import 'package:e_shop/Seller/Widgets/order_products_detail.dart';
import 'package:e_shop/app_properties.dart';
import 'package:flutter/material.dart';

class OrderDetailspage extends StatefulWidget {
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
      ),
      body: SingleChildScrollView(
        child: Column(
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
                        'Order Id: 12124234',
                        style: kOrderCodeTextStyle,
                      ),
                    ),
                    horizontalLine,
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Text(
                        'Customer Name: Hanzla Ahmed',
                        style: kOrderCodeTextStyle,
                      ),
                    ),
                    horizontalLine,
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Text(
                        'Email : customer@example.com',
                        style: kCommonTextStyle,
                      ),
                    ),
                    horizontalLine,
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Text(
                        'Order date : 5-27-2021 07:07 AM',
                        style: kCommonTextStyle,
                      ),
                    ),
                    horizontalLine,
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Text(
                        'Order status : Pending',
                        style: kCommonTextStyle,
                      ),
                    ),
                    horizontalLine,
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Text(
                        'Total order amount : Rs52,000.000',
                        style: kCommonTextStyle,
                      ),
                    ),
                    horizontalLine,
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Text(
                        'Contact : 8136862662',
                        style: kCommonTextStyle,
                      ),
                    ),
                    horizontalLine,
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Text(
                        'Payment method : Cash on delivery',
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
            OrdersProductDetails(),
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
                        'Flat',
                        style: kBoldedText.copyWith(fontSize: 15),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 5.0),
                      child: Text(
                        'No 987, Royal Avenue,\nChatta Bakhtawar,\nIslamabad, Pakistan',
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
                            'Rs.52000.00',
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
                            'Rs.25.000',
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
                            style: kOrderDetailsText.copyWith(fontSize: 15),
                          ),
                          Text(
                            'Rs.52025.000',
                            style: kOrderDetailsText.copyWith(fontSize: 15),
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
        ),
      ),
    );
  }
}
