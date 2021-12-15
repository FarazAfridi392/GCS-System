import 'model.dart';

class Complaint extends Model {
  static const String TITLE_KEY = "title";
  static const String Reason_LINE_1_KEY = "address_line_1";

  static const String ADDRESS_KEY = "address";

  static const String RECEIVER_KEY = "receiver";
  static const String PHONE_KEY = "phone";
  static const String PRODUCT_NAME_KEY = "product_name";
  static const String PRODUCT_ID_KEY = "product_id";

  String title;
  String receiver;

  String reason;

  String address;

  String phone;
  String productName;
  String productId;

  Complaint({
    String id,
    this.title,
    this.receiver,
    this.reason,
    this.address,
    this.phone,
    this.productName,
    this.productId
  }) : super(id);

  factory Complaint.fromMap(Map<String, dynamic> map, {String id}) {
    return Complaint(
      id: id,
      title: map[TITLE_KEY],
      receiver: map[RECEIVER_KEY],
      reason: map[Reason_LINE_1_KEY],
      address: map[ADDRESS_KEY],
      phone: map[PHONE_KEY],
      productName: map[PRODUCT_NAME_KEY],
      productId: map[PRODUCT_ID_KEY],
    );
  }

  @override
  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{
      TITLE_KEY: title,
      RECEIVER_KEY: receiver,
      Reason_LINE_1_KEY: reason,
      ADDRESS_KEY: address,
      PHONE_KEY: phone,
      PRODUCT_NAME_KEY: productName,
      PRODUCT_ID_KEY: productId,
    };

    return map;
  }

  @override
  Map<String, dynamic> toUpdateMap() {
    final map = <String, dynamic>{};
    if (title != null) map[TITLE_KEY] = title;
    if (receiver != null) map[RECEIVER_KEY] = receiver;
    if (reason != null) map[Reason_LINE_1_KEY] = reason;
    if (address != null) map[ADDRESS_KEY] = address;

    if (phone != null) map[PHONE_KEY] = phone;
    if (productName != null) map[PRODUCT_NAME_KEY] = productName;
    if (productId != null) map[PRODUCT_ID_KEY] = productId;
    return map;
  }
}
