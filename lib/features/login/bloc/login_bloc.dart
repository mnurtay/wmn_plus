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
        // this is how user login to the page
        authBloc.add(LoggedInAuthEvent(user: user));
        yield InitialLoginState();
      } catch (error) {
        yield FailureLoginState(error: error.toString());
      }
    }
    if (event is LoginDoctorEvent){
      
    }
  }
}
