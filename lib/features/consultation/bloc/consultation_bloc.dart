import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:wmn_plus/features/consultation/model/Consultation.dart';
import 'package:wmn_plus/features/consultation/resource/chat_repository.dart';
import './bloc.dart';

// CONSULTATION BLOC
class ConsultationBloc extends Bloc<ConsultationEvent, ConsultationState> {
  ChatRepository chatRepository = ChatRepository();
  @override
  ConsultationState get initialState => InitialConsultationState();

  @override
  Stream<ConsultationState> mapEventToState(
    ConsultationEvent event,
  ) async* {
    if (event is ConsultationConfig) {
      yield LoadingConsultationState();
      try {
        List<Consultation> consultations = chatRepository.consultationConfig(
            consultationList: event.consultationList);
        yield FetchedConsultationState(consultations: consultations);
      } catch (e) {
        print(e);
      }
    }
  }
}

// CHAT BLOC
class ChatBloc extends Bloc<ChatEvent, ChatState> {
  ChatRepository chatRepository = ChatRepository();
  @override
  ChatState get initialState => InitialChatState();

  @override
  Stream<ChatState> mapEventToState(ChatEvent event) async* {
    if (event is ChatConfig) {
      yield LoadingChatState();
      try {
        final chat = chatRepository.chatConfig(
            chatHistory: event.chatHistory, newData: event.newData);
        yield FetchedChatState(messages: chat);
      } catch (e) {
        print(e);
      }
    }
  }
}
