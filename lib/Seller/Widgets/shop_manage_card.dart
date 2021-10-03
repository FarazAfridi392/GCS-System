import 'package:e_shop/app_properties.dart';
import 'package:flutter/material.dart';

class ManageCard extends StatelessWidget {
  IconData icon;
  String text;
  final color;
  String image;
  ManageCard({this.icon, this.text, this.color, this.image});
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Expanded(
      child: Container(
        margin: EdgeInsets.all(18),
        padding: EdgeInsets.all(12),
        height: height / 9,
        width: width / 3.5,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)), color: color),
        child: Column(
          children: [
            icon == null
                ? Container(
                    padding: EdgeInsets.only(left: 5),
                    height: 40,
                    width: 40,
                    child: Image.asset(
                      image,
                    ),
                  )
                : Icon(
                    icon,
                    size: 40,
                  ),
            SizedBox(
              height: 10,
            ),
            Text(
              text,
              style: TextStyle(fontStyle: FontStyle.italic, fontSize: 10),
            )
          ],
        ),
      ),
    );
  }
}
