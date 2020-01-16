class SubCategoryList {
  int statusCode;
  String message;
  List<Result> result;

  SubCategoryList({this.statusCode, this.message, this.result});

  SubCategoryList.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    message = json['message'];
    if (json['result'] != null) {
      result = new List<Result>();
      json['result'].forEach((v) {
        result.add(new Result.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['statusCode'] = this.statusCode;
    data['message'] = this.message;
    if (this.result != null) {
      data['result'] = this.result.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Result {
  int id;
  String title;
  List<Products> products;

  Result({this.id, this.title, this.products});

  Result.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    if (json['products'] != null) {
      products = new List<Products>();
      json['products'].forEach((v) {
        products.add(new Products.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    if (this.products != null) {
      data['products'] = this.products.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Products {
  int id;
  String title;
  int price;
  List<String> imageUrls;
  String description;
  String characteristics;
  String properties;
  String additional;

  Products(
      {this.id,
      this.title,
      this.price,
      this.imageUrls,
      this.description,
      this.characteristics,
      this.properties,
      this.additional});

  Products.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    price = json['price'];
    imageUrls = json['image_urls'].cast<String>();
    description = json['description'];
    characteristics = json['characteristics'];
    properties = json['properties'];
    additional = json['additional'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['price'] = this.price;
    data['image_urls'] = this.imageUrls;
    data['description'] = this.description;
    data['characteristics'] = this.characteristics;
    data['properties'] = this.properties;
    data['additional'] = this.additional;
    return data;
  }

  get image => "http://194.146.43.98:4000/image?uri=" + this.imageUrls[0];
}
