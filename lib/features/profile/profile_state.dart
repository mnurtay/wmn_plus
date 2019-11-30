import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class ProfileState extends Equatable {
  /// notify change state without deep clone state
  final int version;
  
  final Iterable propss;
  ProfileState(this.version,[this.propss]);

  /// Copy object for use in action
  /// if need use deep clone
  ProfileState getStateCopy();

  ProfileState getNewVersion();

  @override
  List<Object> get props => (propss);
}

/// UnInitialized
class UnProfileState extends ProfileState {

  UnProfileState(version) : super(version);

  @override
  String toString() => 'UnProfileState';

  @override
  UnProfileState getStateCopy() {
    return UnProfileState(0);
  }

  @override
  UnProfileState getNewVersion() {
    return UnProfileState(version+1);
  }
}

/// Initialized
class InProfileState extends ProfileState {
  final String hello;

  InProfileState(version, this.hello) : super(version, [hello]);

  @override
  String toString() => 'InProfileState $hello';

  @override
  InProfileState getStateCopy() {
    return InProfileState(this.version, this.hello);
  }

  @override
  InProfileState getNewVersion() {
    return InProfileState(version+1, this.hello);
  }
}

class ErrorProfileState extends ProfileState {
  final String errorMessage;

  ErrorProfileState(version, this.errorMessage): super(version, [errorMessage]);
  
  @override
  String toString() => 'ErrorProfileState';

  @override
  ErrorProfileState getStateCopy() {
    return ErrorProfileState(this.version, this.errorMessage);
  }

  @override
  ErrorProfileState getNewVersion() {
    return ErrorProfileState(version+1, this.errorMessage);
  }
}
