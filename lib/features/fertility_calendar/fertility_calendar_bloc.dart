import 'dart:async';
import 'dart:developer' as developer;

import 'package:bloc/bloc.dart';
import 'package:wmn_plus/features/fertility_calendar/index.dart';

class FertilityCalendarBloc extends Bloc<FertilityCalendarEvent, FertilityCalendarState> {
  // todo: check singleton for logic in project
  static final FertilityCalendarBloc _fertilityCalendarBlocSingleton = FertilityCalendarBloc._internal();
  factory FertilityCalendarBloc() {
    return _fertilityCalendarBlocSingleton;
  }
  FertilityCalendarBloc._internal();
  
  @override
  Future<void> close() async{
    super.close();
  }

  FertilityCalendarState get initialState => UnFertilityCalendarState(0);

  @override
  Stream<FertilityCalendarState> mapEventToState(
    FertilityCalendarEvent event,
  ) async* {
    try {
      yield await event.applyAsync(currentState: state, bloc: this);
    } catch (_, stackTrace) {
      developer.log('$_', name: 'FertilityCalendarBloc', error: _, stackTrace: stackTrace);
      yield state;
    }
  }
}
