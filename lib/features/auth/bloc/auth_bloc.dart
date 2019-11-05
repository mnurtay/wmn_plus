import 'dart:async';
import 'package:bloc/bloc.dart';
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
        yield AuthenticatedAuthState(user: currentUser);
      } else {
        yield UnauthenticatedAuthState();
      }
    }

    // App login mechanism
    if (event is LoggedInAuthEvent) {
      yield LoadingAuthState();
      await userRepository.persistUser(event.user);
      final currentUser = await userRepository.getCurrentUser();
      yield AuthenticatedAuthState(user: currentUser);
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
