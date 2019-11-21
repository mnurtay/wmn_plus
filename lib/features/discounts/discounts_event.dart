import 'dart:async';
import 'package:wmn_plus/features/discounts/index.dart';
import 'package:meta/meta.dart';
import 'dart:developer' as developer;

@immutable
abstract class DiscountsEvent {
  Future<DiscountsState> applyAsync(
      {DiscountsState currentState, DiscountsBloc bloc});
  final DiscountsRepository _discountsRepository = DiscountsRepository();
}

class UnDiscountsEvent extends DiscountsEvent {
  @override
  Future<DiscountsState> applyAsync({DiscountsState currentState, DiscountsBloc bloc}) async {
    return UnDiscountsState(0);
  }
}

class LoadDiscountsEvent extends DiscountsEvent {
   
  final bool isError;
  @override
  String toString() => 'LoadDiscountsEvent';

  LoadDiscountsEvent(this.isError);

  @override
  Future<DiscountsState> applyAsync(
      {DiscountsState currentState, DiscountsBloc bloc}) async {
    try {
      if (currentState is InDiscountsState) {
        return currentState.getNewVersion();
      }
      await Future.delayed(Duration(seconds: 2));
      this._discountsRepository.test(this.isError);
      return InDiscountsState(0, "Hello world");
    } catch (_, stackTrace) {
      developer.log('$_', name: 'LoadDiscountsEvent', error: _, stackTrace: stackTrace);
      return ErrorDiscountsState(0, _?.toString());
    }
  }
}
