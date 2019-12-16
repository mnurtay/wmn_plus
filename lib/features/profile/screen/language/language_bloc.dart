import 'dart:async';
import 'dart:developer' as developer;

import 'package:bloc/bloc.dart';
import 'package:wmn_plus/features/profile/screen/language/index.dart';

class LanguageBloc extends Bloc<LanguageEvent, LanguageState> {
  // todo: check singleton for logic in project
  static final LanguageBloc _languageBlocSingleton = LanguageBloc._internal();
  factory LanguageBloc() {
    return _languageBlocSingleton;
  }
  LanguageBloc._internal();
  
  @override
  Future<void> close() async{
    _languageBlocSingleton.close();
    super.close();
  }

  LanguageState get initialState => UnLanguageState(0);

  @override
  Stream<LanguageState> mapEventToState(
    LanguageEvent event,
  ) async* {
    try {
      yield await event.applyAsync(currentState: state, bloc: this);
    } catch (_, stackTrace) {
      developer.log('$_', name: 'LanguageBloc', error: _, stackTrace: stackTrace);
      yield state;
    }
  }
}
