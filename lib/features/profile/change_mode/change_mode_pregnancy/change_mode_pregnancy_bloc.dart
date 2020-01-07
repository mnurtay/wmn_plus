import 'dart:async';
import 'dart:developer' as developer;

import 'package:bloc/bloc.dart';
import 'package:wmn_plus/features/auth/bloc/auth_bloc.dart';
import 'package:wmn_plus/features/auth/bloc/auth_event.dart';
import 'package:wmn_plus/features/auth/model/User.dart';
import 'package:wmn_plus/features/auth/resource/auth_repository.dart';
import 'package:wmn_plus/features/profile/change_mode/change_mode_pregnancy/index.dart';

class ChangeModePregnancyBloc
    extends Bloc<ChangeModePregnancyEvent, ChangeModePregnancyState> {
  AuthBloc authBloc;
  final UserRepository userRepository = UserRepository();
  final ChangeModePregnancyRepository _changeModePregnancyRepository =
      ChangeModePregnancyRepository();

  ChangeModePregnancyBloc({this.authBloc});

  @override
  Future<void> close() async {
    authBloc.close();
    super.close();
  }

  ChangeModePregnancyState get initialState => UnChangeModePregnancyState(0);

  @override
  Stream<ChangeModePregnancyState> mapEventToState(
    ChangeModePregnancyEvent event,
  ) async* {
    try {
      if (event is CompleteChangeModePregnancyEvent) {
        User user = await userRepository.getCurrentUser();
        var token = user.result.token;
        var preg = await _changeModePregnancyRepository.changePregnancyMode(
            token, event.pregnancy);
        print(preg.toJson().toString());
        if (preg != null) {
          authBloc.add(LoggedInAuthEvent(user: preg));
        }
      }
      yield await event.applyAsync(currentState: state, bloc: this);
    } catch (_, stackTrace) {
      developer.log('$_',
          name: 'ChangeModePregnancyBloc', error: _, stackTrace: stackTrace);
      yield state;
    }
  }
}
