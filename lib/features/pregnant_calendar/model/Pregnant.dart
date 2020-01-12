import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class Pregnant extends Equatable {
  final int week;
  final int day;
  final List<PregnantInstruction> instructions;

  Pregnant({
    @required this.week,
    @required this.day,
    @required this.instructions,
  });

  factory Pregnant.anonymous() {
    return Pregnant(week: 0, day: 0, instructions: []);
  }

  factory Pregnant.parseJson(String jsonString) {
    Map objectMap = json.decode(jsonString);
    return Pregnant.parseMap(objectMap);
  }

  factory Pregnant.parseMap(Map objectMap) {
    Pregnant instance = Pregnant(
      week: objectMap['result']['week'],
      day: objectMap['result']['day'],
      instructions: PregnantInstruction.parseListToObject(
          objectMap['result']['instructions']),
    );
    return instance;
  }

  String objectToString() {
    Map objectMap = {
      "result": {
        "week": this.week,
        "day": this.day,
        "instructions": PregnantInstruction.objectToMap(instructions),
      },
    };
    return json.encode(objectMap);
  }

  @override
  List<Object> get props => null;
}

class PregnantInstruction extends Equatable {
  final int week;
  final List<String> messages;
  final DateTime fromDate;
  final DateTime toDate;

  PregnantInstruction({
    @required this.week,
    @required this.messages,
    @required this.fromDate,
    @required this.toDate,
  });

  static List<PregnantInstruction> parseListToObject(List objectList) {
    List<PregnantInstruction> instance = [];
    for (Map item in objectList) {
      instance.add(PregnantInstruction(
        week: item['week'],
        messages: List<String>.from(item['messages']),
        fromDate: DateTime.parse(item['fromDate']),
        toDate: DateTime.parse(item['toDate']),
      ));
    }
    return instance;
  }

  static List<Map> objectToMap(List<PregnantInstruction> instructions) {
    List<Map> objectList = [];
    for (PregnantInstruction item in instructions) {
      objectList.add({
        "week": item.week,
        "fromDate": item.fromDate.toString(),
        "toDate": item.toDate.toString(),
        "messages": item.messages,
      });
    }
    return objectList;
  }

  @override
  List<Object> get props => null;
}
