import 'package:equatable/equatable.dart';

/// generate by https://javiercbk.github.io/json_to_dart/
class AutogeneratedChangeModeFertilityPeriod {
  final List<ChangeModeFertilityPeriodModel> results;

  AutogeneratedChangeModeFertilityPeriod({this.results});

  factory AutogeneratedChangeModeFertilityPeriod.fromJson(Map<String, dynamic> json) {
    List<ChangeModeFertilityPeriodModel> temp;
    if (json['results'] != null) {
      temp = List<ChangeModeFertilityPeriodModel>();
      json['results'].forEach((v) {
        temp.add(ChangeModeFertilityPeriodModel.fromJson(v as Map<String, dynamic>));
      });
    }
    return AutogeneratedChangeModeFertilityPeriod(results: temp);
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (this.results != null) {
      data['results'] = this.results.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ChangeModeFertilityPeriodModel extends Equatable {
  final int id;
  final String name;

  ChangeModeFertilityPeriodModel(this.id, this.name);

  @override
  List<Object> get props => [id, name];

  factory ChangeModeFertilityPeriodModel.fromJson(Map<String, dynamic> json) {
    return ChangeModeFertilityPeriodModel(json['id'] as int, json['name'] as String);
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
  
}
