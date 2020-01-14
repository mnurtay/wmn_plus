import 'dart:async';
import 'dart:developer' as developer;

import 'package:bloc/bloc.dart';
import 'package:wmn_plus/features/auth/bloc/auth_bloc.dart';
import 'package:wmn_plus/features/auth/bloc/auth_event.dart';
import 'package:wmn_plus/features/profile/change_mode/index.dart';

class ChangeModeBloc extends Bloc<ChangeModeEvent, ChangeModeState> {
  // todo: check singleton for logic in project
  final AuthBloc authBloc;
  ChangeModeBloc({this.authBloc});
  @override
  Future<void> close() async {
    authBloc.close();
    ChangeModeBloc().close();
    super.close();
  }

  ChangeModeState get initialState => UnChangeModeState(0);

  @override
  Stream<ChangeModeState> mapEventToState(
    ChangeModeEvent event,
  ) async* {
    try {
        if (event is CompleteChangeModeEvent) {
        //climax
        var user = await ChangeModeProvider().requestChangeModeToClimax();
        if (user.result.token.isNotEmpty)
          authBloc.add(LoggedInAuthEvent(user: user));
      }
      yield await event.applyAsync(currentState: state, bloc: this);
    } catch (_, stackTrace) {
      developer.log('$_',
          name: 'ChangeModeBloc', error: _, stackTrace: stackTrace);
      yield state;
    }
  }
}
