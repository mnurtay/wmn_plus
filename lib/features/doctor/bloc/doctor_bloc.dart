import 'dart:async';
import 'package:bloc/bloc.dart';
import './bloc.dart';

class DoctorBloc extends Bloc<DoctorEvent, DoctorState> {
  @override
  DoctorState get initialState => InitialDoctorState();

  @override
  Stream<DoctorState> mapEventToState(
    DoctorEvent event,
  ) async* {
    // TODO: Add Logic
  }
}
