import 'package:equatable/equatable.dart';

/// generate by https://javiercbk.github.io/json_to_dart/
class AutogeneratedRegistration {
  final List<RegistrationModel> results;

  AutogeneratedRegistration({this.results});

  factory AutogeneratedRegistration.fromJson(Map<String, dynamic> json) {
    List<RegistrationModel> temp;
    if (json['results'] != null) {
      temp = List<RegistrationModel>();
      json['results'].forEach((v) {
        temp.add(RegistrationModel.fromJson(v as Map<String, dynamic>));
      });
    }
    return AutogeneratedRegistration(results: temp);
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (this.results != null) {
      data['results'] = this.results.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class RegistrationModel extends Equatable {
  final int id;
  final String name;

  RegistrationModel(this.id, this.name);

  @override
  List<Object> get props => [id, name];

  factory RegistrationModel.fromJson(Map<String, dynamic> json) {
    return RegistrationModel(json['id'] as int, json['name'] as String);
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
  
}
