class Discountdetail {
  int statusCode;
  String message;
  Result result;

  Discountdetail({this.statusCode, this.message, this.result});

  Discountdetail.fromJson(Map<String, dynamic> json) {
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
  String content;
  String title;
  List<String> imageUrls;
  int watched;
  String address;
  String workdays;
  List<String> phoneNumbers;
  String conditions;
  String properties;

  Result(
      {this.id,
      this.content,
      this.title,
      this.imageUrls,
      this.watched,
      this.address,
      this.workdays,
      this.phoneNumbers,
      this.conditions,
      this.properties});

  Result.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    content = json['content'];
    title = json['title'];
    imageUrls = json['image_urls'].cast<String>();
    watched = json['watched'];
    address = json['address'];
    workdays = json['workdays'];
    phoneNumbers = json['phone_numbers'].cast<String>();
    conditions = json['conditions'];
    properties = json['properties'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['content'] = this.content;
    data['title'] = this.title;
    data['image_urls'] = this.imageUrls;
    data['watched'] = this.watched;
    data['address'] = this.address;
    data['workdays'] = this.workdays;
    data['phone_numbers'] = this.phoneNumbers;
    data['conditions'] = this.conditions;
    data['properties'] = this.properties;
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
