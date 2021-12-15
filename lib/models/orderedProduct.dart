import 'model.dart';

class OrderedProduct extends Model {
  static const String PRODUCT_UID_KEY = "product_uid";
  static const String ORDER_DATE_KEY = "order_date";
  static const String CURRENTUSER_UID_KEY = "current_user";
  static const String CURRENTUSER_EMAIL_KEY = "current_user_email";
  static const String CURRENTUSER_NAME_KEY = "current_user_name";
  static const String TOTAL_AMOUNT_KEY = "total_amount";

  String productUid;
  String currentUserUid;
  String currentUserEmail;
  String currentUserName;
  String totalAmount;
  String ownerUid;
  String orderDate;
  OrderedProduct(
    String id, {
    this.currentUserUid,
    this.currentUserEmail,
    this.currentUserName,
    this.totalAmount,
    this.ownerUid,
    this.productUid,
    this.orderDate,
  }) : super(id);

  factory OrderedProduct.fromMap(Map<String, dynamic> map, {String id}) {
    return OrderedProduct(id,
        productUid: map[PRODUCT_UID_KEY],
        orderDate: map[ORDER_DATE_KEY],
        currentUserUid: map[CURRENTUSER_UID_KEY],
        currentUserEmail: map[CURRENTUSER_EMAIL_KEY],
        currentUserName: map[CURRENTUSER_NAME_KEY],
        totalAmount: map[TOTAL_AMOUNT_KEY]);
  }

  @override
  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{
      PRODUCT_UID_KEY: productUid,
      ORDER_DATE_KEY: orderDate,
      CURRENTUSER_UID_KEY: currentUserUid,
      CURRENTUSER_EMAIL_KEY: currentUserEmail,
      CURRENTUSER_NAME_KEY: currentUserName,
      TOTAL_AMOUNT_KEY: totalAmount,
    };
    return map;
  }

  @override
  Map<String, dynamic> toUpdateMap() {
    final map = <String, dynamic>{};
    if (productUid != null) map[PRODUCT_UID_KEY] = productUid;
    if (orderDate != null) map[ORDER_DATE_KEY] = orderDate;
    if (currentUserUid != null) map[CURRENTUSER_UID_KEY] = currentUserUid;
    if (currentUserEmail != null) map[CURRENTUSER_EMAIL_KEY] = currentUserEmail;
    if (currentUserName != null) map[CURRENTUSER_NAME_KEY] = currentUserName;
    if (totalAmount != null) map[TOTAL_AMOUNT_KEY] = totalAmount;
    return map;
  }
}
