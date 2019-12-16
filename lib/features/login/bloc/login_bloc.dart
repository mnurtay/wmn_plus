import 'dart:async';
import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:wmn_plus/features/auth/bloc/bloc.dart';
import 'package:wmn_plus/features/auth/resource/auth_repository.dart';

import './bloc.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final UserRepository userRepository = UserRepository();
  final AuthBloc authBloc;

  LoginBloc({
    @required this.authBloc,
  }) : assert(authBloc != null);

  @override
  LoginState get initialState => InitialLoginState();

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    if (event is LoginUserEvent) {
      yield LoadingLoginState();
      try {
        final user = await userRepository.authenticate(
            username: event.username, password: event.password);
        if (user.result.token == null) {
          FailureLoginState(error: "Ошибка авторизации");
        } else
          authBloc.add(LoggedInAuthEvent(user: user));
        yield InitialLoginState();
      } catch (error) {
        yield FailureLoginState(error: "Ошибка авторизации");
      }
    }
    if (event is LoginDoctorEvent) {}
  }
}
