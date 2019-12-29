import 'dart:async';
import 'dart:developer' as developer;

import 'package:wmn_plus/features/auth/model/User.dart';
import 'package:wmn_plus/features/auth/resource/auth_repository.dart';
import 'package:wmn_plus/features/profile/screen/language/index.dart';
import 'package:meta/meta.dart';
import 'package:wmn_plus/util/config.dart';

@immutable
abstract class LanguageEvent {
  Future<LanguageState> applyAsync(
      {LanguageState currentState, LanguageBloc bloc});
  final LanguageRepository _languageRepository = LanguageRepository();
}

class UnLanguageEvent extends LanguageEvent {
  @override
  Future<LanguageState> applyAsync(
      {LanguageState currentState, LanguageBloc bloc}) async {
    return UnLanguageState(0);
  }
}

class LoadLanguageEvent extends LanguageEvent {
  final bool isError;
  @override
  String toString() => 'LoadLanguageEvent';

  LoadLanguageEvent(this.isError);

  @override
  Future<LanguageState> applyAsync(
      {LanguageState currentState, LanguageBloc bloc}) async {
    try {
      // await Future.delayed(Duration(seconds: 2));
      this._languageRepository.test(this.isError);
      return InLanguageState(0, "Hello world");
    } catch (_, stackTrace) {
      developer.log('$_',
          name: 'LoadLanguageEvent', error: _, stackTrace: stackTrace);
      return ErrorLanguageState(0, _?.toString());
    }
  }
}

class ChangeLanguageEvent extends LanguageEvent {
  final LanguageType type;
  @override
  String toString() => 'ChangeLanguageEvent';

  ChangeLanguageEvent(this.type);

  @override
  Future<LanguageState> applyAsync(
      {LanguageState currentState, LanguageBloc bloc}) async {
    try {
      UserRepository userRepository = UserRepository();
      HttpStatus status = await this._languageRepository.changeLanguage(type);
      if (status == HttpStatus.Success) {
        User user = await userRepository.getCurrentUser();
        var newUser = user;
        if (type == LanguageType.English) {
          newUser.result.language = "eng";
        } else if (type == LanguageType.Russian) {
          newUser.result.language = "rus";
        } else {
          newUser.result.language = "kaz";
        }
        userRepository.persistUser(newUser);
        return InLanguageState(0, "Hello world");
      } else {
        return ErrorLanguageState(0, "Ошибка");
      }
    } catch (_, stackTrace) {
      developer.log('$_',
          name: 'LoadLanguageEvent', error: _, stackTrace: stackTrace);
      return ErrorLanguageState(0, _?.toString());
    }
  }
}

enum LanguageType { Kazakh, Russian, English }
