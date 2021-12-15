import 'package:e_shop/constants.dart';
import 'package:e_shop/models/address.dart';
import 'package:e_shop/models/complaints.dart';
import 'package:e_shop/services/database/user_database_helper.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class ComplaintBox extends StatelessWidget {
  const ComplaintBox({
    Key key,
    @required this.complaintsId,
  }) : super(key: key);

  final String complaintsId;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 8,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: double.infinity,
            child: Container(
              padding: EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
              ),
              child: FutureBuilder<Complaint>(
                  future: UserDatabaseHelper().getComplaintFromId(complaintsId),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final complaint = snapshot.data;
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${complaint.title}",
                            style: TextStyle(
                              fontSize: 22,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            "${complaint.reason}",
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            "${complaint.receiver}",
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            "${complaint.address}",
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            "City: ${complaint.phone}",
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ]
                      );
                    } else if (snapshot.connectionState ==
                        ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (snapshot.hasError) {
                      final error = snapshot.error.toString();
                      Logger().e(error);
                    }
                    return Center(
                      child: Icon(
                        Icons.error,
                        color: kTextColor,
                        size: 60,
                      ),
                    );
                  }),
            ),
          ),
        ],
      ),
    );
  }
}
