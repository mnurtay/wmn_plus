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
   
  final int category;
  @override
  String toString() => 'LoadDiscountsEvent';

  LoadDiscountsEvent(this.category);

  @override
  Future<DiscountsState> applyAsync(
      {DiscountsState currentState, DiscountsBloc bloc}) async {
    try {
      Discount discounts = await this._discountsRepository.getDiscountsList(category);
      if (discounts.result == null ){
        return ErrorDiscountsState(0, "null");
      }
      return InDiscountsState(0, discounts);
    } catch (_, stackTrace) {
      developer.log('$_', name: 'LoadDiscountsEvent', error: _, stackTrace: stackTrace);
      return ErrorDiscountsState(0, _?.toString());
    }
  }
}
