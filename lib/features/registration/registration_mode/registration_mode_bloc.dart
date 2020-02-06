import 'dart:async';
import 'dart:developer' as developer;

import 'package:bloc/bloc.dart';
import 'package:wmn_plus/features/auth/bloc/auth_bloc.dart';
import 'package:wmn_plus/features/auth/bloc/auth_event.dart';
import 'package:wmn_plus/features/auth/resource/auth_repository.dart';
import 'package:wmn_plus/features/registration/registration_mode/index.dart';
import 'package:wmn_plus/features/registration/registration_mode/pregnant_mode/pregnant_mode_repository.dart';

class RegistrationModeBloc
    extends Bloc<RegistrationModeEvent, RegistrationModeState> {
  final AuthBloc authBloc;
  final UserRepository userRepository = UserRepository();
  final PregnantModeRepository _pregnantModeRepository =
      PregnantModeRepository();
  RegistrationModeBloc({this.authBloc});
  @override
  Future<void> close() async {
    super.close();
  }

  RegistrationModeState get initialState => UnRegistrationModeState(0);

  @override
  Stream<RegistrationModeState> mapEventToState(
    RegistrationModeEvent event,
  ) async* {
    try {
      if (event is CompleteRegistrationModeEvent) {
        //climax
        var user = await _pregnantModeRepository
            .requestUserClimaxRegistration(event.registrationModel);
        if (user.result.token.isNotEmpty)
          authBloc.add(LoggedInAuthEvent(user: user));
      }

      yield await event.applyAsync(currentState: state, bloc: this);
    } catch (_, stackTrace) {
      developer.log('$_',
          name: 'RegistrationModeBloc', error: _, stackTrace: stackTrace);
      yield state;
    }
  }
}
