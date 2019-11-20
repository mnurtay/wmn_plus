import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:wmn_plus/features/news/news_detail/index.dart';
import 'dart:developer' as developer;

class NewsDetailBloc extends Bloc<NewsDetailEvent, NewsDetailState> {
  // todo: check singleton for logic in project
  static final NewsDetailBloc _newsDetailBlocSingleton = NewsDetailBloc._internal();
  factory NewsDetailBloc() {
    return _newsDetailBlocSingleton;
  }
  NewsDetailBloc._internal();
  
  @override
  dispose(){
    _newsDetailBlocSingleton.dispose();
    super.close();
  }

  NewsDetailState get initialState => UnNewsDetailState(0);

  @override
  Stream<NewsDetailState> mapEventToState(
    NewsDetailEvent event,
  ) async* {
    try {
      yield await event.applyAsync(currentState: state, bloc: this);
    } catch (_, stackTrace) {
      developer.log('$_', name: 'NewsDetailBloc', error: _, stackTrace: stackTrace);
      yield state;
    }
  }
}
