import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:wmn_plus/features/consultation/model/Chat.dart';

@immutable
abstract class ConsultationState extends Equatable {}

class InitialConsultationState extends ConsultationState {
  @override
  List<Object> get props => null;
}

// CHAT STATE
@immutable
abstract class ChatState extends Equatable {}

class InitialChatState extends ChatState {
  @override
  List<Object> get props => null;
}

class LoadingChatState extends ChatState {
  @override
  List<Object> get props => null;
}

class FetchedChatState extends ChatState {
  final List<Chat> messages;
  FetchedChatState({@required this.messages});

  @override
  List<Object> get props => null;
}
