import 'package:equatable/equatable.dart';

abstract class FertilityModeState extends Equatable {
  /// notify change state without deep clone state
  final int version;
  
  final List propss;
  FertilityModeState(this.version,[this.propss]);

  /// Copy object for use in action
  /// if need use deep clone
  FertilityModeState getStateCopy();

  FertilityModeState getNewVersion();

  @override
  List<Object> get props => (propss);
}

/// UnInitialized
class UnFertilityModeState extends FertilityModeState {

  UnFertilityModeState(int version) : super(version);

  @override
  String toString() => 'UnFertilityModeState';

  @override
  UnFertilityModeState getStateCopy() {
    return UnFertilityModeState(0);
  }

  @override
  UnFertilityModeState getNewVersion() {
    return UnFertilityModeState(version+1);
  }
}

/// Initialized
class InFertilityModeState extends FertilityModeState {
  final String hello;

  InFertilityModeState(int version, this.hello) : super(version, [hello]);

  @override
  String toString() => 'InFertilityModeState $hello';

  @override
  InFertilityModeState getStateCopy() {
    return InFertilityModeState(this.version, this.hello);
  }

  @override
  InFertilityModeState getNewVersion() {
    return InFertilityModeState(version+1, this.hello);
  }
}

class ErrorFertilityModeState extends FertilityModeState {
  final String errorMessage;

  ErrorFertilityModeState(int version, this.errorMessage): super(version, [errorMessage]);
  
  @override
  String toString() => 'ErrorFertilityModeState';

  @override
  ErrorFertilityModeState getStateCopy() {
    return ErrorFertilityModeState(this.version, this.errorMessage);
  }

  @override
  ErrorFertilityModeState getNewVersion() {
    return ErrorFertilityModeState(version+1, this.errorMessage);
  }
}
