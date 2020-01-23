import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:wmn_plus/features/auth/resource/auth_repository.dart';
import 'package:wmn_plus/features/consultation/model/Chat.dart';
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
    // Consultation Chat List
    if (event is ConsultationConfig) {
      yield LoadingConsultationState();
      try {
        List<Consultation> consultations = chatRepository.consultationConfig(
            consultationList: event.consultationList);
        print(consultations[0].doctor.firstName + consultations[0].doctor.secondName);
        yield FetchedConsultationState(consultations: consultations);
      } catch (e) {
        print(e);
      }
    }
    // Fetching Doctors List By Category
    if (event is FetchDoctorsListEvent) {
      yield LoadingConsultationState();
      try {
        final doctors =
            await chatRepository.fetchDoctorsList(categoryId: event.categoryId);
        yield FetchedDoctorsListState(doctors: doctors);
      } catch (e) {
        print(e);
      }
    }
    // Consultation Payment
    if (event is ConsultationPaymentEvent) {
      yield LoadingConsultationState();
      try {
        final payment = await chatRepository.fetchConsultationPayment(
            doctorId: event.doctorId);
        yield FetchedConsultationPaymentState(payment: payment);
      } catch (e) {
        print(e);
      }
    }
  }
}

// CHAT BLOC
class ChatBloc extends Bloc<ChatEvent, ChatState> {
  ChatRepository chatRepository = ChatRepository();
  UserRepository userRepository = UserRepository();
  @override
  ChatState get initialState => InitialChatState();

  @override
  Stream<ChatState> mapEventToState(ChatEvent event) async* {
    if (event is ChatConfig) {
      yield LoadingChatState();
      try {
        final List<Chat> chat = chatRepository.chatConfig(
            chatHistory: event.chatHistory, newData: event.newData);
        yield FetchedChatState(messages: chat);
      } catch (e) {
        print(e);
      }
    }
    if (event is GetCurrentUserChatEvent) {
      final user = await userRepository.getCurrentUser();
      yield FetchedCurrentUserState(user);
    }
  }
}
