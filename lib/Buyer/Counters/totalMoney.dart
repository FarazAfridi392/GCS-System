import 'package:flutter/cupertino.dart';

class TotalAmount extends ChangeNotifier {
  double _totalAmount = 0;
  double get totalAmount => _totalAmount;

  displayAmount(double no) async {
    _totalAmount = no;
    await Future.delayed(
      Duration(milliseconds: 100),
      () {
        notifyListeners();
      },
    );
  }
}