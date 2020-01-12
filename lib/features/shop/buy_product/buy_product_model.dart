class BuyProduct {
  String phone;
  String name;
  String email;
  String payment;
  String delivery;
  String comments;
  bool privacyPolicy;
  int categoryId;
  int subcategoryId;
  int productId;
  int count;

  BuyProduct(
      {this.phone,
      this.name,
      this.email,
      this.payment,
      this.delivery,
      this.comments,
      this.privacyPolicy,
      this.categoryId,
      this.subcategoryId,
      this.productId,
      this.count});

  BuyProduct.fromJson(Map<String, dynamic> json) {
    phone = json['phone'];
    name = json['name'];
    email = json['email'];
    payment = json['payment'];
    delivery = json['delivery'];
    comments = json['comments'];
    privacyPolicy = json['privacy_policy'];
    categoryId = json['category_id'];
    subcategoryId = json['subcategory_id'];
    productId = json['product_id'];
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['phone'] = this.phone;
    data['name'] = this.name;
    data['email'] = this.email;
    data['payment'] = this.payment;
    data['delivery'] = this.delivery;
    data['comments'] = this.comments;
    data['privacy_policy'] = this.privacyPolicy;
    data['category_id'] = this.categoryId;
    data['subcategory_id'] = this.subcategoryId;
    data['product_id'] = this.productId;
    data['count'] = this.count;
    return data;
  }
}

class ResponseJson {
  int statusCode;
  String message;

  ResponseJson({this.statusCode, this.message});

  ResponseJson.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['statusCode'] = this.statusCode;
    data['message'] = this.message;
    return data;
  }
}



