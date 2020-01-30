import 'package:wmn_plus/features/ecommerce/models/line_item.dart';
import 'package:wmn_plus/features/ecommerce/models/address.dart';

class Order {
  String count;
  String totalPrice;
  List<LineItem> lineItems;

  Order({
    this.totalPrice,
    this.count,
    this.lineItems,
  });
}
