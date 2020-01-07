import 'package:wmn_plus/features/news/index.dart';

class NewsRepository {
  final NewsProvider _newsProvider = NewsProvider();

  NewsRepository();

  Future<List<NewsModel>> getNewsList(int pageIndex, int category) async {
    List<NewsModel> news =
        await _newsProvider.fetchMoreNews(pageIndex, category);
    return news;
  }
}
