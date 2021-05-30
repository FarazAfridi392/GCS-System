import 'package:e_shop/app_properties.dart';
import 'package:flutter/material.dart';

class DashCard extends StatelessWidget {
  final colour;
  final names;
  final images;
  final numbers;

  const DashCard({
    Key key,
    this.colour,
    this.names,
    this.images,
    this.numbers,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 162,
      height: 164,
      decoration: BoxDecoration(
        color: colour,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 23),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 21.0),
              child: images,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 24.4),
              child: Text(numbers, style: kDashBoardText),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 1),
              child: Text(names, style: kCommonTextStyle),
            ),
          ],
        ),
      ),
    );
  }
}
