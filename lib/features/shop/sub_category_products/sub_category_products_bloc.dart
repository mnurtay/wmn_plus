import 'dart:async';
import 'dart:developer' as developer;

import 'package:bloc/bloc.dart';
import 'package:wmn_plus/features/shop/sub_category_products/index.dart';

class SubCategoryProductsBloc extends Bloc<SubCategoryProductsEvent, SubCategoryProductsState> {
  // todo: check singleton for logic in project
  static final SubCategoryProductsBloc _subCategoryProductsBlocSingleton = SubCategoryProductsBloc._internal();
  factory SubCategoryProductsBloc() {
    return _subCategoryProductsBlocSingleton;
  }
  SubCategoryProductsBloc._internal();
  
  @override
  Future<void> close() async{
    // dispose objects
    await super.close();
  }

  @override
  SubCategoryProductsState get initialState => UnSubCategoryProductsState(0);

  @override
  Stream<SubCategoryProductsState> mapEventToState(
    SubCategoryProductsEvent event,
  ) async* {
    try {
      yield await event.applyAsync(currentState: state, bloc: this);
    } catch (_, stackTrace) {
      developer.log('$_', name: 'SubCategoryProductsBloc', error: _, stackTrace: stackTrace);
      yield state;
    }
  }
}
