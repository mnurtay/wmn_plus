import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:wmn_plus/features/consultation/model/Chat.dart';

// CONSULTATION EVENT
@immutable
abstract class ConsultationEvent extends Equatable {
  ConsultationEvent([List props = const []]);
}

class ConsultationConfig extends ConsultationEvent {
  final String consultationList;
  ConsultationConfig({@required this.consultationList});

  @override
  List<Object> get props => null;
}

class FetchDoctorsListEvent extends ConsultationEvent {
  final int categoryId;
  FetchDoctorsListEvent({@required this.categoryId});

  @override
  List<Object> get props => null;
}

class ConsultationPaymentEvent extends ConsultationEvent {
  final int doctorId;
  ConsultationPaymentEvent({@required this.doctorId});

  @override
  List<Object> get props => null;
}

// CHAT EVENT
@immutable
abstract class ChatEvent extends Equatable {}

class ChatConfig extends ChatEvent {
  final List<Chat> chatHistory;
  final String newData;
  ChatConfig({@required this.chatHistory, @required this.newData});

  @override
  List<Object> get props => null;
}

class GetCurrentUserChatEvent extends ChatEvent {
  @override
  List<Object> get props => null;
}
