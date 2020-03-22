import 'dart:async';
import 'dart:developer' as developer;

import 'package:bloc/bloc.dart';
import 'package:wmn_plus/features/profile/changeprofile/index.dart';

class ChangeprofileBloc extends Bloc<ChangeprofileEvent, ChangeprofileState> {
  // todo: check singleton for logic in project
  static final ChangeprofileBloc _changeprofileBlocSingleton = ChangeprofileBloc._internal();
  factory ChangeprofileBloc() {
    return _changeprofileBlocSingleton;
  }
  ChangeprofileBloc._internal();
  
  @override
  Future<void> close() async{
    // dispose objects
    await super.close();
  }

  @override
  ChangeprofileState get initialState => UnChangeprofileState(0);

  @override
  Stream<ChangeprofileState> mapEventToState(
    ChangeprofileEvent event,
  ) async* {
    try {
      yield await event.applyAsync(currentState: state, bloc: this);
    } catch (_, stackTrace) {
      developer.log('$_', name: 'ChangeprofileBloc', error: _, stackTrace: stackTrace);
      yield state;
    }
  }
}
