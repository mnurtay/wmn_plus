import 'package:equatable/equatable.dart';
import 'package:wmn_plus/features/fertility_calendar/index.dart';

abstract class FertilityCalendarState extends Equatable {
  /// notify change state without deep clone state
  final int version;
  
  final List propss;
  FertilityCalendarState(this.version,[this.propss]);

  /// Copy object for use in action
  /// if need use deep clone
  FertilityCalendarState getStateCopy();

  FertilityCalendarState getNewVersion();

  @override
  List<Object> get props => (propss);
}

/// UnInitialized
class UnFertilityCalendarState extends FertilityCalendarState {

  UnFertilityCalendarState(int version) : super(version);

  @override
  String toString() => 'UnFertilityCalendarState';

  @override
  UnFertilityCalendarState getStateCopy() {
    return UnFertilityCalendarState(0);
  }

  @override
  UnFertilityCalendarState getNewVersion() {
    return UnFertilityCalendarState(version+1);
  }
}

/// Initialized
class InFertilityCalendarState extends FertilityCalendarState {
  final Result result;
  final String language;

  InFertilityCalendarState(int version, this.result, this.language) : super(version, [result,language]);

  @override
  String toString() => 'InFertilityCalendarState $result';

  @override
  InFertilityCalendarState getStateCopy() {
    return InFertilityCalendarState(this.version, this.result, this.language);
  }

  @override
  InFertilityCalendarState getNewVersion() {
    return InFertilityCalendarState(version+1, this.result, this.language);
  }
}

class ErrorFertilityCalendarState extends FertilityCalendarState {
  final String errorMessage;

  ErrorFertilityCalendarState(int version, this.errorMessage): super(version, [errorMessage]);
  
  @override
  String toString() => 'ErrorFertilityCalendarState';

  @override
  ErrorFertilityCalendarState getStateCopy() {
    return ErrorFertilityCalendarState(this.version, this.errorMessage);
  }

  @override
  ErrorFertilityCalendarState getNewVersion() {
    return ErrorFertilityCalendarState(version+1, this.errorMessage);
  }
}
