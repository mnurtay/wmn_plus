import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class LoginEvent extends Equatable {
  LoginEvent([List props = const []]);
}

class LoginUserEvent extends LoginEvent {
  final String username;
  final String password;

  LoginUserEvent({
    @required this.username,
    @required this.password,
  });

  @override
  List<Object> get props => [username, password];
}

class LoginDoctorEvent extends LoginEvent {
  final String username;
  final String password;

  LoginDoctorEvent({
    @required this.username,
    @required this.password,
  });

  @override
  List<Object> get props => [username, password];
}
