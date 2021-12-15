import 'package:e_shop/constants.dart';
import 'package:e_shop/models/address.dart';
import 'package:e_shop/models/complaints.dart';
import 'package:e_shop/services/database/user_database_helper.dart';
import 'package:e_shop/size_config.dart';
import 'package:flutter/material.dart';

import 'complaint_details_form.dart';

class Body extends StatelessWidget {
  final String complaintIdToEdit;

  const Body({Key key, this.complaintIdToEdit}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: getProportionateScreenWidth(screenPadding)),
          child: SizedBox(
            width: double.infinity,
            child: Column(
              children: [
                SizedBox(height: getProportionateScreenHeight(20)),
                Text(
                  "Fill Complaint Details",
                  style: headingStyle,
                ),
                SizedBox(height: getProportionateScreenHeight(30)),
                complaintIdToEdit == null
                    ? ComplaintDetailsForm(
                        complaintToEdit: null,
                      )
                    : FutureBuilder<Complaint>(
                        future: UserDatabaseHelper()
                            .getComplaintFromId(complaintIdToEdit),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            final complaint = snapshot.data;
                            return ComplaintDetailsForm(complaintToEdit: complaint);
                          } else if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          return ComplaintDetailsForm(
                            complaintToEdit: null,
                          );
                        },
                      ),
                SizedBox(height: getProportionateScreenHeight(40)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
