class Product {
  final int id;
  final String title;
  final String price;
  final String currencySymbol;
  final String image;
  String description;
  final int subCatId;
  final int catId;

  Product({
    this.subCatId,
    this.catId,
    this.id,
    this.title,
    this.price,
    this.image,
    this.description,
    this.currencySymbol,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['catId'] = this.catId;
    data['subId'] = this.subCatId;
    data['productId'] = this.id;
    data['title'] = this.title;
    data['image_url'] = this.image;
    data['price'] = this.price;
    return data;
  }
}
