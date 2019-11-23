import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:wmn_plus/features/doctor/model/Doctor.dart';

class Consultation extends Equatable {
  final String id;
  final bool messageFromMe;
  final String messageContent;
  final int newMessageCount;
  final String date;
  final Doctor doctor;

  Consultation({
    @required this.id,
    @required this.messageContent,
    @required this.messageFromMe,
    @required this.newMessageCount,
    @required this.date,
    @required this.doctor,
  });

  static Consultation parseObject(Map objectMap) {
    print(objectMap);
    String date = objectMap['history']['date'].split('T')[0];
    Consultation instance = Consultation(
        id: objectMap['id'],
        messageContent: objectMap['history']['content'],
        messageFromMe: objectMap['history']['from'] == 'PAT',
        date: date.replaceAll('-', '.'),
        newMessageCount: 0,
        doctor: Doctor.anonymous());
    return instance;
  }

  static List<Consultation> parseList(String jsonString) {
    List<Consultation> instance = [];
    List<Map> objectList = json.decode(jsonString).cast<Map>();
    objectList.forEach((Map item) {
      instance.add(Consultation.parseObject(item));
    });
    return instance;
  }

  @override
  List<Object> get props => null;
}
