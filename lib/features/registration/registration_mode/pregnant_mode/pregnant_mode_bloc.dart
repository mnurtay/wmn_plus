import 'dart:async';
import 'dart:developer' as developer;

import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wmn_plus/features/auth/bloc/auth_bloc.dart';
import 'package:wmn_plus/features/auth/bloc/auth_event.dart';
import 'package:wmn_plus/features/auth/resource/auth_repository.dart';
import 'package:wmn_plus/features/registration/registration_mode/pregnant_mode/index.dart';

class PregnantModeBloc extends Bloc<PregnantModeEvent, PregnantModeState> {
  AuthBloc authBloc;
  PregnantModeBloc({this.authBloc});
  final UserRepository userRepository = UserRepository();
  final PregnantModeRepository _pregnantModeRepository =
      PregnantModeRepository();
  @override
  Future<void> close() async {
    authBloc.close();
    super.close();
  }

  PregnantModeState get initialState => UnPregnantModeState(0);

  @override
  Stream<PregnantModeState> mapEventToState(
    PregnantModeEvent event,
  ) async* {
    try {
      if (event is CompleteRegistrationEvent) {
        var user = await _pregnantModeRepository.requestUserRegistration(event.registrationModel);
        // await userRepository.setFirstLaunch();
        // var userModel = await userRepository.authenticate(
        //     username: "event.username", password: "event.password");
        authBloc.add(LoggedInAuthEvent(user: user));
      }
      yield await event.applyAsync(currentState: state, bloc: this);
    } catch (_, stackTrace) {
      developer.log('$_',
          name: 'PregnantModeBloc', error: _, stackTrace: stackTrace);
      yield state;
    }
  }
}
