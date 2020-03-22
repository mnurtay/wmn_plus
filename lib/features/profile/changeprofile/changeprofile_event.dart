import 'dart:async';
import 'dart:developer' as developer;

import 'package:wmn_plus/features/auth/model/User.dart';
import 'package:wmn_plus/features/profile/changeprofile/index.dart';
import 'package:meta/meta.dart';

@immutable
abstract class ChangeprofileEvent {
  Future<ChangeprofileState> applyAsync(
      {ChangeprofileState currentState, ChangeprofileBloc bloc});
  final ChangeprofileRepository _changeprofileRepository =
      ChangeprofileRepository();
}

class UnChangeprofileEvent extends ChangeprofileEvent {
  @override
  Future<ChangeprofileState> applyAsync(
      {ChangeprofileState currentState, ChangeprofileBloc bloc}) async {
    return UnChangeprofileState(0);
  }
}

class LoadChangeprofileEvent extends ChangeprofileEvent {
  final bool isError;
  final String dateTime;
  @override
  String toString() => 'LoadChangeprofileEvent';

  LoadChangeprofileEvent(this.isError, {this.dateTime});

  @override
  Future<ChangeprofileState> applyAsync(
      {ChangeprofileState currentState, ChangeprofileBloc bloc}) async {
    try {
      if (currentState is InChangeprofileState) {
        var state = currentState.getStateCopy();
        state.dateTime = this.dateTime;
        return state.getNewVersion();
      }
      User user = await _changeprofileRepository.getUser();
      print(user.toJson());
      return InChangeprofileState(0, user);
    } catch (_, stackTrace) {
      developer.log('$_',
          name: 'LoadChangeprofileEvent', error: _, stackTrace: stackTrace);
      return ErrorChangeprofileState(0, _?.toString());
    }
  }
}

class PostServerChangeprofileEvent extends ChangeprofileEvent {
  final Map<String, dynamic> mapBody;

  @override
  String toString() => 'LoadChangeprofileEvent';

  PostServerChangeprofileEvent(this.mapBody);

  @override
  Future<ChangeprofileState> applyAsync(
      {ChangeprofileState currentState, ChangeprofileBloc bloc}) async {
    try {
      User user = await _changeprofileRepository.getUser();
      User responseUser = await _changeprofileRepository.postServerUser(
          user.result.token, mapBody);
      if (responseUser != null)
        return SuccessChangeprofileState(0);
      else
        return ErrorChangeprofileState(0, "Повторите позже");
    } catch (_, stackTrace) {
      developer.log('$_',
          name: 'LoadChangeprofileEvent', error: _, stackTrace: stackTrace);
      return ErrorChangeprofileState(0, _?.toString());
    }
  }
}
