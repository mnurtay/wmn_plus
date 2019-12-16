class User {
  int statusCode;
  String message;
  Result result;

  User({this.statusCode, this.message, this.result});

  User.fromJson(Map<String, dynamic> json) {
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
  String token;
  String firstname;
  String surname;
  String phone;
  String pushToken;
  String password;
  String regime;
  String language;
  String dateOfBirth;
  Pregnancy pregnancy;
  Fertility fertility;

  Result(
      {this.id,
      this.token,
      this.firstname,
      this.surname,
      this.regime,
      this.pushToken,
      this.phone,
      this.password,
      this.language,
      this.dateOfBirth,
      this.pregnancy,
      this.fertility});

  Result.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    token = json['token'];
    pushToken = json['pushToken'];
    firstname = json['firstname'];
    surname = json['surname'];
    regime = json['regime'];
    phone = json['phone'];
    password = json['password'];
    language = json['language'];
    dateOfBirth = json['dateOfBirth'];
    pregnancy = json['pregnancy'] != null
        ? new Pregnancy.fromJson(json['pregnancy'])
        : null;
    fertility = json['fertility'] != null
        ? new Fertility.fromJson(json['fertility'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['token'] = this.token;
    data['push_token'] = this.pushToken;
    data['firstname'] = this.firstname;
    data['surname'] = this.surname;
    data['phone'] = this.phone;
    data['regime'] = this.regime;
    data['password'] = this.password;
    data['language'] = this.language;
    data['dateOfBirth'] = this.dateOfBirth;
    if (this.pregnancy != null) {
      data['pregnancy'] = this.pregnancy.toJson();
    }
    if (this.fertility != null) {
      data['fertility'] = this.fertility.toJson();
    }
    return data;
  }
}

class Pregnancy {
  String start;
  String startSys;
  int week;

  Pregnancy({this.start, this.startSys, this.week});

  Pregnancy.fromJson(Map<String, dynamic> json) {
    start = json['start'];
    startSys = json['startSys'];
    week = json['week'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['start'] = this.start;
    data['startSys'] = this.startSys;
    data['week'] = this.week;
    return data;
  }
}

class Fertility {
  String start;
  String startSys;
  int duration;
  int period;

  Fertility({this.start, this.startSys, this.duration, this.period});

  Fertility.fromJson(Map<String, dynamic> json) {
    start = json['start'];
    startSys = json['startSys'];
    duration = json['duration'];
    period = json['period'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['start'] = this.start;
    data['startSys'] = this.startSys;
    data['duration'] = this.duration;
    data['period'] = this.period;
    return data;
  }
}