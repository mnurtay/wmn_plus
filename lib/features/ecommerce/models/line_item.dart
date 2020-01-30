
import 'package:wmn_plus/features/ecommerce/models/product.dart';

class LineItem {
  final int id;
  final int count;
  final String title;
  final int price;
  final String image;

  LineItem({this.id, this.count, this.title, this.price, this.image});
}
