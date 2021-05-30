import 'package:e_shop/Seller/Screens/order_detail._page.dart';
import 'package:e_shop/app_properties.dart';
import 'package:flutter/material.dart';

class OrderList extends StatelessWidget {
  final productname;
  final code;
  final date;
  final status;
  final amount;
  const OrderList({
    Key key,
    this.productname,
    this.code,
    this.date,
    this.status,
    this.amount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => OrderDetailspage(),
          ),
        );
      },
      child: Container(
        color: Colors.white,
        height: 130,
        width: 380,
        child: Padding(
          padding: const EdgeInsets.only(left: 29.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 15),
                child: Text(
                  productname,
                  style: TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                      fontWeight: FontWeight.w400),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Text(
                  'Order Code : $code | $date',
                  style: TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5),
                child: Row(
                  children: [
                    Text(
                      amount,
                      style: TextStyle(
                          fontSize: 15,
                          color: Colors.black,
                          fontWeight: FontWeight.w400),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Container(
                      width: 65,
                      height: 17.81,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: Colors.green,
                          width: 1,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          status,
                          style: TextStyle(
                            color: Color(0xFF707070),
                            fontSize: 12,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 165),
                      child: Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5),
                child: Text(
                  'Delivery Status: $status',
                  style: kCommonTextStyle,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                child: Container(
                  height: 1.0,
                  width: 300,
                  color: Colors.grey[200],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
