import 'dart:async';
import 'dart:developer' as developer;

import 'package:bloc/bloc.dart';
import 'package:wmn_plus/features/auth/bloc/auth_bloc.dart';
import 'package:wmn_plus/features/auth/bloc/auth_event.dart';
import 'package:wmn_plus/features/auth/model/User.dart';
import 'package:wmn_plus/features/auth/resource/auth_repository.dart';
import 'package:wmn_plus/features/profile/change_mode/change_mode_fertility/change_mode_fertility_period/index.dart';

class ChangeModeFertilityPeriodBloc extends Bloc<ChangeModeFertilityPeriodEvent,
    ChangeModeFertilityPeriodState> {
  final AuthBloc authBloc;
  final UserRepository userRepository = UserRepository();
  final ChangeModeFertilityPeriodRepository
      _changeModeFertilityPeriodRepository =
      ChangeModeFertilityPeriodRepository();
  ChangeModeFertilityPeriodBloc({this.authBloc});

  @override
  Future<void> close() async {
    // authBloc.close();
    super.close();
  }

  ChangeModeFertilityPeriodState get initialState =>
      UnChangeModeFertilityPeriodState(0);

  @override
  Stream<ChangeModeFertilityPeriodState> mapEventToState(
    ChangeModeFertilityPeriodEvent event,
  ) async* {
    try {
      if (event is CompleteChangeModeFertilityEvent) {
        User user = await userRepository.getCurrentUser();
        var token = user.result.token;
        var fert = await _changeModeFertilityPeriodRepository
            .changeFertilityMode(token, event.fertility);
        print(fert);
        if (fert != null) {
          authBloc.add(LoggedInAuthEvent(user: fert));
        }
      }
    } catch (_, stackTrace) {
      developer.log('$_',
          name: 'ChangeModeFertilityPeriodBloc',
          error: _,
          stackTrace: stackTrace);
      yield state;
    }
  }
}
