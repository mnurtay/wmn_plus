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
  List<dynamic> redDays;
  List<dynamic> babyDays;
  List<dynamic> pMS;

  Result({this.redDays, this.babyDays, this.pMS});

  Result.fromJson(Map<String, dynamic> json) {
    redDays = json['redDays'];
    babyDays = json['babyDays'];
    pMS = json['PMS'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['redDays'] = this.redDays;
    data['babyDays'] = this.babyDays;
    data['PMS'] = this.pMS;
    return data;
  }
}

