import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:wmn_plus/features/auth/model/User.dart';

@immutable
abstract class AuthState extends Equatable {
  AuthState([List props = const []]);
}

class UninitializedAuthState extends AuthState {
  @override
  List<Object> get props => null;
}

class LoadingAuthState extends AuthState {
  @override
  List<Object> get props => null;
}

class UnauthenticatedAuthState extends AuthState {
  @override
  List<Object> get props => null;
}

class AuthenticatedAuthState extends AuthState {
  final User user;
  AuthenticatedAuthState({@required this.user});

  @override
  List<Object> get props => [user];
}

class AuthenticatedDoctorAuthState extends AuthState {
  final User user;
  AuthenticatedDoctorAuthState({@required this.user});

  @override
  List<Object> get props => [user];
}
