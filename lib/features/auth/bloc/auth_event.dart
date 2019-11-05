import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:wmn_plus/features/auth/model/User.dart';

@immutable
abstract class AuthEvent extends Equatable {
  AuthEvent([List props = const []]);
}

class AppStartedAuthEvent extends AuthEvent {
  @override
  List<Object> get props => [];
}

class LoggedInAuthEvent extends AuthEvent {
  final User user;
  LoggedInAuthEvent({@required this.user});

  @override
  List<Object> get props => [user];
}

class LoggedOutAuthEvent extends AuthEvent {
  @override
  List<Object> get props => [];
}

class EditAuthEvent extends AuthEvent {
  final User user;
  EditAuthEvent({@required this.user});

  @override
  List<Object> get props => [user];
}
