import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:wmn_plus/features/consultation/model/Chat.dart';
import 'package:wmn_plus/features/consultation/model/Consultation.dart';

class ChatRepository {
  List<Chat> chatConfig(
      {@required List<Chat> chatHistory, @required String newData}) {
    List<Chat> objectList = chatHistory;
    final newMessage = json.decode(newData);
    if (newMessage['status'] == 'SEND_HISTORY') {
      objectList = Chat.parseList(chatHistory, newMessage['history']);
    } else if (newMessage['status'] == 'SEND_MESSAGE') {
      objectList.insert(0, Chat.parseObject(newMessage));
    }
    return objectList;
  }

  List<Consultation> consultationConfig({@required String consultationList}) {
    List<Consultation> instanceList;
    instanceList = Consultation.parseList(consultationList);
    return instanceList;
  }
}
