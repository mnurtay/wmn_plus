import 'package:equatable/equatable.dart';

abstract class FertilityPeriodState extends Equatable {
  /// notify change state without deep clone state
  final int version;
  
  final List propss;
  FertilityPeriodState(this.version,[this.propss]);

  /// Copy object for use in action
  /// if need use deep clone
  FertilityPeriodState getStateCopy();

  FertilityPeriodState getNewVersion();

  @override
  List<Object> get props => (propss);
}

/// UnInitialized
class UnFertilityPeriodState extends FertilityPeriodState {

  UnFertilityPeriodState(int version) : super(version);

  @override
  String toString() => 'UnFertilityPeriodState';

  @override
  UnFertilityPeriodState getStateCopy() {
    return UnFertilityPeriodState(0);
  }

  @override
  UnFertilityPeriodState getNewVersion() {
    return UnFertilityPeriodState(version+1);
  }
}

/// Initialized
class InFertilityPeriodState extends FertilityPeriodState {
  final String hello;

  InFertilityPeriodState(int version, this.hello) : super(version, [hello]);

  @override
  String toString() => 'InFertilityPeriodState $hello';

  @override
  InFertilityPeriodState getStateCopy() {
    return InFertilityPeriodState(this.version, this.hello);
  }

  @override
  InFertilityPeriodState getNewVersion() {
    return InFertilityPeriodState(version+1, this.hello);
  }
}

class OutFertilityPeriodState extends FertilityPeriodState {
  final String hello;

  OutFertilityPeriodState(int version, this.hello) : super(version, [hello]);

  @override
  String toString() => 'InFertilityPeriodState $hello';

  @override
  OutFertilityPeriodState getStateCopy() {
    return OutFertilityPeriodState(this.version, this.hello);
  }

  @override
  OutFertilityPeriodState getNewVersion() {
    return OutFertilityPeriodState(version+1, this.hello);
  }
}

class ErrorFertilityPeriodState extends FertilityPeriodState {
  final String errorMessage;

  ErrorFertilityPeriodState(int version, this.errorMessage): super(version, [errorMessage]);
  
  @override
  String toString() => 'ErrorFertilityPeriodState';

  @override
  ErrorFertilityPeriodState getStateCopy() {
    return ErrorFertilityPeriodState(this.version, this.errorMessage);
  }

  @override
  ErrorFertilityPeriodState getNewVersion() {
    return ErrorFertilityPeriodState(version+1, this.errorMessage);
  }
}
