import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:wmn_plus/features/auth/model/User.dart';
import 'package:wmn_plus/features/consultation/model/Doctor.dart';

class Consultation extends Equatable {
  final String id;
  final bool messageFromMe;
  final String messageContent;
  final int newMessageCount;
  final String date;
  final Doctor doctor;
  final Result pat;

  Consultation({
    @required this.id,
    @required this.messageContent,
    @required this.messageFromMe,
    @required this.newMessageCount,
    @required this.date,
    @required this.doctor,
    this.pat
  });

  static Consultation parseObject(Map objectMap) {
    Consultation instance;
    if (objectMap['history'] != null) {
      String date = objectMap['history']['date'].split('T')[0];
      instance = Consultation(
          id: objectMap['id'],
          messageContent: objectMap['history']['content'],
          messageFromMe: objectMap['history']['from'] == 'PAT',
          date: date.replaceAll('-', '.'),
          newMessageCount: 0,
          pat: Result.fromJson(objectMap["patient"]),
          doctor: Doctor.parseObject(objectMap["doctor"]));
    } else {
      instance = Consultation(
          id: objectMap['id'],
          messageContent: '',
          messageFromMe: false,
          date: '',
          newMessageCount: 0,
          doctor: Doctor.parseObject(objectMap["doctor"]));
    }
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
