import 'dart:async';
import 'package:wmn_plus/features/news/news_detail/index.dart';
import 'package:meta/meta.dart';
import 'dart:developer' as developer;

@immutable
abstract class NewsDetailEvent {
  Future<NewsDetailState> applyAsync(
      {NewsDetailState currentState, NewsDetailBloc bloc});
  final NewsDetailRepository _newsDetailRepository = NewsDetailRepository();
}

class UnNewsDetailEvent extends NewsDetailEvent {
  @override
  Future<NewsDetailState> applyAsync(
      {NewsDetailState currentState, NewsDetailBloc bloc}) async {
    return UnNewsDetailState(0);
  }
}

class LoadNewsDetailEvent extends NewsDetailEvent {
  final String newsId;
  @override
  String toString() => 'LoadNewsDetailEvent';

  LoadNewsDetailEvent(this.newsId);

  @override
  Future<NewsDetailState> applyAsync(
      {NewsDetailState currentState, NewsDetailBloc bloc}) async {
    try {
      if (currentState is InNewsDetailState) {
        return currentState.getNewVersion();
      }
      // await Future.delayed(Duration(seconds: 2));
      NewsDetail newsDetail = await this._newsDetailRepository.fetchNewsDetail(newsId);
      
      return InNewsDetailState(0, newsDetail);
    } catch (_, stackTrace) {
      developer.log('$_',
          name: 'LoadNewsDetailEvent', error: _, stackTrace: stackTrace);
      return ErrorNewsDetailState(0, _?.toString());
    }
  }
}
