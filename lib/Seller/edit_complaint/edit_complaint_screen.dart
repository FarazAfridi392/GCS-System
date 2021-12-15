import 'package:flutter/material.dart';

import 'components/body.dart';

class EditComplaintScreen extends StatelessWidget {
  final String complaintIdToEdit;

  const EditComplaintScreen({Key key, this.complaintIdToEdit}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Body(complaintIdToEdit: complaintIdToEdit),
    );
  }
}
