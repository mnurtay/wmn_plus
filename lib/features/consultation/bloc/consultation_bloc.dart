import 'dart:async';
import 'package:bloc/bloc.dart';
import './bloc.dart';

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
