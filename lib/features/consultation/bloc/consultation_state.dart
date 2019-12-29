import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:wmn_plus/features/auth/model/User.dart';
import 'package:wmn_plus/features/consultation/model/Chat.dart';
import 'package:wmn_plus/features/consultation/model/Consultation.dart';
import 'package:wmn_plus/features/consultation/model/Doctor.dart';

@immutable
abstract class ConsultationState extends Equatable {}

class InitialConsultationState extends ConsultationState {
  @override
  List<Object> get props => null;
}

class LoadingConsultationState extends ConsultationState {
  @override
  List<Object> get props => null;
}

class FetchedConsultationState extends ConsultationState {
  final List<Consultation> consultations;
  FetchedConsultationState({@required this.consultations});

  @override
  List<Object> get props => null;
}

class FetchedDoctorsListState extends ConsultationState {
  final List<Doctor> doctors;
  FetchedDoctorsListState({@required this.doctors});
  @override
  List<Object> get props => null;
}

class FetchedConsultationPaymentState extends ConsultationState {
  final Map payment;
  FetchedConsultationPaymentState({@required this.payment});
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

class FetchedCurrentUserState extends ChatState {
  final User user;

  FetchedCurrentUserState(this.user);
  @override
  List<Object> get props => null;
}
