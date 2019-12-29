import 'package:equatable/equatable.dart';

abstract class ChangeModeFertilityPeriodState extends Equatable {
  /// notify change state without deep clone state
  final int version;
  
  final List propss;
  ChangeModeFertilityPeriodState(this.version,[this.propss]);

  /// Copy object for use in action
  /// if need use deep clone
  ChangeModeFertilityPeriodState getStateCopy();

  ChangeModeFertilityPeriodState getNewVersion();

  @override
  List<Object> get props => (propss);
}

/// UnInitialized
class UnChangeModeFertilityPeriodState extends ChangeModeFertilityPeriodState {

  UnChangeModeFertilityPeriodState(int version) : super(version);

  @override
  String toString() => 'UnChangeModeFertilityPeriodState';

  @override
  UnChangeModeFertilityPeriodState getStateCopy() {
    return UnChangeModeFertilityPeriodState(0);
  }

  @override
  UnChangeModeFertilityPeriodState getNewVersion() {
    return UnChangeModeFertilityPeriodState(version+1);
  }
}

/// Initialized
class InChangeModeFertilityPeriodState extends ChangeModeFertilityPeriodState {
  final String hello;

  InChangeModeFertilityPeriodState(int version, this.hello) : super(version, [hello]);

  @override
  String toString() => 'InChangeModeFertilityPeriodState $hello';

  @override
  InChangeModeFertilityPeriodState getStateCopy() {
    return InChangeModeFertilityPeriodState(this.version, this.hello);
  }

  @override
  InChangeModeFertilityPeriodState getNewVersion() {
    return InChangeModeFertilityPeriodState(version+1, this.hello);
  }
}

class ErrorChangeModeFertilityPeriodState extends ChangeModeFertilityPeriodState {
  final String errorMessage;

  ErrorChangeModeFertilityPeriodState(int version, this.errorMessage): super(version, [errorMessage]);
  
  @override
  String toString() => 'ErrorChangeModeFertilityPeriodState';

  @override
  ErrorChangeModeFertilityPeriodState getStateCopy() {
    return ErrorChangeModeFertilityPeriodState(this.version, this.errorMessage);
  }

  @override
  ErrorChangeModeFertilityPeriodState getNewVersion() {
    return ErrorChangeModeFertilityPeriodState(version+1, this.errorMessage);
  }
}
