import 'dart:async';
import 'package:wmn_plus/features/auth/model/User.dart';
import 'package:wmn_plus/features/auth/resource/auth_repository.dart';
import 'package:wmn_plus/features/profile/index.dart';
import 'package:meta/meta.dart';
import 'dart:developer' as developer;

@immutable
abstract class ProfileEvent {
  Future<ProfileState> applyAsync(
      {ProfileState currentState, ProfileBloc bloc});
  final ProfileRepository _profileRepository = ProfileRepository();
}

class UnProfileEvent extends ProfileEvent {
  @override
  Future<ProfileState> applyAsync(
      {ProfileState currentState, ProfileBloc bloc}) async {
    return UnProfileState(0);
  }
}

class LoadProfileEvent extends ProfileEvent {
  final bool isError;
  @override
  String toString() => 'LoadProfileEvent';

  LoadProfileEvent(this.isError);

  @override
  Future<ProfileState> applyAsync(
      {ProfileState currentState, ProfileBloc bloc}) async {
    try {
      User user = await UserRepository().getCurrentUser();
      return InProfileState(0, user.result);
    } catch (_, stackTrace) {
      developer.log('$_',
          name: 'LoadProfileEvent', error: _, stackTrace: stackTrace);
      return ErrorProfileState(0, _?.toString());
    }
  }
}
