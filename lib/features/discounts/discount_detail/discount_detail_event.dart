import 'dart:async';
import 'package:wmn_plus/features/discounts/discount_detail/index.dart';
import 'package:meta/meta.dart';
import 'dart:developer' as developer;

@immutable
abstract class DiscountDetailEvent {
  Future<DiscountDetailState> applyAsync(
      {DiscountDetailState currentState, DiscountDetailBloc bloc});
  final DiscountDetailRepository _discountDetailRepository = DiscountDetailRepository();
}

class UnDiscountDetailEvent extends DiscountDetailEvent {
  @override
  Future<DiscountDetailState> applyAsync({DiscountDetailState currentState, DiscountDetailBloc bloc}) async {
    return UnDiscountDetailState(0);
  }
}

class LoadDiscountDetailEvent extends DiscountDetailEvent {
   
  final bool isError;
  @override
  String toString() => 'LoadDiscountDetailEvent';

  LoadDiscountDetailEvent(this.isError);

  @override
  Future<DiscountDetailState> applyAsync(
      {DiscountDetailState currentState, DiscountDetailBloc bloc}) async {
    try {
      if (currentState is InDiscountDetailState) {
        return currentState.getNewVersion();
      }
      await Future.delayed(Duration(seconds: 2));
      this._discountDetailRepository.test(this.isError);
      return InDiscountDetailState(0, "Hello world");
    } catch (_, stackTrace) {
      developer.log('$_', name: 'LoadDiscountDetailEvent', error: _, stackTrace: stackTrace);
      return ErrorDiscountDetailState(0, _?.toString());
    }
  }
}
