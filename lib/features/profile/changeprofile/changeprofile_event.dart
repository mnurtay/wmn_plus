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
  @override
  String toString() => 'LoadChangeprofileEvent';

  LoadChangeprofileEvent(this.isError);

  @override
  Future<ChangeprofileState> applyAsync(
      {ChangeprofileState currentState, ChangeprofileBloc bloc}) async {
    try {
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

class PostChangeprofileEvent extends ChangeprofileEvent {
  @override
  String toString() => 'LoadChangeprofileEvent';

  PostChangeprofileEvent();

  @override
  Future<ChangeprofileState> applyAsync(
      {ChangeprofileState currentState, ChangeprofileBloc bloc}) async {
    try {
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
