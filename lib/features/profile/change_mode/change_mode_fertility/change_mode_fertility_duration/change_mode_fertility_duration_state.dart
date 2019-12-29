import 'package:equatable/equatable.dart';

abstract class ChangeModeFertilityDurationState extends Equatable {
  /// notify change state without deep clone state
  final int version;
  
  final List propss;
  ChangeModeFertilityDurationState(this.version,[this.propss]);

  /// Copy object for use in action
  /// if need use deep clone
  ChangeModeFertilityDurationState getStateCopy();

  ChangeModeFertilityDurationState getNewVersion();

  @override
  List<Object> get props => (propss);
}

/// UnInitialized
class UnChangeModeFertilityDurationState extends ChangeModeFertilityDurationState {

  UnChangeModeFertilityDurationState(int version) : super(version);

  @override
  String toString() => 'UnChangeModeFertilityDurationState';

  @override
  UnChangeModeFertilityDurationState getStateCopy() {
    return UnChangeModeFertilityDurationState(0);
  }

  @override
  UnChangeModeFertilityDurationState getNewVersion() {
    return UnChangeModeFertilityDurationState(version+1);
  }
}

/// Initialized
class InChangeModeFertilityDurationState extends ChangeModeFertilityDurationState {
  final String hello;

  InChangeModeFertilityDurationState(int version, this.hello) : super(version, [hello]);

  @override
  String toString() => 'InChangeModeFertilityDurationState $hello';

  @override
  InChangeModeFertilityDurationState getStateCopy() {
    return InChangeModeFertilityDurationState(this.version, this.hello);
  }

  @override
  InChangeModeFertilityDurationState getNewVersion() {
    return InChangeModeFertilityDurationState(version+1, this.hello);
  }
}

class ErrorChangeModeFertilityDurationState extends ChangeModeFertilityDurationState {
  final String errorMessage;

  ErrorChangeModeFertilityDurationState(int version, this.errorMessage): super(version, [errorMessage]);
  
  @override
  String toString() => 'ErrorChangeModeFertilityDurationState';

  @override
  ErrorChangeModeFertilityDurationState getStateCopy() {
    return ErrorChangeModeFertilityDurationState(this.version, this.errorMessage);
  }

  @override
  ErrorChangeModeFertilityDurationState getNewVersion() {
    return ErrorChangeModeFertilityDurationState(version+1, this.errorMessage);
  }
}
