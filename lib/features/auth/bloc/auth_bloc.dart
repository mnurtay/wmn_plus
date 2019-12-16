import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wmn_plus/features/auth/resource/auth_repository.dart';
import './bloc.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserRepository userRepository = UserRepository();

  @override
  AuthState get initialState => UninitializedAuthState();

  @override
  Stream<AuthState> mapEventToState(
    AuthEvent event,
  ) async* {
    // App first loaded
    if (event is AppStartedAuthEvent) {
      final bool isAuthenticated = await userRepository.isAuthenticated();
      if (isAuthenticated) {
        final currentUser = await userRepository.getCurrentUser();
        var mode = currentUser.result.regime;
        if (mode == "fertility") {
          yield AuthenticatedFertilityModeState(user: currentUser);
        } else if (mode == "pregnancy") {
          yield AuthenticatedAuthState(
              user: currentUser); //pregnancy default mode
        } else if (mode == "climax") {
          yield AuthenticatedClimaxModeState(user: currentUser);
        }
      } else {
        yield UnauthenticatedAuthState();
      }
    }

    // App login mechanism
    if (event is LoggedInAuthEvent) {
      yield LoadingAuthState();
      await userRepository.persistUser(event.user);
      final currentUser = await userRepository.getCurrentUser();
      var mode = currentUser.result.regime;
      if (mode == "fertility") {
        yield AuthenticatedFertilityModeState(user: currentUser);
      } else if (mode == "pregnancy") {
        yield AuthenticatedAuthState(
            user: currentUser); //pregnancy default mode
      } else if (mode == "climax") {
        yield AuthenticatedClimaxModeState(user: currentUser);
      }
    }

    if (event is ChangeAppModeFertilityEvent) {
      await Future.delayed(Duration(seconds: 1)); // post request to change mode
      final currentUser = await userRepository.getCurrentUser();
      yield AuthenticatedFertilityModeState(user: currentUser);
    }

    if (event is ChangeAppModePregnantEvent) {
      await Future.delayed(Duration(seconds: 1)); // post request to change mode
      final currentUser = await userRepository.getCurrentUser();
      yield AuthenticatedAuthState(user: currentUser); //pregnancy default mode
    }

    if (event is ChangeAppModeClimaxEvent) {
      await Future.delayed(Duration(seconds: 1)); // post request to change mode
      final currentUser = await userRepository.getCurrentUser();
      yield AuthenticatedClimaxModeState(user: currentUser);
    }

    // App Edit mechanism
    if (event is EditAuthEvent) {
      // yield LoadingAuthState();
      await userRepository.persistUser(event.user);
      final currentUser = await userRepository.getCurrentUser();
      yield AuthenticatedAuthState(user: currentUser);
    }

    // App logout mechanism
    if (event is LoggedOutAuthEvent) {
      yield LoadingAuthState();
      await userRepository.deleteUser();
      yield UnauthenticatedAuthState();
    }
  }
}
