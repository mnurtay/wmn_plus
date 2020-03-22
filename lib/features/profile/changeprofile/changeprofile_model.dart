import 'package:equatable/equatable.dart';

/// generate by https://javiercbk.github.io/json_to_dart/
class AutogeneratedChangeprofile {
  final List<ChangeprofileModel> results;

  AutogeneratedChangeprofile({this.results});

  factory AutogeneratedChangeprofile.fromJson(Map<String, dynamic> json) {
    List<ChangeprofileModel> temp;
    if (json['results'] != null) {
      temp = List<ChangeprofileModel>();
      json['results'].forEach((v) {
        temp.add(ChangeprofileModel.fromJson(v as Map<String, dynamic>));
      });
    }
    return AutogeneratedChangeprofile(results: temp);
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (this.results != null) {
      data['results'] = this.results.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ChangeprofileModel extends Equatable {
  final int id;
  final String name;

  ChangeprofileModel(this.id, this.name);

  @override
  List<Object> get props => [id, name];

  factory ChangeprofileModel.fromJson(Map<String, dynamic> json) {
    return ChangeprofileModel(json['id'] as int, json['name'] as String);
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
  
}
