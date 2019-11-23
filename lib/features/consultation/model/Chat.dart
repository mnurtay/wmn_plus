import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class Chat extends Equatable {
  final String message;
  final String date;
  final String time;
  final bool sendByMe;

  Chat(
      {@required this.message,
      @required this.date,
      @required this.time,
      @required this.sendByMe});

  factory Chat.parseObject(Map objectMap) {
    String date = objectMap['date'].split('T')[0];
    String time = objectMap['date'].split('T')[1];
    Chat instance = Chat(
        message: objectMap['content'],
        sendByMe: objectMap['from'] == 'PAT',
        date: date,
        time: time.substring(0, 5));
    return instance;
  }

  static List<Chat> parseList(List<Chat> history, List objectList) {
    List<Chat> instance = history;
    objectList.reversed.forEach((value) {
      instance.add(Chat.parseObject(value));
    });
    return instance;
  }

  @override
  List<Object> get props => null;
}
