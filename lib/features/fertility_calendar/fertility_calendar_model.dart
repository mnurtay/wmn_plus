import 'dart:convert';

class FertilityCalendarModel {
  int statusCode;
  String message;
  Result result;

  FertilityCalendarModel({this.statusCode, this.message, this.result});

  FertilityCalendarModel.fromJson(Map<String, dynamic> json) {
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
  Info info;
  List<dynamic> redDays;
  List<dynamic> babyDays;
  List<dynamic> pMS;

  Result({this.redDays, this.babyDays, this.pMS, this.info});

  Result.fromJson(Map<String, dynamic> json) {
    redDays = json['redDays'];
    babyDays = json['babyDays'];
    pMS = json['PMS'];
    // info = Info(babyBoom: false, toFert: 0, toPMS: 0, currentFert: 10);
    info = json['info'] != null ? new Info.fromJson(json['info']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['redDays'] = this.redDays;
    data['babyDays'] = this.babyDays;
    data['PMS'] = this.pMS;
    return data;
  }
}

class Info {
  int currentFert;
  int toFert;
  bool babyBoom;
  int toPMS;

  Info({this.currentFert, this.toFert, this.babyBoom, this.toPMS});
  Info.test() {
    currentFert = 22;
    toFert = 0;
    babyBoom = false;
    toPMS = 0;
  }
  Info.fromJson(Map<String, dynamic> json) {
    currentFert = json["currentFert"];
    toFert = json["toFert"];
    babyBoom = json["babyBoom"];
    toPMS = json["toPMS"];
  }
}
