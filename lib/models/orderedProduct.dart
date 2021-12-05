import 'model.dart';

class OrderedProduct extends Model {
  static const String PRODUCT_UID_KEY = "product_uid";
  static const String ORDER_DATE_KEY = "order_date";
  static const String CURRENTUSER_UID_KEY = "current_user";

  String productUid;
  String currentUserUid;
  String ownerUid;
  String orderDate;
  OrderedProduct(
    String id, {
    this.currentUserUid,
    this.ownerUid,
    this.productUid,
    this.orderDate,
  }) : super(id);

  factory OrderedProduct.fromMap(Map<String, dynamic> map, {String id}) {
    return OrderedProduct(
      id,
      productUid: map[PRODUCT_UID_KEY],
      orderDate: map[ORDER_DATE_KEY],
      currentUserUid: map[CURRENTUSER_UID_KEY]
    );
  }

  @override
  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{
      PRODUCT_UID_KEY: productUid,
      ORDER_DATE_KEY: orderDate,
      CURRENTUSER_UID_KEY: currentUserUid,
    };
    return map;
  }

  @override
  Map<String, dynamic> toUpdateMap() {
    final map = <String, dynamic>{};
    if (productUid != null) map[PRODUCT_UID_KEY] = productUid;
    if (orderDate != null) map[ORDER_DATE_KEY] = orderDate;
    if (currentUserUid != null) map[CURRENTUSER_UID_KEY] = currentUserUid;
    return map;
  }
}
