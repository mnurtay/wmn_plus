import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:wmn_plus/features/auth/model/User.dart';
import 'package:wmn_plus/features/auth/resource/auth_repository.dart';
import 'package:wmn_plus/features/consultation/model/Chat.dart';
import 'package:wmn_plus/features/consultation/model/Consultation.dart';
import 'package:wmn_plus/features/consultation/resource/chat_api_provider.dart';
import 'package:wmn_plus/features/doctor/model/Doctor.dart';

class ChatRepository {
  UserRepository userRepository = UserRepository();
  ChatApiProvider chatApiProvider = ChatApiProvider();

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

  Future<List<Doctor>> fetchDoctorsList({@required int categoryId}) async {
    User user = await userRepository.getCurrentUser();
    List<Doctor> doctors = await chatApiProvider.fetchDoctorsList(
        token: user.getToken, categoryId: categoryId);
    return doctors;
  }
}
