import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:wmn_plus/features/news/news_detail/news_detail_model.dart';

@immutable
abstract class NewsDetailState extends Equatable {
  /// notify change state without deep clone state
  final int version;
  
  final Iterable propss;
  NewsDetailState(this.version,[this.propss]);

  /// Copy object for use in action
  /// if need use deep clone
  NewsDetailState getStateCopy();

  NewsDetailState getNewVersion();

  @override
  List<Object> get props => (propss);
}

/// UnInitialized
class UnNewsDetailState extends NewsDetailState {

  UnNewsDetailState(version) : super(version);

  @override
  String toString() => 'UnNewsDetailState';

  @override
  UnNewsDetailState getStateCopy() {
    return UnNewsDetailState(0);
  }

  @override
  UnNewsDetailState getNewVersion() {
    return UnNewsDetailState(version+1);
  }
}

/// Initialized
class InNewsDetailState extends NewsDetailState {
  final NewsDetail newsDetail;

  InNewsDetailState(version, this.newsDetail) : super(version, [newsDetail]);

  @override
  String toString() => 'InNewsDetailState';

  @override
  InNewsDetailState getStateCopy() {
    return InNewsDetailState(this.version, this.newsDetail);
  }

  @override
  InNewsDetailState getNewVersion() {
    return InNewsDetailState(version+1, this.newsDetail);
  }
}

class ErrorNewsDetailState extends NewsDetailState {
  final String errorMessage;

  ErrorNewsDetailState(version, this.errorMessage): super(version, [errorMessage]);
  
  @override
  String toString() => 'ErrorNewsDetailState';

  @override
  ErrorNewsDetailState getStateCopy() {
    return ErrorNewsDetailState(this.version, this.errorMessage);
  }

  @override
  ErrorNewsDetailState getNewVersion() {
    return ErrorNewsDetailState(version+1, this.errorMessage);
  }
}
