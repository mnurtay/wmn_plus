import 'dart:async';
import 'dart:developer' as developer;

import 'package:bloc/bloc.dart';
import 'package:wmn_plus/features/registration/registration_mode/fertility_mode/fertility_duration/index.dart';

class FertilityDurationBloc extends Bloc<FertilityDurationEvent, FertilityDurationState> {
  // todo: check singleton for logic in project
  static final FertilityDurationBloc _fertilityDurationBlocSingleton = FertilityDurationBloc._internal();
  factory FertilityDurationBloc() {
    return _fertilityDurationBlocSingleton;
  }
  FertilityDurationBloc._internal();
  
  @override
  Future<void> close() async{
    // dispose objects
    super.close();
  }

  FertilityDurationState get initialState => UnFertilityDurationState(0);

  @override
  Stream<FertilityDurationState> mapEventToState(
    FertilityDurationEvent event,
  ) async* {
    try {
      yield await event.applyAsync(currentState: state, bloc: this);
    } catch (_, stackTrace) {
      developer.log('$_', name: 'FertilityDurationBloc', error: _, stackTrace: stackTrace);
      yield state;
    }
  }
}
