import 'package:e_shop/models/address.dart';
import 'package:e_shop/models/complaints.dart';
import 'package:e_shop/services/database/user_database_helper.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

import '../../constants.dart';
import '../../size_config.dart';

class ComplaintShortDetailsCard extends StatelessWidget {
  final String complaintId;
  final Function onTap;

  const ComplaintShortDetailsCard(
      {Key key, @required this.complaintId, @required this.onTap})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: SizedBox(
        width: double.infinity,
        height: SizeConfig.screenHeight * 0.15,
        child: FutureBuilder<Complaint>(
          future: UserDatabaseHelper().getComplaintFromId(complaintId),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final complaint = snapshot.data;
              return Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Container(
                      height: double.infinity,
                      padding:
                          EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                      decoration: BoxDecoration(
                        color: kTextColor.withOpacity(0.24),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15),
                          bottomLeft: Radius.circular(15),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          complaint.title,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 8,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(color: kTextColor.withOpacity(0.24)),
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(15),
                          bottomRight: Radius.circular(15),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            complaint.receiver,
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                          Text("reason: ${complaint.reason}"),
                          Text("Phone: ${complaint.phone}"),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              final error = snapshot.error.toString();
              Logger().e(error);
            }
            return Center(
              child: Icon(
                Icons.error,
                size: 40,
                color: kTextColor,
              ),
            );
          },
        ),
      ),
    );
  }
}
