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

  List toJson() {
    final List json = [];
    for (int i = 0; i < this.lineItems.length; i++) {
      final Map<String, dynamic> data = new Map<String, dynamic>();
      if (this.lineItems != null) {
        data['product'] = this.lineItems[i].toJson();
      }
      data['quantity'] = int.parse(this.count);
      json.add(data);
    }

    return json;
  }
}
