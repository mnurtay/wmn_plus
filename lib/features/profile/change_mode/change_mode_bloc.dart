import 'dart:async';
import 'dart:developer' as developer;

import 'package:bloc/bloc.dart';
import 'package:wmn_plus/features/profile/change_mode/index.dart';

class ChangeModeBloc extends Bloc<ChangeModeEvent, ChangeModeState> {
  // todo: check singleton for logic in project
  static final ChangeModeBloc _changeModeBlocSingleton = ChangeModeBloc._internal();
  factory ChangeModeBloc() {
    return _changeModeBlocSingleton;
  }
  ChangeModeBloc._internal();
  
  @override
  Future<void> close() async{
    // dispose objects
    super.close();
  }

  ChangeModeState get initialState => UnChangeModeState(0);

  @override
  Stream<ChangeModeState> mapEventToState(
    ChangeModeEvent event,
  ) async* {
    try {
      yield await event.applyAsync(currentState: state, bloc: this);
    } catch (_, stackTrace) {
      developer.log('$_', name: 'ChangeModeBloc', error: _, stackTrace: stackTrace);
      yield state;
    }
  }
}
