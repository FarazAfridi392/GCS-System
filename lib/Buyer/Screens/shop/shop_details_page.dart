import 'package:e_shop/app_properties.dart';
import 'package:flutter/material.dart';

class ShopDetailsPage extends StatelessWidget {
  String shopName;
  String ownerName;
  String ownerEmail;
  String shopAdress;
  String contactNumber;
  String dateCreated;
  String shopDescription;
  ShopDetailsPage(
      {this.shopName,
      this.ownerName,
      this.ownerEmail,
      this.shopAdress,
      this.contactNumber,
      this.dateCreated,
      this.shopDescription});
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
                      'Shop Name: $shopName',
                      style: kOrderCodeTextStyle,
                    ),
                  ),
                  horizontalLine,
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text(
                      'Owner Name: $ownerName',
                      style: kOrderCodeTextStyle,
                    ),
                  ),
                  horizontalLine,
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text(
                      'Email : $ownerEmail',
                      style: kCommonTextStyle,
                    ),
                  ),
                  horizontalLine,
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text(
                      'Address : $shopAdress',
                      style: kCommonTextStyle,
                    ),
                  ),
                  horizontalLine,
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text(
                      'Contact : $contactNumber',
                      style: kCommonTextStyle,
                    ),
                  ),
                  horizontalLine,
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text(
                      'Date Created : $dateCreated',
                      style: kCommonTextStyle,
                    ),
                  ),
                  horizontalLine,
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text(
                      'Shop Description: $shopDescription',
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
