import 'package:equatable/equatable.dart';

abstract class FertilityDurationState extends Equatable {
  /// notify change state without deep clone state
  final int version;
  
  final List propss;
  FertilityDurationState(this.version,[this.propss]);

  /// Copy object for use in action
  /// if need use deep clone
  FertilityDurationState getStateCopy();

  FertilityDurationState getNewVersion();

  @override
  List<Object> get props => (propss);
}

/// UnInitialized
class UnFertilityDurationState extends FertilityDurationState {

  UnFertilityDurationState(int version) : super(version);

  @override
  String toString() => 'UnFertilityDurationState';

  @override
  UnFertilityDurationState getStateCopy() {
    return UnFertilityDurationState(0);
  }

  @override
  UnFertilityDurationState getNewVersion() {
    return UnFertilityDurationState(version+1);
  }
}

/// Initialized
class InFertilityDurationState extends FertilityDurationState {
  final String hello;

  InFertilityDurationState(int version, this.hello) : super(version, [hello]);

  @override
  String toString() => 'InFertilityDurationState $hello';

  @override
  InFertilityDurationState getStateCopy() {
    return InFertilityDurationState(this.version, this.hello);
  }

  @override
  InFertilityDurationState getNewVersion() {
    return InFertilityDurationState(version+1, this.hello);
  }
}

class ErrorFertilityDurationState extends FertilityDurationState {
  final String errorMessage;

  ErrorFertilityDurationState(int version, this.errorMessage): super(version, [errorMessage]);
  
  @override
  String toString() => 'ErrorFertilityDurationState';

  @override
  ErrorFertilityDurationState getStateCopy() {
    return ErrorFertilityDurationState(this.version, this.errorMessage);
  }

  @override
  ErrorFertilityDurationState getNewVersion() {
    return ErrorFertilityDurationState(version+1, this.errorMessage);
  }
}
