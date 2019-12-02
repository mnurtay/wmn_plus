import 'package:equatable/equatable.dart';

abstract class RegistrationState extends Equatable {
  /// notify change state without deep clone state
  final int version;
  
  final List propss;
  RegistrationState(this.version,[this.propss]);

  /// Copy object for use in action
  /// if need use deep clone
  RegistrationState getStateCopy();

  RegistrationState getNewVersion();

  @override
  List<Object> get props => (propss);
}

/// UnInitialized
class UnRegistrationState extends RegistrationState {

  UnRegistrationState(int version) : super(version);

  @override
  String toString() => 'UnRegistrationState';

  @override
  UnRegistrationState getStateCopy() {
    return UnRegistrationState(0);
  }

  @override
  UnRegistrationState getNewVersion() {
    return UnRegistrationState(version+1);
  }
}

/// Initialized
class InRegistrationState extends RegistrationState {
  final String hello;

  InRegistrationState(int version, this.hello) : super(version, [hello]);

  @override
  String toString() => 'InRegistrationState $hello';

  @override
  InRegistrationState getStateCopy() {
    return InRegistrationState(this.version, this.hello);
  }

  @override
  InRegistrationState getNewVersion() {
    return InRegistrationState(version+1, this.hello);
  }
}

class ErrorRegistrationState extends RegistrationState {
  final String errorMessage;

  ErrorRegistrationState(int version, this.errorMessage): super(version, [errorMessage]);
  
  @override
  String toString() => 'ErrorRegistrationState';

  @override
  ErrorRegistrationState getStateCopy() {
    return ErrorRegistrationState(this.version, this.errorMessage);
  }

  @override
  ErrorRegistrationState getNewVersion() {
    return ErrorRegistrationState(version+1, this.errorMessage);
  }
}
