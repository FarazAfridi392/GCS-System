import 'package:flutter/material.dart';

const Color kYellow = Color(0xffFDC054);
const Color kMediumYellow = Color(0xffFDB846);
const Color kDarkYellow = Color(0xffE99E22);
const Color kTransparentYellow = Color.fromRGBO(253, 184, 70, 0.7);
const Color kDarkGrey = Color(0xff202020);
const kIconsColor = Color(0xFF727C8E);
const kTextColor = Color(0xFF535353);
const kTextLightColor = Color(0xFFACACAC);

const kDefaultPaddin = 20.0;

const kCommonTextStyle = TextStyle(
  color: Color(0xFF707070),
  fontSize: 14,
  fontWeight: FontWeight.normal,
);
const kBoldedText = TextStyle(
  fontSize: 24,
  color: Color(0xFF022542),
  fontWeight: FontWeight.bold,
);
const kOrderCodeTextStyle =
    TextStyle(fontSize: 14, color: Colors.black, fontWeight: FontWeight.bold);
const kDashBoardText = TextStyle(
  fontSize: 32,
  fontWeight: FontWeight.normal,
  color: Color(0xFF022542),
);
const kOrderDetailsText =
    TextStyle(fontSize: 14, color: Colors.black, fontWeight: FontWeight.w400);

const LinearGradient mainButton = LinearGradient(colors: [
  Color.fromRGBO(236, 60, 3, 1),
  Color.fromRGBO(234, 60, 3, 1),
  Color.fromRGBO(216, 78, 16, 1),
], begin: FractionalOffset.topCenter, end: FractionalOffset.bottomCenter);

const List<BoxShadow> shadow = [
  BoxShadow(color: Colors.black12, offset: Offset(0, 3), blurRadius: 6)
];

screenAwareSize(int size, BuildContext context) {
  double baseHeight = 640.0;
  return size * MediaQuery.of(context).size.height / baseHeight;
}
