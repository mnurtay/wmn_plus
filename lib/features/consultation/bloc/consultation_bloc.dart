import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:wmn_plus/features/consultation/resource/chat_repository.dart';
import './bloc.dart';

// CONSULTATION BLOC
class ConsultationBloc extends Bloc<ConsultationEvent, ConsultationState> {
  @override
  ConsultationState get initialState => InitialConsultationState();

  @override
  Stream<ConsultationState> mapEventToState(
    ConsultationEvent event,
  ) async* {
    // TODO: Add Logic
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
