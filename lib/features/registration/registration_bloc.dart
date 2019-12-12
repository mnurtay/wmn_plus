import 'dart:async';
import 'dart:developer' as developer;

import 'package:bloc/bloc.dart';

import 'package:wmn_plus/features/registration/index.dart';

class RegistrationBloc extends Bloc<RegistrationEvent, RegistrationState> {
  RegistrationBloc();

  @override
  Future<void> close() async {
    super.close();
  }

  RegistrationState get initialState => UnRegistrationState(0);

  @override
  Stream<RegistrationState> mapEventToState(
    RegistrationEvent event,
  ) async* {
    try {
      yield await event.applyAsync(currentState: state, bloc: this);
    } catch (_, stackTrace) {
      developer.log('$_',
          name: 'RegistrationBloc', error: _, stackTrace: stackTrace);
      yield state;
    }
  }
}
