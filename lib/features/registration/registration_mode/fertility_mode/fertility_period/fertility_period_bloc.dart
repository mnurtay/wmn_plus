import 'dart:async';
import 'dart:developer' as developer;

import 'package:bloc/bloc.dart';
import 'package:wmn_plus/features/auth/bloc/auth_bloc.dart';
import 'package:wmn_plus/features/auth/bloc/auth_event.dart';
import 'package:wmn_plus/features/auth/resource/auth_repository.dart';
import 'package:wmn_plus/features/registration/registration_mode/fertility_mode/fertility_period/index.dart';

class FertilityPeriodBloc
    extends Bloc<FertilityPeriodEvent, FertilityPeriodState> {
  // todo: check singleton for logic in project
  AuthBloc authBloc;
  final UserRepository userRepository = UserRepository();
  final FertilityPeriodRepository fertilityPeriodRepository =
      FertilityPeriodRepository();
  FertilityPeriodBloc({this.authBloc});

  @override
  Future<void> close() async {
    authBloc.close();
    super.close();
  }

  FertilityPeriodState get initialState => UnFertilityPeriodState(0);

  @override
  Stream<FertilityPeriodState> mapEventToState(
    FertilityPeriodEvent event,
  ) async* {
    try {
      if (event is CompleteRegistrationEvent) {
        var user = await fertilityPeriodRepository
            .requestUserRegistration(event.registrationModel);
        if (user.result.token.isNotEmpty)
          authBloc.add(LoggedInAuthEvent(user: user));
      }
      yield await event.applyAsync(currentState: state, bloc: this);
    } catch (_, stackTrace) {
      developer.log('$_',
          name: 'FertilityPeriodBloc', error: _, stackTrace: stackTrace);
      yield ErrorFertilityPeriodState(0, _.toString());
    }
  }
}
