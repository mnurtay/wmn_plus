import 'package:wmn_plus/features/ecommerce/models/option_type.dart';
import 'package:wmn_plus/features/ecommerce/models/option_value.dart';

class Product {
  final int id;
  final String slug;
  final int taxonId;
  final String title;
  final String name;
  final String displayPrice;
  final String costPrice;
  final String price;
  final String currencySymbol;
  final String image;
  final double avgRating;
  final String reviewsCount;
  final int totalOnHand;
  final bool isOrderable;
  final bool isBackOrderable;
  final bool hasVariants;
  final List<Product> variants;
  final List<OptionValue> optionValues;
  final List<OptionType> optionTypes;
  String description;
  final int reviewProductId;
  final bool favoritedByUser;
  final int subCatId;
  final int catId;

  Product(
      {this.subCatId,
      this.catId,
      this.taxonId,
      this.id,
      this.slug,
      this.title,
      this.name,
      this.displayPrice,
      this.costPrice,
      this.price,
      this.image,
      this.avgRating,
      this.reviewsCount,
      this.totalOnHand,
      this.isOrderable,
      this.isBackOrderable,
      this.variants,
      this.hasVariants,
      this.description,
      this.optionValues,
      this.reviewProductId,
      this.optionTypes,
      this.currencySymbol,
      this.favoritedByUser});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['image_url'] = this.image;
    data['price'] = this.price;
    return data;
  }
  
}
