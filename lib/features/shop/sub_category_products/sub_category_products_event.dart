import 'dart:async';
import 'dart:developer' as developer;

import 'package:wmn_plus/features/shop/sub_category_products/index.dart';
import 'package:meta/meta.dart';

@immutable
abstract class SubCategoryProductsEvent {
  Future<SubCategoryProductsState> applyAsync(
      {SubCategoryProductsState currentState, SubCategoryProductsBloc bloc});
  final SubCategoryProductsRepository _subCategoryProductsRepository =
      SubCategoryProductsRepository();
}

class UnSubCategoryProductsEvent extends SubCategoryProductsEvent {
  @override
  Future<SubCategoryProductsState> applyAsync(
      {SubCategoryProductsState currentState,
      SubCategoryProductsBloc bloc}) async {
    return UnSubCategoryProductsState(0);
  }
}

class LoadSubCategoryProductsEvent extends SubCategoryProductsEvent {
  final int sub;
  final int id;
  @override
  String toString() => 'LoadSubCategoryProductsEvent';

  LoadSubCategoryProductsEvent(this.sub, this.id);

  @override
  Future<SubCategoryProductsState> applyAsync(
      {SubCategoryProductsState currentState,
      SubCategoryProductsBloc bloc}) async {
    try {
      ProductList productList =
          await _subCategoryProductsRepository.getSubCategoryPage(sub, id);
      return InSubCategoryProductsState(0, productList);
    } catch (_, stackTrace) {
      developer.log('$_',
          name: 'LoadSubCategoryProductsEvent',
          error: _,
          stackTrace: stackTrace);
      return ErrorSubCategoryProductsState(0, _?.toString());
    }
  }
}
