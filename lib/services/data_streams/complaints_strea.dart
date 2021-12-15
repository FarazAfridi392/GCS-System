import 'package:e_shop/services/data_streams/data_stream.dart';
import 'package:e_shop/services/database/user_database_helper.dart';

class ComplaintsStream extends DataStream<List<String>> {
  @override
  void reload() {
    final complaintssList = UserDatabaseHelper().complaintsList;
    complaintssList.then((list) {
      addData(list);
    }).catchError((e) {
      addError(e);
    });
  }
}