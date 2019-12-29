import 'package:equatable/equatable.dart';

/// generate by https://javiercbk.github.io/json_to_dart/
class AutogeneratedChangeMode {
  final List<ChangeModeModel> results;

  AutogeneratedChangeMode({this.results});

  factory AutogeneratedChangeMode.fromJson(Map<String, dynamic> json) {
    List<ChangeModeModel> temp;
    if (json['results'] != null) {
      temp = List<ChangeModeModel>();
      json['results'].forEach((v) {
        temp.add(ChangeModeModel.fromJson(v as Map<String, dynamic>));
      });
    }
    return AutogeneratedChangeMode(results: temp);
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (this.results != null) {
      data['results'] = this.results.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ChangeModeModel extends Equatable {
  final int id;
  final String name;

  ChangeModeModel(this.id, this.name);

  @override
  List<Object> get props => [id, name];

  factory ChangeModeModel.fromJson(Map<String, dynamic> json) {
    return ChangeModeModel(json['id'] as int, json['name'] as String);
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
  
}