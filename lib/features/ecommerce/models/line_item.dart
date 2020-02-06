class LineItem {
  final int id;
  final int categoryId;
  final int subCategoryId;
  final int productId;
  final int count;
  final String title;
  final int price;
  final String image;

  LineItem(
      {this.id,
      this.count,
      this.title,
      this.price,
      this.image,
      this.categoryId,
      this.subCategoryId,
      this.productId});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['category_id'] = this.categoryId;
    data['subcategory_id'] = this.subCategoryId;
    data['product_id'] = this.productId;
    data['producttitle'] = this.title;
    data['price'] = this.price;

    return data;
  }
}
