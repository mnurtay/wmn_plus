import 'package:equatable/equatable.dart';

abstract class ChangeModeFertilityState extends Equatable {
  /// notify change state without deep clone state
  final int version;
  
  final List propss;
  ChangeModeFertilityState(this.version,[this.propss]);

  /// Copy object for use in action
  /// if need use deep clone
  ChangeModeFertilityState getStateCopy();

  ChangeModeFertilityState getNewVersion();

  @override
  List<Object> get props => (propss);
}

/// UnInitialized
class UnChangeModeFertilityState extends ChangeModeFertilityState {

  UnChangeModeFertilityState(int version) : super(version);

  @override
  String toString() => 'UnChangeModeFertilityState';

  @override
  UnChangeModeFertilityState getStateCopy() {
    return UnChangeModeFertilityState(0);
  }

  @override
  UnChangeModeFertilityState getNewVersion() {
    return UnChangeModeFertilityState(version+1);
  }
}

/// Initialized
class InChangeModeFertilityState extends ChangeModeFertilityState {
  final String hello;

  InChangeModeFertilityState(int version, this.hello) : super(version, [hello]);

  @override
  String toString() => 'InChangeModeFertilityState $hello';

  @override
  InChangeModeFertilityState getStateCopy() {
    return InChangeModeFertilityState(this.version, this.hello);
  }

  @override
  InChangeModeFertilityState getNewVersion() {
    return InChangeModeFertilityState(version+1, this.hello);
  }
}

class ErrorChangeModeFertilityState extends ChangeModeFertilityState {
  final String errorMessage;

  ErrorChangeModeFertilityState(int version, this.errorMessage): super(version, [errorMessage]);
  
  @override
  String toString() => 'ErrorChangeModeFertilityState';

  @override
  ErrorChangeModeFertilityState getStateCopy() {
    return ErrorChangeModeFertilityState(this.version, this.errorMessage);
  }

  @override
  ErrorChangeModeFertilityState getNewVersion() {
    return ErrorChangeModeFertilityState(version+1, this.errorMessage);
  }
}
