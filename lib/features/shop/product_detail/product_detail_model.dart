class ProductResponse {
  int statusCode;
  String message;
  Result result;

  ProductResponse({this.statusCode, this.message, this.result});

  ProductResponse.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    message = json['message'];
    result =
        json['result'] != null ? new Result.fromJson(json['result']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['statusCode'] = this.statusCode;
    data['message'] = this.message;
    if (this.result != null) {
      data['result'] = this.result.toJson();
    }
    return data;
  }
}

class Result {
  int id;
  String title;
  int price;
  List<String> imageUrls;
  String description;
  String characteristics;
  String properties;
  String additional;

  Result(
      {this.id,
      this.title,
      this.price,
      this.imageUrls,
      this.description,
      this.characteristics,
      this.properties,
      this.additional});

  Result.fromJson(Map<String, dynamic> json) {
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

  List<String> get images {
    List<String> tempImages = [];
    for (int i = 0; i < this.imageUrls.length; i++) {
      tempImages
          .add("http://194.146.43.98:4000/image?uri=" + this.imageUrls[i]);
    }
    return tempImages;
  }
}
