import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:wmn_plus/features/news/index.dart';

@immutable
abstract class NewsState extends Equatable {
  /// notify change state without deep clone state
  final int version;
  
  final Iterable propss;
  NewsState(this.version,[this.propss]);

  /// Copy object for use in action
  /// if need use deep clone
  NewsState getStateCopy();

  NewsState getNewVersion();

  @override
  List<Object> get props => (propss);
}

/// UnInitialized
class UnNewsState extends NewsState {

  UnNewsState(version) : super(version);

  @override
  String toString() => 'UnNewsState';

  @override
  UnNewsState getStateCopy() {
    return UnNewsState(0);
  }

  @override
  UnNewsState getNewVersion() {
    return UnNewsState(version+1);
  }
}

/// Initialized
class InNewsState extends NewsState {

  final List<NewsModel> newsList;

  InNewsState(version, this.newsList) : super(version, [newsList]);

  @override
  String toString() => 'InNewsState $newsList';

  @override
  InNewsState getStateCopy() {
    return InNewsState(this.version, this.newsList);
  }

  @override
  InNewsState getNewVersion() {
    return InNewsState(version+1, newsList);
  }
}

class CategoryOneNewsState extends NewsState {

  final int category;

  CategoryOneNewsState(version, this.category) : super(version, [category]);

  @override
  String toString() => 'InNewsState $category';

  @override
  CategoryOneNewsState getStateCopy() {
    return CategoryOneNewsState(this.version, this.category);
  }

  @override
  CategoryOneNewsState getNewVersion() {
    return CategoryOneNewsState(version+1, category);
  }
}

class ErrorNewsState extends NewsState {
  final String errorMessage;

  ErrorNewsState(version, this.errorMessage): super(version, [errorMessage]);
  
  @override
  String toString() => 'ErrorNewsState';

  @override
  ErrorNewsState getStateCopy() {
    return ErrorNewsState(this.version, this.errorMessage);
  }

  @override
  ErrorNewsState getNewVersion() {
    return ErrorNewsState(version+1, this.errorMessage);
  }
}
