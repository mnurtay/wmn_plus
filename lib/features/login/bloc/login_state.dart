import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class LoginState extends Equatable {
  LoginState([List props = const []]);
}

class InitialLoginState extends LoginState {
  @override
  List<Object> get props => null;
}

class LoadingLoginState extends LoginState {
  @override
  List<Object> get props => null;
}

class FailureLoginState extends LoginState {
  final String error;
  FailureLoginState({@required this.error}) : super([error]);

  @override
  List<Object> get props => null;
}
