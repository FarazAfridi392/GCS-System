import 'package:flutter/material.dart';

import '../../app_properties.dart';

class DorpDownButton extends StatefulWidget {
  @override
  _DorpDownButtonState createState() => _DorpDownButtonState();
}

class OrderStatus {
  int id;
  String name;
  var color;
  OrderStatus({this.id, this.name, this.color});

  static List<OrderStatus> getOrderStatus() {
    return <OrderStatus>[
      OrderStatus(id: 1, name: 'Pending', color: Color(0xFFEF3D3D)),
      OrderStatus(id: 2, name: 'Processing', color: Colors.orange),
      OrderStatus(id: 3, name: 'Shipping', color: Colors.yellow[700]),
      OrderStatus(id: 4, name: 'Deliverd', color: Colors.green),
    ];
  }
}

class _DorpDownButtonState extends State<DorpDownButton> {
  List<OrderStatus> _orderstatus = OrderStatus.getOrderStatus();
  List<DropdownMenuItem<OrderStatus>> _dropdownMenuItems;
  OrderStatus _selectedorderStatus;
  @override
  void initState() {
    _dropdownMenuItems = buildDropDownMenuItems(_orderstatus);
    _selectedorderStatus = _dropdownMenuItems[0].value;
    super.initState();
  }

  List<DropdownMenuItem<OrderStatus>> buildDropDownMenuItems(List orderstatus) {
    List<DropdownMenuItem<OrderStatus>> items = List();
    for (OrderStatus status in orderstatus) {
      items.add(
        DropdownMenuItem(
          value: status,
          child: Text(status.name),
        ),
      );
    }
    return items;
  }

  onChnageDropdownItem(OrderStatus selectedOrderStatus) {
    setState(() {
      _selectedorderStatus = selectedOrderStatus;
      if (_selectedorderStatus ==
          OrderStatus(id: 4, name: 'Deliverd', color: Colors.green)) {
        Navigator.of(context).pop();
      }
    });
  }

  Widget build(BuildContext context) {
    return Container(
      width: 70.00,
      height: 21.81,
      decoration: BoxDecoration(
        color: _selectedorderStatus.color,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 10.0, right: 0),
        child: DropdownButton(
          value: _selectedorderStatus,
          items: _dropdownMenuItems,
          onChanged: onChnageDropdownItem,
          focusColor: Colors.black,
          dropdownColor: _selectedorderStatus.color,
          style: kCommonTextStyle.copyWith(
            fontSize: 8,
            color: Colors.white,
          ),
          iconEnabledColor: Colors.white,
          iconSize: 20,
          underline: Container(),
        ),
      ),
    );
  }
}
