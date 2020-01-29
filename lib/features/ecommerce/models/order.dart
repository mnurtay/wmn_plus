import 'package:wmn_plus/features/ecommerce/models/line_item.dart';
import 'package:wmn_plus/features/ecommerce/models/address.dart';

class Order {
  String total;
  int id;
  String itemTotal;

  List<LineItem> lineItems;
  int totalQuantity;

  Order({
    this.total,
    this.id,
    this.itemTotal,
    this.lineItems,
    this.totalQuantity,
  });
}
