import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:wmn_plus/features/discounts/discount_detail/index.dart';
import 'dart:developer' as developer;

class DiscountDetailBloc extends Bloc<DiscountDetailEvent, DiscountDetailState> {
  // todo: check singleton for logic in project
  static final DiscountDetailBloc _discountDetailBlocSingleton = DiscountDetailBloc._internal();
  factory DiscountDetailBloc() {
    return _discountDetailBlocSingleton;
  }
  DiscountDetailBloc._internal();
  
  @override
  Future<void> close() async{
    // dispose objects
    super.close();
  }

  DiscountDetailState get initialState => UnDiscountDetailState(0);

  @override
  Stream<DiscountDetailState> mapEventToState(
    DiscountDetailEvent event,
  ) async* {
    try {
      yield await event.applyAsync(currentState: state, bloc: this);
    } catch (_, stackTrace) {
      developer.log('$_', name: 'DiscountDetailBloc', error: _, stackTrace: stackTrace);
      yield state;
    }
  }
}
