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
  String imageUrl;
  int price;

  Result({this.id, this.title, this.imageUrl, this.price});

  Result.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    imageUrl = json['image_url'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['image_url'] = this.imageUrl;
    data['price'] = this.price;
    return data;
  }

    String get image => "http://194.146.43.98:4000/image?uri=" + this.imageUrl;

}

