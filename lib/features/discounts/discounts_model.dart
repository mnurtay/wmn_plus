class Discount {
  int statusCode;
  String message;
  List<Result> result;

  Discount({this.statusCode, this.message, this.result});

  Discount.fromJson(Map<String, dynamic> json) {
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
  String content;
  String title;
  String imageUrl;

  Result({this.id, this.content, this.title, this.imageUrl});

  Result.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    content = json['content'];
    title = json['title'];
    imageUrl = json['image_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['content'] = this.content;
    data['title'] = this.title;
    data['image_url'] = this.imageUrl;
    return data;
  }
}