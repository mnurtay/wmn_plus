import 'dart:async';
import 'dart:developer' as developer;

import 'package:bloc/bloc.dart';
import 'package:wmn_plus/features/registration/registration_mode/index.dart';

class RegistrationModeBloc extends Bloc<RegistrationModeEvent, RegistrationModeState> {
  // todo: check singleton for logic in project
  static final RegistrationModeBloc _registrationModeBlocSingleton = RegistrationModeBloc._internal();
  factory RegistrationModeBloc() {
    return _registrationModeBlocSingleton;
  }
  RegistrationModeBloc._internal();
  
  @override
  Future<void> close() async{
    super.close();
  }

  RegistrationModeState get initialState => UnRegistrationModeState(0);

  @override
  Stream<RegistrationModeState> mapEventToState(
    RegistrationModeEvent event,
  ) async* {
    try {
      yield await event.applyAsync(currentState: state, bloc: this);
    } catch (_, stackTrace) {
      developer.log('$_', name: 'RegistrationModeBloc', error: _, stackTrace: stackTrace);
      yield state;
    }
  }
}
