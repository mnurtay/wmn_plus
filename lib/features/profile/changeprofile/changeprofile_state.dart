import 'package:equatable/equatable.dart';
import 'package:wmn_plus/features/auth/model/User.dart';

abstract class ChangeprofileState extends Equatable {
  /// notify change state without deep clone state
  final int version;

  final List propss;
  ChangeprofileState(this.version, [this.propss]);

  /// Copy object for use in action
  /// if need use deep clone
  ChangeprofileState getStateCopy();

  ChangeprofileState getNewVersion();

  @override
  List<Object> get props => (propss);
}

/// UnInitialized
class UnChangeprofileState extends ChangeprofileState {
  UnChangeprofileState(int version) : super(version);

  @override
  String toString() => 'UnChangeprofileState';

  @override
  UnChangeprofileState getStateCopy() {
    return UnChangeprofileState(0);
  }

  @override
  UnChangeprofileState getNewVersion() {
    return UnChangeprofileState(version + 1);
  }
}

/// Initialized
class InChangeprofileState extends ChangeprofileState {
  final User user;

  InChangeprofileState(int version, this.user) : super(version, [user]);

  @override
  String toString() => 'InChangeprofileState $user';

  @override
  InChangeprofileState getStateCopy() {
    return InChangeprofileState(this.version, this.user);
  }

  @override
  InChangeprofileState getNewVersion() {
    return InChangeprofileState(version + 1, this.user);
  }
}

class ErrorChangeprofileState extends ChangeprofileState {
  final String errorMessage;

  ErrorChangeprofileState(int version, this.errorMessage)
      : super(version, [errorMessage]);

  @override
  String toString() => 'ErrorChangeprofileState';

  @override
  ErrorChangeprofileState getStateCopy() {
    return ErrorChangeprofileState(this.version, this.errorMessage);
  }

  @override
  ErrorChangeprofileState getNewVersion() {
    return ErrorChangeprofileState(version + 1, this.errorMessage);
  }
}
