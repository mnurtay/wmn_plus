import 'package:wmn_plus/features/news/news_detail/index.dart';

class NewsDetailRepository {
  final NewsDetailProvider _newsDetailProvider = NewsDetailProvider();

  NewsDetailRepository();

  Future<NewsDetail> fetchNewsDetail(String id) {
    return _newsDetailProvider.getNewsDetail(id);
  }
}